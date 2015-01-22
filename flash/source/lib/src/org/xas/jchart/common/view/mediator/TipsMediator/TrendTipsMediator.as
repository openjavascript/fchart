package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.TrendTipsView;

	public class TrendTipsMediator extends BaseTipsMediator
	{
		public function TrendTipsMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index8.addChild( _view = new TrendTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}