package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.ZHistogramSerialLabelView;

	public class ZHistogramSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function ZHistogramSeriesLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{			
			mainMediator.view.index8.addChild( _view = new ZHistogramSerialLabelView() );
		}
	}
}