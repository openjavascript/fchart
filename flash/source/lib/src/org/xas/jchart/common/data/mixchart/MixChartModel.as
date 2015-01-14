package org.xas.jchart.common.data.mixchart
{
	import flash.events.EventDispatcher;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
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
			
			var _yType:Object = {}, _yList:Array = [], _params:Array = [];
			
			if( !(
				_config.cd
				&& _config.cd.yAxis 
				&& _config.cd.yAxis.length
			)){
				_params.push( _config.cd.yAxis || {} );
			}else{
				_params = _config.cd.yAxis;
			}
			
			Common.each( _config.displaySeries, function( _k:int, _item:Object ):void{
				var _key:int = parseInt( _item.yAxis || '0' );
				if( !( _key in _yType ) ){
					_yType [ _key ] = [];
					_yList.push( _key );
				}
				_yType [ _key ].push( { index: _k, data: _item } );
			});
			
			if( !_yList.length ){
				return;
			}
			_yList.sort();
			//Log.log( _yList );
			
			Common.each( _yList, function( _k:int, _v:int ):void {
				var _param:Object = _params[ _v ];
				_items.push( new MixChartModelItem( _v, _param, _config ) );
			});
			
//			return;
//			if( !(
//				_config.cd
//				&& _config.cd.yAxis 
//				&& _config.cd.yAxis.length
//				)){
//				_items.push( new MixChartModelItem( 0, _config.cd.yAxis || {}, _config ) );
//				
//			}else if( _config.cd.yAxis && _config.cd.yAxis.length ){
//				Common.each( _config.cd.yAxis, function( _k:int, _item:Object ):void {
//					_items.push( new MixChartModelItem( _k, _item, _config ) );
//				});
//			}
			
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
//					Log.log( _sk );
					_graphicType[ _type ].push( _tmp );
					//Log.printClass( _tmp.model as  );
				});
			});
			//Log.printJSON( _graphicType );
		}
	}
}