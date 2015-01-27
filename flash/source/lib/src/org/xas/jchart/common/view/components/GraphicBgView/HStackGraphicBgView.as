package org.xas.jchart.common.view.components.GraphicBgView
{
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class HStackGraphicBgView extends BaseGraphicBgView
	{
		
		public function HStackGraphicBgView()
		{
			super();
		}
		
		override protected function onMouseMove( _evt:MouseEvent ):void{
			var _point:Object = { x: _evt.stageX, y: _evt.stageY }
				, _rect:Object = { 
					x: config.c.chartX
						, y: config.c.chartY
						, x2: config.c.chartX + config.c.chartWidth 
						, y2: config.c.chartY + config.c.chartHeight 
				}
				, _ix:int = 0
				;
			if( !Common.pointRectangleIntersection( _point, _rect ) ) {
				return;	
			}
			
			_ix = ( _point.y  - _rect.y ) / config.c.vpart;
			
			_ix < 0 && ( _ix = 0 );
			
			if( config.itemLength ){
				_ix >= config.itemLength && ( _ix = config.itemLength - 1 );
			}
//			Log.log( _ix );
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _ix } ) );
		}
	}
}