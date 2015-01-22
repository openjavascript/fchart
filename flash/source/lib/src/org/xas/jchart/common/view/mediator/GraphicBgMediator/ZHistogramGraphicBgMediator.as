package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.ZHistogramGraphicBgView;

	public class ZHistogramGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function ZHistogramGraphicBgMediator()
		{
			super();
		}
		
		
		override public function onRegister():void{
			
			mainMediator.view.index2.addChild( _view = new ZHistogramGraphicBgView() );
			initEvent();
		}
	}
}