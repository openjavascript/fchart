package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.HistogramSerialLabelView;

	public class HistogramSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function HistogramSeriesLabelMediator()
		{
			super();
		}
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new HistogramSerialLabelView() );
		}
	}
}