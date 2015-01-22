package org.xas.jchart.common.view.mediator.HoverBgMediator
{
	import org.xas.jchart.common.view.components.HoverBgView.VHistogramHoverBgView;

	public class VHoverBgMediator extends BaseHoverBgMediator
	{
		public function VHoverBgMediator()
		{
			super();
		}
		override public function onRegister():void{
			
			mainMediator.view.index6.addChild( _view = new VHistogramHoverBgView() );
		}

	}
}