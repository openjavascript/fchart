package org.xas.jchart.common.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import flash.external.ExternalInterface;
	import org.xas.jchart.common.BaseConfig;
	
	public class GroupClickCmd extends SimpleCommand implements ICommand {
		
		private var _config:Config;
		
		public function GroupClickCmd() {
			_config = BaseConfig.ins as Config;
			super();
		}
		
		override public function execute( notification:INotification ):void{
			
			var _data:Object = notification.getBody();
			var _loader:Object = BaseConfig.params;
			var _callBackSet:Object;

			if( !_data || !_loader ){
				return;
			}
			
			_callBackSet = _loader.callback;
			
			if( ExternalInterface.available && _callBackSet && _callBackSet.groupClickCallback ) {
				ExternalInterface.call( _callBackSet.groupClickCallback, _data );
			}
		}
	}
}