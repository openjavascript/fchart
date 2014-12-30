package org.xas.jchart.common.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.jchart.common.BaseConfig;
	
	public class GlobalDrawCmd extends SimpleCommand implements ICommand
	{
		private var _config:Config;
		
		public function GlobalDrawCmd() {
			_config = BaseConfig.ins as Config;
			super();
		}
		
		override public function execute( notification:INotification ):void{
		}
	}
}