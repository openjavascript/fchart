package 
{
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.test.DataFlow;

	public class Config extends BaseConfig
	{
		public function Config()
		{
			super();
		}
		
		private var _dataName:String = "qihoo";
		public function get dataName():String{ return _dataName; }
		
		private var _startDate:String = "";
		public function get startDate():String{ return _startDate; }
		
		private var _endDate:String = "";
		public function get endDate():String{ return _endDate; }
		
		override public function get categories():Array{
			var _r:Array = new Array();
			if( dataFlow ){
				Common.each( dataFlow, function( _k:int, _item:Object ):void{
					_r.push( _item.d );
				});
			}
			return _r;
		}
		
		override protected function calcMinNum():Number{
			var _r:Number = 0, _tmp:Array;
			if( this.isPercent ) return 0;
			if( dataFlow ){
				_tmp = [];
				Common.each( dataFlow, function( _k:int, _item:Object ):void{
					_item.c && ( _tmp = _tmp.concat( _item.c ) );
				});
				_tmp.length && ( _r = Math.min.apply( null, _tmp ) );
				
				_r > 0 && ( _r = 0 );
				_r < 0 && ( _r = -Common.numberUp( Math.abs( _r ) ) );
			}
			return _r;
		}
		
		override protected function calcMaxNum():Number{
			var _r:Number = 0, _tmp:Array;
			
			if( this.isPercent ){
				if( dataFlow ){
					_tmp = [];
					Common.each( dataFlow, function( _k:int, _item:Object ):*{
						_item.c && ( _r += _item.c );
					});
				}
			}else{
				if( dataFlow ){
					_tmp = [];
					Common.each( dataFlow, function( _k:int, _item:Object ):void{
						_item.c && ( _tmp = _tmp.concat( _item.c ) );
					});
					_tmp.length && ( _r = Math.max.apply( null, _tmp ) );
				}
				
				_r < 0 && ( _r = 0 );
				
				_r > 0 && _r && ( _r = Common.numberUp( _r ) );
			}
			
			this.yAxisMaxValue && ( _r = this.yAxisMaxValue );
			
			_r === 0 && ( _r = 10 );
			return _r;
		}
		
		override public function setChartData( _d:Object ):Object { 
			reset();
			_chartData = _d;
			setTrendProp();
			setTrendData();
			calcRate();
			calcLabelDisplayIndex();
			return _d;
		}
		
		private function setTrendProp():void{
			var custData:Object = displaySeries[0];
			custData.dataName && ( _dataName = custData.dataName );
			custData.startDate && ( _startDate = custData.startDate );
			custData.endDate && ( _endDate = custData.endDate );
			custData.baseDate && ( _baseDate = custData.baseDate );
			cd.xAxis.num && ( _hlabelNum = cd.xAxis.num );
		}
		
		private function setTrendData():void{
			var dataFlow:Array = displaySeries[0].data;
			if( !dataFlow || dataFlow.length == 0 ){
				dataFlow = new DataFlow().getDataFlow( _dataName, _startDate, _endDate );
			}
			_dataFlow = dataFlow;
		}
	}
}