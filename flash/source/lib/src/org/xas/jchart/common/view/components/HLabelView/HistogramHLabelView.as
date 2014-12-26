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
	import org.xas.jchart.common.proxy.data.label.BaseLabelData;

	public class HistogramHLabelView extends BaseHLabelView
	{
		private var _config:Config;
		
		private var _lRotateFlag:Boolean;
		
		private var _labelDir:Number;
		
		private var _labelData:BaseLabelData;
		
		public function HistogramHLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
			_labelData = new BaseLabelData();
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			var _twidth:Number = _config.c.labelWidth || 14;
			_twidth = _twidth < 14 ? 14 : _twidth;
			
			var _labelRotate:Boolean = _config.labelRotationEnable;
			
			_lRotateFlag = false;
			_labelDir = _config.labelRotationDir; // 0 - 向右 | 1 - 向左
			
			if( _config.cd && _config.cd.xAxis && _config.cd.xAxis.categories ){
				
				Common.each( _config.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = _t
					_titem.text = StringUtils.printf( _config.xAxisFormat, _t );
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': 'center' }
						, _config.labelsStyle
					] );
					
					if( _config.xAxisWordwrap ) {
						_titem.width = _twidth * 1.5;
						_titem.wordWrap = true;
					} else if( _labelRotate ) {
						if( _twidth < _titem.width && !_lRotateFlag ) {
							_lRotateFlag = !_lRotateFlag;
						}
					}
					
					if( !_config.displayAllLabel ) {
						if( !( _k in _config.labelDisplayIndex ) ) {
							_titem.visible = false;
						}
					}
					
					if( BaseConfig.ins.animationEnabled ) {
						_titem.visible = false;
					}
					
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				} );
				
				if( _lRotateFlag ) {
					var result:Object = _labelData.calcLabelRotation( _labels, _twidth );
					_labels = result.labels;
					_maxWidth = result.maxWidth;
					_maxHeight = result.maxHeight;
				}
			}
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( _config.c && _config.c.hpoint ) ) return;
			
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				if( !_config.displayAllLabel ) {
					if( !( _k in _config.labelDisplayIndex ) ) {
						return;
					}
				}
				
				/* 指定标签定位的坐标 */
				var _x:Number, _y:Number;
				var _chartPoint:Point;
				
				if( _lRotateFlag ) {
					if( _labelDir ){
						var _absRadian:Number = GeoUtils.radians( Math.abs( _tf.rotationZ ) )
							, _cosWidth:Number = _tf.width * Math.cos( _absRadian );
							
						_x = _item.end.x - _cosWidth + 2;
						_y = _item.end.y + _tf.width * Math.sin( _absRadian );
					} else {
						_x = _item.end.x;
						_y = _item.end.y;
					}
				} else {
					_x = _item.end.x - _tf.width / 2;
					_y = _item.end.y - 2;
					
					if( _k === 0 ) {
						_x < _config.c.chartX && ( 
							_x = _config.c.chartX - _tf.width / 2 + _tf.textWidth / 2 - 3
						);
					} else if ( _k === _config.c.hpointReal.length - 1 ) {
						if( _x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
							_x = _config.c.chartX + _config.c.chartWidth - _tf.width / 2 - _tf.textWidth / 2 + 3
						}
					}
				}
				
				if( BaseConfig.ins.animationEnabled ) {
					_tf.visible = true;
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
					_tf.y = _y
				}
			});
		}
	}
}