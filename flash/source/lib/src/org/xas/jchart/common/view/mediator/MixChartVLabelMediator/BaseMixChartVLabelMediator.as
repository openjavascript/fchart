package org.xas.jchart.common.view.mediator.MixChartVLabelMediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.*;
	import org.xas.jchart.common.view.components.MixChartVLabelView.*;
	import org.xas.jchart.common.view.mediator.MainMediator;
	
	public class BaseMixChartVLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PBaseMixChartVLabelMediator';
		protected var _view:Vector.<BaseVLabelView>;
		public function get view():Vector.<BaseVLabelView>{ return _view; }
		protected var _config:Config;
		
		public function BaseMixChartVLabelMediator( )
		{
			super( name );	
			_config = BaseConfig.ins as Config;
		}
		
		override public function onRegister():void{		
			_view = new Vector.<BaseVLabelView>();
			
			switch( (facade as BaseFacade).name ){
				default:{
					//mainMediator.view.index6.addChild( _view = new MixChartVLabelView() );
					Common.each( _config.mixModel.items, function( _k:int, _item:MixChartModelItem ):void{
						//Log.log( 'xxxxxxxxxx', _k );
						var _tmp:BaseVLabelView = new MixChartVLabelView( _k, _item );
						_view.push( _tmp );
						mainMediator.view.index6.addChild( _tmp );
					});
					break;
				}
			}
		}
		
		override public function onRemove():void{
			Common.each( _view, function( _k:int, _item:BaseVLabelView ):void{
				_item && _item.parent && _item.parent.removeChild( _item );
			});
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
					
					Common.each( _view, function( _k:int, _item:BaseVLabelView ):void{
						_item.dispatchEvent( new JChartEvent( JChartEvent.UPDATE ) );
					});
					break;
				}
			}
		}
		
		public function getMaxWidth( _index:int ):Number{
			return _view[ _index ].maxWidth;
		}
		
		public function getMaxHeight( _index:int ):Number{
			return _view[ _index ].maxHeight;
		}
		
		protected function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}