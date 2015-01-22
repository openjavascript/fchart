package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.xas.jchart.common.view.components.SerialLabel.CurveGramSerialLabelView;

	public class CurveGramSeriesLabelMediator extends BaseSeriesLabelMediator
	{
		public function CurveGramSeriesLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index8.addChild( _view = new CurveGramSerialLabelView() );
		}
	}
}