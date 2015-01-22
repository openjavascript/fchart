package org.xas.jchart.vhistogram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.common.view.mediator.BgLineMediator.BaseBgLineMediator;
	import org.xas.jchart.common.view.mediator.BgMediator.BaseBgMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.BaseGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HoverBgMediator.BaseHoverBgMediator;
	import org.xas.jchart.common.view.mediator.ItemBgMediator.BaseItemBgMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.BaseSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.BaseTipsMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.BaseVLabelMediator;
	import org.xas.jchart.vhistogram.view.mediator.*;
	
	public class ClearCmd extends SimpleCommand implements ICommand
	{
		public function ClearCmd()
		{
			super();
		}	
		
		override public function execute( notification:INotification ):void{
			
			//Log.log( 'ClearCmd' );
			
			facade.hasMediator( BaseBgMediator.name ) && facade.removeMediator( BaseBgMediator.name );
			facade.hasMediator( BaseVLabelMediator.name ) && facade.removeMediator( BaseVLabelMediator.name );
			facade.hasMediator( BaseHLabelMediator.name ) && facade.removeMediator( BaseHLabelMediator.name );
			facade.hasMediator( BaseGraphicBgMediator.name ) && facade.removeMediator( BaseGraphicBgMediator.name );
			facade.hasMediator( BaseBgLineMediator.name ) && facade.removeMediator( BaseBgLineMediator.name );
			facade.hasMediator( BaseLegendMediator.name ) && facade.removeMediator( BaseLegendMediator.name );
			facade.hasMediator( BaseTipsMediator.name ) && facade.removeMediator( BaseTipsMediator.name );
			facade.hasMediator( BaseSeriesLabelMediator.name ) && facade.removeMediator( BaseSeriesLabelMediator.name );
			facade.hasMediator( BaseHoverBgMediator.name ) && facade.removeMediator( BaseHoverBgMediator.name );	
			facade.hasMediator( BaseItemBgMediator.name ) && facade.removeMediator( BaseItemBgMediator.name );	
			
			facade.hasMediator( TitleMediator.name ) && facade.removeMediator( TitleMediator.name );
			facade.hasMediator( SubtitleMediator.name ) && facade.removeMediator( SubtitleMediator.name );
			facade.hasMediator( VTitleMediator.name ) && facade.removeMediator( VTitleMediator.name );
			facade.hasMediator( CreditMediator.name ) && facade.removeMediator( CreditMediator.name );
			facade.hasMediator( GraphicMediator.name ) && facade.removeMediator( GraphicMediator.name );
			facade.hasMediator( MainMediator.name ) && facade.removeMediator( MainMediator.name );
			facade.hasMediator( TestMediator.name ) && facade.removeMediator( TestMediator.name );	
		}
	}
}