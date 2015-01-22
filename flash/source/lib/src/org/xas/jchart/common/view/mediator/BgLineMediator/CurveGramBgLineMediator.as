package org.xas.jchart.common.view.mediator.BgLineMediator
{
	import org.xas.jchart.common.view.components.BgLineView.CurveGramBgLineView;

	public class CurveGramBgLineMediator extends BaseBgLineMediator
	{
		public function CurveGramBgLineMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index3.addChild( _view = new CurveGramBgLineView() );	
		}
	}
}