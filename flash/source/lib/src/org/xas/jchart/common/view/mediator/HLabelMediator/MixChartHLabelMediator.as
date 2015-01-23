package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.MixChartHLabelView;

	public class MixChartHLabelMediator extends BaseHLabelMediator
	{
		public function MixChartHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index5.addChild( _view = new MixChartHLabelView() );
		}
	}
}