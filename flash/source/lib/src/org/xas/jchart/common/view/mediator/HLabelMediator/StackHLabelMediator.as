package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.BaseHLabelView;
	import org.xas.jchart.common.view.components.HLabelView.HistogramHLabelView;
	
	public class StackHLabelMediator extends BaseHLabelMediator
	{
		public function StackHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new HistogramHLabelView() );
		}
	}
}