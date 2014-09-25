package org.xas.jchart.common.utils
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.event.JChartEvent;
	
	/**
	 * @example
	 * 		MouseWheelTrap.setup(stage);
	 */ 
	
	public class MouseWheelTrap {
		
		static private var _mouseWheelTrapped :Boolean;
		
		public static function setup(mainStage:Stage):void {
			
			//if( ExternalInterface.available ){
				JChartEvent.mouseEnter( mainStage, function( _evt:MouseEvent ):void{ 						
					Log.log( 'roll_over' );
					if( ExternalInterface.available ){
						ExternalInterface.call( 'console.log', 'roll_over', new Date().getTime() );
						allowBrowserScroll(false); 
					}
					
				});
				
				JChartEvent.mouseLeave( mainStage, function( _evt:MouseEvent ):void{  
					Log.log( 'roll_out' );
					if( ExternalInterface.available ){
						ExternalInterface.call( 'console.log', 'roll_out', new Date().getTime() );
						allowBrowserScroll(true);  
					}
				});
			//}
		}
		
		private static function allowBrowserScroll(allow:Boolean):void
		{
			createMouseWheelTrap();
			if (ExternalInterface.available){
				ExternalInterface.call("allowBrowserScroll", allow);
			}
		}
		private static function createMouseWheelTrap():void
		{
			if (_mouseWheelTrapped) {return;} _mouseWheelTrapped = true; 
			if (ExternalInterface.available){
				ExternalInterface.call("eval", "var browserScrolling;function allowBrowserScroll(value){browserScrolling=value;}function handle(delta){if(!browserScrolling){return false;}return true;}function wheel(event){var delta=0;if(!event){event=window.event;}if(event.wheelDelta){delta=event.wheelDelta/120;}else if(event.detail){delta=-event.detail/3;}if(delta){handle(delta);}if(!browserScrolling){if(event.preventDefault){event.preventDefault();}event.returnValue=false;}}if(window.addEventListener){window.addEventListener('DOMMouseScroll',wheel,false);}window.onmousewheel=document.onmousewheel=wheel;allowBrowserScroll(true);");
			}
		}
	}
}