package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import org.xas.jchart.common.view.components.VLabelView.ZVHistogramVLabelView;

	public class VZHistogramVLabelMediator extends BaseVLabelMediator
	{
		public function VZHistogramVLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{			
			
			mainMediator.view.index5.addChild( _view = new ZVHistogramVLabelView( ) );
		}
	}
}