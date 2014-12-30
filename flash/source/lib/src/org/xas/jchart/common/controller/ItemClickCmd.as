package org.xas.jchart.common.controller
{
	import flash.external.ExternalInterface;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	
	public class ItemClickCmd extends SimpleCommand implements ICommand{
		
		private var _config:Config;
		
		public function ItemClickCmd() {
			_config = BaseConfig.ins as Config;
			super();
		}
		
		override public function execute( notification:INotification ):void{
			
			var _data:Object = notification.getBody();
			var _loader:Object = _config.chartData;
			var _callBackSet:Object;
			
			//Log.log( 'ItemClickCmd 1 ' );
			if( !_data || !_loader ){
				return;
			}
			
			_callBackSet = _loader.callback;
			
			//Log.printFormatJSON( _callBackSet );
			
			try{				
				if( ExternalInterface.available && _callBackSet ) {
					if( _callBackSet.itemClickCallback ) {
						ExternalInterface.call( _callBackSet.itemClickCallback, _data );
					} 
					if( _callBackSet.clickCallback ) {
						ExternalInterface.call( _callBackSet.clickCallback, _data );
					}
				}
			}catch(ex:Error){}
		}
	}
}