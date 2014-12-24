package org.xas.jchart.common.data.mixchart
{
	import flash.events.EventDispatcher;
	
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;

	public class MixChartModel extends EventDispatcher
	{
		protected var _config:Config;
				
		protected var _items:Vector.<MixChartModelItem>;
		public function get items():Vector.<MixChartModelItem>{ return _items; }
		
		public function MixChartModel( _config:Config )
		{
			this._config = _config;
			_items = new Vector.<MixChartModelItem>();
			
			process();
		}
		
		protected function process():void{
			if( !(
				_config.cd
				&& _config.cd.yAxis 
				&& _config.cd.yAxis.length
				)){
				return;
			};
			Common.each( _config.cd.yAxis, function( _k:int, _item:Object ):void {
				_items.push( new MixChartModelItem( _k, _item, _config ) );
			});
		}
	}
}