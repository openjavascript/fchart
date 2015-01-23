package org.xas.jchart.vzhistogram.controller
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
	import org.xas.jchart.common.data.test.ZHistogramData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.common.view.mediator.BgLineMediator.VHistogramBgLineMediator;
	import org.xas.jchart.common.view.mediator.BgMediator.BaseBgMediator;
	import org.xas.jchart.common.view.mediator.CreditMediator.BaseCreditMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.VZHistogramGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.VZHistogramHLabelMediator;
	import org.xas.jchart.common.view.mediator.HoverBgMediator.VHoverBgMediator;
	import org.xas.jchart.common.view.mediator.ItemBgMediator.VItemBgMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.ZLegendMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.BaseSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.VZHistogramSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator.BaseSubtitleMediator;
	import org.xas.jchart.common.view.mediator.TestMediator.BaseTestMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.ZHistogramTipsMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator.BaseTitleMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.BaseVLabelMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.VZHistogramVLabelMediator;
	import org.xas.jchart.common.view.mediator.VTitleMediator.BaseVTitleMediator;
	import org.xas.jchart.vzhistogram.view.mediator.*;
	
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
			
			_c.minX = _config.vlabelSpace + 2;
			_c.minY = _c.y + _config.vspace * 2;
			_c.maxX = _c.x + _config.stageWidth - _config.vspace;
			_c.maxY = _config.stageHeight - _config.vspace;
						
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
				
				if( _config.vtitleEnabled ){
					facade.registerMediator( new BaseVTitleMediator( _config.vtitleText ) )
					
					_config.c.vtitle = { x: _config.c.minX, y: _config.c.x + _config.c.height / 2, item: pVTitleMediator };
					_config.c.minX += pVTitleMediator.view.width - _config.vlabelSpace + _config.vspace;
				} else {
					_config.c.minX += _config.vspace;
				}
				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new BaseCreditMediator( _config.cd.credits.text, _config.cd.credits.href ) )
					
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}
				
				if( _config.legendEnabled ){
					facade.registerMediator( new ZLegendMediator() );
					_config.c.maxY -= pLegendMediator.view.height;
					_config.c.legend = { 
						x: _config.width / 2 - pLegendMediator.view.width / 2
						, y: _config.c.maxY
					};
					_config.c.maxY -= 2;
				}
				
//				_config.c.maxX -= 5;
				
//				//初始化vlabel,并修改图标最大Y的范围
//				if( _config.yAxisEnabled ){
//					facade.registerMediator( new VLabelMediator() );
//					_config.c.maxY -= pVLabelMediator.maxHeight;
//					_config.c.maxY -= 2;
//				}

				_config.c.hoverPadY = 10;
				if( _config.hoverBgEnabled ){
					facade.registerMediator( new VHoverBgMediator() );
					_config.c.minY += _config.c.hoverPadY;
					_yPad += _config.c.hoverPadY;
				}
				
				if( _config.itemBgEnabled ){
					facade.registerMediator( new VItemBgMediator() );
				}
				
				_config.c.serialLabelPadY = 15;
				if( _config.serialLabelEnabled ){
					facade.registerMediator( new VZHistogramSeriesLabelMediator() );
//					_config.c.minY += _config.c.serialLabelPadY;
//					_yPad += _config.c.serialLabelPadY;
				}
				
				if( _config.categories && _config.categories.length ){
					_config.c.labelWidth = _config.c.chartWidth / ( _config.categories.length ) / 2;
				}
				
				if( _config.xAxisEnabled ){
					facade.registerMediator( new VZHistogramHLabelMediator() );
					_config.c.minX += pHLabelMediator.maxWidth;
				}
				
				//初始化vlabel,并修改图标最大Y的范围
				if( _config.yAxisEnabled ){
					facade.registerMediator( new VZHistogramVLabelMediator() );
					_config.c.maxY -= pVLabelMediator.maxHeight;
					//					_config.c.maxX = pVLabelMediator.maxWidth;
					var _tmpMaxWidth:Number = pVLabelMediator.maxWidth;
					//					Log.log( _tmpMaxWidth );
					if( _tmpMaxWidth > 0 ){
						_config.c.maxX -= Math.abs( _tmpMaxWidth );
					} else {
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
				}else{	
					_config.c.chartHeight = _config.c.maxY - _config.c.minY;
				}
				
				_config.c.chartX = _config.c.minX + _config.yArrowLength - 2;
				_config.c.chartY = _config.c.minY;
				
				facade.registerMediator( new VZHistogramGraphicBgMediator() );	
				_config.tooltipEnabled && facade.registerMediator( new ZHistogramTipsMediator() );
				
				sendNotification( JChartEvent.DISPLAY_ALL_CHECK, {}, 'vzbar' );

				
				calcChartPoint();
				
				calcGraphic();
				
				_config.c.totalArray = _config.totalArray;
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new BaseTestMediator( ZHistogramData.instance.data ) );	
				}
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
				_config.c.itemWidth / _config.displaySeries.length;
			
			if( _config.displaySeries.length > 1 ){				
				_config.c.partSpace = 4; 
				_config.c.partWidth = ( _config.c.itemWidth - ( _config.displaySeries.length - 1 ) * _config.c.partSpace
					) / _config.displaySeries.length;
			}
			
			var _partWidth:Number = ( _config.c.hpart * 3 / 4 );
			_partWidth > 50 && ( _partWidth = 50 );
			
