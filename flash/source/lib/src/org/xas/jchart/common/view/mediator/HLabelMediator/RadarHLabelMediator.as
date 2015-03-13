package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.RadarHLabelView;

	public class RadarHLabelMediator extends BaseHLabelMediator
	{
		public function RadarHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index5.addChild( _view = new RadarHLabelView() );
		}
	}
}