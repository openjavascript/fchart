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
		public function MapTipsView()
		{
			super();
		}
		
		override protected function buildData():void{
			
			if( !_config.c.mapData ){
				return;
			}
			
			_data = {};
			
			Common.each( _config.c.mapData, function( _k:int, _item:Object ):void{
				_data[ _k ] = {
					'name': _item.name.replace( /[\r\n]+/g, '' ) || '',
					'items': [{
						'name': BaseConfig.ins.itemName,
						'value': _item.value
					}]
				};
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