//			Log.printObject( _config.c.itemMax( 1 ) );
			
			/* 处理柱状体 */
			Common.each( _config.displaySeries, function( _k:int, _item:Object ):void{
				
				var _items:Array = []
					, _pointItem:Object = _config.c.hlinePoint[ _k ]
					, _sp:Point = _pointItem.start as Point
					, _ep:Point = _pointItem.end as Point
					, _y:Number = _sp.y + ( _config.c.hpart - _partWidth ) / 2  //_config.c.hpart * 1 / 8
					, _tmpDataRect:Object = {
						x: _sp.y, y: _sp.y
						, width: 0
						, height:  _config.c.itemHeight * 2
					}
					, _tmpYAr:Array = []
					, _tmpHAr:Array = []
					, _tmpChartHeightAr:Array = [];
					
				Common.each( _item.data, function( _sk:int, _sitem:Number ):void{
					var _rectItem:Object = {}
						, _num:Number = _sitem
						, _itemNum:Number
						, _h:Number
						, _nx:Number = _config.c.chartX + _config.c.vpart * ( _config.rate.length - 1 - _config.rateZeroIndex )
						, _maxNum:Number = _config.chartMaxNum;
						
						
						if( _sk == 0 ){
							_tmpChartHeightAr[ _k ] = _nx;
						}
						
						if( _config.isAutoRate && !_config.hasNegative ){
							_num -= _config.minNum;
							_maxNum -= _config.minNum;
						}
						
						if( _config.isItemPercent && _config.displaySeries.length > 1 ){
							_h = _config.c.vpart * _config.rateZeroIndex;
							_h = ( _num / _config.itemMax( _k ) || 0 ) * _h;
						} else {
							if( Common.isNegative( _num ) || _num == 0 ){/* 负数或0 */
								_num = Math.abs( _num );
								if( _num == 0 ){
									_h = 0;
								} else {
									_h = ( ( _config.rate.length - 1 ) - _config.rateZeroIndex )
									* _config.c.vpart;
									_h = ( _num / Math.abs( _config.finalMaxNum * 
										_config.rate[ _config.rate.length - 1 ] ) ) * _h;
								}
								_nx -= _h;
								_rectItem.isNegative = true;
							} else {
								_h = ( _num / _config.chartMaxNum || 1 ) * 
									_config.c.vpart * _config.rateZeroIndex;
							}
						}
						
						_h = _h || 1;
						_partWidth = _partWidth || 1;
						
						_rectItem.y = _y;
						_rectItem.x = _tmpChartHeightAr[ _k ];//_nx - 1;
						_tmpChartHeightAr[ _k ] += _h;
						_rectItem.width = _h;
						_rectItem.height = _partWidth;
						_rectItem.value = _sitem;
						
						_tmpYAr.push( _nx );
						_tmpHAr.push( _h );
						
						_items.push( _rectItem );
						
						_tmpDataRect.width += _h;
				});
				
				_tmpDataRect.y = Math.min.apply( null, _tmpYAr );
//				_tmpDataRect.width = Math.max.apply( null, _tmpHAr );
				_tmpDataRect.initType = 'VHistogram';
				
				if( _config.hoverBgEnabled ){
					_tmpDataRect.y -= _config.c.hoverPadY;
					_tmpDataRect.width += _config.c.hoverPadY;
					_tmpDataRect.height = _config.c.hpart;
				}
				
				if( _config.serialLabelEnabled ){
//					_tmpDataRect.y -= _config.c.serialLabelPadY;
					//_tmpDataRect.height += _config.c.serialLabelPadX
				}
				
				_config.c.rects.push( _items );
				_config.c.dataRect.push( _tmpDataRect );
			});
		}
		
		private function calcChartPoint():void{
			facade.registerMediator( new VHistogramBgLineMediator() );
			
			calcChartVPoint();
			calcChartHPoint();
		}
		
		/* 处理柱状图粒度 */
		private function calcChartVPoint():void{
			var _partN:Number = _config.c.chartWidth / ( _config.rate.length -1 )
				;
			
			_config.c.vpart = _partN;
			_config.c.itemWidth = _partN / 2;
			_config.c.vpoint = [];
			_config.c.vpointReal = [];
			
			
			var _startX:Number;
			
			Common.each( _config.rate, function( _k:int, _item:* ):void{
				_startX = _config.c.chartX + _config.c.chartWidth - _partN * _k;
					
				_config.c.vpoint.push( {
					start: new Point( _startX, _config.c.chartY )
					, end: new Point( _startX, _config.c.chartY + _config.c.chartHeight )
				});
				
				_config.c.vpointReal.push( {
					start: new Point( _startX, _config.c.chartY )
					, end: new Point( _startX, _config.c.chartY + _config.c.chartHeight )
				});
			});
		}
		
		/* 处理柱状图分组 */
		private function calcChartHPoint():void{
			if( !_config.yAxisEnabled ){
//				_config.c.chartWidth -= ( _config.vlabelSpace + 2 );
			}
			
			var _partN:Number = _config.c.chartHeight / ( _config.displaySeries.length || 1 );
			
			_config.c.hpart = _partN;
			_config.c.hpoint = [];
			_config.c.hlinePoint = [];
			_config.c.hpointReal = [];
			_config.c.itemHeightRate = 2;
			_config.c.itemHeight = _partN / _config.c.itemHeightRate;
			
			Common.each( _config.displaySeries, function( _k:int, _item:* ):void{
				var _topY:Number = _config.c.chartY + _partN * _k
					, _bottomY:Number = _topY + _partN;
					
				if( _k === 0 ){
					_config.c.hlinePoint.push( {
						start: new Point( _config.c.chartX, _topY )
						, end: new Point( _config.c.chartX + _config.c.chartHeight, _topY )
					});					
				}
								
				_config.c.hlinePoint.push( {
					start: new Point( _config.c.chartX, _bottomY )
					, end: new Point( _config.c.chartX + _config.c.chartHeight, _bottomY )
				});
				
				_config.c.hpoint.push( {
					start: new Point( _config.c.chartX, _bottomY - _partN / 2 )
					, end: new Point( _config.c.chartX, _bottomY - _partN / 2 )
				});
				
				_config.c.hpointReal.push( {
					start: new Point( _config.c.chartX, _topY )
					, end: new Point( _config.c.chartX + _config.c.chartHeight, _topY )
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
		
		private function corner():uint{
			return 20;
		}
	}
}
