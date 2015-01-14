package org.xas.jchart.common
{
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.ObjectUtils;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.data.mixchart.MixChartModel;

	public class BaseConfig 
	{		
		public function get facade():BaseFacade{ return _facade; }
		public var _facade:BaseFacade;
		public function setFacade( _setter:BaseFacade ):void{ _facade = _setter; }
		
		public function get isAutoRate():Boolean {
			var _r:Boolean = false;
			this.cd
				&& this.cd.yAxis 
				&& this.cd.yAxis.autoRate
				&& ( 'enabled' in this.cd.yAxis.autoRate )
				&& ( _r = this.cd.yAxis.autoRate.enabled );
			
			this.cd
				&& this.cd.yAxis
				&& this.cd.yAxis.customRate
				&& ( _r = this.cd.yAxis.customRate );
			
			if( _ignoreAutoRate ){
				_r = false;
			}
			
			return _r;
		} 
		protected var _ignoreAutoRate:Boolean;
		
		public function get autoRateDeep():int {
			var _r:int = 1;
			
			if( this.isAutoRate ){
				this.cd
					&& this.cd.yAxis
					&& this.cd.yAxis.autoRate
					&& this.cd.yAxis.autoRate.enabled
					&& ( 'deep' in this.cd.yAxis.autoRate )
					&& ( _r = this.cd.yAxis.autoRate.deep );
			}
			
			return _r;
		}
		
		public function get rateUp():int {
			var _r:int = 5;
			
			this.cd
				&& this.cd.yAxis
				&& this.cd.yAxis.autoRate
				&& ( 'rateUp' in this.cd.yAxis.autoRate )
				&& ( _r = this.cd.yAxis.autoRate.rateUp );
			
			_r <= 0 && ( _r = 0 );
			
			return _r;
		}
		
		/* trend */
		protected var _hlabelNum:Number = 5;
		public function get hlabelNum():Number{ return _hlabelNum; }
		
		protected var _dataFlow:Array = null;
		public function get dataFlow():Array{ return _dataFlow; }
		
		protected var _baseDate:String = "";
		public function get baseDate():String{ return _baseDate; }
		
		protected static var _ins:BaseConfig;
		public static function setIns( _ins:BaseConfig ):BaseConfig{
			
			if( ExternalInterface.available ) {
				try{
					ExternalInterface.addCallback( 'apiReady', apiReady );
				}catch( ex:Error ){
				}
			}
			
			return BaseConfig._ins = _ins;
		}
		
		protected static function apiReady():Boolean{
			return true;
		}
		
		public static function get ins():BaseConfig{
			return BaseConfig._ins;	
		}
		
		protected var _debug:Boolean = false;		
		public function setDebug( _d:Boolean ):Boolean {
			Log.debug = _d;
			return _debug = _d;
		}
		public function get debug():Object {
			return _debug;
		}
		
		protected var _rateNum:Number = 2;
		public function get rateNum():Number{ return _rateNum; }
		public function setRateNum( _r:Number ):void{ this._rateNum = _r; }
		
		protected var _params:Object;
		public function setParams( _d:Object ):Object {	return _params = _d; }		
		public function get params():Object { return _params;	}		
		public function get p():Object { return _params;	}
	
		protected var _displaySeries:Array;
		public function get displaySeries():Array{
			return _displaySeries;	
		}
		public function updateDisplaySeries( _filter:Object = null, _data:Object = null ):BaseConfig{
			_data = _data || chartData;
			if( !( _data && _data.series && _data.series.length ) ) return this;
			_displaySeries = JSON.parse( JSON.stringify( _data.series ) ) as Array;
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
			
			return this;
		}
		protected var _displaySeriesIndexMap:Object;
		public function get displaySeriesIndexMap():Object{ return _displaySeriesIndexMap || {}; }
		protected var _displayLegend:Array = [];
		public function get displayLegend():Array{ return _displayLegend; }
		
		public function serialDataLabelValue( _serialIx:int, _itemIx:int ):String{
			var _r:String = '', _item:Object = displaySeries[ _serialIx ];		
			
			if( !_item ){
				return '';
			}
			
			if( 'labelData' in _item ){
				_r = _item.labelData[ _itemIx ];
			}else{
				_r = StringUtils.printf( dataLabelFormat, Common.moneyFormat( _item.data[ _itemIx ], 3, floatLen ) );				
			}			
			
			_item.dataLabels
				&& _item.dataLabels.data
				&& _item.dataLabels.data.length
				&& ( _r = _item.dataLabels.data[_itemIx] );
			
			_item.dataLabel
				&& _item.dataLabel.data
				&& _item.dataLabel.data.length
				&& ( _r = _item.dataLabel.data[_itemIx] );
			
			return _r;
		}
		
		public function get tooltipSerial():Array{
			return tooltipSeries;
		}
		
		public function get tooltipSeries():Array{
			var _r:Array = [];
			
			//Log.log( 'tooltipSerial xxx ' );
			
			this.cd
				&& this.cd.tooltip
				&& this.cd.tooltip.serial
				&& this.cd.tooltip.serial.length
				&& ( _r = this.cd.tooltip.serial )
				;
			
			this.cd
				&& this.cd.tooltip
				&& this.cd.tooltip.series
				&& this.cd.tooltip.series.length
				&& ( _r = this.cd.tooltip.series )
				;
			
			return _r;
		}
		
		public function get tooltipAfterSerial():Array{	
			return tooltipAfterSeries;
		}
		
		public function get tooltipAfterSeries():Array{
			var _r:Array = [];
			
			//Log.log( 'tooltipSerial xxx ' );
			
			this.cd
				&& this.cd.tooltip
				&& this.cd.tooltip.afterSerial
				&& this.cd.tooltip.afterSerial.length
				&& ( _r = this.cd.tooltip.afterSerial )
				;
			
			this.cd
				&& this.cd.tooltip
				&& this.cd.tooltip.afterSeries
				&& this.cd.tooltip.afterSeries.length
				&& ( _r = this.cd.tooltip.afterSeries )
				;
			
			return _r;
		}
		
		protected var _filterData:Object;
		public function get filterData():Object{
			return _filterData;	
		}	
		
		protected var _chartData:Object;
		public function setChartData( _d:Object ):Object { 		
			_displayAllLabel = true;
			reset();		
			_chartData = _d;			
			this._hasNegative = Common.hasNegative( displaySeries );
			calcRate();
			calcLabelDisplayIndex();
			_chartData && ( _chartData.legend = _chartData.legend || {} );
			return _d;
		}
		protected var _hasNegative:Boolean;
		public function get hasNegative():Boolean{
			return this._hasNegative;
		}
		public function get chartData():Object { return _chartData; }	
		public function get cd():Object {	return _chartData; }
		public function get rateZeroIndex():int{ return _rateZeroIndex; }
		protected var _rateZeroIndex:int = 0; 
		
		protected var _absNum:Number;
		protected var _finalMaxNum:Number;
		public function get finalMaxNum():Number{ return _finalMaxNum; }
		
		protected var _rate:Array;
		public function get rate():Array{ return _rate; }


		
		protected var _floatLen:int = 0;
		protected var _isFloatLenReady:Boolean = false;
		public function get floatLen():int{
			
			if( _isFloatLenReady ){
				return _floatLen;
			}
			_isFloatLenReady = true;
			
			if( cd && ( 'floatLen' in cd ) ){
				_floatLen = cd.floatLen;
			}else{
				_floatLen = 0;
				
				var _tmpLen:int;
				
				_tmpLen = 0;
				Common.each( displaySeries, function( _k:int, _item:Object ):void{
					_item.data && Common.each( _item.data, function( _sk:int, _sitem:String ):void{
						_tmpLen = Common.floatLen( _sitem );
						_tmpLen > _floatLen && ( _floatLen = _tmpLen );
					});
				});
			}
			_floatLen == 1 && ( _floatLen = 2 );
			
			return _floatLen;
		}

					
		protected var _root:DisplayObject;
		public function get root():DisplayObject{ return _root; }
		
		public function setRoot( _d:* ):DisplayObject{
			_root = _d as DisplayObject;
			_width = _root.stage.stageWidth;
			_height = _root.stage.stageHeight;
			return _root;
		}
		
		protected var _width:uint;
		public function get width():uint{ return _width; }
		
		protected var _height:uint;
		public function get height():uint{ return _height; }
		
		protected var _coordinate:Coordinate
		public function get c():Coordinate{ return _coordinate; }
		public function get coordinate():Coordinate{	return _coordinate;	}
		public function setCoordinate( _d:Coordinate ):Coordinate{
			_coordinate = _d;
			c.width = width;
			c.height = height;
			c.x = 0;
			c.y = 0;
			return _coordinate;
		}
		
		public function get categories():Array{
			var _r:Array = [];
			if( cd && cd.xAxis && cd.xAxis.categories ){
				_r = cd.xAxis.categories;
			}
			return _r;
		}
		
		public function get tipsHeader():Array{
			var _r:Array = [];
			if( cd && cd.xAxis && cd.xAxis.tipsHeader ){
				_r = cd.xAxis.tipsHeader;
			}
			if( cd && cd.tooltip && cd.tooltip.header ){
				_r = cd.tooltip.header;
			}
			return _r;
		}
		
		
		public function getTipsHeader( _ix:int ):String{
			var _r:String = this.tipsHeader[ _ix ] || this.categories[ _ix ] || '';
			return _r;
		}
		
		public function getTipsValue( _sitem:Object, _k:int, _format:String, _floatLen:int = 0 ):String{
			var _r:String = '';
			
			if( _sitem.tipsData ){
				_r = _sitem.tipsData[ _k ]
			}else if( _sitem.data ){
				_r = StringUtils.printf( _format, 
						Common.moneyFormat( _sitem.data[ _k ], 3, _floatLen )
					);
			}
			
			return _r;
		}
		
		public function get tipTitlePostfix():String{
			var _r:String = '{0}';
			if( cd && cd.xAxis && ( 'tipTitlePostfix' in  cd.xAxis ) ){
				_r = cd.xAxis.tipTitlePostfix;
			}
			return _r;
		}
		
		public function get series():Array{
			var _r:Array = [];
			if( cd && cd.series && cd.series.length ){
				_r = cd.series;
			}
			return _r;
		}
		
		public function get legendEnabled():Boolean{
			var _r:Boolean = true;
			
			if( cd && cd.legend && ( 'enabled' in cd.legend ) ){
				_r = StringUtils.parseBool( cd.legend.enabled );
			}
			
			return _r;
		}
		
		public function get toggleBgEnabled():Boolean{
			var _r:Boolean = false;
			
			if( cd && cd.toggleBg && ( 'enabled' in cd.toggleBg ) ){
				_r = StringUtils.parseBool( cd.toggleBg.enabled );
			}
			
			return _r;
		}
		
		public function get yAxisEnabled():Boolean{
			var _r:Boolean = true;
			
			if( cd && cd.rateLabel && ( 'enabled' in cd.rateLabel ) ){
				_r = StringUtils.parseBool( cd.rateLabel.enabled );
			}
			
			if( cd && cd.yAxis && ( 'enabled' in cd.yAxis ) ){
				_r = StringUtils.parseBool( cd.yAxis.enabled );
			}
			
			!displaySeries.length && ( _r = false );
			
			return _r;
		}
		
		public function get xAxisEnabled():Boolean{
			var _r:Boolean = true;
			
			if( cd && cd.xAxis && ( 'enabled' in cd.xAxis ) ){
				_r = StringUtils.parseBool( cd.xAxis.enabled );
			}
			
			!displaySeries.length && ( _r = false );
			
			return _r;
		}
		
		public function get dataLabelEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
				&& cd.plotOptions
				&& cd.plotOptions.pie
				&& cd.plotOptions.pie.dataLabels
				&& ( 'enabled' in cd.plotOptions.pie.dataLabels )
				&& ( _r = cd.plotOptions.pie.dataLabels.enabled );
			
			return _r;
		}
		
		public function get dataLabelFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.dataLabels
				&& ( 'format' in cd.dataLabels )
				&& ( _r = cd.dataLabels.format );
			
			return _r;
		}
		
		public function get xAxisFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.xAxis
				&& ( 'format' in cd.xAxis )
				&& ( _r = cd.xAxis.format );
			
			return _r;
		}
		
		public function get yAxisFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.yAxis
				&& ( 'format' in cd.yAxis )
				&& ( _r = cd.yAxis.format );
			
			return _r;
		}
		
		public function get tooltipPointFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.tooltip
				&& ( 'pointFormat' in cd.tooltip )
				&& ( _r = cd.tooltip.pointFormat );
			
			return _r;
		}
		
		public function get tooltipSerialFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.tooltip
				&& ( 'serialFormat' in cd.tooltip )
				&& ( _r = cd.tooltip.serialFormat );
			
			return _r;
		}
		
		public function get tooltipAfterSerialFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.tooltip
				&& ( 'afterSerialFormat' in cd.tooltip )
				&& ( _r = cd.tooltip.afterSerialFormat );
			
			return _r;
		}
		
		public function get tooltipHeaderFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.tooltip
				&& ( 'headerFormat' in cd.tooltip )
				&& ( _r = cd.tooltip.headerFormat );
			
			return _r;
		}
		
		public function get xAxisWordwrap():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.xAxis
				&& ( 'wordwrap' in cd.xAxis )
				&& ( _r = StringUtils.parseBool( cd.xAxis.wordwrap ) );
			
			return _r;
		}	
		
		public function get serialLabelEnabled():Boolean{
			var _r:Boolean = superSerialLabelEnabled;
//			Log.log( 'superSerialLabelEnabled', _r );
			if( !_r ){
				Common.each( this.displaySeries, function( _k:int, _item:Object ):void{
					if( _item.dataLabels && ( 'enabled' in _item.dataLabels ) ){
						_r = StringUtils.parseBool( _item.dataLabels.enabled ) || _r;
					}
					if( _item.dataLabel && ( 'enabled' in _item.dataLabel ) ){
						_r = StringUtils.parseBool( _item.dataLabel.enabled ) || _r;
					}
				});
			}
			
			return _r;
		}	
		
		public function get superSerialLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
				&& cd.dataLabels
				&& ( 'enabled' in cd.dataLabels )
				&& ( _r = StringUtils.parseBool( cd.dataLabels.enabled ) );
			return _r;
		}
		
		public function get vlineEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
			&& cd.vline
				&& ( 'enabled' in cd.vline )
				&& ( _r = StringUtils.parseBool( cd.vline.enabled ) );
			
			return _r;
		}		
		
		public function get vsideLineEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.vsideLine
				&& ( 'enabled' in cd.vsideLine )
				&& ( _r = StringUtils.parseBool( cd.vsideLine.enabled ) );
			
			return _r;
		}
		
		public function get hlineEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
			&& cd.hline
				&& ( 'enabled' in cd.hline )
				&& ( _r = StringUtils.parseBool( cd.hline.enabled ) );
			
			return _r;
		}
		
		public function get tooltipEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			//Log.printJSON( cd.tooltip );
			cd 
			&& cd.tooltip
				&& ( 'enabled' in cd.tooltip )
				&& ( _r = StringUtils.parseBool( cd.tooltip.enabled ) );
			
			return _r;
		}
		
		public function get cdataLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.dount
				&& cd.plotOptions.dount.cdataLabels
				&& ( 'enabled' in cd.plotOptions.dount.cdataLabels )
				&& ( _r = cd.plotOptions.dount.cdataLabels.enabled );
			
			return _r;
		}
				
		protected var _maxNum:Number = 0;
		public function get maxNum():Number{ return _maxNum; }
		
		
		public function get chartMaxNum():Number{
			return finalMaxNum * rate[0];
		}
		
		protected var _minNum:Number = 0;
		public function get minNum():Number{ return _minNum; }
		protected function calcMinNum():Number{
			var _r:Number = 0, _tmp:Array, _tmpR:Number;
			if( this.isPercent ) return 0;
			if( cd && cd.series ){
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
		
		protected function calcMaxNum():Number{
			var _r:Number = 0, _tmp:Array;
			
			if( this.isPercent ){
				if( cd && cd.series ){
					_tmp = [];
					Common.each( displaySeries, function( _k:int, _item:Object ):*{
						if( _item.data ){
							Common.each( _item.data, function( _sk:int, _item:Number ):void{
								_r += _item;	
							});
						}
					});
				}
			}else{
				if( cd && cd.series ){
					_tmp = [];
					Common.each( displaySeries, function( _k:int, _item:Number ):*{
						_tmp = _tmp.concat( displaySeries[ _k ].data );
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
			
			!floatLen && ( _r = Math.floor( _r ) );
			//return 11000;
		
			return _r;
		}
		
		protected function get maxOffset():Number {
			var _r:Number = 0;
			
			this.cd
				&& this.cd.yAxis
				&& this.cd.yAxis.autoRate
				&& ( 'maxOffset' in this.cd.yAxis.autoRate )
				&& ( _r = parseFloat( this.cd.yAxis.autoRate.maxOffset ));
			
			_r < 0 && ( _r = 0 );
			
			return _r;
		}
		
		protected function get minOffset():Number {
			var _r:Number = 0;
			
			this.cd
				&& this.cd.yAxis
				&& this.cd.yAxis.autoRate
				&& ( 'minOffset' in this.cd.yAxis.autoRate )
				&& ( _r = parseFloat( this.cd.yAxis.autoRate.minOffset ));
			
			_r < 0 && ( _r = 0 );
			
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
		
		public function calcRate():void {
			var _data:Object = _chartData
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
			
			if( this.isPercent ){
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
		
		public function get yAxisMaxValue():Number{
			var _r:Number = 0;
			
			this.cd && this.cd.rateLabel && ( 'maxvalue' in this.cd.rateLabel )
				&& ( _r = this.cd.rateLabel.maxvalue || _r );
			
			this.cd && this.cd.yAxis && ( 'maxvalue' in this.cd.yAxis )
				&& ( _r = this.cd.yAxis.maxvalue || _r );
			
			return _r;
		}
		
		public function get yAxisRate():Array{
			var _r:Array;
			this.cd && this.cd.rateLabel && ( 'data' in this.cd.rateLabel )
				&& ( _r = this.cd.rateLabel.data );
			
			this.cd && this.cd.yAxis && ( 'data' in this.cd.yAxis )
				&& ( _r = this.cd.yAxis.data );
			
			this.cd && this.cd.yAxis && ( 'rate' in this.cd.yAxis )
				&& ( _r = this.cd.yAxis.rate );
			return _r;
		}
		
		protected var _realRate:Array;
		public function get realRate():Array{ return _realRate; }
		
		protected var _realRateFloatLen:int;
		public function get realRateFloatLen():int{ 
			var _r:Number = _realRateFloatLen;
			
			this.cd && this.cd.yAxis && ( 'realRateFloatLen' in this.cd.yAxis )
				&& ( _r = Number( this.cd.yAxis.realRateFloatLen ) );
			
			return _r; 
		}
		
		public function get titleStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.xAxis
				&& chartData.xAxis.title
				&& chartData.xAxis.title.style
				&& ( _r = chartData.xAxis.title.style )
				;
			return _r;
		}		
		public function get titleEnable():Boolean{
			var _r:Boolean = true
			chartData 
				&& chartData.xAxis
				&& chartData.xAxis.title
				&& ( 'enabled' in chartData.xAxis.title )
				&& ( _r = chartData.xAxis.title.enabled )
				;
			return _r;
		}
		public function get labelsStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.xAxis
				&& chartData.xAxis.labels
				&& chartData.xAxis.labels.style
				&& ( _r = chartData.xAxis.labels.style )
				;
			return _r;
		}
		
		public function get vtitleStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.yAxis
				&& chartData.yAxis.title
				&& chartData.yAxis.title.style
				&& ( _r = chartData.yAxis.title.style )
				;
			return _r;
		}
		
		public function get vtitleEnabled():Boolean{
			var _r:Boolean = true;
			chartData 
				&& chartData.yAxis
				&& chartData.yAxis.title
				&& ( 'enabled' in chartData.yAxis.title )
				&& ( _r = chartData.yAxis.title.enabled )
				;
			return _r;
		}
		
		public function get vlabelsStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.yAxis
				&& chartData.yAxis.labels
				&& chartData.yAxis.labels.style
				&& ( _r = chartData.yAxis.labels.style )
				;
			return _r;
		}
		
		public function get subtitleStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.subtitle
				&& chartData.subtitle.style
				&& ( _r = chartData.subtitle.style )
				;
			return _r;
		}		
		public function get subtitleEnable():Boolean{
			var _r:Boolean = true
			chartData 
				&& chartData.subtitle
				&& ( 'enabled' in chartData.subtitle )
				&& ( _r = StringUtils.parseBool( chartData.subtitle.enabled ) )
				;
			return _r;
		}
		
		public function get creditsStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.credits
				&& chartData.credits.style
				&& ( _r = chartData.credits.style )
				;
			return _r;
		}		
		public function get creditsEnabled():Boolean{
			var _r:Boolean = true;
			chartData 
				&& chartData.credits
				&& ( 'enabled' in chartData.credits )
				&& ( _r = chartData.credits.enabled )
				;
			return _r;
		}
		
		public function get legendItemStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.legend
				&& chartData.legend.itemStyle
				&& ( _r = chartData.legend.itemStyle )
				;
			return _r;
		}
		
		public function get legendMargin():Object{
			var _r:Object = { x: 0, y: 0, top: 0, bottom: 0 };
			chartData 
				&& chartData.legend
				&& chartData.legend.margin
				&& ( _r = Common.extendObject( _r, chartData.legend.margin ) )
				;
			return _r;
		}
		
		public function itemColor( _ix:uint, _fixColorIndex:Boolean = true ):uint{
			var _r:uint = 0, _colors:Array = colors;
			
			if( _fixColorIndex && displaySeriesIndexMap && ( _ix in displaySeriesIndexMap ) ){
				//Log.log( 'find', _ix, filterData[ _ix ] );
				//_ix = _filterData[ _ix ];
				_ix = displaySeriesIndexMap[ _ix ];
			}
				
			_r = _colors[ _ix % ( _colors.length ) ];			
			return _r;
		}
		
		public function get colors():Array{
			var _r:Array = DefaultOptions.colors;
			
			chartData 
				&& chartData.colors
				&& chartData.colors.length
				&& ( _r = chartData.colors );
			
			return _r;
		}
		
		public function tooptipSerialItemColor( _ix:uint, _fixColorIndex:Boolean = true ):uint{
			var _r:uint = 0, _colors:Array = tooltipSerialColors;
			
			if( _fixColorIndex && displaySeriesIndexMap && ( _ix in displaySeriesIndexMap ) ){
				//Log.log( 'find', _ix, filterData[ _ix ] );
				//_ix = _filterData[ _ix ];
				_ix = displaySeriesIndexMap[ _ix ];
			}
			
			_r = _colors[ _ix % ( _colors.length ) ];			
			return _r;
		}
		
		public function tooltipHeaderStyle():Object{
			var _r:Object = {};
			
			chartData 
				&& chartData.tooltip
				&& chartData.tooltip.headerStyle
				&& ( _r = chartData.tooltip.headerStyle );
			
			return _r;
		}
		
		public function tooltipHeaderYSpace():Number{
			var _r:Number = 6;
			
			chartData 
				&& chartData.tooltip
				&& ( 'headerYSpace' in chartData.tooltip )
				&& ( _r = chartData.tooltip.headerYSpace as Number );
			
			return _r;
		}
		
		public function tooltipItemYSpace():Number{
			var _r:Number = 6;
			
			chartData 
			&& chartData.tooltip
				&& ( 'itemYSpace' in chartData.tooltip )
				&& ( _r = chartData.tooltip.itemYSpace as Number );
			
			return _r;
		}
		
		public function tooltipValueLabelXSpace():Number{
			var _r:Number = 4;
			
			chartData 
			&& chartData.tooltip
				&& ( 'valueLabelXSpace' in chartData.tooltip )
				&& ( _r = chartData.tooltip.valueLabelXSpace as Number );
			
			return _r;
		}
		
		public function tooltipLabelStyle():Object{
			var _r:Object = {};
			
			chartData 
				&& chartData.tooltip
				&& chartData.tooltip.labelStyle
				&& ( _r = chartData.tooltip.labelStyle );
			
			return _r;
		}
		
		public function tooltipValueStyle():Object{
			var _r:Object = {};
			
			chartData 			
			&& chartData.tooltip
				&& chartData.tooltip.valueStyle
				&& ( _r = chartData.tooltip.valueStyle );
			
			return _r;
		}
		
		public function get tooltipHeaderIcon():Object{
			var _r:Object = {};
			
			chartData 			
			&& chartData.tooltip
				&& chartData.tooltip.headerIcon
				&& ( _r = chartData.tooltip.headerIcon );
			
			return _r;
		}
		
		public function get tooltipHeaderIconStyle():Object{
			var _r:Object = {};
			
			tooltipHeaderIcon 
				&& tooltipHeaderIcon.style			
				&& ( _r = tooltipHeaderIcon.style );
			
			return _r;
		}
		
		public function get tooltipHeaderIconEnabled():Boolean{
			var _r:Boolean = false;
			
			tooltipHeaderIcon 			
				&& ( _r = StringUtils.parseBool( tooltipHeaderIcon.enabled ) );
			
			return _r;
		}
		
		public function get tooltipSerialColors():Array{
			var _r:Array = DefaultOptions.tooltip.serialColor;
			
			chartData 			
				&& chartData.tooltip
				&& chartData.tooltip.serialColor
				&& chartData.tooltip.serialColor.length
				&& ( _r = chartData.tooltip.serialColor );
			
			return _r;
		}
		
		public function tooptipAfterSerialItemColor( _ix:uint, _fixColorIndex:Boolean = true ):uint{
			var _r:uint = 0, _colors:Array = tooltipAfterSerialColors;
			
			if( _fixColorIndex && displaySeriesIndexMap && ( _ix in displaySeriesIndexMap ) ){
				//Log.log( 'find', _ix, filterData[ _ix ] );
				//_ix = _filterData[ _ix ];
				_ix = displaySeriesIndexMap[ _ix ];
			}
			
			_r = _colors[ _ix % ( _colors.length ) ];			
			return _r;
		}
		
		public function get tooltipAfterSerialColors():Array{
			var _r:Array = DefaultOptions.tooltip.afterSerialColor;
			
			chartData 			
				&& chartData.tooltip
				&& chartData.tooltip.afterSerialColor
				&& chartData.tooltip.afterSerialColor.length
				&& ( _r = chartData.tooltip.afterSerialColor );
			
			return _r;
		}

		/* xlabel rotation start */
		protected var _labelRotationEnable:Boolean = false;
		public function get labelRotationEnable():Boolean{
			this.cd
				&& this.cd.xAxis
				&& this.cd.xAxis.rotation
				&& ( 'enabled' in this.cd.xAxis.rotation )
				&& ( _labelRotationEnable = StringUtils.parseBool( this.cd.xAxis.rotation.enabled ) )
				
			this.cd 
				&& this.cd.xAxis
				&& this.cd.xAxis.labels
				&& ( 'rotation' in this.cd.xAxis.labels )
				&& ( _labelRotationEnable = true );
				
			return _labelRotationEnable;
		}
		
		protected var _labelRotationAngle:Number = -45;
		public function get labelRotationAngle():Number{
			
			this.cd
				&& this.cd.xAxis
				&& this.cd.xAxis.rotation
				&& ( 'angle' in this.cd.xAxis.rotation )
				&& ( _labelRotationAngle = this.cd.xAxis.rotation.angle )
				
			
			this.cd
				&& this.cd.xAxis
				&& this.cd.xAxis.labels
				&& ( 'rotation' in this.cd.xAxis.labels )
				&& ( _labelRotationAngle = this.cd.xAxis.labels.rotation )
				
			return _labelRotationAngle;
		}
		
		public function get absLabelRotationAngle():Number{
			return Math.abs( labelRotationAngle );
		}
		
		protected var _labelRotationDir:int = 1; // 0 - 向右 | 1 - 向左
		public function get labelRotationDir():int{
			var _tmpDir:String;
			
			this.cd
				&& this.cd.xAxis
				&& this.cd.xAxis.rotation
				&& this.cd.xAxis.rotation.dir
				&& ( _tmpDir = this.cd.xAxis.rotation.dir );
			
			_labelRotationDir = _tmpDir == "right" ? 0 : 1;
			
			if( labelRotationAngle && labelRotationAngle > 0 ) {
				_labelRotationDir = 0;
			}
			
			return _labelRotationDir;
		}
		
		protected var _displayOverride:Boolean;
		protected var _displayOverrideValue:Boolean;
		protected var _displayAllLabel:Boolean = true;
		public function get displayAllLabel():Boolean{
			
			if( _displayOverride ){
				return _displayOverrideValue;
			}
			
			chartData 
				&& chartData.xAxis
				&& chartData.xAxis.display 
				&& ( 'enabled' in chartData.xAxis.display ) 
				&& ( _displayAllLabel = chartData.xAxis.display.enabled );	
			
			chartData 
				&& chartData.xAxis
				&& chartData.xAxis.displayAll 
				&& ( 'enabled' in chartData.xAxis.displayAll ) 
				&& ( _displayAllLabel = chartData.xAxis.displayAll.enabled );
			
			chartData 
				&& ( 'displayAllLabel' in chartData )
				&& ( _displayAllLabel = chartData[ 'displayAllLabel' ] );
				
			return _displayAllLabel;
		}
		
		public function setDisplayAllLabel( _dal:Boolean ):void {
			_displayAllLabel = _dal;
			_displayOverride = true;
			_displayOverrideValue = _dal;
		}
		
		public function get displayMod():int{
			var _mod:int = 0;
			
			!displayAllLabel 
				&& chartData.xAxis
				&& chartData.xAxis.display 
				&& ( 'mod' in chartData.xAxis.display ) 
				&& ( _mod = chartData.xAxis.display.mod );
			
			!displayAllLabel 
				&& chartData.xAxis
				&& chartData.xAxis.displayAll 
				&& ( 'mod' in chartData.xAxis.displayAll ) 
				&& ( _mod = chartData.xAxis.displayAll.mod );
			
			_mod = _mod < 0 ? 0 : _mod;
			
			return _mod;
		}
		
		public function get startIndex():int{
			var _idx:int = 0;
			
			!displayAllLabel 
				&& chartData.xAxis
				&& chartData.xAxis.display 
				&& ( 'startIndex' in chartData.xAxis.display ) 
				&& ( _idx = chartData.xAxis.display.startIndex );
			
			!displayAllLabel 
				&& chartData.xAxis
				&& chartData.xAxis.displayAll 
				&& ( 'startIndex' in chartData.xAxis.displayAll ) 
				&& ( _idx = chartData.xAxis.displayAll.startIndex );
			
			return _idx;
		}
		
		/**
		 * 获取要显示的水平标签索引位置
		 * 如果返回 undefined, 将显示全部
		 */
		public function calcLabelDisplayIndex():void{
			var _tmp:Number, _len:int = categories.length, _tmp1:Number;
			_labelDisplayIndex = {};
			if( !displayAllLabel ) {
				
				if( !displayMod ) {
					_labelDisplayIndex[ 0 ] = true;
					_labelDisplayIndex[ _len - 1 ] = true;
					_tmp1 = _len % 3;
					_tmp = Math.floor( _len / 3 );
					
					if( _len >= 7 ){	
						switch( _tmp1 ){
							case 0:{
								_labelDisplayIndex[ Math.floor( _tmp * 1 ) - 1] = true;
								_labelDisplayIndex[ Math.floor( _tmp * 2 ) - 0 ] = true;
								break;
							}
							case 1: {
								_labelDisplayIndex[ Math.floor( _tmp * 1 ) ] = true;
								_labelDisplayIndex[ Math.floor( _tmp * 2 )  ] = true;
								break;
							}
							case 2: {
								_labelDisplayIndex[ Math.floor( _tmp * 1 ) ] = true;
								_labelDisplayIndex[ Math.floor( _tmp * 2 ) + 1  ] = true;
								break;
							}
							default: {
								_labelDisplayIndex[ Math.floor( _tmp * 1 ) ] = true;
								_labelDisplayIndex[ Math.floor( _tmp * 2 )  ] = true;
								break;
							}
						}
					}
				} else {
					var _item:Object;
					var _idx:int = startIndex;
					
					for( var _i:Number = _idx; _i < _len; _i++ ){
						_item = _labelDisplayIndex[ _i ];
						if( _i == _idx ){
							_labelDisplayIndex[ _i ] = true;
						} else if( ( _i - _idx ) % displayMod == 0 ) {
							_labelDisplayIndex[ _i ] = true;
						}
					}
				}
			}
		}
		protected var _labelDisplayIndex:Object = {};
		public function get labelDisplayIndex():Object{ return _labelDisplayIndex; }
		
		public function get offsetAngle():Number{
			var _r:Number = 270;
			
			cd 
				&& ( 'offsetAngle' in cd )
				&& ( _r = cd.offsetAngle );
			
			return _r;
		}
		public function get totalNum():Number{
			return 0;
		}
		
		protected var _selected:int = -1;
		public function get selected():int{ return _selected; }
		public function set selected( _setter:int ):void{ _selected = _setter; }
		public function get itemName():String{ return ''; }
		
		public function clearData():BaseConfig{
			_displaySeries = [];
			_displaySeriesIndexMap = {};
			_filterData = {};
			_chartData = {};
			_displayLegend = [];
			
			return this;
		}
		 
		public function get isPercent():Boolean{
			return StringUtils.parseBool( this.cd.isPercent );
		}
		
		public function get isItemPercent():Boolean{
			return StringUtils.parseBool( this.cd.isItemPercent );
		}
		
		protected var _maxValue:Number = 0;
		protected var _isMaxValueReady:Boolean;
		
		public function get maxValue():Number{
			if( !_isMaxValueReady && this.series && this.series.length ){
				_isMaxValueReady = true;
				
				Common.each( this.displaySeries, function( _k:int, _item:Object ):void{
					Common.each( _item.data, function( _sk:int, _sitem:Number ):void{
						_sitem > _maxValue && ( _maxValue = _sitem );
					});
				});
			}
			
			return _maxValue;
		}
		
		public function get maxItemParams():Object{
			var _r:Object = {};
			
			this.cd 
				&& this.cd.maxItem
				&& ( _r = this.cd.maxItem );
			
			return _r;
		}
		
		public function get chartParams():Object{
			var _r:Object = {};
			
			this.cd 
				&& this.cd.chart
				&& ( _r = this.cd.chart );
						return _r;
		}
		
		public function get hoverBgParams():Object{
			var _r:Object = {};
			
			this.cd 
				&& this.cd.hoverBg
				&& ( _r = this.cd.hoverBg );
			
			return _r;
		}
		
		public function get hoverBgStyle():Object{
			var _r:Object = {};
			
			if( 'style' in this.hoverBgParams  ){
				_r = StringUtils.parseBool( this.hoverBgParams.style );
			}
			
			return _r;
		}
		
		public function get hoverBgEnabled():Boolean{
			var _r:Boolean = false;
			
			if( 'enabled' in this.hoverBgParams  ){
				_r = StringUtils.parseBool( this.hoverBgParams.enabled );
			}
			
			return _r;
		}
			
		public function get itemBgParams():Object{
			var _r:Object = {};
			
			this.cd 
				&& this.cd.itemBg
				&& ( _r = this.cd.itemBg );
			
			return _r;
		}
		
		public function get itemBgStyle():Object{
			var _r:Object = {};
			
			if( 'style' in this.itemBgParams  ){
				_r = StringUtils.parseBool( this.itemBgParams.style );
			}
			
			return _r;
		}
		
		public function get itemBgEnabled():Boolean{
			var _r:Boolean = false;
			
			if( 'enabled' in this.itemBgParams  ){
				_r = StringUtils.parseBool( this.itemBgParams.enabled );
			}
			
			return _r;
		}
		
		
		public function get vlabelSpace():Number{
			var _r:Number = this.c.vlabelSpace || 4;
			return _r;
		}
		
		public function get vspace():Number{
			var _r:Number = 5;
			this.cd 
				&& this.cd.yAxis
				&& ( 'space' in this.cd.yAxis )
				&& ( _r = this.cd.yAxis.space )
				;
			return _r;
		}		
		public function get hspace():Number{
			var _r:Number = 15;
			this.cd 
				&& this.cd.xAxis
				&& ( 'space' in this.cd.xAxis )
				&& ( _r = this.cd.xAxis.space )
				;
			return _r;
		}
		
		public function get stageWidth():Number{
			var _r:Number = this.width;			
			if( this.chartParams.width && this.chartParams.width > 0 ){
				_r = Math.min( this.chartParams.width, _r );
			}	
			return _r;
		}
		
		public function get stageHeight():Number{
			var _r:Number = this.height;			
			if( this.chartParams.height && this.chartParams.height > 0 ){
				_r = Math.min( this.chartParams.height, _r );
			}		
			return _r;
		}
		
		public function get graphicHeight():Number{
			var _r:Number = 0;			
			if( this.chartParams.graphicHeight && this.chartParams.graphicHeight > 0 ){
				_r = this.chartParams.graphicHeight;
			}		
			return _r;
		}
		
		public function reset():void{
			_isFloatLenReady = false;
			_isMaxValueReady = false;
			_maxValue = 0;			
			selected = -1;
			_ignoreAutoRate = false;
			
			_labelRotationEnable = false;
			_labelRotationAngle = -45;
			_labelRotationDir = 1;
			
			_displayOverride = false;
			_displayOverrideValue = false;
		}
		
		public function get animation():Object {
			var _r:Object = {};
			this.cd && ( 'animation' in this.cd ) && ( _r =  this.cd.animation );
			return _r;
		}
		
		public function get animationEnabled():Boolean {
			var _r:Boolean;
			//return true;
			'enabled' in animation && ( _r =  StringUtils.parseBool( this.animation.enabled ) );
			!displaySeries.length && ( _r = false );
			return _r;
		}
		
		public function get animationDuration():Number {
			var _r:Number = .75;
			'duration' in animation && ( _r =  parseFloat( this.animation.duration ) );
			return _r;
		}
		
		public function get lineBreakEnable():Boolean {
			var _b:Boolean = false;
			
			this.cd 
				&& ( 'lineBreak' in this.cd ) 
				&& ( 'enabled' in this.cd.lineBreak ) 
				&& ( _b =  this.cd.lineBreak.enabled );
			
			return _b;
		}
		
		/* legend start */
		
		public function get legendInterval():Number {
			var _interval:Number= 2;
			if( cd && cd.legend && legendEnabled && ( 'interval' in cd.legend ) ){
				_interval = cd.legend.interval;
			}
			return _interval;
		}
		
		public function get legendDir():Number {
			var _interval:Number= 7;
			var _intervalDesc:String;
			if( legendEnabled && ( 'direction' in cd.legend ) ){
				_interval = cd.legend.direction;
				
				if( isNaN( _interval ) ){
					_intervalDesc = cd.legend.direction;
					
					switch( _intervalDesc ){
						case 'TOP_LEFT' : { _interval = 0;break; }
						case 'TOP_CENTER' : { _interval = 1;break; }
						case 'TOP_RIGHT' : { _interval = 2;break; }
							
						case 'RIGHT_TOP' : { _interval = 3;break; }
						case 'RIGHT_MIDDLE' : { _interval = 4;break; }
						case 'RIGHT_BOTTOM' : { _interval = 5;break; }
							
						case 'BOTTOM_LEFT' : { _interval = 6;break; }
						case 'BOTTOM_CENTER' : { _interval = 7;break; }
						case 'BOTTOM_RIGHT' : { _interval = 8;break; }
							
						case 'LEFT_TOP' : { _interval = 9;break; }
						case 'LEFT_MIDDLE' : { _interval = 10;break; }
						case 'LEFT_BOTTOM' : { _interval = 11;break; }
						
						default : { _interval = 7;break; }
					}
				} else {
					if( _interval < 0 || _interval > 11 ){
						_interval = 7;
					}
				}
			}
			return _interval;
		}
		
		public function pointEnabled( _item:Object = null ):Boolean{
			var _r:Boolean = true;
			
			this.cd
				&& this.cd.point
				&& ( 'enabled' in this.cd.point )
				&& ( _r = StringUtils.parseBool( this.cd.point.enabled ) );
			
			_item 
				&& _item.point
				&& ( 'enabled' in _item.point )
				&& ( _r = StringUtils.parseBool( _item.point.enabled ) );
			
			return _r;
		}
		
		public function get group():Object{
			var _r:Object = cd.group || {};			
			!( 'enabled'  in _r ) && ( _r.enabled = true );			
			return _r;
		}
		
		public function get groupEnabled():Boolean{
			var _r:Boolean = StringUtils.parseBool( group.enabled );
			!( group.data && group.data.length ) && ( _r = false );
			return _r;
		}
		
		public function get groupBgColors():Array{
			var _r:Array = [0xf2f2f2]; 
			group.background 
				&& group.background.colors
				&& group.background.colors.length
				&& ( _r = group.background.colors );
			return _r;
		}
		
		public function groupLastBgColors( _color:uint ):uint{
			group.background 
				&& ( 'lastColor' in group.background )
				&& ( _color = group.background.lastColor );
			
			return _color;
		}
		
		public function get groupLabelStyle():Object{
			var _r:Object = { color: 0x838383, size: 14 };
			group.label 
				&& group.label.style
				&& ( _r = Common.extendObject( _r, group.label.style ) );
			return _r;
		}	
		
		protected var _mixModel:MixChartModel;
		public function get mixModel():MixChartModel{ return _mixModel; }
		
		public function getYAxisIndex( _seriesItem:Object ):int{
			var _r:int = 0;
			return _r;
		}	
		
		public function get hasVTitle():Boolean{
			var _r:Boolean;
			return _r;
		}
		
		public function get yArrowLength():int{
			var _r:int = 8;
			this.cd
				&& this.cd.yAxis
				&& ( 'arrowLength' in this.cd.yAxis )
				&& ( _r = this.cd.yAxis.arrowLength )
				;
				
			return _r;
		}
		
		public function get xArrowLength():int{
			var _r:int = 8;
			this.cd
				&& this.cd.xAxis
				&& ( 'arrowLength' in this.cd.xAxis )
				&& ( _r = this.cd.xAxis.arrowLength )
				;
			return _r;
		}
		
		/* legend end */
		
		public function get chartName():String{ return ''; }
		public function get chartUrl():String{ return ''; }
		
		public function BaseConfig() {
		}
		
	}
}