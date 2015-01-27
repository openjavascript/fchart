package org.xas.jchart.common.view.mediator.BgLineMediator
{
	import org.xas.jchart.common.view.components.BgLineView.HStackBgLineView;

	public class HStackBgLineMediator extends BaseBgLineMediator
	{
		public function HStackBgLineMediator()
		{
			super();
		}	
		
		override public function onRegister():void{			
			mainMediator.view.index5.addChild( _view = new HStackBgLineView() );
		}
	}
}