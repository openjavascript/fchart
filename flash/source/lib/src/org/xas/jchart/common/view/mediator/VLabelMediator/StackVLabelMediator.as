package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import org.xas.jchart.common.view.components.VLabelView.NormalVLabelView;

	public class StackVLabelMediator extends BaseVLabelMediator
	{
		public function StackVLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{		
			mainMediator.view.index6.addChild( _view = new NormalVLabelView() );
		}
	}
}