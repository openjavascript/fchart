package org.xas.jchart.common.view.mediator.BgLineMediator
{
	import org.xas.jchart.common.view.components.BgLineView.VHistogramBgLineView;

	public class VHistogramBgLineMediator extends BaseBgLineMediator
	{
		public function VHistogramBgLineMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index5.addChild( _view = new VHistogramBgLineView() );
		}
	}
}