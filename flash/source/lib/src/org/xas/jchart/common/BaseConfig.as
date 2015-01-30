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
	import org.xas.jchart.common.data.mixchart.BaseMixChartModel;

	public class BaseConfig extends BaseAttrConfig
	{		
		public function get facade():BaseFacade{ return _facade; }
		public var _facade:BaseFacade;
		public function setFacade( _setter:BaseFacade ):void{ _facade = _setter; }
		
		public function get version():String{ return '0.1'; }
		
		public function serialDataLabelValue( _serialIx:int, _itemIx:int ):String{
			var _r:String = '', _item:Object = displaySeries[ _serialIx ];		
			
			if( !_item ){
				return '';
			}
			
			if( 'labelData' in _item ){
				_r = _item.labelData[ _itemIx ];
			}else{
				_r = StringUtils.printf( 
					dataLabelFormat
					, Common.moneyFormat( 
						_item.data[ _itemIx ]
						, 3
						, dataLabelAbbrNumber( _item.data[ _itemIx ], floatLen, _item ) 
						, ','
						, dataLabelAbbrNumberEnabled( _item )
					) 
				);				
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
		
		public function getTipsValue( _sitem:Object, _k:int, _format:String, _floatLen:int = 0 ):String{
			var _r:String = '';
			
			if( _sitem.tipsData ){
				_r = _sitem.tipsData[ _k ]
			}else if( _sitem.data ){
				_r = StringUtils.printf( _format, 
					Common.moneyFormat( 
						_sitem.data[ _k ]
						, 3
						, tooltipAbbrNumber( _sitem.data[ _k ], _floatLen ) 
						, ','
						, tooltipAbbrNumberEnabled
					)
				);
			}
			
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
		
		public function get itemLength():int{
			var _r:int = 0;
			this.displaySeries
				&& this.displaySeries.length
				&& this.displaySeries[0]
				&& this.displaySeries[0].data
				&& this.displaySeries[0].data.length
				&& ( _r = this.displaySeries[0].data.length );
			return _r;
		}
		public function get realItemLength():int{
			var _r:int = 0;
			this.series
				&& this.series.length
				&& this.series[0]
				&& this.series[0].data
				&& this.series[0].data.length
				&& ( _r = this.series[0].data.length );
			return _r;
		}
		
		public function updateDisplaySeries( _filter:Object = null, _data:Object = null ):BaseConfig{
			_data = _data || chartData;
			if( !( _data && _data.series && _data.series.length ) ) return this;
			_displaySeries = JSON.parse( JSON.stringify( _data.series ) ) as Array;
			_displaySeriesIndexMap = {};
			
			Common.each( _displaySeries, function( _k:int, _item:Object ):void{
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
		protected var _displaySeriesIndexMap:Object;
		public function get displaySeriesIndexMap():Object{ return _displaySeriesIndexMap || {}; }
		protected var _displayLegend:Array = [];
		public function get displayLegend():Array{ return _displayLegend; }
				
		public function get tooltipSerial():Array{
			return tooltipSeries;
		}
		
		public function get tooltipAfterSerial():Array{	
			return tooltipAfterSeries;
		}
		
		protected var _filterData:Object;
		public function get filterData():Object{
			return _filterData;	
		}	
		
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
			
			c.minX = this.vlabelSpace;
			c.minY = this.vspace * 2;
			c.maxX = this.stageWidth - this.vlabelSpace;
			c.maxY = this.stageHeight - this.vspace;

			return _coordinate;
		}

		public function getTipsHeader( _ix:int ):String{
			var _r:String = this.tipsHeader[ _ix ] || this.categories[ _ix ] || '';
			return _r;
		}
		
		override public function get yAxisEnabled():Boolean{
			var _r:Boolean = super.yAxisEnabled;			
			!displaySeries.length && ( _r = false );			
			return _r;
		}
		
		override public function get xAxisEnabled():Boolean{
			var _r:Boolean = super.xAxisEnabled;			
			!displaySeries.length && ( _r = false );			
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
		
		protected var _realRate:Array;
		public function get realRate():Array{ return _realRate; }
		
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

		/* xlabel rotation start */

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
		
		public function setDisplayAllLabel( _dal:Boolean ):void {
			_displayAllLabel = _dal;
			_displayOverride = true;
			_displayOverrideValue = _dal;
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

		public function get totalNum():Number{
			return 0;
		}
		
		protected var _selected:int = -1;
		public function get selected():int{ return _selected; }
		public function set selected( _setter:int ):void{ _selected = _setter; }
		public function get itemName():String{ return ''; }
		
		protected var _dataInited:Boolean = false;
		public function get dataInited():Boolean{ return _dataInited };
		public function set dataInited( _setter:Boolean ):void{ _dataInited = _setter }
		
		public function clearData():BaseConfig{
			_displaySeries = [];
			_displaySeriesIndexMap = {};
			_filterData = {};
			_chartData = {};
			_displayLegend = [];
			_selected = -1;			
			_dataInited = false;
			
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
//			selected = -1;
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
						case 'MIDDLE_RIGHT' : 
						case 'RIGHT_MIDDLE' : { 
							_interval = 4;break; 
						}
						case 'RIGHT_BOTTOM' : { _interval = 5;break; }
							
						case 'BOTTOM_LEFT' : { _interval = 6;break; }
						case 'BOTTOM_CENTER' : { _interval = 7;break; }
						case 'BOTTOM_RIGHT' : { _interval = 8;break; }
							
						case 'LEFT_TOP' : { _interval = 9;break; }
						case 'MIDDLE_LEFT' :
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
		
		public function get groupEnabled():Boolean{
			var _r:Boolean = StringUtils.parseBool( group.enabled );
			!( group.data && group.data.length ) && ( _r = false );
			return _r;
		}
		
		protected var _mixModel:BaseMixChartModel;
		public function get mixModel():BaseMixChartModel{ return _mixModel; }
		
		public function getYAxisIndex( _seriesItem:Object ):int{
			var _r:int = 0;
			return _r;
		}	
		
		public function get hasVTitle():Boolean{
			var _r:Boolean;
			return _r;
		}
				
		public function get chartName():String{ return ''; }
		public function get chartUrl():String{ return ''; }
		
		public function BaseConfig() {
		}
		
	}
}