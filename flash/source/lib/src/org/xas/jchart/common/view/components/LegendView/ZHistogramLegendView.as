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
		
		override protected function addToStage( _evt:Event ):void{
			
			if( !( BaseConfig.ins.chartData && BaseConfig.ins.categories 
				&& BaseConfig.ins.categories.length ) ) return;
			
			this._data = BaseConfig.ins.categories;
			showChart();
		}
		
		override protected function onUpdateStatus( _evt:JChartEvent ):void{
			var _selected:Boolean = _evt.data as Boolean
				, _filterObject:Object = {};

			Common.each( _items, function( _k:int, _item:LegendItemUI ):void{
				_item.selected && ( _filterObject[ _k ] = _k );
			});
			
			dispatchEvent( new JChartEvent( JChartEvent.FILTER_DATA, _filterObject ) );
		}
	}
}