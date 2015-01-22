package org.xas.jchart.common.view.mediator.ItemBgMediator
{
	import org.xas.jchart.common.view.components.ItemBgView.HistogramItemBgView;

	public class StackItemBgMediator extends BaseItemBgMediator
	{
		public function StackItemBgMediator()
		{
			super();
		}
		
		
		override public function onRegister():void{
			mainMediator.view.index4.addChild( _view = new HistogramItemBgView() );
		}
	}
}