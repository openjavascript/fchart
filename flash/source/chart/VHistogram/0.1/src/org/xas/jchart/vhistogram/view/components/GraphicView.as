package org.xas.jchart.vhistogram.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.VHistogramUI;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<Sprite>;
		private var _preIndex:int = -1;
		
		public function GraphicView()
		{
			super(); 
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			addEventListener( JChartEvent.UPDATE, update );
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		private function addToStage( _evt:Event ):void{
		}

		private function update( _evt:JChartEvent ):void{
			
			graphics.clear();
			
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.rects ) ) return;
			_boxs = new Vector.<Sprite>();
			
			var _delay:Number = 0;
			BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
			
			var _itemStyle:Array = BaseConfig.ins.getItemStyle();
			
			Common.each( BaseConfig.ins.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
							
					var _color:uint = BaseConfig.ins.itemColor( _sk );
					
					if( _itemStyle[ _k ] && 'color' in _itemStyle[ _k ] ) {
						_color = _itemStyle[ _k ].color;
					}
					
					if( _sitem.value == BaseConfig.ins.maxValue ){
						
						if( 'style' in BaseConfig.ins.maxItemParams && 'color' in BaseConfig.ins.maxItemParams.style ){
							_color = BaseConfig.ins.maxItemParams.style.color;
						}
					}
					
					var _item:VHistogramUI = new VHistogramUI(
						_sitem.x, _sitem.y
						, _sitem.width, _sitem.height
						, _color
						, {
							animationEnabled: BaseConfig.ins.animationEnabled
							, isNegative: _sitem.isNegative
							, duration: BaseConfig.ins.animationDuration
							, delay: _delay
						}
					);
					_item.mouseEnabled = false;
					_box.addChild( _item );
				});
				addChild( _box );
				_boxs.push( _box );
			});
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			_preIndex = -1;
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			if( !_boxs[ _ix ] ) return;
			
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			
			_boxs[ _ix ].alpha = .65;
			_preIndex = _ix;
		}

	}
}