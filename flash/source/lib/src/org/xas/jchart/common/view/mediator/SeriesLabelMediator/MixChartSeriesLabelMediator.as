package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.MixChartSerialLabelView;

	public class MixChartSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function MixChartSeriesLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index9.addChild( _view = new MixChartSerialLabelView() );
		}
	}
}