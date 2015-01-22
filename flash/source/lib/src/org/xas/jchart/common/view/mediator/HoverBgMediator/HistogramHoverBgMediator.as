package org.xas.jchart.common.view.mediator.HoverBgMediator
{
	import org.xas.jchart.common.view.components.HoverBgView.HistogramHoverBgView;

	public class HistogramHoverBgMediator extends BaseHoverBgMediator
	{
		public function HistogramHoverBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index6.addChild( _view = new HistogramHoverBgView() );
		}
	}
}