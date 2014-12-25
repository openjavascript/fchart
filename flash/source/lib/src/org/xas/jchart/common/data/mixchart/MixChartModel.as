package org.xas.jchart.common.data.mixchart
{
	import flash.events.EventDispatcher;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.ChartType;

	public class MixChartModel extends EventDispatcher
	{
		protected var _config:Config;
				
		protected var _items:Vector.<MixChartModelItem>;
		public function get items():Vector.<MixChartModelItem>{ return _items; }
		
		protected var _graphicType:Object;
		public function get graphicType():Object{ return _graphicType;  }
		
		public function MixChartModel( _config:Config )
		{
			this._config = _config;
			_items = new Vector.<MixChartModelItem>();
			_graphicType = {};
			
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
			
			initGraphicType();
		}
		
		protected function initGraphicType():void{
			Common.each( _items, function( _k:int, _item:MixChartModelItem ):void{
				Common.each( _item.displaySeries, function( _sk:int, _sitem:Object ):void{
					//Log.printJSON( _sitem );
					var _type:String = _sitem.type || ChartType.BAR, _tmp:Object;
					switch( _type ){
						case 'column': _type = ChartType.BAR; break;
						case 'spline': _type = ChartType.LINE; break;
					}
					!( _type in _graphicType ) && ( _graphicType[ _type ] = [] );
					_tmp = { data: _sitem, type: _type, modelIndex: _k, dataIndex: _sk };
					_graphicType[ _type ].push( _tmp );
					//Log.printClass( _tmp.model as  );
				});
			});
			//Log.printJSON( _graphicType );
		}
	}
}