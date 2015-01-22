package org.xas.jchart.common.view.mediator.TipsMediator
{
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.view.components.TipsView.MapTipsView;

	public class MapTipsMediator extends BaseTipsMediator
	{
		public function MapTipsMediator()
		{
			super();
		}
		
		
		override public function onRegister():void{
			
			mainMediator.view.index8.addChild( _view = new MapTipsView() );
			ElementUtility.topIndex( _view );
		}
	}
}