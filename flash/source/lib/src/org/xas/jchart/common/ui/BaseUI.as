package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.ui.icon.*;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class BaseUI extends JSprite
	{
		
		protected var __config:Config;
		public function get config():Config{ return __config; }
		
		protected var _mask:Sprite;
		
		public function BaseUI( _data:Object = null )
		{
			super( _data );
			__config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		protected function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		protected function init():void{
			if( config.animationEnabled ){
				initAnimation();
			}else{
				initStatck();
			}
		}
		
		protected function initStatck():void{
			
		}
		protected function initAnimation():void{
			initStatck();
		}
	}
}

