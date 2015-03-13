package org.xas.jchart.common.view.mediator.GroupMediator
{
	import org.xas.jchart.common.view.components.GroupView.CurveGramGroupView;

	public class CurveGramGropuMediator extends BaseGroupMediator
	{
		public function CurveGramGropuMediator(_minY:Number)
		{
			super(_minY);
		}
		
		override public function onRegister():void {
			mainMediator.view.index2.addChild( _view = new CurveGramGroupView( _startY ) );
		}
		
	}
}