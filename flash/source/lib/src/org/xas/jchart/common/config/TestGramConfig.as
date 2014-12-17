package org.xas.jchart.common.config
{
	import flash.geom.Point;
	
	import org.xas.jchart.common.BaseConfig;

	public class TestGramConfig extends BaseConfig
	{
		public function TestGramConfig()
		{
			super();
		}
		
		override public function get isAutoRate():Boolean{
			return false;
		}

	}
}