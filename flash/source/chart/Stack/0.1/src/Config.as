package 
{
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.config.BaseStackConfig;

	public class Config extends BaseStackConfig
	{
		public function Config()
		{
			super();
		}	
		
		override public function get chartName():String{ return 'StackChart'; }
		override public function get chartUrl():String{ return 'http://fchart.openjavascript.org/modules/JC.FChart/0.1/_demo/stack/'; }
 
	}
}