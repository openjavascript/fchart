package 
{
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	
	public class Config extends BaseConfig
	{
		public function Config()
		{
			super();
		}
		
		private var _pseries:Array = [];
		
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
			//Log.printJSON( _tmpSeries[0].data );
			
			Common.each( _tmpSeries[0].data, function( _k:int, _item: * ):void{
				var _o:Object, _a:Array = _item as Array;
				if( !_a ){
					_o = _item as Object;
				}else{
					_o = { 'name': _a[0], 'y': _a[1] };
				}
				_displaySeries.push( _o );
			});			
			
			_displaySeriesIndexMap = null;
			
			
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
			
			//Log.printJSON( _displaySeries );			
			
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
				
		override public function get legendEnabled():Boolean{
			var _r:Boolean = false;
			
			if( cd && cd.legend && ( 'enabled' in cd.legend ) ){
				_r = StringUtils.parseBool( cd.legend.enabled );
			}
			
			return _r;
		}
		
		override public function get subtitleEnable():Boolean{
			var _r:Boolean = false
			chartData 
				&& chartData.subtitle
				&& ( 'enabled' in chartData.subtitle )
				&& ( _r = StringUtils.parseBool( chartData.subtitle.enabled ) )
				;
			return _r;
		}
		
		override public function get titleEnable():Boolean{
			var _r:Boolean = false
			chartData 
				&& chartData.xAxis
				&& chartData.xAxis.title
				&& ( 'enabled' in chartData.xAxis.title )
				&& ( _r = chartData.xAxis.title.enabled )
				;
			return _r;
		}
		
		override public function get creditsEnabled():Boolean{
			var _r:Boolean = false;
			chartData 
			&& chartData.credits
				&& ( 'enabled' in chartData.credits )
				&& ( _r = chartData.credits.enabled )
				;
			return _r;
		}
		
		override public function get vtitleEnabled():Boolean{
			var _r:Boolean = false;
			chartData 
			&& chartData.yAxis
				&& chartData.yAxis.title
				&& ( 'enabled' in chartData.yAxis.title )
				&& ( _r = chartData.yAxis.title.enabled )
				;
			return _r;
		}
				
		override public function get tooltipEnabled():Boolean{
			var _r:Boolean = false;
			cd 
				&& cd.tooltip
				&& ( 'enabled' in cd.tooltip )
				&& ( _r = StringUtils.parseBool( cd.tooltip.enabled ) );
			
			return _r;
		}
		
		
		override public function get dataLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.pie
				&& cd.plotOptions.pie.dataLabels
				&& ( 'enabled' in cd.plotOptions.pie.dataLabels )
				&& ( _r = cd.plotOptions.pie.dataLabels.enabled );
			
			return _r;
		}
		
		public function get borderWidth():Number{
			var _r:Number = 20;
			cd 
				&& cd.radius
				&& ( 'borderWidth' in cd.radius )
				&& ( _r = cd.radius.borderWidth );
			return _r;
		}
		
		
		override public function get yAxisMaxValue():Number{
			var _r:Number = 100;
			
			this.cd && this.cd.rateLabel && ( 'maxvalue' in this.cd.rateLabel )
				&& ( _r = this.cd.rateLabel.maxvalue || _r );
			
			this.cd && this.cd.yAxis && ( 'maxvalue' in this.cd.yAxis )
				&& ( _r = this.cd.yAxis.maxvalue || _r );
			
			return _r;
		}
		
		public function get textStyle():Array{
			var _r:Array = [ {
				size: 20
				, color: 0x000000
				, font: "Microsoft YaHei"
			}];
			
			this.series
				&& this.series.length
				&& ( 'style' in this.series[0] )
				&& ( _r.push( this.series[0].style ) );
			
			return _r;
		}
		
		override public function get serialLabelEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
			&& cd.dataLabels
				&& ( 'enabled' in cd.dataLabels )
				&& ( _r = StringUtils.parseBool( cd.dataLabels.enabled ) );
			
			return _r;
		}
	}
}