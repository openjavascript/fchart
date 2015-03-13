package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import org.xas.jchart.common.view.components.VLabelView.RadarVLabelView;

	public class RadarVLabelMediator extends BaseVLabelMediator
	{
		public function RadarVLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{		
			mainMediator.view.index6.addChild( _view = new RadarVLabelView() );
		}
	}
}