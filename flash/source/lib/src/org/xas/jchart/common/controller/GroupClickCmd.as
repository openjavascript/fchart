package org.xas.jchart.common.controller
{
	import flash.external.ExternalInterface;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	
	public class GroupClickCmd extends SimpleCommand implements ICommand {
		
		private var _config:Config;
		
		public function GroupClickCmd() {
			_config = BaseConfig.ins as Config;
			super();
		}
		
		override public function execute( notification:INotification ):void{
			
			var _data:Object = notification.getBody();
			var _loader:Object = _config.chartData;
			var _callBackSet:Object;

			if( !_data || !_loader ){
				return;
			}
			
			_callBackSet = _loader.callback;
			
			try{
				if( ExternalInterface.available && _callBackSet && _callBackSet.groupClickCallback ) {
					ExternalInterface.call( _callBackSet.groupClickCallback, _data );
				}
			}catch(ex:Error){}
		}
	}
}