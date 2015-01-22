package org.xas.jchart.common.view.mediator.SeriesLabelMediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.SerialLabel.*;
	import org.xas.jchart.common.view.components.TitleView;
	import org.xas.jchart.common.view.mediator.MainMediator;
	
	public class BaseSeriesLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PBaseSerialLabelMediator';
		protected var _view:BaseSerialLabelView;
		public function get view():BaseSerialLabelView{ return _view; }
		
		public function BaseSeriesLabelMediator( )
		{
			super( name );
			
		} 
		
		override public function onRegister():void{
			mainMediator.view.index8.addChild( _view = new BaseSerialLabelView() );
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
					_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_CHART ) );
					break;
				}
			
			}
		}
		
		public function get maxHeight():Number{
			var _r:Number = 0;
			_view && ( _r = _view.maxHeight );
			return _r;
		}
		
		public function get maxWidth():Number{
			var _r:Number = 0;
			_view && ( _r = _view.maxWidth );
			return _r;
		}
		
		
		protected function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}