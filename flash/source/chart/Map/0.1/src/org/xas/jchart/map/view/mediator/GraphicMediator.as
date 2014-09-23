package org.xas.jchart.map.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.map.view.components.*;
	import org.xas.jchart.common.view.mediator.MainMediator;
	import org.xas.core.utils.Log;
	
	public class GraphicMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PChartMediator';
		private var _view:GraphicView;
		public function get view():GraphicView{ return _view; }
		
		public function GraphicMediator()
		{
			super( name );
		}
		
		override public function onRegister():void{
			mainMediator.view.index4.addChild( _view = new GraphicView() );
			
			_view.addEventListener( JChartEvent.UPDATE_TIPS, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.UPDATE_TIPS, _evt.data );
			});
			
			_view.addEventListener( JChartEvent.SHOW_TIPS, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.SHOW_TIPS, _evt.data );
			});
			
			_view.addEventListener( JChartEvent.HIDE_TIPS, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.HIDE_TIPS, _evt.data );
			});
			
			_view.addEventListener( JChartEvent.SHOW_LEGEND_ARROW, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.SHOW_LEGEND_ARROW, _evt.data );
			});
			
			_view.addEventListener( JChartEvent.HIDE_LEGEND_ARROW, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.HIDE_LEGEND_ARROW, _evt.data );
			});
		}
		
		override public function onRemove():void{
			_view.parent.removeChild( _view );
		}
		
		override public function listNotificationInterests():Array{
			return [
				JChartEvent.SHOW_CHART
				, JChartEvent.UPDATE_TIPS
				, JChartEvent.SHOW_TIPS
				, JChartEvent.HIDE_TIPS
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
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}