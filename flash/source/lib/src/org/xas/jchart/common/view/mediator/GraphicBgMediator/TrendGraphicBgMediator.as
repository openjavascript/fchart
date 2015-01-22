package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.TrendGraphicBgView;

	public class TrendGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function TrendGraphicBgMediator()
		{
			super();
		}
		
		
		override public function onRegister():void{
						
			mainMediator.view.index2.addChild( _view = new TrendGraphicBgView() );
			initEvent();
		}
	}
}