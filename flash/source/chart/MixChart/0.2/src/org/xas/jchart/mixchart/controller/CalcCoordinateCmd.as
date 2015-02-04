package org.xas.jchart.mixchart.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.ui.text.RotationText;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.BaseMixChartModelItem;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.data.test.MixChartData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.LegendProxy;
	import org.xas.jchart.common.ui.widget.DisplayRotation;
	import org.xas.jchart.common.view.mediator.BgLineMediator.BaseBgLineMediator;
	import org.xas.jchart.common.view.mediator.BgLineMediator.MixChartBgLineMediator;
	import org.xas.jchart.common.view.mediator.BgMediator.BaseBgMediator;
	import org.xas.jchart.common.view.mediator.CreditMediator.BaseCreditMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.MixChartGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.MixChartHLabelMediator;
	import org.xas.jchart.common.view.mediator.HoverBgMediator.BaseHoverBgMediator;
	import org.xas.jchart.common.view.mediator.ItemBgMediator.BaseItemBgMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.MixChartLegendMediator;
	import org.xas.jchart.common.view.mediator.MainMediator;
	import org.xas.jchart.common.view.mediator.MixChartVLabelMediator.BaseMixChartVLabelMediator;
	import org.xas.jchart.common.view.mediator.MixChartVTitleMediator.BaseMixChartVTitleMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.BaseSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.MixChartSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator.BaseSubtitleMediator;
	import org.xas.jchart.common.view.mediator.TestMediator.BaseTestMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.MixChartTipsMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator.BaseTitleMediator;
	import org.xas.jchart.mixchart.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		private var _config:Config;
		
		public function CalcCoordinateCmd()
		{
			super();
			 
			_config = BaseConfig.ins as Config;
			
//			Log.log( _config.serialLabelEnabled, _config.superSerialLabelEnabled );
		}
		
		override public function execute(notification:INotification):void{
			
			_c = _config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();

			_c.vtitle = {};
									
			facade.registerMediator( new BaseBgMediator( ) );
			var _yPad:Number = _c.minY;
			
//			Log.log( 'labelRotation:', _config.labelRotationEnable );
			
			if( _config.cd ){			
				
				if( _config.titleEnable ){
					facade.registerMediator( new BaseTitleMediator( _config.titleText ) )	
					_config.c.title = { x: _config.stageWidth / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;			
				}
				
				if( _config.subtitleEnable ){
					facade.registerMediator( new BaseSubtitleMediator( _config.subtitleText ) )
					
					_config.c.subtitle = { x: _config.stageWidth / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height + 5;
				}
				
				if( _config.legendEnabled ){
					
					facade.registerProxy( new LegendProxy() );
					facade.registerMediator( new MixChartLegendMediator() );
					
					pLegendProxy.dataModel.calLegendPosition( pLegendMediator.view );
				}

				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new BaseCreditMediator( _config.cd.credits.text, _config.cd.credits.href ) )
					
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}	
				
//				_config.c.maxX -= 5;
				
				
				if( _config.yAxisEnabled ){
					
					facade.registerMediator( new BaseMixChartVLabelMediator() );
					
					if( _config.hasVTitle ){
						//Log.log( 'hasVTitle', new Date().getTime() );
						facade.registerMediator( new BaseMixChartVTitleMediator() );
					}
					
					Common.each( _config.mixModel.items, function( _k:int, _item:BaseMixChartModelItem ):void{
						if( !_item.enabeld ) return;
						if( _item.isOpposite ) return;

						if( _item.hasVTitle ){
							
							_config.c.vtitle[ _k ] = {
								x: _config.c.minX + pMixChartVTitleMediator.getWidth( _k ) / 2
								, y: _config.c.height / 2
							}
							
							_config.c.minX += pMixChartVTitleMediator.getWidth( _k );
						}
						
						_config.c.minX += pMixChartVLabelMediator.getMaxWidth( _k );
						_item.left = _config.c.minX ;
						_config.c.minX += _config.vlabelSpace;
						
						_config.c.hasYAxis = true;
					});
					
					Common.each( _config.mixModel.items, function( _k:int, _item:BaseMixChartModelItem ):void{
						if( !_item.enabeld ) return;
						if( !_item.isOpposite ) return;

						if( _item.hasVTitle ){
							_config.c.maxX -= pMixChartVTitleMediator.getWidth( _k );
							
							_config.c.vtitle[ _k ] = {
								x: _config.c.maxX + pMixChartVTitleMediator.getWidth( _k ) / 2
								, y: _config.c.height / 2
							}
							
						}
						
						_config.c.maxX -= pMixChartVLabelMediator.getMaxWidth( _k );
						_item.left = _config.c.maxX;
						_config.c.maxX -= _config.vlabelSpace;
						
						_config.c.hasOppositeYAxis = true;
					}, true );
					
					if( _config.c.hasYAxis ){
						_config.c.minX += _config.yArrowLength;
					}
					
					if( _config.c.hasOppositeYAxis ){
						_config.c.maxX -= _config.yArrowLength;
					}
				}

				_config.c.hoverPadY = 10;
				if( _config.hoverBgEnabled ){
					facade.registerMediator( new BaseHoverBgMediator() );
					_config.c.minY += _config.c.hoverPadY;
					_yPad += _config.c.hoverPadY;
				}
				
				if( _config.itemBgEnabled ){
					facade.registerMediator( new BaseItemBgMediator() );
				}
				
				_config.c.serialLabelPadY = 15;
				if( _config.serialLabelEnabled ){
					facade.registerMediator( new MixChartSeriesLabelMediator() );
				}
				
				if( _config.xAxisEnabled ){
					facade.registerMediator( new MixChartHLabelMediator() );
					
					_config.c.maxY -= pHLabelMediator.maxHeight;
					
					var _tmpMaxWidth:Number = pHLabelMediator.maxWidth;
					
					if( _tmpMaxWidth < 0 ){
						_config.c.minX += Math.abs( _tmpMaxWidth );
					} else {
						_config.c.maxX -= _tmpMaxWidth;
					}

				}else{
					_config.c.maxY -= _config.vspace;
				}
				_config.c.chartWidth = _config.c.maxX - _config.c.minX;
			
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
				
				_config.c.chartX = _config.c.minX - 2;
				_config.c.chartY = _config.c.minY;
				
				if( _config.yAxisEnabled ){
					
					Common.each( _config.mixModel.items, function( _k:int, _item:BaseMixChartModelItem ):void{
						if( !_item.enabeld ) return;
												
						if( _item.hasVTitle && _config.c.vtitle[ _k ] ){
							_config.c.vtitle[ _k ].y = _config.c.chartY +  _config.c.chartHeight / 2
						}
					});
				}
//				Log.log( _config.c.chartY, _config.c.chartHeight );
				
				sendNotification( JChartEvent.DISPLAY_ALL_CHECK );
				
				facade.registerMediator( new MixChartGraphicBgMediator() );	
				_config.tooltipEnabled && facade.registerMediator( new MixChartTipsMediator() );
				//Log.log( _config.tooltipEnabled );
								
				calcChartPoint();
				//_config.mixModel.calcGraphic();
								
				if( _config.yAxisEnabled && _config.labelRotationEnable ){
					//Log.log( _config.c.chartX );
					var _fixOffset:Number = _config.c.chartX
						, _opOffset:Number = _config.c.chartX + _config.c.chartWidth
						;
					if( _config.vlineEnabled ){
						_fixOffset -= _config.xArrowLength;
						_opOffset +=_config.xArrowLength;
					}
					Common.each( _config.mixModel.items, function( _k:int, _item:BaseMixChartModelItem ):void{
						if( !_item.enabeld ) return;
						if( _item.isOpposite ) return;
						_fixOffset -= 1;
						_item.left = _fixOffset;
						_fixOffset -= pMixChartVLabelMediator.getMaxWidth( _k );
						
						if( _item.hasVTitle ){
							_fixOffset -= pMixChartVTitleMediator.getWidth( _k ) / 2 ;
							_config.c.vtitle[ _k ].x = _fixOffset;
							_fixOffset -= pMixChartVTitleMediator.getWidth( _k ) / 2 ;
							_fixOffset -= _config.vlabelSpace;
						}
					}, true );
					
					Common.each( _config.mixModel.items, function( _k:int, _item:BaseMixChartModelItem ):void{
						if( !_item.enabeld ) return;
						if( !_item.isOpposite ) return;
						
						_opOffset += 1;
						_item.left = _opOffset;
						_opOffset += pMixChartVLabelMediator.getMaxWidth( _k );
						
						if( _item.hasVTitle ){
							_opOffset += pMixChartVTitleMediator.getWidth( _k ) / 2 ;
							_config.c.vtitle[ _k ].x = _opOffset;
							_opOffset += pMixChartVTitleMediator.getWidth( _k ) / 2 ;
							_opOffset += _config.vlabelSpace;
						}
					} );
				}
				
				_config.c.mix = {};
				Common.each( _config.mixModel.graphicType, function( _k:String, _item:* ):void{
					//Log.printClass( _item.model as MixChartModelItem );
					//Log.printJSON( _item );
					_config.c.mix[ _k ] = { srcData: _item };
					sendNotification( JChartEvent.MIX_CHART_CALC_COORDINATE_PREFIX + _k, _item, _k );
				});
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new BaseTestMediator( MixChartData.instance.data ) );	
				}
				
				//Log.log( _config.c.chartWidth, _config.c.chartHeight );
			}
			
			sendNotification( JChartEvent.SHOW_CHART );		
			
