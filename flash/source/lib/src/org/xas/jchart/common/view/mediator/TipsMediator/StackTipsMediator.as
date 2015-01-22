package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.StackTipsView;

	public class StackTipsMediator extends BaseTipsMediator
	{
		public function StackTipsMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new StackTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}