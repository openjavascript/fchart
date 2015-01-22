package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.VHistogramGraphicBgView;

	public class VHistogramGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function VHistogramGraphicBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			
			mainMediator.view.index2.addChild( _view = new VHistogramGraphicBgView() );
			initEvent();
		}
	}
}