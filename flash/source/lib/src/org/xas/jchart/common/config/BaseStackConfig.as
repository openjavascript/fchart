package org.xas.jchart.common.config
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	
	public class BaseStackConfig extends BaseConfig
	{
		public function BaseStackConfig()
		{
			super();
		}
		override public function get isPercent():Boolean{
			return false;
		}
		
		override public function calcRate():void {
			super.calcRate();
			
			_hrate = this.rate.slice().reverse();
			_hrealRate = this.realRate.slice().reverse();
			
			_hrateZeroIndex = ( this.rate.length - 1 ) - rateZeroIndex;
		}
		
		protected var _hrateZeroIndex:int;
		protected var _hrate:Array;
		protected var _hrealRate:Array;
		
		public function get hrateZeroIndex():int{ return _hrateZeroIndex; }
		public function get hrate():Array{ return _hrate; }
		public function get hrealRate():Array{ return _hrealRate; }
		
		override protected function calcMaxNum():Number{
			var _r:Number = 0, _tmp:Number;
			

			if( displaySeries && displaySeries.length && displaySeries[0].data && displaySeries[0].data.length  ){
				
				Common.each( displaySeries[0].data, function( _k:int, _item:Number ):void {
					_tmp = 0;
					Common.each( displaySeries, function( _sk:int, _sitem:Object ):void {
						if( _sitem && _sitem.data && _sitem.data.length && _sitem.data[ _k ] && _sitem.data[ _k ] > 0 ){
							_tmp += _sitem.data[ _k ];
						}
					});
					
					_tmp > _r && ( _r = _tmp );
				});

			}
			
			_r < 0 && ( _r = 0 );
			
			_r >= 0 && ( _r = Common.numberUp( _r, 5, this.rateUp ) );
			if( this.rateUp === 0 ){
				_r = Common.numberDown( _r, 2 );
			}
			
			this.yAxisMaxValue && ( _r = this.yAxisMaxValue );
			
			if( _r === 0 ){
				_r = 100;
			}else{
				_r = _r + _r * maxOffset;
			}
			
			!floatLen && ( _r = Math.floor( _r ) );
			
			return _r;
		}
		
		override protected function calcMinNum():Number{
			var _r:Number = 0, _tmp:Number, _tmpR:Number, _tmpAr:Array;
			
			if( displaySeries && displaySeries.length && displaySeries[0].data && displaySeries[0].data.length  ){
				
				if( this.hasNegative ){
					Common.each( displaySeries[0].data, function( _k:int, _item:Number ):void {
						_tmp = 0;
						Common.each( displaySeries, function( _sk:int, _sitem:Object ):void {
							if( _sitem && _sitem.data && _sitem.data.length && _sitem.data[ _k ] && _sitem.data[ _k ] < 0 ){
								_tmp += Math.abs( _sitem.data[ _k ] );
	//							Log.log( _sitem.data[ _k ] );
							}
						});
						
						_tmp > _r && ( _r = _tmp );
					});
					_r > 0 && ( _r = -_r );
				}else{
					_tmpAr = [];
					Common.each( displaySeries, function( _k:int, _item:Number ):*{
						_tmpAr = _tmpAr.concat( displaySeries[ _k ].data );
					});
					_tmpAr.length && ( _r = Math.min.apply( null, _tmpAr ) );
				}
				
				if( !_hasNegative && this.isAutoRate ){
//					Log.log( 'xxxxxxxxxx' + _r ); 
					_tmpR = _r = Common.numberDown( _r, this.autoRateDeep );
					
					if( _r === 0 ){
					}else{
						//Log.log( [  Common.numberDown( _r ) * minOffset, _r ] );
						_r = _r - Common.percentDown( _r ) * minOffset;
					}
					
					!floatLen && ( _r = Math.floor( _r ) );
					
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
				
//		override public function get isAutoRate():Boolean { return false; }
	}
}