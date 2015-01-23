package org.xas.jchart.mixchart.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.BgLineMediator.BaseBgLineMediator;
	import org.xas.jchart.common.view.mediator.BgMediator.BaseBgMediator;
	import org.xas.jchart.common.view.mediator.CreditMediator.BaseCreditMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.BaseGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HoverBgMediator.BaseHoverBgMediator;
	import org.xas.jchart.common.view.mediator.ItemBgMediator.BaseItemBgMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.MainMediator;
	import org.xas.jchart.common.view.mediator.MixChartVLabelMediator.BaseMixChartVLabelMediator;
	import org.xas.jchart.common.view.mediator.MixChartVTitleMediator.BaseMixChartVTitleMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.BaseSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator.BaseSubtitleMediator;
	import org.xas.jchart.common.view.mediator.TestMediator.BaseTestMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.BaseTipsMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator.BaseTitleMediator;
	import org.xas.jchart.curvegram.view.mediator.CurveGramGraphicMediator;
	import org.xas.jchart.histogram.view.mediator.HistogramGraphicMediator;
	import org.xas.jchart.mixchart.view.mediator.GraphicMediator;
	
	public class ClearCmd extends SimpleCommand implements ICommand
	{
		public function ClearCmd()
		{
			super();
		}	
		
		override public function execute( notification:INotification ):void{
			
			//Log.log( 'ClearCmd' );
			facade.hasMediator( BaseMixChartVLabelMediator.name ) && facade.removeMediator( BaseMixChartVLabelMediator.name );
			facade.hasMediator( BaseMixChartVTitleMediator.name ) && facade.removeMediator( BaseMixChartVTitleMediator.name );
			
			facade.hasMediator( BaseBgMediator.name ) && facade.removeMediator( BaseBgMediator.name );
			facade.hasMediator( BaseHLabelMediator.name ) && facade.removeMediator( BaseHLabelMediator.name );
			facade.hasMediator( BaseGraphicBgMediator.name ) && facade.removeMediator( BaseGraphicBgMediator.name );
			facade.hasMediator( BaseBgLineMediator.name ) && facade.removeMediator( BaseBgLineMediator.name );
			facade.hasMediator( BaseLegendMediator.name ) && facade.removeMediator( BaseLegendMediator.name );
			facade.hasMediator( BaseTipsMediator.name ) && facade.removeMediator( BaseTipsMediator.name );
			facade.hasMediator( BaseSeriesLabelMediator.name ) && facade.removeMediator( BaseSeriesLabelMediator.name );
			facade.hasMediator( BaseHoverBgMediator.name ) && facade.removeMediator( BaseHoverBgMediator.name );	
			facade.hasMediator( BaseItemBgMediator.name ) && facade.removeMediator( BaseItemBgMediator.name );	
			
						
			facade.hasMediator( BaseTitleMediator.name ) && facade.removeMediator( BaseTitleMediator.name );
			facade.hasMediator( BaseSubtitleMediator.name ) && facade.removeMediator( BaseSubtitleMediator.name );
			
			
			facade.hasMediator( BaseCreditMediator.name ) && facade.removeMediator( BaseCreditMediator.name );
			facade.hasMediator( GraphicMediator.name ) && facade.removeMediator( GraphicMediator.name );
			facade.hasMediator( MainMediator.name ) && facade.removeMediator( MainMediator.name );
			facade.hasMediator( BaseTestMediator.name ) && facade.removeMediator( BaseTestMediator.name );	
			facade.hasMediator( HistogramGraphicMediator.name ) && facade.removeMediator( HistogramGraphicMediator.name );	
			facade.hasMediator( CurveGramGraphicMediator.name ) && facade.removeMediator( CurveGramGraphicMediator.name );	
			
		}
	}
}