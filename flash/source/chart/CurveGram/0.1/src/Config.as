package 
{
	import flash.geom.Point;
	
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;

	public class Config extends BaseConfig
	{
		public function Config()
		{
			super();
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
	}
}