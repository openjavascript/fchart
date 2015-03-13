package org.xas.jchart.common.view.mediator.BgLineMediator
{
	import org.xas.jchart.common.view.components.BgLineView.RadarBgLineView;

	public class RadarBgLineMediator extends BaseBgLineMediator
	{
		public function RadarBgLineMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index3.addChild( _view = new RadarBgLineView );	
		}
	}
}