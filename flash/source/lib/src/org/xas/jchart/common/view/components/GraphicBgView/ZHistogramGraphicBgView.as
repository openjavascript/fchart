package org.xas.jchart.common.view.components.GraphicBgView
{
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class ZHistogramGraphicBgView extends BaseGraphicBgView
	{
		public function ZHistogramGraphicBgView()
		{
			super();
		}
		
		override protected function onMouseMove( _evt:MouseEvent ):void{
			//Log.log( 'GraphicView onMouseMove', new Date().getTime() );
			var _point:Object = { x: _evt.stageX, y: _evt.stageY }
				, _rect:Object = { 
					x: BaseConfig.ins.c.chartX
						, y: BaseConfig.ins.c.chartY
						, x2: BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth 
						, y2: BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight 
				}
				, _ix:int = 0
				;
			if( !Common.pointRectangleIntersection( _point, _rect ) ) {
				return;	
			}
			
			_ix = ( _point.x  - _rect.x ) / BaseConfig.ins.c.hpart;
			_ix < 0 && ( _ix = 0 );
			if( BaseConfig.ins.cd && BaseConfig.ins.series && BaseConfig.ins.series.length ){
				_ix >= BaseConfig.ins.series.length && ( _ix = BaseConfig.ins.series.length - 1 );
			}
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _ix } ) );
		}
	}
}