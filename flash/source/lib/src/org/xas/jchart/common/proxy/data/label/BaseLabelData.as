package org.xas.jchart.common.proxy.data.label
{
	import flash.text.TextField;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	
	public class BaseLabelData {
		
		private var _config:Config;
		
		public function BaseLabelData() {
			_config = BaseConfig.ins as Config;
		}
		
		public function resetHLabel( _labelWidth:Number ):Number {
			var _defaultMinWidth:uint = 14;
			
			if( !_labelWidth ){
				return _defaultMinWidth;
			}
			
			if( _labelWidth > _defaultMinWidth ) {
				return _labelWidth;
			} else {
//				_config.setDisplayAllLabel( false );
//				_config.calcLabelDisplayIndex();
				return _defaultMinWidth;
			}
		}
		
		public function calcLabelRotation( _labels:Vector.<TextField>, _labelWidth:Number ):Object{
			
			var _labelAngle:Number = _config.labelRotationAngle
				, _defualtLabelHeight:Number = parseInt( DefaultOptions.xAxis.labels.style.size ) * 1.2
				, _defaultAngle:Number = GeoUtils.degree( Math.atan( _defualtLabelHeight / _labelWidth ) )
				, _labelDir:Number = _config.labelRotationDir
				, _maxAngle:Number = 0
				, _realAngle:Number
				, _maxWidth:Number = 0
				, _maxHeight:Number = 0;
			
			_defaultAngle = _defaultAngle <= 90 ? _defaultAngle : 90;
			
			_realAngle = _maxAngle < _defaultAngle ? _defaultAngle : _maxAngle;
			_realAngle = _labelDir ? -_realAngle : _realAngle;
			
			if( _labelAngle ){
				_realAngle = _labelAngle;
			}
			
			var _tmpWidth:Number
			, _labelsLen:Number = _config.categories.length
				, _displayMod:Number = _config.displayMod
				, _displayLabelNum:Number
				, _displayLabelIndex:Number;
			
			_displayMod = _displayMod == 0 ? 1 : _displayMod;
			
			if( _config.displayAllLabel ) {
				_displayLabelNum = _labelsLen;
			} else {
				_displayLabelNum = _displayMod == 0 ? _labelsLen : _labelsLen / _displayMod; 
			}
			
			Common.each( _labels, function( _k:int, _item:TextField ):void{
				_displayLabelIndex = Math.floor( _k / _displayMod );
				
				_item.rotationZ = _realAngle;
				
				_tmpWidth = _item.width * Math.cos(  GeoUtils.radians( Math.abs( _realAngle ) ) );
				
				if( _labelDir && _displayLabelIndex < 2  ){
					_tmpWidth = _tmpWidth - _k * _labelWidth - _config.c.vlabelMaxWidth * 1.5;
					if( _tmpWidth > 0 ){
						_maxWidth = _tmpWidth > _maxWidth ? _tmpWidth : _maxWidth;
					}
				} else if( !_labelDir && _displayLabelNum - _displayLabelIndex <= 2 ) {
					_tmpWidth -= ( _displayLabelNum - _displayLabelIndex ) * _labelWidth - 8
					if( _tmpWidth > 0 ){
						_maxWidth = _tmpWidth > _maxWidth ? _tmpWidth : _maxWidth;
					}
				}
				
				_item.height > _maxHeight && ( _maxHeight = _item.height );
			} );
			
			if( _labelDir && _maxWidth ) {
				_maxWidth = -_maxWidth;
			}
			
			return {
				"maxWidth" : _maxWidth
				, "maxHeight" : _maxHeight
				, "labels" : _labels
			}
		}
	}
}