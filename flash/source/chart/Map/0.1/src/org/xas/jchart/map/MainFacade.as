package org.xas.jchart.map
{
	import flash.net.registerClassAlias;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.facade.*;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.map.controller.CalcCoordinateCmd;
	import org.xas.jchart.map.controller.ClearCmd;
	import org.xas.jchart.map.controller.DrawCmd;
	import org.xas.jchart.map.controller.FilterDataCmd;
	
	public class MainFacade extends BaseFacade implements ICommand
	{
		public static const name:String = 'MapFacade';
		
		public function MainFacade( _name:String ) {
			super( _name );
		}
		
		public function execute( notification:INotification ):void {
		}
		
		public static function getInstance():Facade {
			if ( instanceMap[ name ] == null ) instanceMap[ name ]  = new MainFacade( name );
			return instanceMap[ name ] as MainFacade;
		}
		
		override protected function initializeController():void {
			super.initializeController();
			registerCommand( JChartEvent.CALC_COORDINATE, CalcCoordinateCmd );
			registerCommand( JChartEvent.CLEAR, ClearCmd );
			registerCommand( JChartEvent.DRAW, DrawCmd );
			registerCommand( JChartEvent.FILTER_DATA, FilterDataCmd );
		}
	}
}