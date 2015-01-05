package org.xas.jchart.common.view.components.HLabelView
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;

	public class VZHistogramHLabelView extends BaseHLabelView
	{
		private var _config:Config;
		
		public function VZHistogramHLabelView()
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
					
//					if( BaseConfig.ins.animationEnabled ){
//						_titem.visible = false;
//					}
					_titem.x = -1000;
					
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.width > _maxWidth && ( _maxWidth = _titem.width );
				});			
			}
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( _config.c && _config.c.hpoint ) ) return;
			
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				
				var _tf:TextField = _labels[ _k ];

				/* 指定标签定位的坐标 */
				var _y:Number = _item.end.y - _tf.height / 2;
				
				if( _k === 0 ){
					_y < _config.c.chartY && ( _y = _config.c.chartY - 3 );
				}else if( _k === _config.c.hpointReal.length - 1 ){
					if( _y + _tf.height > _config.c.chartY + _config.c.chartHeight ){
						_y = _config.c.chartY + _config.c.chartHeight - _tf.height + 3;
					}
				}
				
				if( BaseConfig.ins.animationEnabled ){
					_tf.x = _item.start.x - _tf.width - 200;
					_tf.y = _y;
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, BaseConfig.ins.animationDuration
								, { 
									x: _item.start.x - _tf.width
									, y: _y
									, ease: Expo.easeOut } );
						});
				}else{					
					_tf.x = _item.start.x - _tf.width;
					_tf.y = _y;
				}
			});
		}
	}
}