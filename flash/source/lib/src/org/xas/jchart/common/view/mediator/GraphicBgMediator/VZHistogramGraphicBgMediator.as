package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.VZHistogramGraphicBgView;

	public class VZHistogramGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function VZHistogramGraphicBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
						
			mainMediator.view.index2.addChild( _view = new VZHistogramGraphicBgView() );
			initEvent();
		}
	}
}