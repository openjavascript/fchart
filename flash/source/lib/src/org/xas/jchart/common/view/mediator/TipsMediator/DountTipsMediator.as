package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.PieTipsView;
	import org.xas.jchart.common.view.components.TipsView.StackTipsView;

	public class DountTipsMediator extends BaseTipsMediator
	{
		public function DountTipsMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new PieTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}