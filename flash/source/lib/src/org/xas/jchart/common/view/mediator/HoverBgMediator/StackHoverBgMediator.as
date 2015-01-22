package org.xas.jchart.common.view.mediator.HoverBgMediator
{
	import org.xas.jchart.common.view.components.HoverBgView.StackHoverBgView;

	public class StackHoverBgMediator extends BaseHoverBgMediator
	{
		public function StackHoverBgMediator()
		{
			super();
		}
				
		override public function onRegister():void{
			mainMediator.view.index6.addChild( _view = new StackHoverBgView() );
		}
	}
}