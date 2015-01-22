package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.ZHistogramTipsView;

	public class ZHistogramTipsMediator extends BaseTipsMediator
	{
		public function ZHistogramTipsMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index8.addChild( _view = new ZHistogramTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}