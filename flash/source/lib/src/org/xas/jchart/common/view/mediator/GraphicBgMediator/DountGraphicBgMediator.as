package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.HistogramGraphicBgView;
	import org.xas.jchart.common.view.components.GraphicBgView.PieGraphicBgView;

	public class DountGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function DountGraphicBgMediator()
		{
			super( );
		}
		
		override public function onRegister():void{
			mainMediator.view.index2.addChild( _view = new PieGraphicBgView() );
			initEvent();
		}
	}
}