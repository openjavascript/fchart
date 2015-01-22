package org.xas.jchart.common.view.mediator.LegendMediator
{
	import org.xas.jchart.common.view.components.LegendView.MapLegendView;

	public class MapLegendMediator extends BaseLegendMediator
	{
		public function MapLegendMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			
			mainMediator.view.index7.addChild( _view = new MapLegendView() );
			initEvent();
		}
	}
}