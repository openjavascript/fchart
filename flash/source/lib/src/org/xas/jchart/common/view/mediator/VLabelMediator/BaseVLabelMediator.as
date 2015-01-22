package org.xas.jchart.common.view.mediator.VLabelMediator
{
	import flash.text.TextField;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.*;
	import org.xas.jchart.common.view.components.VLabelView.*;
	import org.xas.jchart.common.view.mediator.MainMediator;
	
	public class BaseVLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'BaseVLabelMediator';
		protected var _view:BaseVLabelView;
		public function get view():BaseVLabelView{ return _view; }
		
		public function BaseVLabelMediator( )
		{
			super( name );			
		}
		
		override public function onRegister():void{		
			mainMediator.view.index6.addChild( _view = new BaseVLabelView() );
		}
		
		override public function onRemove():void{
			_view.parent.removeChild( _view );
		}
		
		override public function listNotificationInterests():Array{
			return [
				JChartEvent.SHOW_CHART
			];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch( notification.getName() ){
			case JChartEvent.SHOW_CHART:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.UPDATE ) );
					break;
				}
			}
		}
		
		public function get maxWidth():Number{
			return _view.maxWidth;
		}
		
		public function get maxHeight():Number{
			return _view.maxHeight;
		}
		
		public function get maxWidthRight():Number{
			return _view.maxWidth;
		}
		
		public function set maxHeight( _setter:Number ):void{
			_view.maxHeight = _setter;
		}		
		
		public function set maxWidth( _setter:Number ):void{
			_view.maxWidth = _setter;
		}	
		
		
		protected function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		public function get labels():Vector.<TextField>{
			return _view.labels;
		}
		
	}
}