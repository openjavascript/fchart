package 
{
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.ChartType;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.data.mixchart.BaseMixChartModel;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.BaseMixChartModelItem;

	public class Config extends BaseConfig
	{
		
		public function Config()
		{
			super();
		}			
		override public function get version():String{ return '0.2'; }
		
		override public function get chartName():String{ return 'MixChart 0.2'; }
		override public function get chartUrl():String{ return 'http://fchart.openjavascript.org/modules/JC.FChart/0.1/_demo/mix/'; }
		

		override public function setChartData( _d:Object ):Object {
			
			super.setChartData( _d );
			_mixModel = new BaseMixChartModel( this );
			return _d;
		}	
		
		override public function get yAxisEnabled():Boolean{
			var _r:Boolean = true, _allFalse:Boolean = true;
			
			/*
			if( cd && cd.yAxis && ( 'enabled' in cd.yAxis ) ){
				_r = StringUtils.parseBool( cd.yAxis.enabled );
			}
			*/
			Common.each( _mixModel.items, function( _k:int, _item:BaseMixChartModelItem ):Boolean{
				if( _item.enabeld ){
//				if( _item.enabeld && _item.hasVTitle){
					return _allFalse = false;
				}
				return true;
			});
//			Log.log( 'yAxisEnabled1:', _r );
			
			if( _allFalse ){
				_r = false;
			}
//			Log.log( 'yAxisEnabled2:', _r );
			
			if( cd && cd.rateLabel && ( 'enabled' in cd.rateLabel ) ){
				_r = StringUtils.parseBool( cd.rateLabel.enabled );
			}
//			Log.log( 'yAxisEnabled3:', _r );
			
			return _r;
		}	
		
		override public function getYAxisIndex( _seriesItem:Object ):int{
			var _r:int = 0;
			_r = _seriesItem.yAxis || _r;
			return _r;
		}	
		
		override public function get hasVTitle():Boolean{
			var _r:Boolean;
			
			/*
			if( cd && cd.yAxis && ( 'enabled' in cd.yAxis ) ){
			_r = StringUtils.parseBool( cd.yAxis.enabled );
			}
			*/
			Common.each( _mixModel.items, function( _k:int, _item:BaseMixChartModelItem ):Boolean{
				if( 
					_item.enabeld 
					&& _item.params
					&& _item.params.title
					&& _item.params.title.text 
				){
					var _isEnabled:Boolean = true;
					if( 'enabled' in _item.params.title ){
						_isEnabled = StringUtils.parseBool( _item.params.title.enabled ) && _item.params.title.text;
					}
					if( _isEnabled ){
						_r = true;
						return false;
					}
				}
				return true;
			});
			
			return _r;
		}
		
		
		public function lineDashStyle( _seriesPart:Object ):String{
			var _r:String = 'Solid';
			
			this.cd
				&& this.cd.plotOptions
				&& this.cd.plotOptions.line
				&& this.cd.plotOptions.line.dashStyle
				&& ( _r = this.cd.plotOptions.line.dashStyle );
			
			_seriesPart
			&& _seriesPart.dashStyle
				&& ( _r = _seriesPart.dashStyle );				
			
			return _r;
		}
		
		public function isFillLine( _seriesPart:Object ):Boolean{
			var _r:Boolean;
			
			this.cd
				&& this.cd.plotOptions
				&& this.cd.plotOptions.area
				&& ( 'fillColor' in this.cd.plotOptions.area )
				&& ( _r = true );
			
			_seriesPart
			&& ( 'fillColor' in _seriesPart )
				&& ( _r = true );				
			
			return _r;
		}
		
		public function isLineGradient( _seriesPart:Object ):Boolean{
			var _r:Boolean;
			
			this.cd
				&& this.cd.plotOptions
				&& this.cd.plotOptions.area
				&& this.cd.plotOptions.area.fillColor
				&& ( 'linearGradient' in this.cd.plotOptions.area.fillColor )
				&& ( _r =  StringUtils.parseBool( this.cd.plotOptions.area.fillColor.linearGradient ) );
			
			_seriesPart
			&& _seriesPart.fillColor 
				&& ( 'linearGradient' in _seriesPart.fillColor )
				&& ( _r = StringUtils.parseBool( _seriesPart.fillColor.linearGradient ) );				
			
			return _r;
		}
		
		public function lineFillOpacity( _seriesPart:Object ):Number{
			var _r:Number = .35;
			
			this.cd
				&& this.cd.plotOptions
				&& this.cd.plotOptions.area
				&& ( 'fillOpacity' in this.cd.plotOptions.area )
				&& ( _r = this.cd.plotOptions.area.fillOpacity );
			
			_seriesPart
			&& ( 'fillOpacity' in _seriesPart )
				&& ( _r = _seriesPart.fillOpacity );				
			
			return _r;
		}
		
		override public function get animationDuration():Number {
			var _r:Number = 1;
			'duration' in animation && ( _r =  parseFloat( this.animation.duration ) );
			return _r;
		}
		
		override public function get colors():Array{
			var _r:Array = [ 
				0x7cb5ec
				, 0x09c100
				, 0xf7a35c
				, 0x8085e9
				, 0x434348
				, 0x90ed7d
				, 0xf15c80
				, 0xe4d354
				, 0x8085e8
				, 0x8d4653
				, 0x91e8e1 
			];
	
			chartData 
				&& chartData.colors
				&& chartData.colors.length
				&& ( _r = chartData.colors );
			
			return _r;
		}
	
 
	}
}