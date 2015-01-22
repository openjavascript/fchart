package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.VZHistogramHLabelView;

	public class VZHistogramHLabelMediator extends BaseHLabelMediator
	{
		public function VZHistogramHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
						
			mainMediator.view.index5.addChild( _view = new VZHistogramHLabelView() );
		}
	}
}