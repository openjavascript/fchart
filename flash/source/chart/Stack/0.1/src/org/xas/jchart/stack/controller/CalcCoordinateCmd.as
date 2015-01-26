package org.xas.jchart.stack.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.LegendProxy;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.common.view.mediator.BgLineMediator.StackBgLineMediator;
	import org.xas.jchart.common.view.mediator.BgMediator.StackBgMediator;
	import org.xas.jchart.common.view.mediator.CreditMediator.BaseCreditMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.StackGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.StackHLabelMediator;
	import org.xas.jchart.common.view.mediator.HoverBgMediator.StackHoverBgMediator;
	import org.xas.jchart.common.view.mediator.ItemBgMediator.StackItemBgMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.StackLegendMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.BaseSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.StackSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator.BaseSubtitleMediator;
	import org.xas.jchart.common.view.mediator.TestMediator.BaseTestMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.StackTipsMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator.BaseTitleMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.BaseVLabelMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.StackVLabelMediator;
	import org.xas.jchart.common.view.mediator.VTitleMediator.BaseVTitleMediator;
	import org.xas.jchart.stack.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		private var _config:Config;
		
		public function CalcCoordinateCmd()
		{
			super();
			
			_config = BaseConfig.ins as Config;
		}
		
		override public function execute(notification:INotification):void{
			
			_c = _config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
									
			facade.registerMediator( new StackBgMediator( ) );
			var _yPad:Number = _c.minY;
			
			if( _config.cd ){			
				
				if( _config.titleEnable ){
					facade.registerMediator( new BaseTitleMediator( _config.titleText ) )	
					_config.c.title = { x: _config.stageWidth / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;			
				}
				
				if( _config.subtitleEnable ){
					facade.registerMediator( new BaseSubtitleMediator( _config.subtitleText ) )
					
					_config.c.subtitle = { x: _config.stageWidth / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height;
				}
				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new BaseCreditMediator( _config.cd.credits.text, _config.cd.credits.href ) )
					
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}	
				
//				_config.c.maxX -= _config.hspace;
				
				if( _config.legendEnabled ){
					facade.registerProxy( new LegendProxy() );
					facade.registerMediator( new StackLegendMediator() );
					
					pLegendProxy.dataModel.calLegendPosition( pLegendMediator.view );
				}
				
				if( _config.vtitleEnabled ){
					facade.registerMediator( new BaseVTitleMediator( _config.vtitleText ) )
					
					_config.c.vtitle = { x: _config.c.minX, y: _config.c.x + _config.c.height / 2, item: pVTitleMediator };
					_config.c.minX += pVTitleMediator.view.width - _config.vlabelSpace;
				}
				
				if( _config.yAxisEnabled ){
					facade.registerMediator( new StackVLabelMediator() );
					_config.c.minX += pVLabelMediator.maxWidth;
					_config.c.minX += _config.yArrowLength;
				}

				_config.c.hoverPadY = 0;
				if( _config.hoverBgEnabled ){
					facade.registerMediator( new StackHoverBgMediator() );
					_config.c.minY += _config.c.hoverPadY;
//					_yPad += _config.c.hoverPadY;
				}
				
				if( _config.itemBgEnabled ){
					facade.registerMediator( new StackItemBgMediator() );
				}
				
				_config.c.serialLabelPadY = 0;
				if( _config.serialLabelEnabled ){
					facade.registerMediator( new StackSeriesLabelMediator() );
				}
								
				_config.c.vlabelMaxWidth = pVLabelMediator ? pVLabelMediator.maxWidth : 0;
				
				if( _config.categories && _config.categories.length ) {
					if( _config.displayAllLabel ){
						_config.c.labelWidth = _config.c.chartWidth / _config.categories.length / 2;
					} else {
						if( _config.displayMod ){
							_config.c.labelWidth = _config.c.chartWidth * _config.displayMod 
								/ _config.categories.length;
						} else {
							_config.c.labelWidth = _config.c.chartWidth / 7;
						}
					}
				}
				
				if( _config.xAxisEnabled ){
					facade.registerMediator( new StackHLabelMediator() );
					
					_config.c.maxY -= pHLabelMediator.maxHeight;
					
					var _tmpMaxWidth:Number = pHLabelMediator.maxWidth;
					
					if( _tmpMaxWidth < 0 ){
						_config.c.minX += Math.abs( _tmpMaxWidth );
					} else {
						_config.c.maxX -= _tmpMaxWidth;
					}
				}
								
				_config.c.chartWidth = _config.c.maxX - _config.c.minX - _config.hspace;
			
				if( _config.graphicHeight ){
					var _hpad:Number = _config.c.maxY - _config.graphicHeight;
					_config.c.chartHeight = _config.graphicHeight - _yPad;		
					_config.c.maxY -= _hpad;
					
					if( _config.c.legend ){
						_config.c.legend.y -= _hpad;
					}
					
					if( _config.c.credits ){
						_config.c.credits.y -= _hpad;
					}
				} else {
					_config.c.chartHeight = _config.c.maxY - _config.c.minY;
				}
				
				_config.c.chartX = _config.c.minX + _config.yArrowLength - 2;
				_config.c.chartY = _config.c.minY;
				
				sendNotification( JChartEvent.DISPLAY_ALL_CHECK );
				
				facade.registerMediator( new StackGraphicBgMediator() );	
				_config.tooltipEnabled && facade.registerMediator( new StackTipsMediator() );
				//Log.log( _config.tooltipEnabled );
				
				
				/* 添加HLabel重计算 */
				
				calcChartPoint();
				
				facade.registerMediator( new GraphicMediator() );
				
				calcGraphic();
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new BaseTestMediator( DefaultData.instance.data ) );	
				}
				//Log.log( _config.c.chartWidth, _config.c.chartHeight );
			}
			
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{
			
			_config.c.rects = [];
			_config.c.dataRect = [];
			_config.c.stackItems = [];
			
			if( !( _config.series && _config.series.length ) ) return;
			
			_config.c.partSpace = 0; 
			_config.c.partWidth = _config.c.itemWidth;
			
			if( _config.displaySeries.length > 1 ){				
				_config.c.partSpace = 4; 
				_config.c.partWidth = _config.c.itemWidth
					;
			}
			
//			Log.log( _config.minNum, _config.maxNum );
			
			var _partWidth:Number = _config.c.partWidth
				;
			if( _partWidth > 50 ){
				_partWidth = 50;
			}
			
			if( !_config.itemLength ) return;
			
			var _positiveOffset:Number
				, _positiveHeight:Number = _config.c.vpart * _config.rateZeroIndex
				
				, _negativeOffset:Number
				, _negativeHeight:Number = _config.c.chartHeight - _config.c.vpart * _config.rateZeroIndex
				;
				
//				Log.log( _config.minNum );
			
			Common.each( _config.displaySeries[0].data, function( _k:int, _item:Object ):void{
				_positiveOffset = 0;
				_negativeOffset = 0;
				
				var _items:Array = []
					, _pointItem:Object = _config.c.hlinePoint[ _k ]
					, _sp:Point = _pointItem.start as Point
					, _ep:Point = _pointItem.end as Point
					, _x:Number = _sp.x + _config.c.hpart / 2 - _partWidth / 2
					, _tmp:Number = 0
					, _tmpDataRect:Object = {
						x: _sp.x, y: _config.c.chartY
						, width: _config.c.hpart
						, height: _config.c.chartHeight 
					}
					, _tmpYAr:Array = []
					, _tmpHAr:Array = []
					, _stackItem:Object = {
						data: {
							negative: []
							, positive: []
						}
					}
					, _rectY:Number = _sp.y + _positiveHeight
					;
									
				Common.each( _config.displaySeries, function( _sk:int, _sitem:Object ):void{
					var _rectItem:Object = {}
						, _itemNum:Number
						, _h:Number = 0, _y:Number
						, _num:Number = _sitem.data[ _k ]
						, _maxNum:Number = _config.chartMaxNum
						;
						
						if( _config.isAutoRate && !_config.hasNegative ){
							_num -= _config.minNum / _config.displaySeries.length;
							_maxNum -= _config.minNum;
						}
//						Log.log( _num, _maxNum );

						if( Common.isNegative( _num ) || _num == 0 ){
							_num = Math.abs( _num );
							
							_h = _negativeHeight;
							_h = 
							( _num / 
								Math.abs( _config.finalMaxNum * _config.rate[ _config.rate.length - 1 ] ) ) 
							* _h;
							_y = _sp.y + _positiveHeight + _negativeOffset ;
							_negativeOffset += _h;
							
							if( _num ){
								_stackItem.hasNegative = _rectItem.isNegative = true
							}
						}else{
							
							_h = ( _num / _maxNum || 1 ) * _positiveHeight;
							
							_y = _sp.y + _positiveHeight - _h - _positiveOffset;
//							if( _k === 0 ) {
//								Log.log( _num, _maxNum, _positiveHeight, _y, _h );
//							}
							_positiveOffset += _h;
							_rectY = _y;
							
							_stackItem.hasPositive = true;
						}
						_rectItem.x = _x;
						
						_rectItem.k = _k;
						_rectItem.sk = _sk;
						_rectItem.y = _y;
						_rectItem.width = _partWidth;
						_rectItem.height = _h;
						_rectItem.value = _sitem.data[ _k ];
						_rectItem.color = _config.itemColor( _sk );
						
						_tmpYAr.push( _y );
						_tmpHAr.push( _h );

						_items.push( _rectItem );
						
						if( _rectItem.isNegative ){
							_stackItem.data.negative.push( _rectItem );
						}else{
							_stackItem.data.positive.push( _rectItem );
						}
						
				});
				
				fixPositiveSort( _stackItem.data.positive );
//				_tmpDataRect.y = Math.min.apply( null, _tmpYAr );
//				_tmpDataRect.height = Math.max.apply( null, _tmpHAr );
				
				if( _config.hoverBgEnabled ){
//					_tmpDataRect.y -= _config.c.hoverPadY;
//					_tmpDataRect.height += _config.c.hoverPadY
				}
				
				if( _config.serialLabelEnabled ){
//					_tmpDataRect.y -= _config.c.serialLabelPadY;
//					_tmpDataRect.height += _config.c.serialLabelPadY
				}
				
				_stackItem.width = _partWidth;
				_stackItem.height = _positiveOffset + _negativeOffset;
				_stackItem.x = _x;;
				_stackItem.y = _rectY;
				_stackItem.k = _k;
				_stackItem.realX = _sp.x;
				_stackItem.realY = _config.c.chartY;
				_stackItem.realWidth = _config.c.hpart;
				_stackItem.realHeight = _config.c.chartHeight;
				
//				Log.log( _stackItem.x, _stackItem.y, _stackItem.width, _stackItem.height );
				
				_config.c.rects.push( _items );
				_config.c.dataRect.push( _tmpDataRect );
				_config.c.stackItems.push( _stackItem );
			});
			
			
//			Log.printFormatJSON( _config.c.stackItems );
		}
		
		private function fixPositiveSort( _positiveItems:Array ):void{
			if( !( _positiveItems && _positiveItems.length && _positiveItems.length > 1 ) ) return;
			var _tmp:Array = []
				, _tmpData:Object
				, _maxLen:int = _positiveItems.length - 1
				, _minY:Number = _positiveItems[_maxLen].y 
				;
			//				Log.log( data.data.positive[0].y, data.data.positive[1].y );
			Common.each( _positiveItems, function( _k:int, _item:Object ):void{
				_tmpData = {
					y: _minY
					, height: _item.height
				};
				_minY += _item.height;
				_tmp.push( _tmpData );
			} );
			Common.each( _positiveItems, function( _k:int, _item:Object ):void{
//				Log.log( _item.x, _tmp[ _k ].y, _item.width, _tmp[ _k ].height );
				_item.y = _tmp[ _k ].y;
				_item.height = _tmp[ _k ].height;
			});
		}
		
		private function calcChartPoint():void{
			facade.registerMediator( new StackBgLineMediator() );
			
			calcChartVPoint();
			calcChartHPoint();
		}
		
		private function calcChartVPoint():void{
			var _partN:Number = _config.c.chartHeight / ( _config.rate.length -1 )
				;
			_config.c.vpart = _partN;
			_config.c.itemHeight = _partN / 2;
			_config.c.vpoint = [];
			_config.c.vpointReal = [];
			
			
			var _padX:Number = 0;
			if( !_config.yAxisEnabled ){
			}
			
			Common.each( _config.rate, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.chartY + _partN * _k;
				_config.c.vpoint.push( {
					start: new Point( _config.c.chartX, _n )
					, end: new Point( _config.c.chartX +_config.c.chartWidth, _n )
				});
				
				_config.c.vpointReal.push( {
					start: new Point( _config.c.chartX, _n )
					, end: new Point( _config.c.chartX +_config.c.chartWidth, _n )
				});
			});
		}
		
		private function calcChartHPoint():void{
			if( !_config.yAxisEnabled ){
//				_config.c.chartWidth -= ( _config.vlabelSpace + 2 );
			}
			var _partN:Number = _config.c.chartWidth / ( _config.categories.length || 1 )
				;
			
			_config.c.hpart = _partN;
			_config.c.hpoint = [];
			_config.c.hlinePoint = [];
			_config.c.hpointReal = [];
			_config.c.itemWidthRate = 2;
			_config.c.itemWidth = _partN / 2;
						
			Common.each( _config.categories, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.chartX + _partN * _k;
				
				if( _k === 0 ){					
					_config.c.hlinePoint.push( {
						start: new Point( _n, _config.c.chartY )
						, end: new Point( _n, _config.c.chartY + _config.c.chartHeight )
					});					
				}
								
				_config.c.hlinePoint.push( {
					start: new Point( _n + _partN, _config.c.chartY )
					, end: new Point( _n + _partN, _config.c.chartY + _config.c.chartHeight )
				});
				
				_config.c.hpoint.push( {
					start: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.chartY + _config.c.chartHeight )
					, end: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.chartY + _config.c.chartHeight )
				});
				
				_config.c.hpointReal.push( {
					start: new Point( _n + _partN, _config.c.chartY )
					, end: new Point( _n + _partN, _config.c.chartY + _config.c.chartHeight )
				});
			});
		}
		
		private function get pLegendMediator():BaseLegendMediator{
			return facade.retrieveMediator( BaseLegendMediator.name ) as BaseLegendMediator;
		}
		
		private function get pSerialLabelMediator():BaseSeriesLabelMediator{
			return facade.retrieveMediator( BaseSeriesLabelMediator.name ) as BaseSeriesLabelMediator;
		}
		
		private function get pHLabelMediator():BaseHLabelMediator{
			return facade.retrieveMediator( BaseHLabelMediator.name ) as BaseHLabelMediator;
		}
	
		private function get pVLabelMediator():BaseVLabelMediator{
			return facade.retrieveMediator( BaseVLabelMediator.name ) as BaseVLabelMediator;
		}
		
		private function get pCreditMediator():BaseCreditMediator{
			return facade.retrieveMediator( BaseCreditMediator.name ) as BaseCreditMediator;
		}
		
		private function get pVTitleMediator():BaseVTitleMediator{
			return facade.retrieveMediator( BaseVTitleMediator.name ) as BaseVTitleMediator;
		}
		
		private function get pSubtitleMediator():BaseSubtitleMediator{
			return facade.retrieveMediator( BaseSubtitleMediator.name ) as BaseSubtitleMediator;
		}
		
		private function get pTitleMediator():BaseTitleMediator{
			return facade.retrieveMediator( BaseTitleMediator.name ) as BaseTitleMediator;
		}
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		private function get pLegendProxy():LegendProxy{
			return facade.retrieveProxy( LegendProxy.name ) as LegendProxy;
		}
		
		private function corner():uint{
			return 20;
		}
	}
}