//			var _textf:DisplayRotation = new DisplayRotation( '123456789', 90, function( _stf:TextField ):void{
//				
//				Common.implementStyle( _stf, [
//					DefaultOptions.title.style
//				] );
//				
//			});
//			//_textf.x = 0;
//			//_textf.y = 0;
//			mainMediator.view.index12.addChild( _textf );	
		}
				
		private function calcChartPoint():void{
			facade.registerMediator( new MixChartBgLineMediator() );
			
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
			
			Common.each( _config.rate, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.chartY + _partN * _k;
				_config.c.vpoint.push( {
					start: new Point( _config.c.chartX, _n )
					, end: new Point( _config.c.chartX + _config.c.chartWidth + 1, _n )
				});
				
				_config.c.vpointReal.push( {
					start: new Point( _config.c.chartX, _n )
					, end: new Point( _config.c.chartX + _config.c.chartWidth, _n )
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
					start: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.chartY + _config.c.chartHeight  )
					, end: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.chartY + _config.c.chartHeight )
				});
				
				_config.c.hpointReal.push( {
					start: new Point( _n, _config.c.chartY )
					, end: new Point( _n, _config.c.chartY + _config.c.chartHeight )
				});
			});
		}
		
		private function get pMixChartVTitleMediator():BaseMixChartVTitleMediator{
			return facade.retrieveMediator( BaseMixChartVTitleMediator.name ) as BaseMixChartVTitleMediator;
		}
		
		private function get pMixChartVLabelMediator():BaseMixChartVLabelMediator{
			return facade.retrieveMediator( BaseMixChartVLabelMediator.name ) as BaseMixChartVLabelMediator;
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
		
		private function get pCreditMediator():BaseCreditMediator{
			return facade.retrieveMediator( BaseCreditMediator.name ) as BaseCreditMediator;
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
