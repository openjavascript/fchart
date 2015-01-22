package org.xas.jchart.dount.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.dount.view.mediator.GraphicMediator;
	
	public class FilterDataCmd extends SimpleCommand implements ICommand
	{
		public function FilterDataCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void{
			//Log.log( 'filter data cmd' );
			//Log.printJSON( BaseConfig.ins.displaySeries );
			
			update( notification.getBody() );
		}
		
		private function update( _data:Object ):void{
			BaseConfig.ins.updateDisplaySeries( _data );
			BaseConfig.ins.setChartData( BaseConfig.ins.chartData );
			facade.sendNotification( JChartEvent.DRAW );
		}
	}
}