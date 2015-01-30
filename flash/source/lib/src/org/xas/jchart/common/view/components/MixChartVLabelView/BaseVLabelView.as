package org.xas.jchart.common.view.components.MixChartVLabelView
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
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.BaseMixChartModelItem;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseVLabelView extends Sprite
	{
		protected var _labels:Vector.<TextField>;
		public function get labels():Vector.<TextField>{ return _labels; }
		
		protected var _maxWidth:Number = 0;
		public function get maxWidth():Number{ return _maxWidth; }
		
		protected var _maxHeight:Number = 0;
		public function get maxHeight():Number{ return _maxHeight; }
		
		protected var _index:Number;
		public function get index():Number{ return _index; }
		
		
		protected var _model:BaseMixChartModelItem;
		public function get model():BaseMixChartModelItem{ return _model; }
				
		
		public function BaseVLabelView( _index:int, _model:BaseMixChartModelItem )
		{
			super();
			
			this._index = _index;
			this._model = _model;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );			
		}
		
		protected function addToStage( _evt:Event ):void{

		}
		
		protected function update( _evt:JChartEvent ):void{

		}
	}
}