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
	
	public class BaseLegendView extends Sprite
	{
		protected var _items:Vector.<LegendItemUI>;
		protected var _interval:Number;
		protected var _dir:Number;
		protected var _isVertical:Boolean;
		protected var _data:Array;
		
		protected var _maxHeight:Number = 0;
		public function get maxHeight():Number{ return _maxHeight; }
		public function set maxHeight( _setter:Number ):void{ _maxHeight = _setter; }
		
		protected var _maxWidth:Number = 0;
		public function get maxWidth():Number{ return _maxWidth; }
		public function set maxWidth( _setter:Number ):void{ _maxWidth = _setter; }
		
		protected var __config:Config;
		public function get config():Config{ return __config; }
		
		public function BaseLegendView()
		{
			this._interval = BaseConfig.ins.legendInterval;
			this._dir = BaseConfig.ins.legendDir;
			this._isVertical = Boolean( Math.floor( this._dir / 3 ) & 1 );
			
			super();
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.SHOW_LEGEND_ARROW, updateLegendArrow );
			addEventListener( JChartEvent.HIDE_LEGEND_ARROW, hideLegendArrow );
		}
		
		protected function addToStage( _evt:Event ):void{
			
			if( !( BaseConfig.ins.chartData && BaseConfig.ins.series && BaseConfig.ins.series.length ) ) return;
			this._data = BaseConfig.ins.series;
			showChart();
		}
		
		protected function showChart( ):void{
			this.graphics.clear();

			var _x:int = 0, _tmp:LegendItemUI;
			_items = new Vector.<LegendItemUI>();

			Common.each( _data, function( _k:int, _item:Object ):void{
				
				var _styles:Object = {};
				_styles = Common.extendObject( 
					DefaultOptions.title.style
					, DefaultOptions.legend.itemStyle
				);
				
				_styles.color = BaseConfig.ins.itemColor( _k, false );
				
				_styles = Common.extendObject( _styles, BaseConfig.ins.legendItemStyle );
				
				addChild( _tmp = new LegendItemUI( 'name' in _item ? _item : { name : _item }, _styles ) );
				_tmp.addEventListener( JChartEvent.UPDATE_STATUS, onUpdateStatus );
				
				if( _isVertical ) { /* 纵向 */
					_x = putVerticalLegend( _tmp, _x );
				} else { /* 横向 */
					_x = putTransverseLegend( _tmp, _x );
				}
				
				if( _k in BaseConfig.ins.filterData ){
					_tmp.toggle();
				} 
				_tmp.width > _maxWidth && ( _maxWidth = _tmp.width );
				_tmp.height > _maxHeight && ( _maxHeight = _tmp.height );

			});
			
		}
		
		protected function putVerticalLegend( _legend:LegendItemUI, _point:Number ):Number{
			_legend.y = _point;
			_items.push( _legend );
			return _point + _interval + _legend.height;
		}
		
		protected function putTransverseLegend( _legend:LegendItemUI, _point:Number ):Number{
			_legend.x = _point;
			_items.push( _legend );
			return _point + _interval + _legend.width
		}
		
		protected function onUpdateStatus( _evt:JChartEvent ):void{
			var _selected:Boolean = _evt.data as Boolean
				, _filterObject:Object = {}
				;
			
			Common.each( _items, function( _k:int, _item:LegendItemUI ):void{
				_item.selected && ( _filterObject[ _k ] = _k );
			});
			
			dispatchEvent( new JChartEvent( JChartEvent.FILTER_DATA, _filterObject ) );
		}
		
		protected function updateLegendArrow( _evt:JChartEvent ):void{
			
		}
		
		protected function hideLegendArrow( _evt:JChartEvent ):void{
			
		}

	}
}