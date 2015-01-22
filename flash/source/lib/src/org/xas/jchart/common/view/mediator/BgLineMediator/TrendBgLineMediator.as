package org.xas.jchart.common.view.mediator.BgLineMediator
{
	import org.xas.jchart.common.view.components.BgLineView.TrendBgLineView;

	public class TrendBgLineMediator extends BaseBgLineMediator
	{
		public function TrendBgLineMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index5.addChild( _view = new TrendBgLineView() );
		}
	}
}