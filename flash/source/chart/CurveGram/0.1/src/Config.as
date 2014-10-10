package 
{
	import flash.geom.Point;
	
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
	}
}