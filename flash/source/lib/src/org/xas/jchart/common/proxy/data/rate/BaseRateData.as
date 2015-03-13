package org.xas.jchart.common.proxy.data.rate
{
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseAttrConfig;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;

	public class BaseRateData {
		public var _config:Config = BaseConfig.ins as Config;
		public var _attrConfig:BaseAttrConfig = new BaseAttrConfig();
		private var _totalLength:Number;
		private var _path:Vector.<Number>;
		
		public function BaseRateData() {
		}
		
		public function calcMinRate( _array:Array ):Number {
			var _r:Number = 0, _tmp:Array, _tmpR:Number;
			
			if( _config.isPercent ) return 0;
			
			var _hasNegative:Boolean = hasNegative( _array );
			_tmp = [];
			
			Common.each( _array, function( _k:int, _item:Object ):*{
				_tmp = _tmp.concat( _item.data );
			} );
			_tmp.length && ( _r = Math.min.apply( null, _tmp ) );
			
			if( _tmp.length && !_hasNegative && _config.isAutoRate ) {
				_tmpR = _r = Common.numberDown( _r, _config.autoRateDeep );
				
//				if( _r !== 0 ) {
//					_r = _r - Common.percentDown( _r ) * _attrConfig.minOffset;
//				}
				
				!_config.floatLen && ( _r = Math.floor( _r ) );
				
				if( _tmpR > 0 && _r < 0 ){
					_r = _tmpR;
				}
			} else {
				_r > 0 && ( _r = 0 );
				_r < 0 && ( _r = -Common.numberUp( Math.abs( _r ), 5, _config.rateUp ) );
			}
			return _r;
		}
		
		public function calcMaxRate( _array:Array ):Number {
			var _r:Number = 0, _tmp:Array;
			
			if( _config.isPercent ) {
				_tmp = [];
				Common.each( _array, function( _sk:int, _item:Object ):void{
					_r += _item.data;	
				});
			} else {
				_tmp = [];
				Common.each( _array, function( _k:int, _item:Object ):*{
					_tmp = _tmp.concat( _item.data );
				} );
				_tmp.length && ( _r = Math.max.apply( null, _tmp ) );
				
				_r < 0 && ( _r = 0 );
				
				_r >= 0 && ( _r = Common.numberUp( _r, 5, _config.rateUp ) );
				if( _config.rateUp === 0 ) {
					_r = Common.numberDown( _r, 2 );
				}
			}
			
			if( _r === 0 ) {
				_r = 100;
			}
			
//			else {
//				_r = _r + _r * _config.maxOffset;
//			}
			
			!_config.floatLen && ( _r = Math.floor( _r ) );
			
			return _r;
		}
		
		public function calcRate( _array:Array ):Object {
			
			var _customRate:Boolean = _config.isAutoRate;
			var _rate:Array = [];
			var _maxNum:Number = this.calcMaxRate( _array );
			var _minNum:Number = this.calcMinRate( _array );
			var _absNum:Number = Math.abs( _minNum );
			var _finalMaxNum:Number = Math.max( _maxNum, _absNum );
			var _hasNegative:Boolean = hasNegative( _array );
			var _rateZeroIndex:Number;
			var _realRate:Array;
			var _realRateFloatLen:Number;
			
			if( _hasNegative ) {
				
				/* 有负数数据将不会处理_customRate */
				_customRate = false;
				
				if( _maxNum > _absNum ) {
					if( Math.abs( _finalMaxNum * 0.33 ) > _absNum ) {
						_rate = [ 1, 0.66, 0.33, 0, -0.33];
						_rateZeroIndex = 3;
					}
				} else {
					if( _maxNum == 0 ){
						_rate = [ 0, -0.25, -0.5, -0.75, -1 ];
						_rateZeroIndex = 0;
					} else if ( Math.abs( _finalMaxNum * 0.33 ) > _maxNum ) {
						_rate = [ 0.33, 0, -0.33, -0.66, -1 ];
						_rateZeroIndex = 1;
					}
				}
				
				if( !_rate.length ) {
					_rate = [ 1, .5, 0, -.5, -1 ];
					_rateZeroIndex = 2;
				}
			} else {
				_rate = [1, .75, .5, .25, 0 ];
				_rateZeroIndex = 4;
			}
			
			_realRate = [];
			_realRateFloatLen = 0;
			var _tmpLen:int = 0
				, _rateValue:Number = _finalMaxNum
				, _tmpRateValue:Number
				;
			
			if( _config.isPercent ) {
				_rateValue = 100;
			}
			
			_rate = _config.yAxisRate || _rate;
			Common.each( _rate, function( _k:int, _item:Number ):void {
				if( _item === 0 ){
					_rateZeroIndex = _k;
				}
			} );
			//this.yAxisMaxValue && ( _rateValue = _config.yAxisMaxValue );
			
			_tmpRateValue = _rateValue;
			if( _customRate ) {
				_rateValue = _maxNum - _minNum;
				
				var _partNum:Number = _rateValue / ( _rate.length - 1 );
				if( (_minNum - _partNum ) < 0 ){
					_customRate = false;
					
					_rateValue = _tmpRateValue;
				}
				
			}
			
			Common.each( _rate, function( _k:int, _item:Number ):void{
				var _realItem:Number = _rateValue * _item;
				_realItem = Common.parseFinance( _realItem, 10 );
				
				if( Common.isFloat( _realItem ) ) {
					_tmpLen = _realItem.toString().split( '.' )[1].length;
					_tmpLen > _realRateFloatLen && ( _realRateFloatLen = _tmpLen );
				}
				
				if( _customRate ) {
					_realItem += _minNum;
					
				}
				
				_realRate.push( _realItem );
			});
			
			return {
				'realRate' : _realRate
				, 'rateZeroIndex' : _rateZeroIndex
				, 'maxNum': _maxNum
				, 'minNum': _minNum
			};
		}
		
		public static function hasNegative( _data:Array ):Boolean {
			var _r:Boolean = false;
			
			if( _data && _data.length ){
				
				var _arr:Array = new Array();
				
				Common.each( _data, function( _i:Number, _item:Object ):void {
					_arr.push( _item.data );
				} );
				
				var _tmp:Number = Math.min.apply( null, _arr );
				
				if( _tmp < 0 ){
					_r = true;
					return false;
				}
			}			
			
			return _r;
		}
		
	}
}