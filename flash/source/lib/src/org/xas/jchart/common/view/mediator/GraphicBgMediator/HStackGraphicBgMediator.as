package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.HStackGraphicBgView;

	public class HStackGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function HStackGraphicBgMediator()
		{
			super( );
		}
		
		override public function onRegister():void{
			mainMediator.view.index2.addChild( _view = new HStackGraphicBgView() );
			initEvent();
		}
	}
}