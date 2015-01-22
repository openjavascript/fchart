package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.ZHistogramHLabelView;

	public class ZHistogramHLabelMediator extends BaseHLabelMediator
	{
		public function ZHistogramHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new ZHistogramHLabelView() );
		}
	}
}