package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.HStackHLabelView;
	
	public class HStackHLabelMediator extends BaseHLabelMediator
	{
		public function HStackHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new HStackHLabelView() );
		}
	}
}