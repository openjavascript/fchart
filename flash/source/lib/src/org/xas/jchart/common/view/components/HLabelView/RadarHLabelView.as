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
	
	public class RadarHLabelView extends BaseHLabelView
	{
		private var _config:Config;
		
		public function RadarHLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void {
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			if( _config.cd && _config.cd.xAxis && _config.cd.xAxis.categories ) {
				
				Common.each( _config.cd.xAxis.categories, function( _k:int, _item:* ):void {
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = StringUtils.printf( _config.xAxisFormat, _t );
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					var _align:String = 'center';
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': _align }
						, _config.labelsStyle
					] );
					
					if( _config.c.labelWidth ) {
						if( _config.xAxisWordwrap ) {
							var _twidth:Number = _config.c.labelWidth;
							if( _twidth < 14 ) _twidth = 14;
							_titem.width = _twidth * 1.5;
							_titem.wordWrap = true;
						}
					}
					
					if( _config.animationEnabled ) {
						_titem.alpha = 0;
					}
					
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				} );			
			}
			config.facade.sendNotification( JChartEvent.ROTATION_LABELS, {}, 'line' );
		}
		
		override protected function normalUpdate():void {

			if( !( _config.c && _config.c.hpoint ) ) return;
			
			var _tmpAngle:Number;
			
			Common.each( _config.c.hpoint, function( _idx:int, _point:Point ):void {
				
				_tmpAngle = _config.c.radarAngle[ _idx ];
				
				var _tf:TextField = _labels[ _idx ];
				
				_tf.x = _point.x - _tf.width / 2;
				_tf.y = _point.y - _tf.height / 2;
				
				if( _config.animationEnabled ) {
					TweenLite.delayedCall( 0, function():void {
						TweenLite.to( _tf, _config.animationDuration, {
							alpha: 1
							, ease: Expo.easeOut 
						} );
					} );
				}
			} );
		}
		
		override protected function rotationUpdate():void {
			normalUpdate();
		}
		
		private function normalPosition( _index:int, _item:Object, _point:Point ):Point {
			var _tf:TextField = _labels[ _index ]		
				, _k:int = _index
				;
			_point.x = _item.end.x - _tf.width / 2;
						
			if( _k === 0 ){					
				_point.x < _config.c.chartX && ( 
					_point.x = _config.c.chartX - _tf.width / 2 + _tf.textWidth / 2 - 3
				);
			}else if( _k === _config.c.hpointReal.length - 1 ){
				if( _point.x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
					_point.x = _config.c.chartX + _config.c.chartWidth - _tf.width / 2 - _tf.textWidth / 2 + 3
				}
			}
			return _point;
		}
		
		private function vlineDisabledPosition( _index:int, _item:Object, _point:Point ):void {

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