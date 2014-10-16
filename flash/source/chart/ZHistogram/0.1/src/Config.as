package 
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.DefaultOptions;

	public class Config extends BaseConfig
	{
		public function Config()
		{
			super();
		}
		
		protected var _totalArray:Array = new Array();
		public function get totalArray():Array{ return _totalArray; }
		
		override protected function calcMaxNum():Number{
			var _r:Number = 0, _max:Number = 0;
			
			if( cd && cd.series ){
				Common.each( displaySeries, function( _k:int, _item:Object ):*{
					_r = 0;
					if( _item.data ){
						Common.each( _item.data, function( _sk:int, _item:Number ):void{
							_r += _item;
						});
						_totalArray[ _k ] = _r;
					}
					_r > _max && ( _max = _r );
				});
			}
			
			_max < 0 && ( _max = 0 );
			
			_max && _max > 0 && !this.isPercent && ( _max = Common.numberUp( _max ) );
			
			this.yAxisMaxValue && ( _max = this.yAxisMaxValue );
			
			_max === 0 && ( _max = 10 );
			
			return _max;
		}
		
	}
}