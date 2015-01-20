package org.xas.jchart.common.config
{
	import flash.geom.Rectangle;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.view.mediator.LegendMediator;
	
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
		
		public function get innerRadiusEnabled():Boolean{
			var _r:Boolean = false;
			
			cd 
				&& cd.innerRadius
				&& 'enabled' in cd.innerRadius
				&& ( _r = StringUtils.parseBool( cd.innerRadius.enabled ) );
			
			return _r;
		}
		
		public function get innerRadiusThickness():uint{
			var _r:uint = 2;
			
			cd 
				&& cd.innerRadius
				&& 'thickness' in cd.innerRadius
				&& ( _r = cd.innerRadius.thickness );
			
			return _r; 
		}
		
		public function get innerRadiusMargin():uint{
			var _r:uint = 6;
			
			cd 
				&& cd.innerRadius
				&& 'margin' in cd.innerRadius
				&& ( _r = cd.innerRadius.margin );
			
			return _r;
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
		
		public function get selectableEnabled():Boolean{
			var _r:Boolean = true;
			
			cd 
				&& cd.selectable
				&& 'enabled' in cd.selectable
				&& ( _r = StringUtils.parseBool( cd.selectable.enabled ) );
			
			return _r;
		}
		
		override public function get offsetAngle():Number{
			var _r:Number = 270;
			
			cd 
				&& ( 'offsetAngle' in cd )
				&& ( _r = cd.offsetAngle );
			
			
			cd 
				&& cd.angle
				&& ( 'offset' in cd.angle )
				&& ( _r = cd.angle.offset );
							
			return _r;
		}
				
		public function get angleMargin():Number{
			var _r:Number = 0;
			
			cd 
				&& cd.angle
				&& ( 'margin' in cd.angle )
				&& ( _r = cd.angle.margin );
			
			return _r;
		}
		
		public function legendIntersect( _radius:Number, _offsetWidth:Number, _offsetPad:Number ):Boolean{
			var _r:Boolean = false
				, _legendRect:Rectangle
				, _chartRect:Rectangle
				;

			if( this.legendEnabled && this.c && this.c.legend ){
				_chartRect = new Rectangle( 
					this.c.cx - _radius - _offsetWidth - _offsetPad
					, this.c.cy - _radius - _offsetPad
					, ( _radius + _offsetWidth + _offsetPad ) * 2
					, ( _radius + _offsetPad ) * 2
					)
				_legendRect = new Rectangle( this.c.legend.x, this.c.legend.y, pLegendMediator.maxWidth, pLegendMediator.maxHeight );
//				Log.log( _chartRect, _legendRect );
				_r = _chartRect.intersects( _legendRect );
			}
			
			return _r;
		}
		
		protected function get pLegendMediator():LegendMediator{
			return facade.retrieveMediator( LegendMediator.name ) as LegendMediator;
		}
		
		public function get totalLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;

//			return true && this.totalNum; 
			
			cd 
				&& cd.totalLabel
				&& ( 'enabled' in cd.totalLabel )
				&& ( _r = StringUtils.parseBool( cd.totalLabel.enabled ) && this.totalNum );
			
			return _r;
		}
		
		public function get totalLabelFormat():String{
			var _r:String = "{0}";
			cd 
				&& cd.totalLabel
				&& ( 'format' in cd.totalLabel )
				&& ( _r = cd.totalLabel.format );
			
			return _r;
		}
		
		
		public function get totalLabelBgColor():uint{
			var _r:uint = 0xF5F5DC;
			cd  
				&& cd.totalLabel
				&& cd.totalLabel.bgStyle
				&& ( 'color' in cd.totalLabel.bgStyle )
				&& ( _r = cd.totalLabel.bgStyle.color );
			
			return _r;
		}	
			
		
		public function get totalLabelBgAlpha():Number{
			var _r:Number = .9;
			cd 
				&& cd.totalLabel
				&& cd.totalLabel.bgStyle
				&& ( 'alpha' in cd.totalLabel.bgStyle )
				&& ( _r = cd.totalLabel.bgStyle.alpha );
			
			return _r;
		}	
		
		public function get totalLabelLabelStyle():Object{
			var _r:Object = {
				size: 16
//				, bold: true
				, color: 0xff0000
			};
			cd 
				&& cd.totalLabel
				&& cd.totalLabel.labelStyle
				&& ( _r = Common.extendObject( _r, cd.totalLabel.labelStyle, true ) );			
				
			return _r;
		}
		
		
		public function get totalLabelRadiusRate():Number{
			var _r:Number = .6;
			this.cd
				&& this.cd.totalLabel
				&& 'rate' in this.cd.totalLabel
				&& ( _r = this.cd.totalLabel.rate )
				;
			return _r;
		}
		
		public function get totalLabelRadius():Number{
			return inRadius * totalLabelRadiusRate;
		}
		
		public function calcRadius( _w:Number, _h:Number, _maxLabelWidth:Number, _maxLabelHeight:Number ):Number{
			var _radius:Number = Math.min( _w, _h );
			
			_radius /= 2;
			
			//			Log.log( '_maxLabelWidth:', _maxLabelWidth );
			
			if( this.dataLabelEnabled ){			
				_radius -= (this.dataLabelLineLength - this.dataLabelLineStart );	
				if(
					_w > _h && !this.legendIntersect( _radius - _maxLabelHeight
						, _maxLabelWidth
						,  this.dataLabelLineLength - this.dataLabelLineStart
					)
				){
					_radius = _radius - _maxLabelHeight;
				}else{
					_radius = _radius - _maxLabelWidth;
				}
			}else{ 
				_radius -= this.moveDistance;
			}
			//			Log.log( this.c.chartWidth,this.c.chartHeight, _radius );
			
			return _radius;
		}

//		
//		override public function get animationDuration():Number {
//			var _r:Number = .5;
//			'duration' in animation && ( _r =  parseFloat( this.animation.duration ) );
//			return _r;
//		}
	}
}