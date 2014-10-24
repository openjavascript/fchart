package org.xas.jchart.common.view.components.LegendView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.LegendItemUI;

	public class ZHistogramLegendView extends BaseLegendView
	{
		public function ZHistogramLegendView()
		{
			super();
		}
		
		override protected function showChart( ):void{
			this.graphics.clear();
			
			if( !( BaseConfig.ins.chartData && BaseConfig.ins.chartData.series && BaseConfig.ins.chartData.series.length ) ) return;
			var _x:int = 0, _tmp:LegendItemUI;
			
			_items = new Vector.<LegendItemUI>();
			
			Common.each( BaseConfig.ins.categories, function( _k:int, _item:String ):void{
				
				var _styles:Object = {};
				_styles = Common.extendObject( 
					DefaultOptions.title.style
					, DefaultOptions.legend.itemStyle
				);
				
				_styles.color = BaseConfig.ins.itemColor( _k, false );
				
				_styles = Common.extendObject( 
					_styles
					, BaseConfig.ins.legendItemStyle
				);
				
				addChild( _tmp = new LegendItemUI( { name: _item }, _styles ) );
				_tmp.addEventListener( JChartEvent.UPDATE_STATUS, onUpdateStatus );
				_tmp.x = _x;
				_items.push( _tmp );
				
				if( _k in BaseConfig.ins.filterData ){
					_tmp.toggle();
				} 
				
				_x = _x + 2 + _tmp.width;
			});
		}
		
		override protected function onUpdateStatus( _evt:JChartEvent ):void{
			var _selected:Boolean = _evt.data as Boolean
				, _filterObject:Object = {}
				;
			//Log.log( 'onUpdateStatus', _selected );
			Common.each( _items, function( _k:int, _item:LegendItemUI ):void{
				//Log.log( 'selected', _item.selected );
				_item.selected && ( _filterObject[ _k ] = _k );
			});
			
			dispatchEvent( new JChartEvent( JChartEvent.FILTER_DATA, _filterObject ) );
		}
	}
}