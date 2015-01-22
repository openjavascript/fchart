package org.xas.jchart.common.view.mediator.ItemBgMediator
{
	import org.xas.jchart.common.view.components.ItemBgView.VHistogramItemBgView;

	public class VItemBgMediator extends BaseItemBgMediator
	{
		public function VItemBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index4.addChild( _view = new VHistogramItemBgView() );
		}
	}
}