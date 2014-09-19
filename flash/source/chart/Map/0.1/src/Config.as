package 
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	
	public class Config extends BaseConfig
	{
		
		public function Config()
		{
			super();
		}
		
		override public function setChartData( _d:Object ):Object {
			reset();
			_chartData = _d;
			calcRate();
			checkRate();
			calcLabelDisplayIndex();
			return _d;
		}
		
		override protected function calcMaxNum():Number{
			var _r:Number = 0, _tmp:Array;
			
			if( this.isPercent ){
				if( cd && cd.series ){
					_tmp = [];
					Common.each( displaySeries, function( _k:int, _item:Object ):void{
						if( _item.data ){
							Common.each( _item.data, function( _sk:int, _item:Number ):void{
								_r += _item;	
							});
						}
					});
				}
			} else {
				if( cd.series[0] && cd.series[0].data ){
					_tmp = [];
					var _datas:Array = cd.series[0].data;
					Common.each( _datas, function( _k:int, _item:Object ):void{
						_tmp = _tmp.concat( _item.value );
					});
					_tmp.length && ( _r = Math.max.apply( null, _tmp ) );
				}
				_r < 0 && ( _r = 0 );
				
				_r > 0 && ( _r = Common.numberUp( _r ) );
			}
			
			this.yAxisMaxValue && ( _r = this.yAxisMaxValue );
			
			_r === 0 && ( _r = 10 );
			return _r;
		}

		override protected function calcminNum():Number{
			var _r:Number = 0, _tmp:Array;
			if( this.isPercent ) return 0;
			if( cd.series[0] && cd.series[0].data ){
				_tmp = [];
				var _datas:Array = cd.series[0].data;
				Common.each( _datas, function( _k:int, _item:Object ):void{
					_tmp = _tmp.concat( _item.value );
				});
				_tmp.length && ( _r = Math.min.apply( null, _tmp ) );
				
				_r > 0 && ( _r = 0 );
				_r < 0 && ( _r = -Common.numberUp( Math.abs( _r ) ) );
			}
			return _r;
		}
		
		protected function checkRate():void{
			if( cd.yAxis && cd.yAxis.ratenum ){
				( cd.yAxis.ratenum > 2 ) && setRateNum( cd.yAxis.ratenum );
				( rateNum > 5 ) && setRateNum( 5 );
			}
		}
		
	}
}