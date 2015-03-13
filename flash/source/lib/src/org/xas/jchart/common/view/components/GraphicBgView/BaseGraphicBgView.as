package org.xas.jchart.common.view.components.GraphicBgView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseGraphicBgView extends Sprite
	{	
		protected var _hideTimer:Timer;
		protected var config:Config;
		
		public function BaseGraphicBgView()
		{
			super();
			config = BaseConfig.ins as Config;
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			_hideTimer = new Timer( 200, 1 );
			_hideTimer.addEventListener( TimerEvent.TIMER, onTimerHideDone );
			mouseEnabled = false;
		}
		
		protected function addToStage( _evt:Event ):void{
			
			JChartEvent.mouseEnter( this, onMouseEnter );
			JChartEvent.mouseLeave( this, onMouseLeave );
		}
		
		protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			this.graphics.beginFill( 0xffffff, .01 );
			this.graphics.drawRect(
				0, 0, BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight 
			);
			this.x = BaseConfig.ins.c.chartX;
			this.y = BaseConfig.ins.c.chartY;
			this.graphics.endFill();
			
			/*
			this.graphics.beginFill( 0xcccccc, 1 );
			this.graphics.drawRect(
				0, 0, BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight 
			);
			this.graphics.endFill();
			*/
			
			this.x = BaseConfig.ins.c.chartX;
			this.y = BaseConfig.ins.c.chartY;
		}
		
		protected function onMouseEnter( _evt:MouseEvent ):void {
			//Log.log( 'GraphicView mouse onMouseEnter' );
			_hideTimer.running && _hideTimer.stop();
			this.root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			this.root.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, _evt ) );
		}
		
		protected function onMouseLeave( _evt:MouseEvent ):void {
			//Log.log( 'GraphicView mouse onMouseLeave' );		
			this.root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			//dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt ) );	
			_hideTimer.running && _hideTimer.stop();
			_hideTimer.start();
		}
		
		protected function onTimerHideDone( _evt:TimerEvent ):void {
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS ) );
		}
		
		protected function onMouseMove( _evt:MouseEvent ):void {
		}

	}
}