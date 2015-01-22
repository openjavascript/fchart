package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.HistogramGraphicBgView;

	public class StackGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function StackGraphicBgMediator()
		{
			super( );
		}
		
		override public function onRegister():void{
			mainMediator.view.index2.addChild( _view = new HistogramGraphicBgView() );
			initEvent();
		}
	}
}