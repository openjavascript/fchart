package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import org.xas.jchart.common.view.components.VLabelView.HStackVLabelView;

	public class HStackVLabelMediator extends BaseVLabelMediator
	{
		public function HStackVLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{		
			mainMediator.view.index6.addChild( _view = new HStackVLabelView() );
		}
	}
}