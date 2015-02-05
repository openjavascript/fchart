package org.xas.jchart.histogram.controller
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
	import org.xas.jchart.common.view.mediator.BgMediator.BaseBgMediator;
	import org.xas.jchart.common.view.mediator.CreditMediator.BaseCreditMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.StackGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.StackHLabelMediator;
	import org.xas.jchart.common.view.mediator.HoverBgMediator.HistogramHoverBgMediator;
	import org.xas.jchart.common.view.mediator.ItemBgMediator.StackItemBgMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.BaseSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.HistogramSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator.BaseSubtitleMediator;
	import org.xas.jchart.common.view.mediator.TestMediator.BaseTestMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.HistogramTipsMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator.BaseTitleMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.BaseVLabelMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.StackVLabelMediator;
	import org.xas.jchart.common.view.mediator.VTitleMediator.BaseVTitleMediator;
	import org.xas.jchart.histogram.view.mediator.*;
	
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
									
			facade.registerMediator( new BaseBgMediator( ) );
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
					facade.registerMediator( new BaseLegendMediator() );
					
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

				_config.c.hoverPadY = 10;
				if( _config.hoverBgEnabled ){
					facade.registerMediator( new HistogramHoverBgMediator() );
					_config.c.minY += _config.c.hoverPadY;
					_yPad += _config.c.hoverPadY;
				}
				
				if( _config.itemBgEnabled ){
					facade.registerMediator( new StackItemBgMediator() );
				}
				
				_config.c.serialLabelPadY = 15;
				if( _config.serialLabelEnabled ){
					facade.registerMediator( new HistogramSeriesLabelMediator() );
//					_config.c.minY += _config.c.serialLabelPadY;
//					_yPad += _config.c.serialLabelPadY;
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
				_config.tooltipEnabled && facade.registerMediator( new HistogramTipsMediator() );
				//Log.log( _config.tooltipEnabled );
				
				
				/* 添加HLabel重计算 */
				
				calcChartPoint();
				
				calcGraphic();
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new BaseTestMediator( DefaultData.instance.data ) );	
				}
				//Log.log( _config.c.chartWidth, _config.c.chartHeight );
			}
			
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{
			facade.registerMediator( new GraphicMediator() );
			
			_config.c.rects = [];
			_config.c.dataRect = [];
			
			if( !( _config.series && _config.series.length ) ) return;
			
			_config.c.partSpace = 0; 
			_config.c.partWidth = 
				_config.c.itemWidth / _config.displaySeries.length
				;
			
			if( _config.displaySeries.length > 1 ){				
				_config.c.partSpace = 4; 
				_config.c.partWidth = 
					(
						_config.c.itemWidth - (_config.displaySeries.length - 1) * _config.c.partSpace
					) / _config.displaySeries.length
					;
				
				if( _config.c.partWidth < 1 ){				
					_config.c.partSpace = 0; 
					_config.c.partWidth = 
						(
							_config.c.itemWidth - (_config.displaySeries.length - 1) * _config.c.partSpace
						) / _config.displaySeries.length
						;
				}
			}
			
			//_config.c.partWidth > 50 && ( _config.c.partWidth = 50 );
			var _partWidth:Number = _config.c.partWidth
				;
			//_partWidth > 50 && ( _partWidth = 50 );
			if( _partWidth > 50 ){
				_partWidth = 50;
			}
			
			
			Common.each( _config.series[0].data, function( _k:int, _item:Object ):void{
				
				var _items:Array = []
					, _pointItem:Object = _config.c.hlinePoint[ _k ]
					, _sp:Point = _pointItem.start as Point
					, _ep:Point = _pointItem.end as Point
					//, _x:Number = _sp.x + ( _config.c.itemWidth - _config.c.itemWidth / 2 )
					, _x:Number = _sp.x 
						+ ( _config.c.itemWidth 
							- _partWidth * _config.displaySeries.length / 2
							- _config.c.partSpace * ( ( _config.displaySeries.length || 1 ) - 1 ) / 2 
						)
					, _tmp:Number = 0
					, _tmpDataRect:Object = {
						x: _sp.x, y: _sp.y
						, width: _config.c.itemWidth * 2
						, height: _ep.y - _sp.y 
					}
					, _tmpYAr:Array = []
					, _tmpHAr:Array = []
					;
									
				Common.each( _config.displaySeries, function( _sk:int, _sitem:Object ):void{
					var _rectItem:Object = {}
						, _num:Number = _sitem.data[ _k ]
						, _itemNum:Number
						, _h:Number = 0, _y:Number
						, _dataHeight:Number
						, _maxNum:Number = _config.chartMaxNum
						;
						
						if( _config.isAutoRate && !_config.hasNegative ){
							_num -= _config.minNum;
							_maxNum -= _config.minNum;
						}
						
						
						if( _config.isItemPercent && _config.displaySeries.length > 1 ){
							_h = _config.c.vpart * _config.rateZeroIndex;
							_h = ( _num / _config.itemMax( _k ) || 0 ) * _h;
							_y = _sp.y 
							+ _config.c.vpart * _config.rateZeroIndex - _h
							;
							if( _k === 0 ){
								//Log.log( _num / _config.itemMax( _k ) * 100, _num, _config.itemMax( _k ) );
							}
						}else{
							
							if( Common.isNegative( _num ) || _num == 0 ){
								_num = Math.abs( _num );
								_dataHeight = _config.c.vpart * _config.rateZeroIndex;
								
								_h = _config.c.chartHeight - _dataHeight;
								_y = _sp.y + _dataHeight ;
								_h = 
								( _num / 
									Math.abs( _config.finalMaxNum * _config.rate[ _config.rate.length - 1 ] ) ) 
								* _h;
								//Log.log( _h, _config.finalMaxNum );
								_rectItem.isNegative = true;
							}else{
								_h = _config.c.vpart * _config.rateZeroIndex;
								//Log.log( [ _config.c.vpart, _config.rateZeroIndex, _config.c.vpart * _config.rateZeroIndex ].join(', ' ) ); 
								_h = ( _num / _maxNum || 1 ) * _h;
								//Log.log( [ _num, _config.chartMaxNum, _num / _config.chartMaxNum ] );
								_y = _sp.y 
								+ _config.c.vpart * _config.rateZeroIndex - _h
								;
							}
						}						
						//Log.log( _h, _y );
						
						_rectItem.x = _x + _sk * _partWidth + _config.c.partSpace * _sk;
						_h = _h || 1;
						
						_rectItem.y = _y;
						_rectItem.width = _partWidth;
						_rectItem.height = _h;
						_rectItem.value = _sitem.data[ _k ];
						
						_tmpYAr.push( _y );
						_tmpHAr.push( _h );
						
						_items.push( _rectItem );
				});
				
				_tmpDataRect.y = Math.min.apply( null, _tmpYAr );
				_tmpDataRect.height = Math.max.apply( null, _tmpHAr );
				
				if( _config.hoverBgEnabled ){
					_tmpDataRect.y -= _config.c.hoverPadY;
					_tmpDataRect.height += _config.c.hoverPadY
				}
				
				if( _config.serialLabelEnabled ){
					_tmpDataRect.y -= _config.c.serialLabelPadY;
					_tmpDataRect.height += _config.c.serialLabelPadY
				}
				
				_config.c.rects.push( _items );
				_config.c.dataRect.push( _tmpDataRect );
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
			var _partN:Number = _config.c.chartWidth / ( _config.realItemLength || 1 )
				;
			
			_config.c.hpart = _partN;
			_config.c.hpoint = [];
			_config.c.hlinePoint = [];
			_config.c.hpointReal = [];
			_config.c.itemWidthRate = 2;
			_config.c.itemWidth = _partN / _config.c.itemWidthRate;
						
			Common.each( _config.series[0].data, function( _k:int, _item:* ):void{
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
