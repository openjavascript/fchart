package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.RadarGraphicBgView;

	public class RadarGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function RadarGraphicBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index2.addChild( _view = new RadarGraphicBgView() );
			initEvent();
		}
	}
}