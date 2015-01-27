package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.HStackSerialLabelView;

	public class HStackSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function HStackSeriesLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new HStackSerialLabelView() );	
		}
	}
}