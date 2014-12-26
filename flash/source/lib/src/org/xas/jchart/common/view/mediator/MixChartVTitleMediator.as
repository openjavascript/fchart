package org.xas.jchart.common.view.mediator
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
	import org.xas.jchart.common.view.components.MixChartVTitleView.*;
	import org.xas.jchart.common.view.components.TitleView;
	
	public class MixChartVTitleMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PMixChartVTitleMediator';
		private var _text:String;
		private var _view:Vector.<BaseMixChartVTitleView>;
		public function get view():Vector.<BaseMixChartVTitleView>{ return _view; }
		private var _config:Config;

		
		public function MixChartVTitleMediator()
		{
			super( name );
			_config = BaseConfig.ins as Config;
		}
		
		override public function onRegister():void{
	
			_view = new Vector.<BaseMixChartVTitleView>();
			
			switch( (facade as BaseFacade).name ){
				default:{
					//mainMediator.view.index6.addChild( _view = new MixChartVLabelView() );
					Common.each( _config.mixModel.items, function( _k:int, _item:MixChartModelItem ):void{
						//Log.log( 'xxxxxxxxxx', _k );
						var _tmp:BaseMixChartVTitleView = new BaseMixChartVTitleView( _k, _item );
						_view.push( _tmp );
						mainMediator.view.index6.addChild( _tmp );
					});
					break;
				}
			}

		}
		
		override public function onRemove():void{
			Common.each( _view, function( _k:int, _item:BaseMixChartVTitleView ):void{
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
						//_view.x = BaseConfig.ins.c.vtitle.x;
						//_view.y = BaseConfig.ins.c.vtitle.y;
						Common.each( _view, function( _k:int, _item:BaseMixChartVTitleView ):void{
							//if( !_item.hasVTitle ) return;
							_item.dispatchEvent( new JChartEvent( JChartEvent.UPDATE ) );
						});

						break;
					}			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		public function getWidth( _index:int ):Number{
			return _view[ _index ].getWidth;
		}
		
		public function getHeight( _index:int ):Number{
			return _view[ _index ].getHeight;
		}

		
	}
}