package org.xas.jchart.mixchart.controller
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
	import org.xas.jchart.common.data.mixchart.MixChartModelItem;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.data.test.MixChartData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.LegendProxy;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.mixchart.view.mediator.*;
	
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
			
			_c.minX = _c.x + _config.vlabelSpace + 2;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _config.stageWidth - 5;
			_c.maxY = _c.y + _config.stageHeight - 5;
			
			_c.arrowLength = 8;
						
			facade.registerMediator( new BgMediator( ) );
			var _yPad:Number = _c.minY;
			
			if( _config.cd ){			
				
				if( _config.cd.title && _config.cd.title.text ){
					facade.registerMediator( new TitleMediator( _config.cd.title.text ) )	
					_config.c.title = { x: _config.stageWidth / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;			
				}
				
				if( _config.cd.subtitle && _config.cd.subtitle.text ){
					facade.registerMediator( new SubtitleMediator( _config.cd.subtitle.text ) )
					
					_config.c.subtitle = { x: _config.stageWidth / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height + 5;
				}
				
				if( _config.legendEnabled ){
					
					facade.registerProxy( new LegendProxy() );
					facade.registerMediator( new LegendMediator() );
					
					pLegendProxy.dataModel.calLegendPosition( pLegendMediator.view );
				}
				
				/*
				if( _config.cd.yAxis && _config.cd.yAxis.title && _config.cd.yAxis.title.text ){
					facade.registerMediator( new VTitleMediator( _config.cd.yAxis.title.text ) )
					
					_config.c.vtitle = { x: _config.c.minX, y: _config.c.x + _config.c.height / 2, item: pVTitleMediator };
					_config.c.minX += pVTitleMediator.view.width - _config.vlabelSpace;
				}
				*/
				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new CreditMediator( _config.cd.credits.text, _config.cd.credits.href ) )
					
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}	
				
				_config.c.maxX -= 5;
				
				
				if( _config.yAxisEnabled ){
					
					facade.registerMediator( new MixChartVLabelMediator() );
					
					Common.each( _config.mixModel.items, function( _k:int, _item:MixChartModelItem ):void{
						if( !_item.enabeld ) return;
						if( _item.isOpposite ){
							_config.c.maxX -= pMixChartVLabelMediator.getMaxWidth( _k );
							_item.left = _config.c.maxX;
							_config.c.maxX -= _config.vlabelSpace;
							_config.c.hasOppositeYAxis = true;

						}else{
							_config.c.hasYAxis = true;
							_config.c.minX += pMixChartVLabelMediator.getMaxWidth( _k );
							_item.left = _config.c.minX;
							_config.c.minX += _config.vlabelSpace;

						}
					});
					
					if( _config.c.hasYAxis ){
						_config.c.maxX -= _config.c.arrowLength;
					}
					
					if( _config.c.hasOppositeYAxis ){
						
					}
				}

				_config.c.hoverPadY = 10;
				if( _config.hoverBgEnabled ){
					facade.registerMediator( new HoverBgMediator() );
					_config.c.minY += _config.c.hoverPadY;
					_yPad += _config.c.hoverPadY;
				}
				
				if( _config.itemBgEnabled ){
					facade.registerMediator( new ItemBgMediator() );
				}
				
				_config.c.serialLabelPadY = 15;
				if( _config.serialLabelEnabled ){
					facade.registerMediator( new SerialLabelMediator() );
					_config.c.minY += _config.c.serialLabelPadY;
					_yPad += _config.c.serialLabelPadY;
				}
				
				if( _config.yAxisEnabled ){
					_config.c.chartWidth = _config.c.maxX - _config.c.minX - 5;
				}else{
					//_config.c.chartWidth = _config.c.maxX - 5;
					_config.c.chartWidth = _config.c.maxX - _config.c.minX;
				}
				
				if( _config.categories && _config.categories.length ){
					if( _config.displayAllLabel ){
						_config.c.labelWidth = _config.c.chartWidth / ( _config.categories.length ) / 2;
					}else{
						_config.c.labelWidth = _config.c.chartWidth / 7;
					}
				}
				
				if( _config.xAxisEnabled ){
					facade.registerMediator( new HLabelMediator() );
					_config.c.maxY -= pHLabelMediator.maxHeight;
				}
			
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
				
				_config.c.chartX = _config.c.minX + _config.c.arrowLength - 2;
				_config.c.chartY = _config.c.minY;
				
				facade.registerMediator( new GraphicBgMediator() );	
				_config.tooltipEnabled && facade.registerMediator( new TipsMediator() );
				//Log.log( _config.tooltipEnabled );
								
				calcChartPoint();
				//_config.mixModel.calcGraphic();
				
				_config.c.mix = {};
				Common.each( _config.mixModel.graphicType, function( _k:String, _item:* ):void{
					//Log.printClass( _item.model as MixChartModelItem );
					//Log.printJSON( _item );
					_config.c.mix[ _k ] = {};
					sendNotification( JChartEvent.MIX_CHART_CALC_COORDINATE_PREFIX + _k, _item, _k );
				});
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new TestMediator( MixChartData.instance.data ) );	
				}
				
				//Log.log( _config.c.chartWidth, _config.c.chartHeight );
			}
									
			sendNotification( JChartEvent.SHOW_CHART );			
		}
				
		private function calcChartPoint():void{
			facade.registerMediator( new BgLineMediator() );
			
			calcChartVPoint();
			calcChartHPoint();
		}
		
		private function calcChartVPoint():void{
			var _partN:Number = _config.c.chartHeight / ( _config.rate.length -1 )
				, _sideLen:Number = _config.c.arrowLength
				;
			_config.c.vpart = _partN;
			_config.c.itemHeight = _partN / 2;
			_config.c.vpoint = [];
			_config.c.vpointReal = [];
			
			
			var _padX:Number = 0;
			if( !_config.yAxisEnabled ){
			}
			
			Common.each( _config.rate, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.minY + _partN * _k, _sideLen:int = _config.c.arrowLength;
				_config.c.vpoint.push( {
					start: new Point( _config.c.minX + _padX, _n )
					, end: new Point( _config.c.maxX + _padX, _n )
				});
				
				_config.c.vpointReal.push( {
					start: new Point( _config.c.minX + _sideLen, _n )
					, end: new Point( _config.c.maxX + _sideLen, _n )
				});
			});
		}
		
		private function calcChartHPoint():void{
			if( !_config.yAxisEnabled ){
				_config.c.chartWidth -= ( _config.vlabelSpace + 2 );
			}
			var _partN:Number = _config.c.chartWidth / ( _config.categories.length )
				, _sideLen:Number = _config.c.arrowLength
				;
			
			_config.c.hpart = _partN;
			_config.c.hpoint = [];
			_config.c.hlinePoint = [];
			_config.c.hpointReal = [];
			_config.c.itemWidthRate = 2;
			_config.c.itemWidth = _partN / _config.c.itemWidthRate;
						
			Common.each( _config.categories, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.minX + _partN * _k + 5, _sideLen:int = _config.c.arrowLength;
				
				if( _k === 0 ){					
					_config.c.hlinePoint.push( {
						start: new Point( _n, _config.c.minY )
						, end: new Point( _n, _config.c.maxY + 1 )
					});					
				}
								
				_config.c.hlinePoint.push( {
					start: new Point( _n + _partN, _config.c.minY )
					, end: new Point( _n + _partN, _config.c.maxY + 1 )
				});
				
				_config.c.hpoint.push( {
					start: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.maxY )
					, end: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.maxY + _sideLen )
				});
				
				_config.c.hpointReal.push( {
					start: new Point( _n, _config.c.minY )
					, end: new Point( _n, _config.c.maxY )
				});
			});
		}
		
		private function get pLegendMediator():LegendMediator{
			return facade.retrieveMediator( LegendMediator.name ) as LegendMediator;
		}
		
		private function get pSerialLabelMediator():SerialLabelMediator{
			return facade.retrieveMediator( SerialLabelMediator.name ) as SerialLabelMediator;
		}
		
		private function get pHLabelMediator():HLabelMediator{
			return facade.retrieveMediator( HLabelMediator.name ) as HLabelMediator;
		}
		
		private function get pMixChartVLabelMediator():MixChartVLabelMediator{
			return facade.retrieveMediator( MixChartVLabelMediator.name ) as MixChartVLabelMediator;
		}
		
		private function get pCreditMediator():CreditMediator{
			return facade.retrieveMediator( CreditMediator.name ) as CreditMediator;
		}
		
		private function get pVTitleMediator():VTitleMediator{
			return facade.retrieveMediator( VTitleMediator.name ) as VTitleMediator;
		}
		
		private function get pSubtitleMediator():SubtitleMediator{
			return facade.retrieveMediator( SubtitleMediator.name ) as SubtitleMediator;
		}
		
		private function get pTitleMediator():TitleMediator{
			return facade.retrieveMediator( TitleMediator.name ) as TitleMediator;
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
