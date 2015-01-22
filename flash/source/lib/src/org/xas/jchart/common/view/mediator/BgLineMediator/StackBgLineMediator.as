package org.xas.jchart.common.view.mediator.BgLineMediator
{
	import org.xas.jchart.common.view.components.BgLineView.BaseBgLineView;
	import org.xas.jchart.common.view.components.BgLineView.HistogramBgLineView;

	public class StackBgLineMediator extends BaseBgLineMediator
	{
		public function StackBgLineMediator()
		{
			super();
		}	
		
		override public function onRegister():void{			
			mainMediator.view.index5.addChild( _view = new HistogramBgLineView() );
		}
	}
}