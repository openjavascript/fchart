package 
{
	import org.xas.jchart.common.BaseConfig;

	public class Config extends BaseConfig
	{
		public function Config()
		{
			super();
		}	
		
		override public function get chartName():String{ return 'Histogram'; }
		override public function get chartUrl():String{ return 'http://fchart.openjavascript.org/modules/JC.FChart/0.1/_demo/bar/'; }
 
	}
}