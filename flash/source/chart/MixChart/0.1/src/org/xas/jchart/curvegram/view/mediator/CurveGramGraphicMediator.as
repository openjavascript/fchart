package org.xas.jchart.curvegram.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.MainMediator;
	import org.xas.jchart.curvegram.view.components.GraphicView;
	
	public class CurveGramGraphicMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PChartCurveGramMediator';
		private var _view:GraphicView;
		public function get view():GraphicView{ return _view; }
		
		private var _config:Config;
		private var _seriesAr:Array;
		private var _coordinate:Object;
		
		public function CurveGramGraphicMediator( _seriesAr:Array, _coordinate:Object )
		{
			super( name );
			
			_config = BaseConfig.ins as Config;
			this._seriesAr = _seriesAr;
			this._coordinate = _coordinate;
			
		}
		
		override public function onRegister():void{
			//Log.log( [ 'PChartCurveGramMediator', new Date().getTime() ] );
			mainMediator.view.index7.addChild( _view = new GraphicView( _seriesAr, _coordinate ) );		
			
			_view.addEventListener( JChartEvent.ITEM_CLICK, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.ITEM_CLICK, _evt.data );
			} );
			
			_view.addEventListener( JChartEvent.GROUP_CLICK, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.GROUP_CLICK, _evt.data );
			}  );
			
			_view.addEventListener( JChartEvent.INITED, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.INITED, _evt.data );
			}  );

		}
		
		override public function onRemove():void{
			_view.parent && _view.parent.removeChild( _view );
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
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}
