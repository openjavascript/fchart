package org.xas.jchart.common.view.mediator.GraphicBgMediator
{
	import org.xas.jchart.common.view.components.GraphicBgView.CurveGramGraphicBgView;

	public class CurveGramGraphicBgMediator extends BaseGraphicBgMediator
	{
		public function CurveGramGraphicBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index2.addChild( _view = new CurveGramGraphicBgView() );
			initEvent();
		}
	}
}