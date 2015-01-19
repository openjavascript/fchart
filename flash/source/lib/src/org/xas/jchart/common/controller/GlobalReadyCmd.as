package org.xas.jchart.common.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.jchart.common.BaseConfig;
	
	public class GlobalReadyCmd extends SimpleCommand implements ICommand
	{
		private var _config:Config;
		
		public function GlobalReadyCmd()
		{
			super();
			_config = BaseConfig.ins as Config;
		}		
		
		override public function execute( notification:INotification ):void{			
			_config.dataInited = true;
		}
	}
}