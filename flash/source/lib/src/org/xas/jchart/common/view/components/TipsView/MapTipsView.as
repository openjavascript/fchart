package org.xas.jchart.common.view.components.TipsView
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class MapTipsView extends BaseTipsView
	{
		private var _mconfig:Config = BaseConfig.ins as Config;
		
		public function MapTipsView()
		{
			super();
		}
		
		override protected function buildData():void{
			
			if( !_mconfig.c.mapData ){
				return;
			}
			
			_data = {};
			
			
			/*
			Common.each( _mconfig.tooltipSerial, function( _k:int, _item:Object ):void{
				
				var _format:String = _mconfig.tooltipHeaderFormat
				, _headerName:String = StringUtils.printf( _format,  _mconfig.getTipsHeader( _k ).replace( /[\r\n]+/g, '' ) || ''  )
				, _value:String = StringUtils.printf( _mconfig.tooltipPointFormat, 
					Common.moneyFormat( _item.value, 3, Common.floatLen( _item.value ) )
				)
				;
				
				_data[ _k ] = {
					'name': _headerName,
					'items': [{
						'name': BaseConfig.ins.itemName,
						'value': _value
					}]
				};
			});	
			*/
			//Log.log( _mconfig.tooltipSerial. );
			
			Common.each( _mconfig.c.mapData, function( _k:int, _item:Object ):void{
				
				var _format:String = _mconfig.tooltipHeaderFormat
					, _headerName:String = StringUtils.printf( _format,  _mconfig.getTipsHeader( _k ).replace( /[\r\n]+/g, '' ) || ''  )
					, _value:String = StringUtils.printf( _mconfig.tooltipPointFormat, 
						Common.moneyFormat( _item.value, 3, Common.floatLen( _item.value ) )
					)
					, _items:Array = []
				;
				
				_data[ _k ] = {
					'name': _headerName
					, items: [], beforeItems: [], afterItems: []					
				};
				
				if( _mconfig.tooltipSeries && _mconfig.tooltipSeries.length && _mconfig.tooltipSeries[ _k ] ){
					_data[ _k ].beforeItems.push( {
						'name': _mconfig.tooltipSeries[ _k ].name,
						'value': StringUtils.printf( _config.tooltipSerialFormat, 
							Common.moneyFormat( _mconfig.tooltipSeries[ _k ].value, 3, Common.floatLen( _mconfig.tooltipSeries[ _k ].value ) )
						)

					});
				}
				
				_data[ _k ].items.push( {
					'name': BaseConfig.ins.itemName,
					'value': _value
				});
				
				
				if( _mconfig.tooltipAfterSeries && _mconfig.tooltipAfterSeries.length && _mconfig.tooltipAfterSeries[ _k ] ){
					_data[ _k ].afterItems.push( {
						'name': _mconfig.tooltipAfterSeries[ _k ].name,
						'value': StringUtils.printf( _config.tooltipSerialFormat, 
							Common.moneyFormat( _mconfig.tooltipAfterSeries[ _k ].value, 3, Common.floatLen( _mconfig.tooltipAfterSeries[ _k ].value ) )
						)
					});
				}
				
			});
		}
		
		override protected function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent,
				_ix:int = _evt.data.index as int;
			if( !( _data && _data[ _ix ] ) ) return;
			_tips.update( _data[ _ix ], new Point( _srcEvt.stageX, _srcEvt.stageY ) );
		}
		
		override protected function showTips( _evt:JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent,
				_ix:int = _evt.data.index as int;
			_tips.buildLayout( _data[ _ix ] ).show( new Point( _srcEvt.stageX, _srcEvt.stageY ) );
		}
		
		override protected function hideTips(_evt:JChartEvent):void{
			_tips.hide();
		}
	}
}