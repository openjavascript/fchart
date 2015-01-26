package org.xas.jchart.common.view.mediator.PieLabelMediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.PieLabelView.BasePieLabelView;
	import org.xas.jchart.common.view.mediator.MainMediator;
	
	public class BasePieLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PPieLabelMediator';
		private var _view:BasePieLabelView;
		public function get view():BasePieLabelView{ return _view; }
		
		public function BasePieLabelMediator()
		{
			super( name );
		}
		
		override public function onRegister():void{
			mainMediator.view.index6.addChild( _view = new BasePieLabelView( ) );
		}
		
		override public function onRemove():void{
			_view.parent.removeChild( _view );
		}
		
		override public function listNotificationInterests():Array{
			return [
				JChartEvent.SHOW_CHART
				, JChartEvent.READY
			];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch( notification.getName() ){
				
				case JChartEvent.SHOW_CHART: {
						_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_CHART ) );
						break;
					}
					
				case JChartEvent.READY: {
					_view.dispatchEvent( new JChartEvent( JChartEvent.READY ) );
					break;
				}
			
			}
		}	
				
		public function get maxHeight():Number{
			return _view.maxHeight;
		}		
		
		public function get maxWidth():Number{
			return _view.maxWidth;
		}
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}