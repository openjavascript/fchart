package org.xas.jchart.common.view.components.VLabelView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
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
	
	public class HistogramVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		public function HistogramVLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			Common.each( BaseConfig.ins.realRate, function( _k:int, _item:Number ):*{
				
				var _floatLen:int = BaseConfig.ins.realRateFloatLen;
				
				if( BaseConfig.ins.floatLen === 0 && BaseConfig.ins.maxNum >= 8 ){
					_floatLen = 0;
				}
				
				_t = Common.moneyFormat( _item, 3, _floatLen || 0 );
				
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
											
				if( BaseConfig.ins.animationEnabled ){
					_titem.visible = false;
				}
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
			});			
			//Log.log( 'maxwidth', _maxWidth );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.vpoint ) ) return;
			
			Common.each( BaseConfig.ins.c.vpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				if( BaseConfig.ins.animationEnabled ){
					_tf.visible = true;
					_tf.y = _item.start.y - _tf.height / 2;
					_tf.x = _item.start.x - _tf.width - BaseConfig.ins.vlabelSpace - 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, BaseConfig.ins.animationDuration
								, { 
									x: _item.start.x - _tf.width - BaseConfig.ins.vlabelSpace
									, y: _item.start.y - _tf.height / 2
									, ease: Expo.easeOut } );
						});
				}else{
					_tf.x = _item.start.x - _tf.width - BaseConfig.ins.vlabelSpace;
					_tf.y = _item.start.y - _tf.height / 2;
				}
				
			});
		}


	}
}