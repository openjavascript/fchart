package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.VZHistogramSerialLabelView;

	public class VHistogramSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function VHistogramSeriesLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index8.addChild( _view = new VZHistogramSerialLabelView() );
		}
	}
}