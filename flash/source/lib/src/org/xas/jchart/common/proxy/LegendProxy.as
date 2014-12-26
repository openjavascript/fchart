package org.xas.jchart.common.proxy
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.proxy.data.legend.BaseLegendData;
	
	public class LegendProxy extends Proxy implements IProxy
	{
		public static const name:String = 'LegendProxy';
		private var _data:BaseLegendData;
		
		public function LegendProxy( ) {
			super( LegendProxy.name );
		}
		
		public function get dataModel():BaseLegendData{ 
			return _data; 
		}
		
		override public function onRegister():void {
			switch( (facade as BaseFacade).name ) {
				default: {
					_data = new BaseLegendData();
					break;
				}
			}
		}
		
		override public function onRemove():void{
		}
		
	}
}