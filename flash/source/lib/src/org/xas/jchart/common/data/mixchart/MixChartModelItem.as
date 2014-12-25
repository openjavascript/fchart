package org.xas.jchart.common.data.mixchart
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.Common;
	
	public class MixChartModelItem extends EventDispatcher
	{
		protected var _config:Config;
		protected var _index:int;
		protected var _params:Object;
		public function get params():Object{ return _params; }
		
		protected var _displaySeries:Array;
		public function get displaySeries():Array{ return _displaySeries; }
		
		protected var _hasNegative:Boolean;
		public function get hasNegative():Boolean{ return _hasNegative; }
		
		public function get isOpposite():Boolean{
			var _r:Boolean;			
			_r = _params.opposite || _r;			
			return _r;
		}
		
		protected var _ignoreAutoRate:Boolean;		
		public function get isAutoRate():Boolean {
			var _r:Boolean = false;
			this._params
				&& this._params.autoRate
				&& ( 'enabled' in this._params.autoRate )
				&& ( _r = this._params.autoRate.enabled );
			
			this._params
				&& this._params.customRate
				&& ( _r = this._params.customRate );
			
			if( _ignoreAutoRate ){
				_r = false;
			}
			
			return _r;
		} 
		protected var _rate:Array;
		public function get rate():Array{ return _rate; }
		
		public function get rateUp():int {
			var _r:int = 5;
			
			this._params
				&& this._params.autoRate
				&& ( 'rateUp' in this._params.autoRate )
				&& ( _r = this._params.autoRate.rateUp );
			
			_r <= 0 && ( _r = 0 );
			
			return _r;
		}
				
		public function get yAxisMaxValue():Number{
			var _r:Number = 0;
			
			_config.cd && _config.cd.rateLabel && ( 'maxvalue' in _config.cd.rateLabel )
				&& ( _r = _config.cd.rateLabel.maxvalue || _r );
			
			this._params && ( 'maxvalue' in this._params )
				&& ( _r = this._params.maxvalue || _r );
			
			return _r;
		}
		
		protected function get maxOffset():Number {
			var _r:Number = 0;
			
			this._params
				&& this._params.autoRate
				&& ( 'maxOffset' in this._params.autoRate )
				&& ( _r = parseFloat( this._params.autoRate.maxOffset ));
			
			_r < 0 && ( _r = 0 );
			
			return _r;
		}
		
		protected function get minOffset():Number {
			var _r:Number = 0;
			
			this._params
				&& this._params.autoRate
				&& ( 'maxOffset' in this._params.autoRate )
				&& ( _r = parseFloat( this._params.autoRate.minOffset ));
			
			_r < 0 && ( _r = 0 );
			
			return _r;
		}
		
		protected var _floatLen:int = 0;
		protected var _isFloatLenReady:Boolean = false;
		public function get floatLen():int{
			
			if( _isFloatLenReady ){
				return _floatLen;
			}
			_isFloatLenReady = true;
			
			if( _config.cd && ( 'floatLen' in _config.cd ) ){
				_floatLen = _config.cd.floatLen;
			}else{
				_floatLen = 0;
				
				var _tmpLen:int;
				
				_tmpLen = 0;
				Common.each( displaySeries, function( _k:int, _item:Object ):void{
					Common.each( _item.data, function( _sk:int, _sitem:String ):void{
						_tmpLen = Common.floatLen( _sitem );
						_tmpLen > _floatLen && ( _floatLen = _tmpLen );
						//Log.log( _sitem, _tmpLen, _floatLen );
					});
				});
			}
			_floatLen == 1 && ( _floatLen = 2 );
			
			//Log.log( _floatLen );
			
			return _floatLen;
		}
		
		public function get rateZeroIndex():int{ return _rateZeroIndex; }
		protected var _rateZeroIndex:int = 0; 
		
		protected var _absNum:Number;
		protected var _finalMaxNum:Number;
		public function get finalMaxNum():Number{ return _finalMaxNum; }
		
		protected var _maxNum:Number = 0;
		public function get maxNum():Number{ return _maxNum; }
		
		
		public function get chartMaxNum():Number{
			return finalMaxNum * rate[0];
		}
		
		protected var _minNum:Number = 0;
		public function get minNum():Number{ return _minNum; }
		
		protected var _realRate:Array;
		public function get realRate():Array{ return _realRate; }
		
		protected var _realRateFloatLen:int;
		public function get realRateFloatLen():int{ 
			var _r:Number = _realRateFloatLen;
			
			this._params && ( 'realRateFloatLen' in this._params )
				&& ( _r = Number( this._params.realRateFloatLen ) );
			
			return _r; 
		}
		
		
		public function get yAxisRate():Array{
			var _r:Array;
			_config.cd && _config.cd.rateLabel && ( 'data' in _config.cd.rateLabel )
				&& ( _r = _config.cd.rateLabel.data );
			
			this._params && ( 'data' in this._params )
				&& ( _r = this._params.data );
			
			this._params && this._params && ( 'rate' in this._params )
				&& ( _r = this._params.rate );
			return _r;
		}
		protected var _itemMax:Array;
		public function itemMax( _ix:int ):Number {
			var _r:Number = 0;
			if( _itemMax && _ix >= 0 && ( _ix < _itemMax.length ) ){
				_r = _itemMax[ _ix ];
			}
			return _r;
		}
		
		public function get autoRateDeep():int {
			var _r:int = 1;
			
			if( this.isAutoRate ){
				this._params
					&& this._params.autoRate
					&& this._params.autoRate.enabled
					&& ( 'deep' in this._params.autoRate )
					&& ( _r = this._params.autoRate.deep );
			}
			
			return _r;
		}
		
		public function get enabeld():Boolean{
			var _r:Boolean = true;
			if( this._params && ( 'enabled' in this._params ) ){
				_r = StringUtils.parseBool( this._params.enabled );
			}
			return _r;
		}
		
		protected var _left:Number = 0;
		public function get left():Number{ return _left; }
		public function set left( _setter:Number ):void{ _left = _setter; }
		
		public function MixChartModelItem( _index:int, _params:Object, _config:Config )
		{
			this._index = _index;
			this._params = _params || {};
			this._config = _config;
			
			init();
		}
		
		protected function init():void{
			_displaySeries = [];
			
			Common.each( _config.displaySeries, function( _k:int, _item:Object ):void{
				if( _config.getYAxisIndex( _item ) === _index ){
					//Log.log( [ _k, _config.getYAxisIndex( _item ) ] );
					_item.displayIndex = _k;
					_displaySeries.push( _item );
				}
			});
			
			this._hasNegative = Common.hasNegative( displaySeries );
			
			calcRate();
			//_chartData && ( _chartData.legend = _chartData.legend || {} );
		}
		
		public function calcRate():void {
			var _data:Object = _config.cd
				, _customRate:Boolean = this.isAutoRate;
			_rate = [];
			if( !_data ) return;
			
			_maxNum = calcMaxNum();
			_minNum = calcMinNum();
			_absNum = Math.abs( _minNum );
			_finalMaxNum = Math.max( _maxNum, _absNum );
			
			if( _hasNegative ) {
				
				/* 有负数数据将不会处理_customRate*/
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
			
			if( _config.isPercent ){
				_rateValue = 100;
			}
			
			_rate = yAxisRate || _rate;
			Common.each( _rate, function( _k:int, _item:Number ):void{
				if( _item === 0 ){
					_rateZeroIndex = _k;
				}
			} );
			this.yAxisMaxValue && ( _rateValue = this.yAxisMaxValue );
			
			_tmpRateValue = _rateValue;
			if( _customRate ) {
				_rateValue = _maxNum - _minNum;
				
				var _partNum:Number = _rateValue / ( _rate.length - 1 );
				if( (_minNum - _partNum ) < 0 ){
					_customRate = false;
					_ignoreAutoRate = true;
					
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
				//Log.log( 'xxxxxxxx: ' + _realItem );
				
				_realRate.push( _realItem );
			});
			
			_itemMax = [];
			_realRateFloatLen === 1 && ( _realRateFloatLen = 2 );
			
			if( displaySeries && displaySeries.length &&  displaySeries[0].data && displaySeries[0].data.length ){
				var _tmpMax:Number;
				Common.each( displaySeries[0].data, function( _k:int, _item:Object ):void{
					_tmpMax = 0;
					Common.each( displaySeries, function( _sk:int, _sitem:Object ):void{
						_tmpMax += _sitem.data[ _k ];
					});
					_itemMax.push( _tmpMax );
				});
			}
		}
		
		protected function calcMaxNum( _series:Array = null ):Number{
			var _r:Number = 0, _tmp:Array;
			_series = _series || displaySeries;
			
			if( _config.isPercent ){
				if( _config.cd && _config.cd.series ){
					_tmp = [];
					Common.each( _series, function( _k:int, _item:Object ):*{
						if( _item.data ){
							Common.each( _item.data, function( _sk:int, _item:Number ):void{
								_r += _item;	
							});
						}
					});
				}
			}else{
				if( _config.cd && _config.cd.series ){
					_tmp = [];
					Common.each( _series, function( _k:int, _item:Number ):*{
						_tmp = _tmp.concat( _series[ _k ].data );
					});
					_tmp.length && ( _r = Math.max.apply( null, _tmp ) );
				}
				
				_r < 0 && ( _r = 0 );
				
				//Log.log( _r + ', ' + this.rateUp );
				_r >= 0 && ( _r = Common.numberUp( _r, 5, this.rateUp ) );
				if( this.rateUp === 0 ){
					//Log.log( _r + ', ' + Common.percentDown( _r, 1 ) );
					_r = Common.numberDown( _r, 2 );
				}
				
				//Log.log( _r + ', ' + Common.numberDown( _r, 2 ) );
			}
			
			this.yAxisMaxValue && ( _r = this.yAxisMaxValue );
			
			if( _r === 0 ){
				_r = 100;
			}else{
				//Log.log( [ Common.numberDown( _r ), _r ] );
				_r = _r + _r * maxOffset;
			}
			//Log.log( _r );
			
			!floatLen && ( _r = int( _r ) );
			//return 11000;
			
			return _r;
		}
		
		protected function calcMinNum():Number{
			var _r:Number = 0, _tmp:Array, _tmpR:Number;
			if( _config.isPercent ) return 0;
			if(_config.cd && _config.cd.series ){
				_tmp = [];
				Common.each( displaySeries, function( _k:int, _item:Number ):*{
					_tmp = _tmp.concat( displaySeries[ _k ].data );
				});
				_tmp.length && ( _r = Math.min.apply( null, _tmp ) );
				
				if( _tmp.length && !_hasNegative && this.isAutoRate ){
					//Log.log( 'xxxxxxxxxx' + _r );
					_tmpR = _r = Common.numberDown( _r, this.autoRateDeep );
					
					if( _r === 0 ){
					}else{
						//Log.log( [  Common.numberDown( _r ) * minOffset, _r ] );
						_r = _r - Common.percentDown( _r ) * minOffset;
					}
					
					!floatLen && ( _r = int( _r ) );
					
					if( _tmpR > 0 && _r < 0 ){
						_r = _tmpR;
					}
					//Log.log( 'xxxxxxxxxx' + _r );
				} else {
					_r > 0 && ( _r = 0 );
					_r < 0 && ( _r = -Common.numberUp( Math.abs( _r ), 5, this.rateUp ) );
				}
			}
			
			return _r;
		}
	}
}