package 
{
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.config.BasePieConfig;
	
	public class Config extends BasePieConfig
	{
		public function Config()
		{
			super();
		}
		
		
		override public function get dataLabelEnabled():Boolean{
			var _r:Boolean = super.dataLabelEnabled;
			return false;
			cd 
				&& cd.plotOptions
				&& cd.plotOptions.ndount
				&& cd.plotOptions.ndount.dataLabels
				&& ( 'enabled' in cd.plotOptions.ndount.dataLabels )
				&& ( _r = cd.plotOptions.ndount.dataLabels.enabled );
			
			return _r;
		}
		
		override public function get cdataLabelEnabled():Boolean{
			var _r:Boolean = false;
			return false;
			cd 
				&& cd.plotOptions
				&& cd.plotOptions.ndount
				&& cd.plotOptions.ndount.cdataLabels
				&& ( 'enabled' in cd.plotOptions.ndount.cdataLabels )
				&& ( _r = cd.plotOptions.ndount.cdataLabels.enabled );
				
			cd 
				&& cd.plotOptions.cdataLabels
				&& ( 'enabled' in cd.cdataLabels )
				&& ( _r = cd.cdataLabels.enabled );
			
			return _r;
		}
		
		public function get radiusStep():Number{
			var _r:Number = 8;
			cd 
				&& 'radiusStep' in cd
				&& ( _r = cd.radiusStep);
				
			cd 
				&& cd.radius
				&& 'step' in cd.radius
				&& ( _r = cd.radius.step );
				
			return _r;
		}
	}
}