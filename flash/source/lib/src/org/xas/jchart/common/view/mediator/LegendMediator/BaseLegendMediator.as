package org.xas.jchart.common.view.mediator.LegendMediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.*;
	import org.xas.jchart.common.view.components.LegendView.BaseLegendView;
	import org.xas.jchart.common.view.components.LegendView.MapLegendView;
	import org.xas.jchart.common.view.components.LegendView.MixChartLegendView;
	import org.xas.jchart.common.view.components.LegendView.ZHistogramLegendView;
	import org.xas.jchart.common.view.mediator.MainMediator;
	
	public class BaseLegendMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PBaseLegendMediator';
		protected var _view:BaseLegendView;
		public function get view():BaseLegendView{ return _view; }
		
		public function BaseLegendMediator( )
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			mainMediator.view.index7.addChild( _view = new BaseLegendView() ); 
			initEvent();
		}
		
		protected function initEvent():void{
			_view.addEventListener( JChartEvent.FILTER_DATA, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.FILTER_DATA, _evt.data );	
			});
		}
		
		override public function onRemove():void{
			_view.parent.removeChild( _view );
		}
		
		override public function listNotificationInterests():Array{
			return [
				JChartEvent.SHOW_CHART,
				JChartEvent.SHOW_LEGEND_ARROW,
				JChartEvent.HIDE_LEGEND_ARROW
			];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch( notification.getName() ){
			case JChartEvent.SHOW_CHART:
				{
					//_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_CHART ) );
					if( !( BaseConfig.ins.c && BaseConfig.ins.c.legend ) ) return;
					
					_view.x = BaseConfig.ins.c.legend.x;
					_view.y = BaseConfig.ins.c.legend.y;
					break;
				}
				
			case JChartEvent.SHOW_LEGEND_ARROW:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_LEGEND_ARROW, notification.getBody() ) );
					break;
				}
				
			case JChartEvent.HIDE_LEGEND_ARROW:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.HIDE_LEGEND_ARROW, notification.getBody() ) );
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
		
		public function set maxHeight( _setter:Number ):void{
			_view.maxHeight = _setter;
		}		
		
		public function set maxWidth( _setter:Number ):void{
			_view.maxWidth = _setter;
		}
		
		protected function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}