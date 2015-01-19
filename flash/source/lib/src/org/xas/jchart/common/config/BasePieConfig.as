package org.xas.jchart.common.config
{
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	
	public class BasePieConfig extends BaseConfig
	{
		public function BasePieConfig()
		{
			super();
		}
		
		protected var _pseries:Array = [];
		
		override public function setChartData(_d:Object):Object{
			super.setChartData( _d );
			
			_pseries = [];
			
			if( this.cd.series && this.cd.series.length ){
				Common.each( this.cd.series[0].data, function( _k:int, _item: * ):void{
					var _o:Object, _a:Array = _item as Array;
					if( !_a ){
						_o = _item as Object;
					}else{
						_o = { 'name': _a[0], 'y': _a[1] };
					}
					_pseries.push( _o );
				});
				//Log.printJSON( _pseries );
			}
			
			return this.chartData;
		}
		
		override public function get series():Array{
			
			return _pseries;
		}
		
		override public function updateDisplaySeries( _filter:Object = null, _data:Object = null ):BaseConfig{
			_data = _data || chartData;
			if( !( _data && _data.series && _data.series.length ) ) return this;
			var _tmpSeries:Array = JSON.parse( JSON.stringify( _data.series ) ) as Array
				;
			
			_displaySeries = []
			_displaySeriesIndexMap = {};
			//Log.printJSON( _tmpSeries[0].data );
			
			Common.each( _tmpSeries[0].data, function( _k:int, _item: * ):void{
				var _o:Object, _a:Array = _item as Array;
				if( !_a ){
					_o = _item as Object;
				}else{
					_o = { 'name': _a[0], 'y': _a[1] };
				}
				_displaySeries.push( _o );
				_displaySeriesIndexMap[ _k ] = _k;
			});			
						
			if( _filter ){
				var _tmp:Array = [], _count:int = 0;
				_displaySeriesIndexMap = {};
				Common.each( _displaySeries, function( _k:int, _item:Object ):void{
					if( !(_k in _filter) ){
						_tmp.push( _item );	
						_displaySeriesIndexMap[ _count++ ] = _k;
					}
				});
				_displaySeries = _tmp;
			}
			
			_filterData = _filter || {};		
			
			return this;
		}
		
		override public function get totalNum():Number{
			var _r:Number = 0;
			
			if( this.isPercent ){
				_r = 100;
			}else{
				Common.each( _displaySeries, function( _k:int, _item:Object ):void{
					_r += _item.y;
				});
			}
			
			return _r;
		}
		
		override public function get itemName():String{
			var _r:String = '';
			cd && cd.series && cd.series.length && ( _r = cd.series[0].name || '' );
			return _r;
		}
		
		override public function get floatLen():int{
			
			if( _isFloatLenReady ){
				return _floatLen;
			}
			_isFloatLenReady = true;
			
			if( cd && ( 'floatLen' in cd ) ){
				_floatLen = cd.floatLen;
			}else{
				_floatLen = 0;
				var _tmpLen:int = 0;
				Common.each( series, function( _k:int, _item:Object ):void{
					_tmpLen = Common.floatLen( _item.y );
					_tmpLen > _floatLen && ( _floatLen = _tmpLen );
				});
			}
			_floatLen == 1 && ( _floatLen = 2 );
			
			return _floatLen;
		}
		
		public function get radius():Number{
			var _r:Number = this.coordinate.radius;
			_r < 10 && ( _r = 10 );
			return _r;
		}
		
		public function get outRadius():Number{
			return radius;
		}
		
		public function get inRadius():Number{
			return outRadius - radiusWidth;
		}
		
		public function get radiusWidth():Number{
			var _r:Number = radius - radius * this.radiusInnerRate;
			
			radiusData.width 
				&& ( _r = radiusData.width );
			
			_r < 5 && ( _r = 5 );
			
			return _r;
		}
				
		public function get radiusInnerRate():Number{
			var _r:Number = .6;
			radiusData.innerRate && ( _r = radiusData.innerRate );
			return _r;
		}
		
		public function get radiusData():Object{
			var _r:Object = {};
			cd && cd.radius && ( _r = cd.radius || _r );
			return _r;
		}
		
		public function get dataLabelLineStart():Number{
			var _r:Number = 0;
			
			cd 
				&& cd.plotOptions
				&& cd.plotOptions.pie
				&& cd.plotOptions.pie.dataLabels
				&& cd.plotOptions.pie.dataLabels.line
				&& ( 'start' in cd.plotOptions.pie.dataLabels.line )
				&& ( _r = cd.plotOptions.pie.dataLabels.line.start );
			
			cd 
				&& cd.dataLabels
				&& cd.dataLabels.line
				&& ( 'start' in cd.dataLabels.line )
				&& ( _r = cd.dataLabels.line.start );
			
			return _r;
		}
		
		
		public function get dataLabelLineLength():Number{
			var _r:Number = 40;
			
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.pie
				&& cd.plotOptions.pie.dataLabels
				&& cd.plotOptions.pie.dataLabels.line
				&& ( 'length' in cd.plotOptions.pie.dataLabels.line )
				&& ( _r = cd.plotOptions.pie.dataLabels.line.length );
			
			cd 
			&& cd.dataLabels
				&& cd.dataLabels.line
				&& ( 'length' in cd.dataLabels.line )
				&& ( _r = cd.dataLabels.line.length );
			
			return _r;
		}
		
		public function get dataLabelLineControlXOffset():Number{
			var _r:Number = 5;
			
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.pie
				&& cd.plotOptions.pie.dataLabels
				&& cd.plotOptions.pie.dataLabels.line
				&& ( 'controlX' in cd.plotOptions.pie.dataLabels.line )
				&& ( _r = cd.plotOptions.pie.dataLabels.line.controlX );
			
			cd 
			&& cd.dataLabels
				&& cd.dataLabels.line
				&& ( 'controlX' in cd.dataLabels.line )
				&& ( _r = cd.dataLabels.line.controlX );
			
			return _r;
		}
				
		public function get dataLabelLineControlYOffset():Number{
			var _r:Number = 5;
			
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.pie
				&& cd.plotOptions.pie.dataLabels
				&& cd.plotOptions.pie.dataLabels.line
				&& ( 'controlY' in cd.plotOptions.pie.dataLabels.line )
				&& ( _r = cd.plotOptions.pie.dataLabels.line.controlY );
			
			cd 
			&& cd.dataLabels
				&& cd.dataLabels.line
				&& ( 'controlY' in cd.dataLabels.line )
				&& ( _r = cd.dataLabels.line.controlY );
			
			return _r;
		}
		
		public function get moveDistance():Number{
			var _r:Number = 10;
			cd
				&& cd.animation
				&& 'moveDistance' in cd.animation
				&& ( _r = cd.animation.moveDistance );
				
			return _r;
		}
		
//		
//		override public function get animationDuration():Number {
//			var _r:Number = .5;
//			'duration' in animation && ( _r =  parseFloat( this.animation.duration ) );
//			return _r;
//		}
	}
}