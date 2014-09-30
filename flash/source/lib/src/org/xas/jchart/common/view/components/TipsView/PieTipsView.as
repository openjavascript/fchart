package org.xas.jchart.common.view.components.TipsView
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class PieTipsView extends BaseTipsView
	{
		public function PieTipsView()
		{
			super();
		}
		
		
		override protected function buildData():void{
			
			if( !( BaseConfig.ins.displaySeries && BaseConfig.ins.displaySeries.length ) ){
				return;
			}
			
			_data = {};
			
			Common.each( BaseConfig.ins.displaySeries, function( _k:int, _item:Object ):void{
				_data[ _k ] = { 
					'name': StringUtils.printf( _config.tooltipHeaderFormat,  ( _item.name || '' ).replace( /[\r\n]+/g, '' ) )
					, 'items': [ 
						{ 
							'name': BaseConfig.ins.itemName
							, 'value': StringUtils.printf( _config.tooltipPointFormat, 
								Common.moneyFormat( _item.y || 0, 3, _config.floatLen  )
							)
						}  
					] 
				};

			});
		}
		
		override protected function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;		
			if( !( _data && _data[ _ix ] ) ) return;
			//Log.printObject( _data[ _ix ] );
			_tips.update( _data[ _ix ], new Point( _srcEvt.stageX, _srcEvt.stageY ), [ BaseConfig.ins.itemColor( _ix ) ] );
			//Log.log( 'updateTips', _ix );
		}

	}
}