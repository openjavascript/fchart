package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.*;
	import org.xas.jchart.common.view.components.VLabelView.BaseVLabelView;
	import org.xas.jchart.common.view.components.VLabelView.HistogramVLabelView;
	import org.xas.jchart.common.view.components.VLabelView.VHistogramVLabelView;
	import org.xas.jchart.common.view.components.VLabelView.MapVLabelView;
	
	public class VLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PVLabelMediator';
		private var _view:BaseVLabelView;
		public function get view():BaseVLabelView{ return _view; }
		
		public function VLabelMediator( )
		{
			super( name );			
		}
		
		override public function onRegister():void{			
			switch( (facade as BaseFacade).name ){
				case 'CurveGramFacade':
				{
					mainMediator.view.index5.addChild( _view = new HistogramVLabelView() );
					break;
				}
				case 'HistogramFacade':
				{
					mainMediator.view.index5.addChild( _view = new HistogramVLabelView( ) );
					break;
				}
				case 'VHistogramFacade':
				{
					mainMediator.view.index5.addChild( _view = new VHistogramVLabelView( ) );
					break;
				}
				case 'MapFacade':
				{
					mainMediator.view.index5.addChild( _view = new MapVLabelView() );
					break;
				}
				default:{
					mainMediator.view.index5.addChild( _view = new BaseVLabelView() ); 
					break;
				}
			}
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
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}