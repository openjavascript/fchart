package org.xas.jchart.common.view.mediator.BgLineMediator
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.view.components.BgLineView.MixChartBgLineView;

	public class MixChartBgLineMediator extends BaseBgLineMediator
	{
		public function MixChartBgLineMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			Log.log( 'MixChartBgLineMediator' );
			mainMediator.view.index5.addChild( _view = new MixChartBgLineView() );
		}
	}
}