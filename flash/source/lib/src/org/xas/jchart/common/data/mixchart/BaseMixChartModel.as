package org.xas.jchart.common.data.mixchart
{
	import flash.events.EventDispatcher;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.ChartType;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.BaseMixChartModelItem;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.StackMixChartModelItem;

	public class BaseMixChartModel extends EventDispatcher
	{
		protected var _config:Config;
				
		protected var _items:Vector.<BaseMixChartModelItem>;
		public function get items():Vector.<BaseMixChartModelItem>{ return _items; }
		
		protected var _graphicType:Object;
		public function get graphicType():Object{ return _graphicType;  }
		
		protected var _columnIndexCount:int = 0;
		
		public function BaseMixChartModel( _config:Config )
		{
			this._config = _config;
			_items = new Vector.<BaseMixChartModelItem>();
			_graphicType = {};
			
			process();
		}
		
		protected function process():void{
			
			var _yType:Object = {}
				, _yAxisList:Array = []
				, _yAxisParams:Array = []
				;
			
			if( !(
				_config.cd
				&& _config.cd.yAxis 
				&& _config.cd.yAxis.length
			)){
				_yAxisParams.push( _config.cd.yAxis || {} );
			}else{
				_yAxisParams = _config.cd.yAxis;
			}
			
			var _stackIndex:Object = {};
			
			Common.each( _config.displaySeries, function( _k:int, _item:Object ):void{
				var _key:int = parseInt( _item.yAxis || '0' )
					, _tmp:Object 
					, _type:String = ChartType.fixChartType( _item.type )
					;
				if( !( _key in _yType ) ){
					_yType [ _key ] = [];
					_yAxisList.push( { index: _key } );
				}
				_tmp = { index: _k, data: _item };
				
				if( _type == ChartType.STACK ){
					_tmp.isStack = true;
				}
				
				switch( _type ){
					case ChartType.BAR: {
						_item.columnIndex = _columnIndexCount++;
						break;
					}
					case ChartType.STACK: {
						
						if( !( _key in _stackIndex ) ){
							_stackIndex[ _key ] = {};
						}
						
						if( !_stackIndex[ _key ].findStackIndex ){
							_stackIndex[ _key ].stackIndex = _columnIndexCount;
							_columnIndexCount++;
						}
						_item.columnIndex = _stackIndex[ _key ].stackIndex;
						_stackIndex[ _key ].findStackIndex = true;
						break;
					}
				}
				
				_yType [ _key ].push( _tmp );
				
			});
			
			if( !_yAxisList.length ){
				return;
			}
			_yAxisList.sort();
			//Log.log( _yAxisList );
//			Log.printFormatJSON( _yAxisList );
			
			Common.each( _yAxisList, function( _k:int, _v:Object ):void {
				var _param:Object = _yAxisParams[ _v.index ] || {}
					, _tmp:Array = _yType[ _v.index ]
					;
					_param.yAxisIndex = _k;
				if( _tmp && _tmp.length && _tmp[0].isStack ){
					_items.push( new StackMixChartModelItem( _v.index, _param, _config ) );
				}else{
					_items.push( new BaseMixChartModelItem( _v.index, _param, _config ) );
				}
			});
			
			initGraphicType();
			
//			Log.log( columnLen );
		}
		
		protected function initGraphicType():void{
			
			Common.each( _items, function( _k:int, _item:BaseMixChartModelItem ):void{
				Common.each( _item.displaySeries, function( _sk:int, _sitem:Object ):void{
					//Log.printJSON( _sitem );
					var _type:String = _sitem.type || ChartType.BAR, _tmp:Object;
					switch( _type ){
						case 'column': _type = ChartType.BAR; break;
						case 'spline': _type = ChartType.LINE; break;
					}
					_type = ChartType.fixChartType( _type );
					
					!( _type in _graphicType ) && ( _graphicType[ _type ] = [] );
					_tmp = { data: _sitem, type: _type, modelIndex: _k, dataIndex: _sk };
//					Log.log( _sk );
					_graphicType[ _type ].push( _tmp );
				});
			});
//			Log.printFormatJSON( _graphicType );
		}
		
		public function get columnLen():int{
			return _columnIndexCount;
		}
	}
}