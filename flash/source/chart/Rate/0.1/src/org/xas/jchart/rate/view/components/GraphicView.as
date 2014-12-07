package org.xas.jchart.rate.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.RateBall;
	
	public class GraphicView extends Sprite
	{			
		private var _hideTimer:Timer;
		private var _rateBall:RateBall;	
		
		private var _config:Config;
		
		public function GraphicView()
		{
			super(); 
			
			_config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			_hideTimer = new Timer( 200, 1 );
			_hideTimer.addEventListener( TimerEvent.TIMER, onTimerHideDone );
			//_hideTimer.start();
		}
		
		private function addToStage( _evt:Event ):void{
		}
		
		public function update():void{
			
			if( !( _config.c && _config.c.piePart && _config.c.piePart.length ) ) return;
			
			graphics.clear();
			
			if( !_config.c.piePart.length ) return;
			
			var _k:int = 0, _item:Object = _config.c.piePart[0];
			
			//if( _item.data.y === 0 ) return;
			if( _item.data.y === 0 ){
				Log.log( 'is zero' );
			}
			
			_rateBall = new RateBall( 
				_item.data.y, _config.yAxisMaxValue
				, new Point( _item.cx, _item.cy )
				, _item.radius
				, _config.borderWidth
				, _config.textStyle
				, _config.dataLabelFormat
				, _config.serialLabelEnabled
				, _item.data.borderBgColor || 0xECECEC
				, _item.data.borderBgFillColor || 0xffffff
				, _item.data.dataBorderBgColor || 0xFEB556
				, _item.data.dataBorderBgFillColor || 0xFDF0F2
			);
			addChild( _rateBall );
			_rateBall.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			_rateBall.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			/*
			name: 'Firefox'
			,  y: 50.01
			, style: { size: 40 }
			, borderBgColor: 0xECECEC
			, borderBgFillColor: 0xffffff
			, dataBorderBgColor: 0xFEB556
			, dataBorderBgFillColor: 0xFDF0F2
			*/
			
			//Log.printJSON( _config.textStyle );
			/*
			
			var _pp:PiePart = new PiePart( 
				new Point( _item.cx, _item.cy )
				, _item.startAngle, _item.endAngle
				, _item.radius
				, _k
				, { 'color': _config.itemColor( _k ) }
			);
						
			addChild( _pp );
			*/
		}
				
		protected function onMouseOver( _evt:MouseEvent ):void{
			
			_hideTimer.running && _hideTimer.stop();
			root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			root.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, _evt ) );
			//Log.log( 'show tips' );
			
		}
		
		protected function onMouseOut( _evt:MouseEvent ):void{
			try{
				root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				//dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt ) );
				_hideTimer.running && _hideTimer.stop();
				_hideTimer.start();
			}catch( ex:Error ){}
			//Log.log( 'hide tips' );
			
		}
		
		protected function onTimerHideDone( _evt:TimerEvent ):void{
			//Log.log( 'timer done' );
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS ) );
		}
		
		protected function onMouseClick( _evt:MouseEvent ):void{

		}
		
		protected function onMouseMove( _evt:MouseEvent ):void{
			//Log.log( 'GraphicView onMouseMove', new Date().getTime() );
			
			var _pp:RateBall = _evt.target as RateBall;
			//Log.log( _pp.dataIndex );
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: 0 } ) );
			
		}	

	}
}