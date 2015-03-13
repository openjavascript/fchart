package org.xas.jchart.radar
{
	import flash.net.registerClassAlias;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.facade.*;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.controller.GroupClickCmd;
	import org.xas.jchart.common.controller.InitedCmd;
	import org.xas.jchart.common.controller.ItemClickCmd;
	import org.xas.jchart.common.controller.LegendUpdateCmd;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.radar.controller.CalcCoordinateCmd;
	import org.xas.jchart.radar.controller.ClearCmd;
	import org.xas.jchart.radar.controller.DrawCmd;
	import org.xas.jchart.radar.controller.FilterDataCmd;
	
	public class MainFacade extends BaseFacade implements IFacade
	{
		public static const name:String = 'CurveGramFacade';
		
		public function MainFacade( _name:String )
		{
			super( _name );
		}
		
		public function execute( notification:INotification ):void{
		}
		
		public static function getInstance():Facade {
			if ( instanceMap[ name ] == null ) instanceMap[ name ]  = new MainFacade( name );
			return instanceMap[ name ] as MainFacade;
		}
		
		override protected function initializeController():void
		{
			
			super.initializeController();
			//Log.log( 'MainFacade.initializeController' );
						
			registerCommand( JChartEvent.CALC_COORDINATE, CalcCoordinateCmd );
			
			registerCommand( JChartEvent.CLEAR, ClearCmd );
			registerCommand( JChartEvent.DRAW, DrawCmd );
			registerCommand( JChartEvent.FILTER_DATA, FilterDataCmd );
		}			
	}
}