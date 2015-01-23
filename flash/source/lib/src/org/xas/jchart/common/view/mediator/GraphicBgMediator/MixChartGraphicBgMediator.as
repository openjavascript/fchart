package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.MixChartGraphicBgView;

	public class MixChartGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function MixChartGraphicBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index2.addChild( _view = new MixChartGraphicBgView() );
			initEvent();
		}
	}
}