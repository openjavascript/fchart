package org.xas.jchart.common.view.components.HLabelView
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
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
					
					if( !_config.displayAllLabel ){
						if( !( _k in _config.labelDisplayIndex ) ){
							_titem.visible = false;
						}
					}
					if( BaseConfig.ins.animationEnabled ){
						_titem.visible = false;
					}
					
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				});			
			}
		}
		
		override protected function update( _evt:JChartEvent ):void{
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
					_x < _config.c.chartX && ( _x = _config.c.chartX - 3 );
				}else if( _k === _config.c.hpointReal.length - 1 ){
					if( _x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
						_x = _config.c.chartX + _config.c.chartWidth - _tf.width + 3;
					}
				}
				
				if( BaseConfig.ins.animationEnabled ){
					_tf.visible = true;
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
	}
}