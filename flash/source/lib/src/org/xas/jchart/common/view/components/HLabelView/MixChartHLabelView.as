package org.xas.jchart.common.view.components.HLabelView
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;

	public class MixChartHLabelView extends BaseHLabelView
	{
		private var _config:Config;
		
		public function MixChartHLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			if( _config.cd && _config.cd.xAxis && _config.cd.xAxis.categories ){
				
				//Log.log( 'ssssssssss', _config.c.labelWidth );
				Common.each( _config.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					//_titem.text = _t;
					_titem.text = StringUtils.printf( _config.xAxisFormat, _t );
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': 'center' }
						, _config.labelsStyle
					] );
					//Log.log( 'w:', _config.c.labelWidth, 'wrap:', _config.xAxisWordwrap );
					
					if( _config.c.labelWidth && _config.xAxisWordwrap ){
						var _twidth:Number = _config.c.labelWidth;
						if( _twidth < 14 ) _twidth = 14;
						_titem.width = _twidth * 1.5;
						_titem.wordWrap = true;
					}
					
					if( !_config.displayAllLabel ){
						if( !( _k in _config.labelDisplayIndex ) ){
							_titem.visible = false;
						}
					}
					if( BaseConfig.ins.animationEnabled ){
//						_titem.visible = false;
					}
					
					_titem.x = -1000;
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				});			
			}
			//Log.log( '_maxHeight', _maxHeight );
			
			config.facade.sendNotification( JChartEvent.ROTATION_LABELS, {}, 'mix' );
		}
		
		override protected function normalUpdate():void{
			if( !( _config.c && _config.c.hpoint ) ) return;
			
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				if( !_config.displayAllLabel ){
					if( !( _k in _config.labelDisplayIndex ) ){
						return;
					}
				}
				
				/* 指定标签定位的坐标 */
				var _x:Number = _item.end.x - _tf.width / 2;
				
				
				if( _k === 0 ){					
					_x < _config.c.chartX && ( 
						_x = _config.c.chartX - _tf.width / 2 + _tf.textWidth / 2 - 3
					);
					//Log.log( _tf.width + ', ' + _config.c.labelWidth );
				}else if( _k === _config.c.hpointReal.length - 1 ){
					if( _x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
						//_x = _config.c.chartX + _config.c.chartWidth - _tf.width + 3;
						_x = _config.c.chartX + _config.c.chartWidth - _tf.width / 2 - _tf.textWidth / 2 + 3
					}
				}
				
				
				if( BaseConfig.ins.animationEnabled ){
					_tf.y = _item.end.y + 200;
					_tf.x = _x;
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, BaseConfig.ins.animationDuration
								, { 
									x: _x
									, y: _item.end.y - 2
									, ease: Expo.easeOut } );
						});
				}else{					
					_tf.x = _x;
					_tf.y = _item.end.y - 2;
				}
			});
		}
		
		override protected function rotationUpdate():void{
			
			if( !( config.c.rotationCoor && config.c.rotationCoor.length ) ) return;
			
			Common.each( config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ]
				, _location:Point
				, _newLocation:Point
				, _offsetPoint:Point
				;
				
				if( !config.displayAllLabel ) {
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
				
				if( _config.vlineEnabled ){
					_location.y += _config.xArrowLength - 1;
				}else{
					if( _config.xAxisEnabled ){
						_location.y += _config.xArrowLength - 1;
					}else{
						_location.y += 2;
					}
				}
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