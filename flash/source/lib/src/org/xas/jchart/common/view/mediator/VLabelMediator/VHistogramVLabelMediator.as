package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import org.xas.jchart.common.view.components.VLabelView.VHistogramVLabelView;

	public class VHistogramVLabelMediator extends BaseVLabelMediator
	{
		public function VHistogramVLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{			
			
			mainMediator.view.index5.addChild( _view = new VHistogramVLabelView( ) );
		}
	}
}