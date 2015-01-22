package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.VHistogramHLabelView;

	public class VHistogramHLabelMediator extends BaseHLabelMediator
	{
		public function VHistogramHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index5.addChild( _view = new VHistogramHLabelView() );
		}
	}
}