package 
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.config.BasePieConfig;
	
	public class Config extends BasePieConfig
	{
		public function Config()
		{
			super();
		}		
		
		override public function get chartName():String{ return 'Dount'; }
		override public function get chartUrl():String{ return 'http://fchart.openjavascript.org/modules/JC.FChart/0.1/_demo/dount/'; }

	}
}