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
	
	public class CurveGramHLabelView extends BaseHLabelView
	{
		private var _config:Config;
		
		public function CurveGramHLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			//Log.printObject(_config.labelDisplayIndex  );
			
			if( _config.cd && _config.cd.xAxis && _config.cd.xAxis.categories ){
				
				//Log.log( 'ssssssssss', _config.c.labelWidth );
				Common.each( _config.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = StringUtils.printf( _config.xAxisFormat, _t );
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					var _align:String = 'center';
					
					if( _config.vlineEnabled ){
						if( _config.cd.xAxis.categories === 1 ){
							
						}else if( _k === 0 ){
							//_align = 'left';
						}else if( _k === _config.cd.xAxis.categories.length - 1 ){
							//_align = 'right';
						} 
					}
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': _align }
						, _config.labelsStyle
					] );
					//Log.log( 'w:', _config.c.labelWidth, 'wrap:', _config.xAxisWordwrap );
					
					//Log.log( [ _config.c.labelWidth ].join() );
					
					
					if( _config.c.labelWidth ){
						if( _config.xAxisWordwrap ){
							var _twidth:Number = _config.c.labelWidth;
							if( _twidth < 14 ) _twidth = 14;
							_titem.width = _twidth * 1.5;
							_titem.wordWrap = true;
						}
					}
					
					if( !_config.displayAllLabel ){
						if( !( _k in _config.labelDisplayIndex ) ){
							_titem.visible = false;
						}
					}
					if( _config.animationEnabled ){
						_titem.visible = false;
					}
					
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				});			
			}
			//Log.log( '_maxHeight', _maxHeight );
			
			config.facade.sendNotification( JChartEvent.ROTATION_LABELS, {}, 'line' );
		}
		
		override protected function normalUpdate():void{
			if( !( _config.c && _config.c.hpoint ) ) return;
			
			Common.each( _config.c.hpointReal, function( _k:int, _item:Object ):void{
				
				var _tf:TextField = _labels[ _k ]
					, _location:Point = new Point( _tf.x, _tf.y )
					;
				
				if( _config.vlineEnabled ){
					_location = normalPosition( _k, _item, _location );
				} else {
					vlineDisabledPosition( _k, _item, _location );
				}
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

				_tf.x = _location.x;
				
				if( _config.animationEnabled ){
					
					if( !_config.displayAllLabel ){
						if( !( _k in _config.labelDisplayIndex ) ){
							return;
						}
					}
					_tf.visible = true;
					
					_tf.y = _location.y + 200;
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									y: _location.y
									, ease: Expo.easeOut } );
						});
				}else{					
					_tf.y = _location.y;
				}
				
			});
		}
		
		override protected function rotationUpdate():void{
			if( !( config.c.rotationCoor && config.c.rotationCoor.length ) ) return;
			
			Common.each( _config.c.hpointReal, function( _k:int, _item:Object ):void{
				
				var _tf:TextField = _labels[ _k ]
					, _location:Point = new Point( _tf.x, _tf.y )
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
				
				
				_location.x = _item.end.x;
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
				
				_newLocation = _location.subtract( _offsetPoint );
				
				_tf.x = _newLocation.x;
				
				if( _config.animationEnabled ){
					
					if( !_config.displayAllLabel ){
						if( !( _k in _config.labelDisplayIndex ) ){
							return;
						}
					}
					_tf.visible = true;
					
					_tf.y = _newLocation.y + 200;
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									y: _newLocation.y
									, ease: Expo.easeOut } );
						});
				}else{					
					_tf.y = _newLocation.y;
				}
				
			});
		}
		
		private function normalPosition( _index:int, _item:Object, _point:Point ):Point{
			var _tf:TextField = _labels[ _index ]		
				, _k:int = _index
				;
			_point.x = _item.end.x - _tf.width / 2;
						
			if( _k === 0 ){					
				_point.x < _config.c.chartX && ( 
					_point.x = _config.c.chartX - _tf.width / 2 + _tf.textWidth / 2 - 3
				);
				//Log.log( _tf.width + ', ' + _config.c.labelWidth );
			}else if( _k === _config.c.hpointReal.length - 1 ){
				if( _point.x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
					//_x = _config.c.chartX + _config.c.chartWidth - _tf.width + 3;
					_point.x = _config.c.chartX + _config.c.chartWidth - _tf.width / 2 - _tf.textWidth / 2 + 3
				}
			}
			return _point;
		}
		
		private function vlineDisabledPosition( _index:int, _item:Object, _point:Point ):void{

			var _tf:TextField = _labels[ _index ]		
				, _chartX:Number = _config.c.chartX + _config.c.linePadding / 2
				, _chartWidth:Number = _config.c.chartWidth - _config.c.linePadding
				;
			_point.x = _item.end.x - _tf.width / 2;
			
			if( _point.x + _tf.width > _config.stageWidth ){
				_point.x = _config.stageWidth - _tf.width;
			}else if( _point.x - _tf.width / 2 < 1 ){
				_point.x = 1;
			}
		}
	}
}