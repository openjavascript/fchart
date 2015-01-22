package org.xas.jchart.common.view.mediator.LegendMediator
{
	import org.xas.jchart.common.view.components.LegendView.ZHistogramLegendView;

	public class ZLegendMediator extends BaseLegendMediator
	{
		public function ZLegendMediator()
		{
			super();
		}
		override public function onRegister():void{
						
			mainMediator.view.index7.addChild( _view = new ZHistogramLegendView() );			
			initEvent();
		}
	}
}