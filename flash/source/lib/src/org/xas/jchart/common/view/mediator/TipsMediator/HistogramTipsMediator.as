package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.NormalTipsView;

	public class HistogramTipsMediator extends BaseTipsMediator
	{
		public function HistogramTipsMediator()
		{
			super();
		}
		
		
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new NormalTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}