package 
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.map.data.MapPathData;
	
	public class Config extends BaseConfig
	{
		
		public function Config()
		{
			super();
		}
		
		private var _highColor:String = "3112664";
		public function get highColor():String{ return _highColor; }
		
		private var _hoverColor:String = "12245589";
		public function get hoverColor():String{ return _hoverColor; }
		
		private var _lowColor:String = "16777215";
		public function get lowColor():String{ return _lowColor; }
		
		private var _zoomRate:Number = .5;
		public function get zoomRate():Number{ return _zoomRate; }
		
		private var _zoomSpeed:Number = .5;
		public function get zoomSpeed():Number{ return _zoomSpeed; }
		
		private var _mapType:String = "customer";
		public function get mapType():String{ return _mapType; }
		
		private var _defaultData:Number = 0;
		public function get defaultData():Number{ return _defaultData; }
		
		private var _mapData:Array = null;
		public function get mapData():Array{ return _mapData; }
		
		private var _initedCallback:String = null;
		public function get initedCallback():String{ return _initedCallback; }
		
		private var _hoverCallback:String = null;
		public function get hoverCallback():String{ return _hoverCallback; }
		
		private var _clickCallback:String = null;
		public function get clickCallback():String{ return _clickCallback; }
		
		override public function get itemName():String{
			var _r:String = '';
			cd && cd.series && cd.series.length && ( _r = cd.series[0].name || '' );
			return _r;
		}
		
		public function get zoomEnabled():Boolean{
			var _r:Boolean = false;
			
			if( chartData.zoom && chartData.zoom.enable ){
				_r = chartData.zoom.enable;
			}
			return _r;
		}
		
		override public function setChartData( _d:Object ):Object {
			reset();
			_chartData = _d;
			calcRate();
			checkRate();
			calcLabelDisplayIndex();
			setMapProp();
			setMapData();
			return _d;
		}
		
		protected function setMapProp():void{
			var custData:Object = displaySeries[0];
			custData.highColor && ( _highColor = custData.highColor.toString(10) );
			custData.lowColor && ( _lowColor = custData.lowColor.toString(10) );
			custData.hoverColor && ( _hoverColor = custData.hoverColor.toString(10) );
			custData.mapType && ( _mapType = custData.mapType );
			custData.defaultData && ( _defaultData = custData.defaultData );
			zoomEnabled && ( _zoomRate = chartData.zoom.zoomRate ) 
				&& ( _zoomSpeed = chartData.zoom.zoomSpeed );
			
			var _cb:Object = chartData.callBack;
			if( _cb ) {
				_cb.initedCallback && ( _initedCallback = _cb.initedCallback );
				_cb.hoverCallback && ( _hoverCallback = _cb.hoverCallback );
				_cb.clickCallback && ( _clickCallback = _cb.clickCallback );
			} 
		}
		
		protected function setMapData():void{
			var custData:Object = displaySeries[0];
			if( mapType == 'customer' ){
				custData.data && ( _mapData = custData.data );
			} else {
				var _tmpdata:Object,
					pathData:Object = new MapPathData().getPathData( _mapType ),
					zoomY:Number = pathData.zoomY;
				pathData && custData.data && ( _mapData = new Array() ) &&
				Common.each( pathData.data, function( _i:int, _item:Object ):void{
					if( custData.data[ _i ] ){
						_tmpdata = custData.data[ _i ];
					} else {
						_tmpdata = new Object();
						_tmpdata.value = defaultData;
					}
					
					!_tmpdata.type && ( _tmpdata.type = _item.type );
					!_tmpdata.coordinates && ( _tmpdata.coordinates = _item.coordinates );
					!_tmpdata.name && ( _tmpdata.name = _item.name );
					!_tmpdata.id && ( _tmpdata.id = _item.id );
					
					zoomY && 
					Common.each( _item.coordinates, function( _k:int, _sitem:Object ):void{
						if( _item.type == "MultiPolygon" ){
							Common.each( _sitem, function( _j:int, _vitem:Object ):void{
								_tmpdata.coordinates[_k][_j][1] = _vitem[1] * zoomY;
							});
						} else {
							_tmpdata.coordinates[_k][1] = _sitem[1] * zoomY;
						}
					});
					_mapData[ _i ] = _tmpdata;
				});
			}
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

		override protected function calcMinNum():Number{
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
		
		override public function getTipsHeader( _ix:int ):String{
			var _r:String = '';
			c.mapData[ _ix ] && ( _r = c.mapData[ _ix ].name ); 
			tipsHeader[ _ix ] && ( _r = tipsHeader[ _ix ] );
			return _r;
		}
		
		override public function get tipsHeader():Array{
			var _r:Array = [];

			if( cd && cd.tooltip && cd.tooltip.header ){
				_r = cd.tooltip.header;
			}
			return _r;
		}
		
	}
}