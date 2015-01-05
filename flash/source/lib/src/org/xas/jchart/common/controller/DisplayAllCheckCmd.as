package org.xas.jchart.common.controller
{
	import flash.text.TextField;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.HLabelMediator;
	import org.xas.jchart.common.view.mediator.MainMediator;
	
	public class DisplayAllCheckCmd extends SimpleCommand implements ICommand
	{
		private var _type:String = '', _body:Object;
		private var _config:Config;
		private var _itemWidth:Number;
		private var _labels:Vector.<TextField>;
		private var _isReset:Boolean;
		
		public function DisplayAllCheckCmd()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override public function execute( notification:INotification ):void{
			_body = notification.getBody();
			_type = notification.getType();
			
//			Log.log( _config.labelRotationEnable, _config.displayAllLabel );
			if( !_config.xAxisEnabled ) return;
			if( !_config.displayAllLabel ) return;
			
			_labels = hlabelMediator.labels;
			if( !( _labels && _labels.length) ) return;
			
			_itemWidth = _config.c.chartWidth / ( _labels.length );
							
			switch( _type ){
				default: {
					normalAction();
					break;
				}
			}
			_isReset && sendNotification( JChartEvent.RESET_HLABELS );
		}
		
		protected function normalAction():void{
			//Log.log( 'DisplayAllCheckCmd normalAction', _itemWidth );
			
			Common.each( _labels, function( _k:int, _item:TextField ):Boolean{
				
				if( _config.labelRotationEnable ){
					if( _itemWidth < 16  ){			
						_isReset = true;
						return false;
					}					
				}else if( _item.width > _itemWidth ){	
					_isReset = true;
					return false;
				} 				
				
				return true;
			});
		}
		
		protected function get hlabelMediator():HLabelMediator{
			return facade.retrieveMediator( HLabelMediator.name ) as HLabelMediator;
		}
	}
}