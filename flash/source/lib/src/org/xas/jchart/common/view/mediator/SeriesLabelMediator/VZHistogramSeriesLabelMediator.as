package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.VZHistogramSerialLabelView;

	public class VZHistogramSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function VZHistogramSeriesLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index8.addChild( _view = new VZHistogramSerialLabelView() );
		}
	}
}