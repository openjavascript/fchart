package org.xas.jchart.common.view.mediator.LegendMediator
{
	import org.xas.jchart.common.view.components.LegendView.MixChartLegendView;

	public class MixChartLegendMediator extends BaseLegendMediator
	{
		public function MixChartLegendMediator()
		{
			super();
		}
		
		
		override public function onRegister():void{
						
			mainMediator.view.index7.addChild( _view = new MixChartLegendView() );
			initEvent();
		}
	}
}