package org.xas.jchart.rate.controller
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
	import org.xas.jchart.common.data.test.DefaultPieData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.rate.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		
		public function CalcCoordinateCmd()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			
			_c = BaseConfig.ins.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _c.width - 5;
			_c.maxY = _c.y + _c.height - 5;
						
			facade.registerMediator( new BgMediator( ) )		
			
			if( BaseConfig.ins.cd ){			
				
				if( BaseConfig.ins.titleEnable && BaseConfig.ins.cd.title && BaseConfig.ins.cd.title.text ){
					facade.registerMediator( new BaseTitleMediator( BaseConfig.ins.cd.title.text ) )	
					BaseConfig.ins.c.title = { x: _c.width / 2, y: _c.minY, item: pTitleMediator };
					BaseConfig.ins.c.minY += pTitleMediator.view.height;			
				}
				
				if( BaseConfig.ins.subtitleEnable && BaseConfig.ins.cd.subtitle && BaseConfig.ins.cd.subtitle.text ){
					facade.registerMediator( new BaseSubtitleMediator( BaseConfig.ins.cd.subtitle.text ) )
					
					BaseConfig.ins.c.subtitle = { x: _c.width / 2, y: _c.minY, item: pSubtitleMediator };
					BaseConfig.ins.c.minY += pSubtitleMediator.view.height + 5;
				}				
				
				if( BaseConfig.ins.vtitleEnabled && BaseConfig.ins.cd.yAxis && BaseConfig.ins.cd.yAxis.title && BaseConfig.ins.cd.yAxis.title.text ){
					facade.registerMediator( new BaseVTitleMediator( BaseConfig.ins.cd.yAxis.title.text ) )
					
					BaseConfig.ins.c.vtitle = { x: BaseConfig.ins.c.minX, y: BaseConfig.ins.c.x + BaseConfig.ins.c.height / 2, item: pVTitleMediator };
					BaseConfig.ins.c.minX += pVTitleMediator.view.width - 5;
				}
				
				if( BaseConfig.ins.creditsEnabled 
					&&  BaseConfig.ins.cd.credits 
					&& BaseConfig.ins.cd.credits.enabled 
					&& ( BaseConfig.ins.cd.credits.text || BaseConfig.ins.cd.credits.href ) ){
					facade.registerMediator( new BaseCreditMediator( BaseConfig.ins.cd.credits.text, BaseConfig.ins.cd.credits.href ) )
					
					BaseConfig.ins.c.credits = { x: BaseConfig.ins.c.maxX, y: BaseConfig.ins.c.maxY, item: pCreditMediator };
					BaseConfig.ins.c.maxY -= pCreditMediator.view.height;
				}	
				
				if( BaseConfig.ins.legendEnabled ){
					facade.registerMediator( new LegendMediator() );
					BaseConfig.ins.c.maxY -= pLegendMediator.view.height;
					BaseConfig.ins.c.legend = { 
						x: BaseConfig.ins.width / 2 - pLegendMediator.view.width / 2
						, y: BaseConfig.ins.c.maxY
					};
					BaseConfig.ins.c.maxY -= 2;
				}
				
				BaseConfig.ins.c.maxX -= 5;
				
				BaseConfig.ins.c.arrowLength = 0;
				BaseConfig.ins.c.chartWidth = BaseConfig.ins.c.maxX - BaseConfig.ins.c.minX - 5;
				BaseConfig.ins.c.chartHeight = BaseConfig.ins.c.maxY - BaseConfig.ins.c.minY;	
				
				BaseConfig.ins.c.chartX = BaseConfig.ins.c.minX + BaseConfig.ins.c.arrowLength + 6.5;
				BaseConfig.ins.c.chartY = BaseConfig.ins.c.minY;
				
				BaseConfig.ins.c.chartMaxX = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth;
				BaseConfig.ins.c.chartMaxY = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight;
				
				facade.registerMediator( new GraphicBgMediator() );	
				BaseConfig.ins.tooltipEnabled && facade.registerMediator( new TipsMediator() );
								
				calcGraphic();	
				
				CONFIG::debug {	
					if( !ExternalInterface.available ){
						facade.registerMediator( new BaseTestMediator( DefaultPieData.instance.data ) );	
					}
				} 
				
				//Log.log( BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight );
			}
									
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{			
			
			facade.registerMediator( new BasePieLabelMediator() );
			facade.registerMediator( new GraphicMediator() );
			
			BaseConfig.ins.c.cx = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth / 2;
			BaseConfig.ins.c.cy = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight / 2;
			BaseConfig.ins.c.lineLength = 40;
			BaseConfig.ins.c.lineStart = 10;
			BaseConfig.ins.c.radius = calcRadius( BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight );
			
			BaseConfig.ins.c.piePart = [];
			BaseConfig.ins.c.pieLine = [];
			
			if( !( BaseConfig.ins.series && BaseConfig.ins.series.length ) ) return;
			
			var _angle:Number = 360
				, _angleCount:Number = 0
				, _offsetAngle:Number = BaseConfig.ins.offsetAngle
				, _totalNum:Number = BaseConfig.ins.totalNum
				, _tmpPoint:Point
				, _cpoint:Point = new Point( BaseConfig.ins.c.cx, BaseConfig.ins.c.cy )
				;

			Common.each( BaseConfig.ins.displaySeries, function( _k:int, _item:Object ):void {
				//if( _item.y === 0 ) return;
				var _pieP:Object = { 
						cx: BaseConfig.ins.c.cx
						, cy: BaseConfig.ins.c.cy
						, radius: BaseConfig.ins.c.radius 
						, offsetAngle: _offsetAngle
						, totalNum: _totalNum
						, data: _item
					}
					, _pieL:Object  = { data: _item }
					;
					
				_pieP.offsetAngle = _offsetAngle;		
				
				if( _item.y == _totalNum ){
					_pieP.angle = _angle;
					_pieP.percent = 100;
				}else{
					_pieP.percent = _item.y / _totalNum * 100;
					_pieP.angle = _item.y / _totalNum * _angle;
				}
				
				_pieP.startAngle = ( _angleCount + _offsetAngle ) % _angle;
				_pieP.midAngle = ( _pieP.startAngle + _pieP.angle / 2 ) % _angle;
				_pieP.endAngle = ( ( _angleCount += _pieP.angle ) + _offsetAngle ) % _angle;
				
				var _spoint:Point = Common.distanceAngleToPoint( _pieP.radius, _pieP.startAngle )
					, _epoint:Point = Common.distanceAngleToPoint( _pieP.radius, _pieP.endAngle )
					, _expoint:Point = Common.distanceAngleToPoint( _pieP.radius + 10, _pieP.midAngle )
					; 
				
				_pieP.startPoint = { x: _spoint.x + _pieP.cx, y: _spoint.y + _pieP.cy };
				_pieP.endPoint = { x: _epoint.x + _pieP.cx, y: _epoint.y + _pieP.cy };
				
				_spoint = Common.distanceAngleToPoint( _pieP.radius - BaseConfig.ins.c.lineStart, _pieP.midAngle );
				_epoint = Common.distanceAngleToPoint( _pieP.radius + BaseConfig.ins.c.lineLength, _pieP.midAngle );
				
				_pieL.cx = BaseConfig.ins.c.cx;
				_pieL.cy = BaseConfig.ins.c.cy;
				_pieL.start = { x: _spoint.x + _pieL.cx, y: _spoint.y + _pieL.cy };
				_pieL.end = { x: _epoint.x + _pieL.cx, y: _epoint.y + _pieL.cy };
				_pieL.ex = { x: _expoint.x + _pieL.cx, y: _expoint.y + _pieL.cy };

				
				BaseConfig.ins.c.piePart.push( _pieP );
			});
		}
		
		private function calcRadius( _w:Number, _h:Number ):Number{
			var _radius:Number = Math.min( _w, _h );
			
			if( BaseConfig.ins.legendEnabled ){
				//_radius -= 30;
			}
			
			if( BaseConfig.ins.dataLabelEnabled ){
				_radius -= ( BaseConfig.ins.c.lineLength - BaseConfig.ins.c.lineStart + 40 ) * 2;
			}else{
				//_radius -= 40;
			}
			
			_radius /= 2;
			
			return _radius;
		}
		
		private function get pLegendMediator():LegendMediator{
			return facade.retrieveMediator( LegendMediator.name ) as LegendMediator;
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