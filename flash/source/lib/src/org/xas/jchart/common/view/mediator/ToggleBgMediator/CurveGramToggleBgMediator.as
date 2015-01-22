package org.xas.jchart.common.view.mediator.ToggleBgMediator
{
	import org.xas.jchart.common.view.components.ToggleBgView.CurveGramToggleBgView;

	public class CurveGramToggleBgMediator extends BaseToggleBgMediator
	{
		public function CurveGramToggleBgMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			mainMediator.view.index4.addChild( _view = new CurveGramToggleBgView() );
		}
	}
}