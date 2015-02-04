package org.xas.jchart.common
{
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.data.DefaultOptions;

	public class BaseAttrConfig
	{
		public function BaseAttrConfig()
		{
		}
		
		public static function hasAttr( _data:Object, _keys:String ):Boolean{
			var _r:Boolean
			, _keyList:Array = _keys.split( '.' )
				, _tmp:*
				, _maxLen:int = _keyList.length - 1
				, _hasItem:Boolean
				;
			
			if( _data && _maxLen > 0 ){
				_tmp = _data;
				Common.each( _keyList, function( _k:int, _item:String ):Boolean{
					var _next:Boolean = true;
					
					if( _item in _tmp ){
						_tmp = _tmp[ _item ];
						if( _k === _maxLen ){
							_r = true;
							_next = false;
						}
					}else{
						_next = false;
					}
					
					return  _next;
				});
			}
			
			return _r;
		}
		
		public static function getAttr( _data:Object, _keys:String, _defValue:* ):*{
			var _r:* = _defValue
				, _keyList:Array = _keys.split( '.' )
				, _tmp:*
				, _maxLen:int = _keyList.length - 1
				;
			
			if( _data && _keyList.length ){
				_tmp = _data;
				Common.each( _keyList, function( _k:int, _item:String ):Boolean{
					var _next:Boolean = true;
					
					if( _item in _tmp ){
						_tmp = _tmp[ _item ];
						if( _k === _maxLen ){
							_r = _tmp;
							_next = false;
						}
					}else{
						_next = false;
					}
					
					return  _next;
				});
				
			}
			
			return _r;
		}
		
		public static function getAttrLen( _data:Object, _keys:String, _def:uint ):uint{
			var _tmp:* = getAttr( _data, _keys, null );
			if( _tmp && 'length' in _tmp ){
				_def = _tmp.length;
			}
			return _def;
		}
		
		public function get colors():Array{
			var _r:Array = DefaultOptions.colors, _tmp:Array;
			_tmp =  BaseAttrConfig.getAttr( this.cd, 'colors', [] ) as Array;	
			_tmp && _tmp.length && ( _r = _tmp );
			return _r;
		}
		
		
		public function get tooltipSerialColors():Array{
			var _r:Array = DefaultOptions.tooltip.serialColor, _tmp:Array;
			_tmp =  BaseAttrConfig.getAttr( this.cd, 'tooltip.serialColor', [] ) as Array;	
			_tmp && _tmp.length && ( _r = _tmp );
			return _r;
		}
		
		
		public function get tooltipAfterSerialColors():Array{
			var _r:Array = DefaultOptions.tooltip.afterSerialColor, _tmp:Array;
			_tmp =  BaseAttrConfig.getAttr( this.cd, 'tooltip.afterSerialColor', [] ) as Array;	
			_tmp && _tmp.length && ( _r = _tmp );
			return _r;
		}
		
		public function get yArrowLength():int{
			var _r:int = 8;			
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.arrowLength', _r ) as int;				
			return _r;
		}
		
		public function get xArrowLength():int{
			var _r:int = 8;
			_r = BaseAttrConfig.getAttr( this.cd, 'xAxis.arrowLength', _r ) as int;		
			return _r;
		}
		
		public function get abbrNumberEnabled():Boolean{
			var _r:Boolean = BaseAttrConfig.getAttr( this.cd, 'abbrNumber.enabled', false ) as Boolean;
			return _r;
		}	
		
		public function abbrNumber( _num:Number ):uint{
			var _r:uint = abbrNumberPrecision, _num:Number = Math.abs( _num );
			
			if( abbrNumberEnabled ){
				if( _num >= Math.pow( 10, 8 ) ){
					_r = abbrNumber9( _r );
				}else if( _num >= Math.pow( 10, 4 ) ){
					_r = abbrNumber5( _r );
				}
			}
			
			return _r;
		}
		public function get abbrNumberPrecision():uint{
			return BaseAttrConfig.getAttr( this.cd, 'abbrNumber.precision', 2 ) as uint;
		} 
		public function abbrNumber9( _def:uint ):uint{
			return BaseAttrConfig.getAttr( this.cd, 'abbrNumber.9', _def ) as uint;
		} 
		public function abbrNumber5( _def:uint ):uint{
			return BaseAttrConfig.getAttr( this.cd, 'abbrNumber.5', _def ) as uint;
		} 
		
		public function get tooltipAbbrNumberEnabled():Boolean{
			return BaseAttrConfig.getAttr( this.cd, 'tooltip.abbrNumber.enabled', abbrNumberEnabled ) as Boolean;
		}
		
		public function tooltipAbbrNumber( _num:Number, _def:int = 2 ):int{
			var _r:int = _def, _num:Number = Math.abs( _num );
			
			if( tooltipAbbrNumberEnabled ){
				if( _num >= Math.pow( 10, 8 ) ){
					_r = tooltipAbbrNumber9;
				}else if( _num >= Math.pow( 10, 4 ) ){
					_r = tooltipAbbrNumber5;
				}
			}
			
			return _r;
		}
		
		public function get tooltipAbbrNumber5( ):uint{
			var _r:uint = abbrNumber5( abbrNumberPrecision );			
			_r = BaseAttrConfig.getAttr( this.cd, 'tooltip.abbrNumber.5', _r ) as uint;
			return _r;
		} 
		
		public function get tooltipAbbrNumber9(  ):uint{
			var _r:uint = abbrNumber9( abbrNumberPrecision );
			
			_r = BaseAttrConfig.getAttr( this.cd, 'tooltip.abbrNumber.9', _r ) as uint;
			
			return _r;
		}		
		
		
		public function dataLabelAbbrNumberEnabled( _item:Object = null ):Boolean{
			var _r:Boolean = abbrNumberEnabled;
						
			_r = BaseAttrConfig.getAttr( this.cd, 'dataLabels.abbrNumber.enabled', _r ) as Boolean;
			_r = BaseAttrConfig.getAttr( _item, 'abbrNumber.abbrNumber.9', _r ) as Boolean;
			
			return _r;
		}
		
		public function dataLabelAbbrNumber( _num:Number, _def:int = 2, _item:Object = null ):int{
			var _r:int = _def, _num:Number = Math.abs( _num );
			
			if( dataLabelAbbrNumberEnabled( _item ) ){
				if( _num >= Math.pow( 10, 8 ) ){
					_r = dataLabelAbbrNumber9( _item );
				}else if( _num >= Math.pow( 10, 4 ) ){
					_r = dataLabelAbbrNumber5( _item );
				}
			}
			
			return _r;
		}
		
		public function dataLabelAbbrNumber5( _item:Object = null ):uint{
			var _r:uint = abbrNumber5( abbrNumberPrecision );
			
			_r = BaseAttrConfig.getAttr( this.cd, 'dataLabels.abbrNumber.5', _r ) as uint;
			_r = BaseAttrConfig.getAttr( _item, 'dataLabel.abbrNumber.5', _r ) as uint;
			
			return _r;
		} 
		
		public function dataLabelAbbrNumber9( _item:Object = null ):int{
			var _r:int = abbrNumber9( abbrNumberPrecision );
			
			_r = BaseAttrConfig.getAttr( this.cd, 'dataLabels.abbrNumber.9', _r ) as uint;
			_r = BaseAttrConfig.getAttr( _item, 'dataLabel.abbrNumber.9', _r ) as uint;
			
			return _r;
		}
		
		public function yAxisAbbrNumber( _num:Number, _def:int = 2 ):int{
			var _r:int = _def, _num:Number = Math.abs( _num );
			
			if( yAxisAbbrNumberEnabled ){
				if( _num >= Math.pow( 10, 8 ) ){
					_r = yAxisAbbrNumber9;
				}else if( _num >= Math.pow( 10, 4 ) ){
					_r = yAxisAbbrNumber5;
				}
			}
			
			return _r;
		}
		
		public function get yAxisAbbrNumber5():uint{
			var _r:uint = abbrNumber5( abbrNumberPrecision );
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.abbrNumber.5', _r ) as uint;			
			return _r;
		} 
		
		public function get yAxisAbbrNumber9():int{
			var _r:int = abbrNumber9( abbrNumberPrecision );
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.abbrNumber.9', _r ) as uint;			
			return _r;
		}
		
		public function get yAxisAbbrNumberEnabled():Boolean{
			var _r:Boolean = BaseAttrConfig.getAttr( this.cd, 'yAxis.abbrNumber.enabled', abbrNumberEnabled ) as Boolean;
			return _r;
		}
		
		
		protected var _chartData:Object;
		protected var _hasNegative:Boolean;
		public function get hasNegative():Boolean{
			return this._hasNegative;
		}
		public function get chartData():Object { return _chartData; }	
		public function get cd():Object {	return _chartData; }
		
		
		protected var _displayOverride:Boolean;
		protected var _displayOverrideValue:Boolean;
		protected var _displayAllLabel:Boolean = true;
		public function get displayAllLabel():Boolean{
			
			if( _displayOverride ){
				return _displayOverrideValue;
			}
			
			_displayAllLabel =  BaseAttrConfig.getAttr( this.cd, 'xAxis.display.enable', _displayAllLabel ) as Boolean;
			_displayAllLabel =  BaseAttrConfig.getAttr( this.cd, 'xAxis.displayAll.enabled', _displayAllLabel ) as Boolean;
			_displayAllLabel =  BaseAttrConfig.getAttr( this.cd, 'displayAllLabel', _displayAllLabel ) as Boolean;
			
			return _displayAllLabel;
		}
				
		public function get isAutoRate():Boolean {
			var _r:Boolean = false;
			
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.autoRate.enabled', _r ) as Boolean;
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.customRate', _r ) as Boolean;
			
			if( _ignoreAutoRate ){
				_r = false;
			}
			
			return _r;
		} 
		protected var _ignoreAutoRate:Boolean;
		
		
		public function get autoRateDeep():int {
			var _r:int = 1;
			
			if( this.isAutoRate ){
				_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.autoRate.deep', _r ) as int;	
			}
			
			return _r;
		}
		
		public function get rateUp():int {
			var _r:int = 5;
			
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.autoRate.rateUp', _r ) as int;	
			
			_r <= 0 && ( _r = 0 );
			
			return _r;
		}
		
		
		public function get tooltipSeries():Array{
			var _r:Array = [];
			
			_r = BaseAttrConfig.getAttr( this.cd, 'tooltip.serial', _r ) as Array;
			_r = BaseAttrConfig.getAttr( this.cd, 'tooltip.series', _r ) as Array;	
			
			return _r;
		}
		
		
		public function get tooltipAfterSeries():Array{
			var _r:Array = [];
			
			_r = BaseAttrConfig.getAttr( this.cd, 'tooltip.afterSerial', _r ) as Array;
			_r = BaseAttrConfig.getAttr( this.cd, 'tooltip.afterSeries', _r ) as Array;	
			
			return _r;
		}
		
		
		public function pointEnabled( _item:Object = null ):Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'point.enabled', _r ) as Boolean;
			_r =  BaseAttrConfig.getAttr( _item, 'point.enabled', _r ) as Boolean;
			return _r;
		}
		
		
		public function pointHoverShow( _item:Object = null ):Boolean{
			var _r:Boolean = false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'point.hoverShow', _r ) as Boolean;
			_r =  BaseAttrConfig.getAttr( _item, 'point.hoverShow', _r ) as Boolean;
			return _r;
		}
		
		
		
		public function get animationDuration():Number {
			var _r:Number = .75;
			_r = BaseAttrConfig.getAttr( this.cd, 'animation.duration', _r ) as Number;	
			return _r;
		}
		
		public function get lineBreakEnable():Boolean {
			var _r:Boolean = false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'lineBreak.enabled', _r ) as Boolean;			
			return _r;
		}
		
		public function get tipTitlePostfix():String{
			var _r:String = '{0}';
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.tipTitlePostfix', _r ) as String;
			return _r;
		}
		
		public function get legendEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'legend.enabled', _r ) as Boolean;	
			
			return _r;
		}
		
		public function get toggleBgEnabled():Boolean{
			var _r:Boolean = false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'toggleBg.enabled', _r ) as Boolean;				
			return _r;
		}
		
		public function get dataLabelEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'plotOptions.pie.dataLabels.enabled', _r ) as Boolean;
			_r =  BaseAttrConfig.getAttr( this.cd, 'dataLabels.enabled', _r ) as Boolean;	
			
			return _r;
		}
		
		public function get yAxisEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'rateLabel.enabled', _r ) as Boolean;
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.enabled', _r ) as Boolean;
						
			return _r;
		}
		
		public function get xAxisEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.enabled', _r ) as Boolean;			
			return _r;
		}
		
		
		public function get dataLabelFormat():String{
			var _r:String = "{0}";
			_r =  BaseAttrConfig.getAttr( this.cd, 'dataLabels.format', _r ) as String;			
			return _r;
		}
		
		public function get xAxisFormat():String{
			var _r:String = "{0}";
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.format', _r ) as String;					
			return _r;
		}
		
		public function get yAxisFormat():String{
			var _r:String = "{0}";
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.format', _r ) as String;				
			return _r;
		}
		
		public function get tooltipPointFormat():String{
			var _r:String = "{0}";
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.pointFormat', _r ) as String;				
			return _r;
		}
		
		public function get tooltipSerialFormat():String{
			var _r:String = "{0}";
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.serialFormat', _r ) as String;				
			return _r;
		}
		
		public function get tooltipAfterSerialFormat():String{
			var _r:String = "{0}";
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.afterSerialFormat', _r ) as String;					
			return _r;
		}
		
		public function get tooltipHeaderFormat():String{
			var _r:String = "{0}";
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.headerFormat', _r ) as String;				
			return _r;
		}
		
		public function get xAxisWordwrap():Boolean{
			var _r:Boolean = false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.wordwrap', _r ) as Boolean;				
			return _r;
		}	
		
		
		public function get superSerialLabelEnabled():Boolean{
			var _r:Boolean = false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'dataLabels.enabled', _r ) as Boolean;		
			return _r;
		}
		
		public function get vlineEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'vline.enabled', _r ) as Boolean;				
			return _r;
		}		
		
		public function get vsideLineEnabled():Boolean{
			var _r:Boolean = false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'vsideLine.enabled', _r ) as Boolean;				
			return _r;
		}
		
		public function get hlineEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'hline.enabled', _r ) as Boolean;				
			return _r;
		}
		
		public function get tooltipEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.enabled', _r ) as Boolean;	
			return _r;
		}
		
		public function get cdataLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			_r =  BaseAttrConfig.getAttr( this.cd, 'plotOptions.dount.cdataLabels.enabled', _r ) as Boolean;	
			_r =  BaseAttrConfig.getAttr( this.cd, 'dataLabels.enabled', _r ) as Boolean;				
			return _r;
		}
		
		protected function get maxOffset():Number {
			var _r:Number = 0;
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.autoRate.maxOffset', _r ) as Number;	
			_r < 0 && ( _r = 0 );			
			return _r;
		}
		
		protected function get minOffset():Number {
			var _r:Number = 0;
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.autoRate.minOffset', _r ) as Number;	
			_r < 0 && ( _r = 0 );
			return _r;
		}
		
		
		public function get yAxisMaxValue():Number{
			var _r:Number = 0;
			_r = BaseAttrConfig.getAttr( this.cd, 'rateLabel.maxvalue', _r ) as Number;	
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.maxvalue', _r ) as Number;	
			return _r;
		}
		
		public function get yAxisRate():Array{
			var _r:Array;
			_r = BaseAttrConfig.getAttr( this.cd, 'rateLabel.data', _r ) as Array;	
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.data', _r ) as Array;	
			_r = BaseAttrConfig.getAttr( this.cd, 'yAxis.rate', _r ) as Array;	
			return _r;
		}
		public function get titleText():String{
			var _r:String = '';
			_r =  BaseAttrConfig.getAttr( this.cd, 'title.text', _r ) as String;	
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.title.text', _r ) as String;		
			return _r;
		}
		
		public function get vtitleText():String{
			var _r:String = '';
			_r =  BaseAttrConfig.getAttr( this.cd, 'vtitle.text', _r ) as String;	
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.title.text', _r ) as String;	
			return _r;
		}
		
		public function get labelsStyle():Object{
			var _r:Object = {};
			cd 
			&& cd.xAxis
				&& cd.xAxis.labels
				&& cd.xAxis.labels.style
				&& ( _r = cd.xAxis.labels.style )
				;
			return _r;
		}
		
		public function get vtitleStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.title.style', _r ) as Object;	
			return _r;
		}
		
		
		
		public function get vlabelsStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.labels.style', _r ) as Object;	
			return _r;
		}
		
		public function get subtitleStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'subtitle.style', _r ) as Object;	
			return _r;
		}	
		
		
		public function get subtitleText():String{
			var _r:String = ''
			_r =  BaseAttrConfig.getAttr( this.cd, 'subtitle.text', _r ) as String;	
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.subtitle.text', _r ) as String;	
			return _r;
		}
		
		public function get creditsStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'credits.style', _r ) as Object;	
			return _r;
		}		
		public function get creditsEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'credits.enabled', _r ) as Boolean;	
			return _r;
		}
		
		
		public function get legendItemStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'legend.itemStyle', _r ) as Object;	
			return _r;
		}
		
		
		public function tooltipHeaderStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.headerStyle', _r ) as Object;	
			return _r;
		}
		
		public function tooltipHeaderYSpace():Number{
			var _r:Number = 6;
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.headerYSpace', _r ) as Number;	
			return _r;
		}
		
		public function tooltipItemYSpace():Number{
			var _r:Number = 6;
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.itemYSpace', _r ) as Number;				
			return _r;
		}
		protected var _labelRotationEnable:Boolean = false;
		public function get labelRotationEnable():Boolean{
			_labelRotationEnable =  BaseAttrConfig.getAttr( this.cd, 'xAxis.rotation.enabled', _labelRotationEnable ) as Boolean;	
			
			BaseAttrConfig.hasAttr( this.cd, 'xAxis.labels.rotation' ) 
				&& ( _labelRotationEnable = true );
			
			return _labelRotationEnable;
		}
				
		protected var _labelRotationAngle:Number = -45;
		public function get labelRotationAngle():Number{			
			_labelRotationAngle =  BaseAttrConfig.getAttr( this.cd, 'xAxis.rotation.angle', _labelRotationAngle ) as Number;	
			_labelRotationAngle =  BaseAttrConfig.getAttr( this.cd, 'xAxis.labels.rotation', _labelRotationAngle ) as Number;	
			return _labelRotationAngle;
		}
		
		
		public function get displayMod():int{
			var _mod:int = 0;
			
			if( !displayAllLabel ){
				_mod =  BaseAttrConfig.getAttr( this.cd, 'xAxis.display.mod', _mod ) as int;
				_mod =  BaseAttrConfig.getAttr( this.cd, 'xAxis.displayAll.mod', _mod ) as int;
			}			
			_mod = _mod < 0 ? 0 : _mod;			
			return _mod;
		}
		
		public function get startIndex():int{
			var _idx:int = 0;
			if( !displayAllLabel ){
				_idx =  BaseAttrConfig.getAttr( this.cd, 'xAxis.display.startIndex', _idx ) as int;
				_idx =  BaseAttrConfig.getAttr( this.cd, 'xAxis.displayAll.startIndex', _idx ) as int;
			}			
			return _idx;
		}
		
		public function get offsetAngle():Number{
			var _r:Number = 270;
			_r =  BaseAttrConfig.getAttr( this.cd, 'offsetAngle', _r ) as Number;
			return _r;
		}
		
		public function get group():Object{
			var _r:Object = cd.group || {};			
			!( 'enabled'  in _r ) && ( _r.enabled = true );			
			return _r;
		}
		
		public function get groupLabelStyle():Object{
			var _r:Object = { color: 0x838383, size: 14 };
			_r =  Common.extendObject( _r, BaseAttrConfig.getAttr( group, 'label.style', {} ) as Object );
			return _r;
		}	
		
		
		public function get groupBgColors():Array{
			var _r:Array = [0xf2f2f2], _tmp:Array; 
			_tmp =  BaseAttrConfig.getAttr( group, 'background.colors', [] ) as Array;
			_tmp && _tmp.length && ( _r = _tmp );
			return _r;
		}
		
		public function groupLastBgColors( _color:uint ):uint{
			group.background 
				&& ( 'lastColor' in group.background )
				&& ( _color = group.background.lastColor );
			
			return _color;
		}
		
		public function get categories():Array{
			var _r:Array = [];
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.categories', _r ) as Array;
			return _r;
		}
		
		public function get tipsHeader():Array{
			var _r:Array = [];
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.tipsHeader', _r ) as Array;
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.header', _r ) as Array;
			return _r;
		}
		
		public function get series():Array{
			var _r:Array = [];
			_r =  BaseAttrConfig.getAttr( this.cd, 'series', _r ) as Array;
			return _r;
		}	
		
		protected var _realRateFloatLen:int;
		public function get realRateFloatLen():int{ 
			var _r:int = _realRateFloatLen;
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.realRateFloatLen', _r ) as int;			
			return _r; 
		}
		
		public function get titleStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.title.style', _r ) as Object;	
			return _r;
		}		
		
		
		public function get titleEnable():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'title.enabled', _r ) as Boolean;	
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.title.enabled', _r ) as Boolean;				
			_r && !titleText && ( _r = false );			
			return _r;
		}
		
		
		public function get vtitleEnabled():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'vtitle.enabled', _r ) as Boolean;	
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.title.enabled', _r ) as Boolean;	
			_r && !vtitleText && ( _r = false );			
			return _r;
		}
		
		
		public function get subtitleEnable():Boolean{
			var _r:Boolean = true;
			_r =  BaseAttrConfig.getAttr( this.cd, 'subtitle.enabled', _r ) as Boolean;	
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.title.enabled', _r ) as Boolean;	
			_r && !subtitleText && ( _r = false );
			
			return _r;
		}	
		
		
		public function tooltipValueLabelXSpace():Number{
			var _r:Number = 4;
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.valueLabelXSpace', _r ) as Number;				
			return _r;
		}
		
		public function tooltipLabelStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.labelStyle', _r ) as Object;	
			return _r;
		}
		
		public function tooltipValueStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.valueStyle', _r ) as Object;	
			return _r;
		}
		
		public function get tooltipHeaderIcon():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.headerIcon', _r ) as Object;
			return _r;
		}
		
		public function get tooltipType():String{
			var _r:String = 'normal';
			_r =  BaseAttrConfig.getAttr( this.cd, 'tooltip.type', _r ) as String;
			return _r;
		}
		
		public function get tooltipHeaderIconStyle():Object{
			var _r:Object = {};
			_r =  BaseAttrConfig.getAttr( tooltipHeaderIcon, 'style', _r ) as Object;			
			return _r;
		}
		
		public function get tooltipHeaderIconEnabled():Boolean{
			var _r:Boolean = false;
			_r =  BaseAttrConfig.getAttr( tooltipHeaderIcon, 'enabled', _r ) as Boolean;	
			return _r;
		}
		
		public function get vspace():Number{
			var _r:Number = 5;
			_r =  BaseAttrConfig.getAttr( this.cd, 'yAxis.space', _r ) as Number;	
			return _r;
		}		
		public function get hspace():Number{
			var _r:Number = 15;
			_r =  BaseAttrConfig.getAttr( this.cd, 'xAxis.space', _r ) as Number;	
			return _r;
		}
	}
	
}