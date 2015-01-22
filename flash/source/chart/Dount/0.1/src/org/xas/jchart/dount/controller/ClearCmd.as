package org.xas.jchart.dount.controller
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
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.BaseTipsMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.BaseVLabelMediator;
	import org.xas.jchart.dount.view.mediator.*;
	
	public class ClearCmd extends SimpleCommand implements ICommand
	{
		public function ClearCmd()
		{
			super();
		}	
		
		override public function execute( notification:INotification ):void{
			
			//Log.log( 'ClearCmd' );
			
			facade.hasMediator( BaseBgMediator.name ) && facade.removeMediator( BaseBgMediator.name );
			facade.hasMediator( BaseBgLineMediator.name ) && facade.removeMediator( BaseBgLineMediator.name );
			facade.hasMediator( BaseLegendMediator.name ) && facade.removeMediator( BaseLegendMediator.name );
			facade.hasMediator( BaseTipsMediator.name ) && facade.removeMediator( BaseTipsMediator.name );
			facade.hasMediator( BaseHLabelMediator.name ) && facade.removeMediator( BaseHLabelMediator.name );
			facade.hasMediator( BaseGraphicBgMediator.name ) && facade.removeMediator( BaseGraphicBgMediator.name );
			facade.hasMediator( BaseVLabelMediator.name ) && facade.removeMediator( BaseVLabelMediator.name );
			
			facade.hasMediator( TitleMediator.name ) && facade.removeMediator( TitleMediator.name );
			facade.hasMediator( SubtitleMediator.name ) && facade.removeMediator( SubtitleMediator.name );
			facade.hasMediator( VTitleMediator.name ) && facade.removeMediator( VTitleMediator.name );
			facade.hasMediator( CreditMediator.name ) && facade.removeMediator( CreditMediator.name );
			facade.hasMediator( GraphicMediator.name ) && facade.removeMediator( GraphicMediator.name );
			facade.hasMediator( MainMediator.name ) && facade.removeMediator( MainMediator.name );
			facade.hasMediator( TestMediator.name ) && facade.removeMediator( TestMediator.name );		
			facade.hasMediator( PieLabelMediator.name ) && facade.removeMediator( PieLabelMediator.name );	
			facade.hasMediator( PieTotalLabelMediator.name ) && facade.removeMediator( PieTotalLabelMediator.name );			
		}
	}
}