package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.NormalTipsView;

	public class RadarTipsMediator extends BaseTipsMediator
	{
		public function RadarTipsMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new NormalTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}