package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.MixChartTipsView;

	public class MixChartTipsMediator extends BaseTipsMediator
	{
		public function MixChartTipsMediator()
		{
			super();
		}
		
		override public function onRegister():void{
						
			mainMediator.view.index11.addChild( _view = new MixChartTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}