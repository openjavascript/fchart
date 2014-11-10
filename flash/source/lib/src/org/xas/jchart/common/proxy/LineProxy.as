package org.xas.jchart.common.proxy
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.proxy.data.line.BaseLineData;
	
	public class LineProxy extends Proxy implements IProxy
	{
		public static const name:String = 'LineProxy';
		private var _data:BaseLineData;
		
		public function LineProxy( ) {
			
			super( LineProxy.name );
		}
		
		public function get dataModel():BaseLineData{
			return _data;
		}
		
		override public function onRegister():void {
			switch( (facade as BaseFacade).name ) {
				default: {
					_data = new BaseLineData();
					break;
				}
			}
		}
		
		override public function onRemove():void{
		}
		
	}
}