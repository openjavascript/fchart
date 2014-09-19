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
	
	public class MapVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		public function MapVLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, 
				_t:String, 
				_titem:TextField,
				_tarrow:Sprite,
				_realRate:Array = _config.realRate,
				_custRate:Array,
				_lHeight:Number = _config.c.legend.height,
				_startY:Number = _config.c.legend.pY + _lHeight,
				_startX:Number = _config.c.legend.pX;
				
				
			if( _config.rateNum == 3 ) {
				_custRate = new Array(
					_realRate[0],
					_realRate[2],
					_realRate[4]
				);
			} else if( _config.rateNum == 2 ) {
				_custRate = new Array(
					_realRate[0],
					_realRate[4]
				);
			} else {
				_custRate = _realRate;
			}
			
			var _tmpHeight:Number = _lHeight / ( _config.rateNum - 1 );
			
			Common.each( _custRate, function( _k:int, _item:Number ):void{
				
				_t = Common.moneyFormat( _item, 3, _config.realRateFloatLen || 0 );
				
				_titem = new TextField();
				_tarrow = new Sprite();
				
				if( _config.isPercent ) {
					_titem.text = _t + '%';
				}
				_titem.text = StringUtils.printf( _config.yAxisFormat, _t );
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, { color: 0x838383 }
					, _config.vlabelsStyle
				] );
				
				_tarrow.graphics.clear();
				_tarrow.graphics.lineStyle( 1, 0xcccccc );
				_tarrow.graphics.moveTo( _startX, _startY );
				_tarrow.graphics.lineTo( _startX + 5, _startY );
				
				_titem.x = _startX + 10;
				_titem.y = _startY - _titem.height / 2;
				_startY -= _tmpHeight;
				addChild( _titem );
				addChild( _tarrow );
				_labels.push( _titem );
			});
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