package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import org.xas.jchart.common.view.components.VLabelView.MapVLabelView;

	public class MapVLabelMediator extends BaseVLabelMediator
	{
		public function MapVLabelMediator()
		{
			super();
		}
		
		override public function onRegister():void{			
			
			mainMediator.view.index6.addChild( _view = new MapVLabelView() );
		}
	}
}