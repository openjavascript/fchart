package org.xas.jchart.common.view.components.HLabelView
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;

	public class HStackHLabelView extends BaseHLabelView
	{		
		private var _lRotateFlag:Boolean;
		
		private var _labelDir:Number;
		
		private var _displayAllLabel:Boolean;
		private var _config:Config;
		
		public function HStackHLabelView()
		{
			super();
			_config = config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			Common.each( _config.realRate, function( _k:int, _item:Number ):*{
				
				_item =  _config.realRate[ _config.realRate.length - _k - 1 ];
				
				var _floatLen:int = _config.realRateFloatLen;
				
				if( _config.floatLen === 0 && _config.maxNum > 10 ){
					_floatLen = 0;
				}
				
				if( _config.cd && _config.cd.yAxis && ( 'realRateFloatLen' in _config.cd.yAxis ) ){
					_floatLen = _config.realRateFloatLen;
				}
				
				//				_t = Common.moneyFormat( _item, 3, _floatLen || 0 );
				_t = Common.moneyFormat( 
					_item
					, 3
					, _config.yAxisAbbrNumber( _item, _floatLen || 0 )
					, ','
					, _config.yAxisAbbrNumberEnabled 
				);
				
				_titem = new TextField();				
				
				if( _config.isPercent ){
					_titem.text = _t + '%';
				}else{
				} 
				_titem.text = StringUtils.printf( _config.yAxisFormat, _t );
//				Log.log( _t );
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, { color: 0x838383 }
					, _config.vlabelsStyle
				] );
				
//				_titem.x = -1000;
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
				_titem.height > _maxHeight && ( _maxHeight = _titem.height );
			});	
		}
		
		override protected function normalUpdate():void{
			
			if( !( _config.c && _config.c.hpoint ) ) return;
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				if( _k >= _labels.length ) return;
				var _tf:TextField = _labels[ _k ]
					, _x:Number = _item.start.x - _tf.width / 2
					, _y:Number = _item.end.y + _config.yArrowLength
					;
					
				if( _x < 0 ){
					_x = 0;
				}
				
				if( _x + _tf.width > _config.stageWidth ){
					_x = _config.stageWidth - _tf.width;
				}
				
				if( _config.animationEnabled ){
					_tf.visible = true;
					_tf.y = _y + 200;
					_tf.x = _x;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									x: _x
									, y: _y
									, ease: Expo.easeOut } );
						});
				}else{
					_tf.x = _x;
					_tf.y = _y;
				}
				
			});
		}
	}
}