package org.xas.jchart.common.view.components.VLabelView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
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
	
	public class ZVHistogramVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		public function ZVHistogramVLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			Common.each( BaseConfig.ins.realRate, function( _k:int, _item:Number ):*{
				
				
				var _floatLen:int = BaseConfig.ins.realRateFloatLen;
				
				if( _config.floatLen === 0 && _config.maxNum >= 8 ){
					_floatLen = 0;
				}
				
				_t = Common.moneyFormat( _item, 3, _floatLen || 0 );
				
				_titem = new TextField();
				
				if( _config.isPercent ){
					_titem.text = _t + '%';
				}
				
				
				
				_titem.text = StringUtils.printf( _config.yAxisFormat, _t );
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, { color: 0x838383 }
					, _config.vlabelsStyle
				] );
				
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
				_titem.height > _maxHeight && ( _maxHeight = _titem.height );
			});			
			//Log.log( 'maxwidth', _maxWidth );
			config.facade.sendNotification( JChartEvent.ROTATION_LABELS_YAXIS, {}, 'vzbar' );
		}
		
		override protected function normalUpdate( ):void{
			if( !( _config.c && _config.c.vpoint ) ) return;
			
			var _endY:Number = _config.c.chartY + _config.c.chartHeight + 1;
			if( _config.yAxisEnabled && _config.vlineEnabled ){
				_endY += _config.yArrowLength;
			}
			
			Common.each( _config.c.vpointReal, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				var _x:Number = _item.end.x - _tf.width / 2
					;
				
				if( _k === 0 ){
					if( _x + _tf.width > _config.stageWidth ){
						_x = _config.stageWidth - _tf.width;
					}
				}else if( _k === _config.c.vpointReal.length - 1 ){
					_x < 1 && ( _x = 1 );
				}
				
//				_tf.x = _x;
//				_tf.y = _item.end.y;
				
				if( _config.animationEnabled ){
					_tf.visible = true;
					_tf.x = _x;
					_tf.y = _item.end.y + 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									x: _x
									, y: _endY
									, ease: Expo.easeOut } );
						});
				}else{
//					_tf.x = _item.start.x - _tf.width - _config.vlabelSpace;
//					_tf.y = _item.start.y - _tf.height / 2;
					_tf.x = _x;
					_tf.y = _endY;
				}
			});
		}
		override protected function rotationUpdate():void{
			if( !( config.c.rotationCoor && config.c.rotationCoor.length ) ) return;
			
			var _endY:Number = _config.c.chartY + _config.c.chartHeight + 1;
			if( _config.yAxisEnabled && _config.vlineEnabled ){
				_endY += _config.yArrowLength;
			}
			
			Common.each( _config.c.vpointReal, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ]
				, _location:Point
				, _newLocation:Point
				, _offsetPoint:Point
				, _x:Number = _item.end.x 
				, _y:Number = _endY
				;
				_offsetPoint = config.c.rotationCoor[ _k ].offset as Point;
				if( !_offsetPoint ) return;
				

				_location = new Point( _x, _y );
				_newLocation = _location.subtract( _offsetPoint );
				
				//				_tf.x = _x;
				//				_tf.y = _item.end.y;
				
				if( _config.animationEnabled ){
					_tf.visible = true;
					_tf.x = _newLocation.x;
					_tf.y = _newLocation.y + 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									x: _newLocation.x
									, y: _newLocation.y
									, ease: Expo.easeOut } );
						});
				}else{
					_tf.x = _newLocation.x;
					_tf.y = _newLocation.y;
				}
			});
		}


	}
}