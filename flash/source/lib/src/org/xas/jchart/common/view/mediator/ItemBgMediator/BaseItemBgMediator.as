package org.xas.jchart.common.view.mediator.ItemBgMediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.BgView.DDountBgView;
	import org.xas.jchart.common.view.components.ItemBgView.BaseItemBgView;
	import org.xas.jchart.common.view.components.ItemBgView.HistogramItemBgView;
	import org.xas.jchart.common.view.components.ItemBgView.VHistogramItemBgView;
	import org.xas.jchart.common.view.components.TitleView;
	import org.xas.jchart.common.view.mediator.MainMediator;
	
	public class BaseItemBgMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PBaseItemBgMediator';
		protected var _view:BaseItemBgView;
		public function get view():BaseItemBgView{ return _view; }
		
		public function BaseItemBgMediator( )
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			mainMediator.view.index4.addChild( _view = new BaseItemBgView() );
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
				case JChartEvent.UPDATE_TIPS:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, notification.getBody() ) );
					break;
				}	
				case JChartEvent.SHOW_TIPS:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, notification.getBody() ) );
					break;
				}	
				case JChartEvent.HIDE_TIPS:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, notification.getBody() ) );
					break;
				}
			}
		}
		
		
		protected function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}