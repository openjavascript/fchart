package org.xas.jchart.common.view.mediator.HLabelMediator
{
	import org.xas.jchart.common.view.components.HLabelView.CurveGramHLabelView;

	public class CurveGramHLabelMediator extends BaseHLabelMediator
	{
		public function CurveGramHLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index5.addChild( _view = new CurveGramHLabelView() );
		}
	}
}