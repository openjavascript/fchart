package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.TrendHLabelView;

	public class TrendHLabelMediator extends BaseHLabelMediator
	{
		public function TrendHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index5.addChild( _view = new TrendHLabelView() );
		}
	}
}