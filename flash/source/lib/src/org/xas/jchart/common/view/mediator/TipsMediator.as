package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.TipsView.BaseTipsView;
	import org.xas.jchart.common.view.components.TipsView.NormalTipsView;
	import org.xas.jchart.common.view.components.TipsView.PieTipsView;
	import org.xas.jchart.common.view.components.TipsView.MapTipsView;
	import org.xas.jchart.common.view.components.TipsView.TrendTipsView;
	import org.xas.jchart.common.view.components.TipsView.ZHistogramTipsView;
	import org.xas.jchart.common.view.components.TitleView;
	
	public class TipsMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PTipsMediator';
		private var _view:BaseTipsView;
		public function get view():BaseTipsView{ return _view; }
		
		public function TipsMediator( )
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			
			switch( (facade as BaseFacade).name ){
				case 'PieGraphFacade':
				case 'DDountFacade':
				case 'NDountFacade':
				case 'DountFacade':
				case 'RateFacade':
				{
					mainMediator.view.index8.addChild( _view = new PieTipsView() );
					break;
				}
				case 'CurveGramFacade':
				case 'HistogramFacade':
				case 'VHistogramFacade':
				{
					mainMediator.view.index8.addChild( _view = new NormalTipsView() );
					break;
				}
				case 'ZHistogramFacade':
				{
					mainMediator.view.index8.addChild( _view = new ZHistogramTipsView() );
					break;
				}
				case 'MapFacade':
				{
					mainMediator.view.index8.addChild( _view = new MapTipsView() );
					break;
				}
				case 'TrendFacade':{
					mainMediator.view.index8.addChild( _view = new TrendTipsView() );
					break;
				}
				default:{
					mainMediator.view.index8.addChild( _view = new BaseTipsView() ); 
					break;
				}
			}
			ElementUtility.topIndex( _view );
		}
		
		override public function onRemove():void{
			_view.parent.removeChild( _view );
		}
		
		override public function listNotificationInterests():Array{
			return [
				JChartEvent.UPDATE_TIPS
				, JChartEvent.SHOW_TIPS
				, JChartEvent.HIDE_TIPS
			];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch( notification.getName() ){
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