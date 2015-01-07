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
	
	public class NormalVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		public function NormalVLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			Common.each( _config.realRate, function( _k:int, _item:Number ):*{
				
				var _floatLen:int = _config.realRateFloatLen;
				
				if( _config.floatLen === 0 && _config.maxNum > 10 ){
					_floatLen = 0;
				}
					
				if( _config.cd && _config.cd.yAxis && ( 'realRateFloatLen' in _config.cd.yAxis ) ){
					_floatLen = _config.realRateFloatLen;
				}
				
				_t = Common.moneyFormat( _item, 3, _floatLen || 0 );
				
				_titem = new TextField();				
				
				if( _config.isPercent ){
					_titem.text = _t + '%';
				}else{
				}
				_titem.text = StringUtils.printf( _config.yAxisFormat, _t );
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, { color: 0x838383 }
					, _config.vlabelsStyle
				] );
											
				if( _config.animationEnabled ){
					_titem.visible = false;
				}
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
			});			
			//Log.log( 'maxwidth', _maxWidth );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( _config.c && _config.c.vpoint ) ) return;
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ]
					, _sx:Number = _item.start.x - _config.yArrowLength; 
					;
								
				if( _config.animationEnabled ){
					_tf.visible = true;
					_tf.y = _item.start.y - _tf.height / 2;
					_tf.x = _sx - _tf.width - _config.vlabelSpace - 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									x: _sx - _tf.width - _config.vlabelSpace
									, y: _item.start.y - _tf.height / 2
									, ease: Expo.easeOut } );
						});
				}else{
					_tf.x = _sx - _tf.width - _config.vlabelSpace;
					_tf.y = _item.start.y - _tf.height / 2;
				}
				
			});
		}


	}
}