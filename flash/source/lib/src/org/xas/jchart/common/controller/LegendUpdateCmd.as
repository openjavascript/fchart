package org.xas.jchart.common.controller
{
	import flash.external.ExternalInterface;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class LegendUpdateCmd extends SimpleCommand implements ICommand {
		
		protected var _config:Config;
		
		public function LegendUpdateCmd() {
			_config = BaseConfig.ins as Config;
			super();
		}
		
		override public function execute( notification:INotification ):void{
			
			var _data:Object = notification.getBody();
			
			if( !_data ) { return; }
			 
			_config.updateDisplaySeries( _data );
			_config.setChartData( BaseConfig.ins.chartData );
			facade.sendNotification( JChartEvent.DRAW );
		}
	}
}