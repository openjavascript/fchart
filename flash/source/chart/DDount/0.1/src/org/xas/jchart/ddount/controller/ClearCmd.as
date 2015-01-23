package org.xas.jchart.ddount.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.ddount.view.mediator.*;
	
	public class ClearCmd extends SimpleCommand implements ICommand
	{
		public function ClearCmd()
		{
			super();
		}	
		
		override public function execute( notification:INotification ):void{
			
			//Log.log( 'ClearCmd' );
			
			facade.hasMediator( BgMediator.name ) && facade.removeMediator( BgMediator.name );
			facade.hasMediator( BaseTitleMediator.name ) && facade.removeMediator( BaseTitleMediator.name );
			facade.hasMediator( BaseSubtitleMediator.name ) && facade.removeMediator( BaseSubtitleMediator.name );
			facade.hasMediator( BaseVTitleMediator.name ) && facade.removeMediator( BaseVTitleMediator.name );
			facade.hasMediator( BaseCreditMediator.name ) && facade.removeMediator( BaseCreditMediator.name );
			facade.hasMediator( VLabelMediator.name ) && facade.removeMediator( VLabelMediator.name );
			facade.hasMediator( HLabelMediator.name ) && facade.removeMediator( HLabelMediator.name );
			facade.hasMediator( GraphicMediator.name ) && facade.removeMediator( GraphicMediator.name );
			facade.hasMediator( GraphicBgMediator.name ) && facade.removeMediator( GraphicBgMediator.name );
			facade.hasMediator( MainMediator.name ) && facade.removeMediator( MainMediator.name );
			facade.hasMediator( BgLineMediator.name ) && facade.removeMediator( BgLineMediator.name );
			facade.hasMediator( LegendMediator.name ) && facade.removeMediator( LegendMediator.name );
			facade.hasMediator( TipsMediator.name ) && facade.removeMediator( TipsMediator.name );
			facade.hasMediator( BaseTestMediator.name ) && facade.removeMediator( BaseTestMediator.name );		
			facade.hasMediator( BasePieLabelMediator.name ) && facade.removeMediator( BasePieLabelMediator.name );			
		}
	}
}