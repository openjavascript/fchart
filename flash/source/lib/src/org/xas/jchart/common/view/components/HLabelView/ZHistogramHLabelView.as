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

	public class ZHistogramHLabelView extends BaseHLabelView
	{
		private var _config:Config;
		
		public function ZHistogramHLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _titem:TextField;
			
			if( _config.cd && _config.displaySeries ){
				
				Common.each( _config.displaySeries, function( _k:int, _item:Object ):void{
					
					_titem = new TextField();
					_titem.text = StringUtils.printf( _config.xAxisFormat, _item.name );
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': 'center' }
						, _config.labelsStyle
					] );
					
					if( _config.c.labelWidth && _config.xAxisWordwrap ){
						var _twidth:Number = _config.c.labelWidth;
						if( _twidth < 14 ) _twidth = 14;
						_titem.width = _twidth * 1.8;
						_titem.wordWrap = true;
					}
//					
//					if( BaseConfig.ins.animationEnabled ){
//						_titem.visible = false;//false
//					}
					_titem.x = -1000;
					
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				});
			}
			config.facade.sendNotification( JChartEvent.ROTATION_LABELS, {}, 'column' );
		}
		
		override protected function normalUpdate( ):void{
			if( !( _config.c && _config.c.hpoint ) ) return;
			
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ]
				, _location:Point = new Point( _tf.x, _tf.y )
				;
				
				/* 指定标签定位的坐标 */
				_location.x = _item.end.x - _tf.width / 2;
				_location.y = _item.end.y;
				
				if( _config.vlineEnabled ){
					_location.y += _config.xArrowLength - 1;
				}else{
					if( _config.xAxisEnabled ){
						_location.y += _config.xArrowLength - 1;
					}else{
						_location.y += 2;
					}
				}
				
				if( _k === 0 ){
					_location.x < _config.c.chartX && ( _location.x = _config.c.chartX - 3 );
				}else if( _k === _config.c.hpointReal.length - 1 ){
					if( _location.x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
						_location.x = _config.c.chartX + _config.c.chartWidth - _tf.width + 3;
					}
				}
				
				if( BaseConfig.ins.animationEnabled ){
					_tf.y = _location.y + 200;
					_tf.x = _location.x;
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, BaseConfig.ins.animationDuration
								, { 
									x: _location.x
									, y: _location.y - 2
									, ease: Expo.easeOut } );
						});
				}else{
					_tf.x = _location.x;
					_tf.y = _location.y - 2;
				}
			});
		}
		
		override protected function rotationUpdate():void{
			if( !( config.c.rotationCoor && config.c.rotationCoor.length ) ) return;
			
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				/* 指定标签定位的坐标 */
				var _location:Point = new Point( _item.end.x, _item.end.y )
					, _offsetPoint:Point
					, _newLocation:Point
					;				
					
				if( _config.vlineEnabled ){
					_location.y += _config.xArrowLength - 1;
				}else{
					if( _config.xAxisEnabled ){
						_location.y += _config.xArrowLength - 1;
					}else{
						_location.y += 2;
					}
				}
					
				_offsetPoint = config.c.rotationCoor[ _k ].offset as Point;
				if( !_offsetPoint ) return;
				_newLocation = _location.subtract( _offsetPoint );
				
				if( BaseConfig.ins.animationEnabled ){
					_tf.y = _newLocation.y + 200;
					_tf.x = _newLocation.x;
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, BaseConfig.ins.animationDuration
								, { 
									x: _newLocation.x
									, y: _newLocation.y
									, ease: Expo.easeOut } );
						});
				}else{
					_tf.x = _newLocation.y;
					_tf.y = _newLocation.y;
				}
			});
		}
	}
}