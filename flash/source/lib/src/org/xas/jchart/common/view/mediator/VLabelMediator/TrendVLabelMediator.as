package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import org.xas.jchart.common.view.components.VLabelView.HistogramVLabelView;

	public class TrendVLabelMediator extends BaseVLabelMediator
	{
		public function TrendVLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{			
			
			mainMediator.view.index5.addChild( _view = new HistogramVLabelView() );
		}
	}
}