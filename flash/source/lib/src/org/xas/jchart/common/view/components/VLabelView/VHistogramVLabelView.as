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
	
	public class VHistogramVLabelView extends BaseVLabelView
	{
		public function VHistogramVLabelView()
		{
			super();
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			Common.each( config.realRate, function( _k:int, _item:Number ):*{
				
				
				var _floatLen:int = config.realRateFloatLen;
				
				if( config.floatLen === 0 && config.maxNum >= 8 ){
					_floatLen = 0;
				}
				
				_t = Common.moneyFormat( _item, 3, _floatLen || 0 );
				
				_titem = new TextField();
				
				
				
				if( config.isPercent ){
					_titem.text = _t + '%';
				}else{
				}
				_titem.text = StringUtils.printf( config.yAxisFormat, _t );
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, { color: 0x838383 }
					, config.vlabelsStyle
				] );
				
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
				_titem.height > _maxHeight && ( _maxHeight = _titem.height );
			});			
			//Log.log( 'maxwidth', _maxWidth );
			
			config.facade.sendNotification( JChartEvent.ROTATION_LABELS_YAXIS, {}, 'vbar' );
		}
		
		override protected function normalUpdate( ):void{
			if( !( config.c && config.c.vpoint ) ) return;
			
			Common.each( config.c.vpointReal, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				var _x:Number = _item.end.x - _tf.width / 2
					, _y:Number = _item.end.y
					;
					
				if( config.hlineEnabled ){
				}
				_y += config.xArrowLength;
				
				if( _k === 0 ){
					if( _x + _tf.width > config.stageWidth ){
						_x = config.stageWidth - _tf.width - 2;
					}
				}else if( _k === config.c.vpointReal.length - 1 ){
					_x < 2 && ( _x = 2 );
				}
				
//				_tf.x = _x;
//				_tf.y = _item.end.y;
				
				if( config.animationEnabled ){
					_tf.visible = true;
					_tf.x = _x;
					_tf.y = _y + 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, config.animationDuration
								, { 
									x: _x
									, y: _y
									, ease: Expo.easeOut } );
						});
				}else{
//					_tf.x = _item.start.x - _tf.width - config.vlabelSpace;
//					_tf.y = _item.start.y - _tf.height / 2;
					_tf.x = _x;
					_tf.y = _y;
				}
			});
		}
		override protected function rotationUpdate():void{
			if( !( config.c.rotationCoor && config.c.rotationCoor.length ) ) return;
			
			Common.each( config.c.vpointReal, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ]
					, _location:Point
					, _newLocation:Point
					, _offsetPoint:Point
					, _x:Number = _item.end.x 
					, _y:Number = _item.end.y
					;
				
				_offsetPoint = config.c.rotationCoor[ _k ].offset as Point;
				if( !_offsetPoint ) return;
				
				_y += config.xArrowLength;

				_location = new Point( _x, _y );
				_newLocation = _location.subtract( _offsetPoint );
				
				//				_tf.x = _x;
				//				_tf.y = _item.end.y;
				
				if( config.animationEnabled ){
					_tf.visible = true;
					_tf.x = _newLocation.x;
					_tf.y = _newLocation.y + 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, config.animationDuration
								, { 
									x: _newLocation.x
									, y: _newLocation.y
									, ease: Expo.easeOut } );
						});
				}else{
					//					_tf.x = _item.start.x - _tf.width - config.vlabelSpace;
					//					_tf.y = _item.start.y - _tf.height / 2;
					_tf.x = _newLocation.x;
					_tf.y = _newLocation.y;
				}
			});	
		}


	}
}