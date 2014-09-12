package org.xas.jchart.common.view.components.VLabelView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class VHistogramVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		public function VHistogramVLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			Common.each( BaseConfig.ins.realRate, function( _k:int, _item:Number ):*{
				
				_t = Common.moneyFormat( _item, 3, BaseConfig.ins.realRateFloatLen || 0 );
				
				_titem = new TextField();
				
				
				
				if( BaseConfig.ins.isPercent ){
					_titem.text = _t + '%';
				}else{
				}
				_titem.text = StringUtils.printf( BaseConfig.ins.yAxisFormat, _t );
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, { color: 0x838383 }
					, BaseConfig.ins.vlabelsStyle
				] );
				
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
				_titem.height > _maxHeight && ( _maxHeight = _titem.height );
			});			
			//Log.log( 'maxwidth', _maxWidth );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.vpoint ) ) return;
			
			Common.each( BaseConfig.ins.c.vpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				var _x:Number = _item.end.x - _tf.width / 2;
				
				if( _k === 0 ){
					if( _x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
						_x = _config.c.chartX + _config.c.chartWidth - _tf.width + 3;
					}
				}else if( _k === _config.c.vpointReal.length - 1 ){
					_x < 5 && ( _x = _config.c.chartX - 3 );
				}
				
				_tf.x = _x;
				_tf.y = _item.end.y;
			});
		}


	}
}