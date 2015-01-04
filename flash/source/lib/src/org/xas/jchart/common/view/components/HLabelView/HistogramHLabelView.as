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

	public class HistogramHLabelView extends BaseHLabelView
	{		
		private var _lRotateFlag:Boolean;
		
		private var _labelDir:Number;
		
		private var _displayAllLabel:Boolean;
		
		public function HistogramHLabelView()
		{
			super();
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			var _labelRotate:Boolean = config.labelRotationEnable;
			var _twidth:Number = config.c.labelWidth;
			
			_twidth < 16 && ( _twidth = 16 );
			
			_displayAllLabel = config.displayAllLabel;
			
			if( config.cd && config.cd.xAxis && config.cd.xAxis.categories ){
				
				Common.each( config.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = _t
					_titem.text = StringUtils.printf( config.xAxisFormat, _t );
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': 'center' }
						, config.labelsStyle
					] );
					
					if( config.xAxisWordwrap ) {
						_titem.width = _twidth * 1.5;
						_titem.wordWrap = true;
					} 
					
					if( !_displayAllLabel ) {
						if( !( _k in config.labelDisplayIndex ) ) {
							_titem.visible = false;
						}
					}
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
					_titem.x = -1000;
					addChild( _titem );
					
					_labels.push( _titem );
					
				} );								
			}
			
			config.facade.sendNotification( JChartEvent.ROTATION_LABELS, {}, 'bar' );
			
//			Common.each( _labels, function( _k:int, _titem:TextField ):*{
//				_titem.height > _maxHeight && ( _maxHeight = _titem.height );
//				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
//			} );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( config.c && config.c.hpoint ) ) return;
			
			if( config.labelRotationEnable ){
				rotationUpdate();
			}else{
				normalUpdate();
			}
		}
		
		private function normalUpdate():void{
			
			Common.each( config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				if( !_displayAllLabel ) {
					if( !( _k in config.labelDisplayIndex ) ) {
						return;
					}
				}
				
				/* 指定标签定位的坐标 */
				var _x:Number, _y:Number;
				var _chartPoint:Point;
				
				_x = _item.end.x - _tf.width / 2;
				_y = _item.end.y - 2;
				
				if( _k === 0 ) {
					_x < config.c.chartX && ( 
						_x = config.c.chartX - _tf.width / 2 + _tf.textWidth / 2 - 3
					);
				} else if ( _k === config.c.hpointReal.length - 1 ) {
					if( _x + _tf.width > config.c.chartX + config.c.chartWidth ){
						_x = config.c.chartX + config.c.chartWidth - _tf.width / 2 - _tf.textWidth / 2 + 3
					}
				}
				
				if( BaseConfig.ins.animationEnabled ) {
					//_tf.visible = true;
					_tf.y = _item.end.y + 200;
					_tf.x = _x;
					TweenLite.delayedCall( 0, function():void{
						TweenLite.to( _tf, BaseConfig.ins.animationDuration, { 
							x: _x
							, y: _y
							, ease: Expo.easeOut 
						} );
					} );
				} else {
					_tf.x = _x;
					_tf.y = _y;
				}
			});
		}
		
		private function rotationUpdate():void{
			
			if( !( config.c.rotationCoor && config.c.rotationCoor.length ) ) return;
			
			Common.each( config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ]
					, _location:Point
					, _newLocation:Point
					, _offsetPoint:Point
					;
				
				if( !_displayAllLabel ) {
					if( !( _k in config.labelDisplayIndex ) ) {
						return;
					}
				}
				_offsetPoint = config.c.rotationCoor[ _k ].offset as Point;
				if( !_offsetPoint ) return;
				
				/* 指定标签定位的坐标 */
				var _x:Number, _y:Number;
				var _chartPoint:Point;
				
				_x = _item.end.x ;
				_y = _item.end.y;
				
				_location = new Point( _x, _y );
				_newLocation = _location.subtract( _offsetPoint );
				
				if( BaseConfig.ins.animationEnabled ) {
					//_tf.visible = true;
					_tf.y = _newLocation.y + 200;
					_tf.x = _newLocation.x;
					TweenLite.delayedCall( 0, function():void{
						TweenLite.to( _tf, BaseConfig.ins.animationDuration, { 
							x: _newLocation.x
							, y: _newLocation.y
							, ease: Expo.easeOut 
						} );
					} );
				} else {
					_tf.x = _newLocation.x;
					_tf.y = _newLocation.y;
				}
			});
		}
	}
}