package org.xas.jchart.common.view.mediator.HoverBgMediator
{
	import org.xas.jchart.common.view.components.HoverBgView.ZHistogramHoverBgView;

	public class ZHistogramHoverBgMediator extends BaseHoverBgMediator
	{
		public function ZHistogramHoverBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{			
			mainMediator.view.index6.addChild( _view = new ZHistogramHoverBgView() );	
		}
	}
}