package org.xas.jchart.common.view.mediator.HoverBgMediator
{
	import org.xas.jchart.common.view.components.HoverBgView.HStackHoverBgView;

	public class HStackHoverBgMediator extends BaseHoverBgMediator
	{
		public function HStackHoverBgMediator()
		{
			super();
		}
				
		override public function onRegister():void{
			mainMediator.view.index6.addChild( _view = new HStackHoverBgView() );
		}
	}
}