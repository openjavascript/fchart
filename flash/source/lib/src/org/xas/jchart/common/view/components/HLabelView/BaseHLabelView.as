package org.xas.jchart.common.view.components.HLabelView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseHLabelView extends Sprite
	{
		protected var _labels:Vector.<TextField>;
		public function get labels():Vector.<TextField>{ return _labels; }
		
		protected var _tmpLabels:Vector.<TextField>;
		
		protected var _maxHeight:Number = 0;
		public function get maxHeight():Number{ return _maxHeight; }
		public function set maxHeight( _setter:Number ):void{ _maxHeight = _setter; }
		
		protected var _maxWidth:Number = 0;
		public function get maxWidth():Number{ return _maxWidth; }
		public function set maxWidth( _setter:Number ):void{ _maxWidth = _setter; }
		
		protected var __config:Config;
		public function get config():Config{ return __config; }
		
		public function BaseHLabelView()
		{
			super();
			__config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );			
			addEventListener( JChartEvent.RESET_HLABELS, reset );			
		}
		
		protected function addToStage( _evt:Event ):void{

		}
		
		protected function update( _evt:JChartEvent ):void{
			if( !( config.c && config.c.hpoint ) ) return;
			
			if( config.labelRotationEnable ){
				rotationUpdate();
			}else{
				normalUpdate();
			}
		}
				
		protected function normalUpdate():void{
		}
		
		protected function rotationUpdate():void{
			normalUpdate();
		}
		
		protected function reset( _evt:JChartEvent ):void{
//			Log.log( 'BaseHLabelView.reset' );
			config.setDisplayAllLabel( false );
			config.calcLabelDisplayIndex();
//			Log.printFormatJSON( config.labelDisplayIndex );
			if( !( labels && labels.length && config.labelDisplayIndex ) ) return;
			
			Common.each( labels, function( _k:int, _item:TextField ):void{
				_item.visible = config.labelDisplayIndex[ _k ] || false;
				//Log.log( _item.visible );
			});
		}
	}
}