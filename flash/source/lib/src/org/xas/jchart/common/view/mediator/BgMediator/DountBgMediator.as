package org.xas.jchart.common.view.mediator.BgMediator
{
	import org.xas.jchart.common.view.components.BgView.DDountBgView;

	public class DountBgMediator extends BaseBgMediator
	{
		public function DountBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index1.addChild( _view = new DDountBgView() );
		}
	}
}