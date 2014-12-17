package org.xas.jchart.curvegram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.controller.LegendUpdateCmd;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.BgLineMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator;
	import org.xas.jchart.curvegram.view.mediator.GraphicMediator;
	
	public class FilterDataCmd extends LegendUpdateCmd
	{
		public function FilterDataCmd()
		{
			super();
		}
	}
}