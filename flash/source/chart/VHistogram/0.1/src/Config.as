package 
{
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;

	public class Config extends BaseConfig
	{
		public function Config()
		{
			super();
		}	
		
		override public function get chartName():String{ return 'VHistogram'; }
		override public function get chartUrl():String{ return 'http://fchart.openjavascript.org/modules/JC.FChart/0.1/_demo/vbar/'; }
		
		override public function get labelRotationEnable():Boolean{
			this.cd
				&& this.cd.yAxis
				&& this.cd.yAxis.rotation
				&& ( 'enabled' in this.cd.yAxis.rotation )
				&& ( _labelRotationEnable = StringUtils.parseBool( this.cd.yAxis.rotation.enabled ) )
			
			this.cd 
				&& this.cd.yAxis
				&& this.cd.yAxis.labels
				&& ( 'rotation' in this.cd.yAxis.labels )
				&& ( _labelRotationEnable = true );
			
			return _labelRotationEnable;
		}
		
		override public function get labelRotationAngle():Number{
			
			this.cd
				&& this.cd.yAxis
				&& this.cd.yAxis.rotation
				&& ( 'angle' in this.cd.yAxis.rotation )
				&& ( _labelRotationAngle = this.cd.yAxis.rotation.angle )
			
			
			this.cd
				&& this.cd.yAxis
				&& this.cd.yAxis.labels
				&& ( 'rotation' in this.cd.yAxis.labels )
				&& ( _labelRotationAngle = this.cd.yAxis.labels.rotation )
			
			return _labelRotationAngle;
		}
		
	}
}