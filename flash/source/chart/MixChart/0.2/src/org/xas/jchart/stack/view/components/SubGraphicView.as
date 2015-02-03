package org.xas.jchart.stack.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.HistogramUI;
	import org.xas.jchart.common.ui.StackUI;
	import org.xas.jchart.common.ui.widget.JSprite;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class SubGraphicView extends JSprite
	{	
		private var _boxs:Vector.<Sprite>;
		public function get box():Vector.<Sprite>{ return _boxs; }
		private var _preIndex:int = -1;
		
		private var _config:Config;
		
		public function SubGraphicView( _data:Object )
		{
			super( _data ); 
			
			_config = BaseConfig.ins as Config;
			
//			Log.printFormatJSON( _data );
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			addEventListener( JChartEvent.UPDATE, update );
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		private function addToStage( _evt:Event ):void{
		}
		
		private function update( _evt:JChartEvent ):void{
			
			graphics.clear();
			
//			Log.printFormatJSON( data );
			
//			return;
			if( !( data.stackItems && data.stackItems.length ) ) return;
			_boxs = new Vector.<Sprite>();
			
			var _delay:Number = 0;
			_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
			
			Common.each( data.stackItems, function( _k:int, _item:Object ):void{
				var _box:Sprite = new Sprite(), _ui:StackUI;
				
				Common.extendObject( _item, {
					animationEnabled: _config.animationEnabled
					, duration: _config.animationDuration
					, delay: _delay
				}, true );
				//				Log.printFormatJSON( _item );
				
				_ui = new StackUI( _item );
				_box.mouseEnabled = false;
				_box.addChild( _ui );
				addChild( _box );
				_boxs.push( _box );
			});


		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{			
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			_preIndex = -1;
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			if( !_boxs[ _ix ] ) return;
			
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			
			_boxs[ _ix ].alpha = .65;
			_preIndex = _ix;
		}
		
	}
}