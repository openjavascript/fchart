package org.xas.jchart.common.view.components.SerialLabel
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseSerialLabelView extends Sprite
	{	
		protected var _maxHeight:Number = 0;
		public function get maxHeight():Number{ return _maxHeight; }
		
		protected var _maxWidth:Number = 0;
		public function get maxWidth():Number{ return _maxWidth; }
		
		protected var _labels:Vector.< Vector.<TextField> >;
		public function get labels():Vector.<Vector.<TextField>>{ return _labels; }
		
		private var _config:Config;
		public function get config():Config{ return _config; }
		
		public function BaseSerialLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		protected function addToStage( _evt:Event ):void{
		}
		
		protected function showChart( _evt: JChartEvent ):void{
		}
		
		protected function showTips( _evt: JChartEvent ):void{
		}
		
		protected function hideTips( _evt: JChartEvent ):void{		
		}		
		
		protected function updateTips( _evt: JChartEvent ):void{
		}
		
		protected function seriesEnabled( _srcData:Object, _k:int ):Boolean{
			var _r:Boolean = _config.superSerialLabelEnabled, _tmp:Object;
			
			if( _srcData && ( _tmp = _srcData[ _k ] ) ){
				//				"data":
				//				{
				//					"dataLabels":
				//					{
				//						"enabled": false
				//					}, 
//				Log.printFormatJSON( _srcData[ _k ] )
				//				_r = _config.superSerialLabelEnabled;
				_tmp.dataLabels
					&& ( 'enabled' in _tmp.dataLabels )
					&& ( _r = StringUtils.parseBool( _tmp.dataLabels.enabled ) );
				
				_tmp.dataLabel
					&& ( 'enabled' in _tmp.dataLabel )
					&& ( _r = StringUtils.parseBool( _tmp.dataLabel.enabled ) );
			}
			
			return _r;
		}

	}
}