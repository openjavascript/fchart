package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.StackSerialLabelView;

	public class StackSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function StackSeriesLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new StackSerialLabelView() );	
		}
	}
}