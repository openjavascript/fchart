package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseBgLineView extends Sprite
	{	
		protected var config:Config;
		
		public function BaseBgLineView()
		{
			super(); 
			config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );
		}
		
		protected function addToStage( _evt:Event ):void{
		}

		protected function update( _evt:JChartEvent ):void{
			
			ElementUtility.removeAllChild( this );
			
			this.graphics.clear();
			this.graphics.lineStyle( 1, 0x999999, .35 );
			
			this.drawHLine();
			this.drawVLine();
			this.drawLineArrow();			
		}
		
		protected function drawHLine():void{

		}
		
		protected function drawVLine():void{

		}
		
		protected function drawLineArrow():void{

		}

	}
}