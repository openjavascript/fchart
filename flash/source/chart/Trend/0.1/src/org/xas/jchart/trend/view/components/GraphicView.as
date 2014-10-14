package org.xas.jchart.trend.view.components
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
	import org.xas.jchart.common.ui.CurveGramUI;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<JSprite>;
		private var _preIndex:int = -1;
		
		public function GraphicView()
		{
			super(); 
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
		}
		
		private function addToStage( _evt:Event ):void{
		}

		private function update( _evt:JChartEvent ):void{
			
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.paths && BaseConfig.ins.c.paths.length ) ) return;
			
			graphics.clear();
			_boxs = new Vector.<JSprite>;
			var _box:JSprite = new JSprite();
			_box.graphics.lineStyle(0.5, 0x006aff);
			Common.each( BaseConfig.ins.c.paths, function( _k:int, _item:Object ):void{
				Common.each( _item.position, function( _j:int, _sitem:Object ):void{
					if( _j == 0 ){
						_box.graphics.moveTo( _sitem.x, _sitem.y );
					} else {
						_box.graphics.lineTo( _sitem.x, _sitem.y );
					}
				});
			});
			_boxs.push( _box );
			addChild( _box );
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
		}
		
	}
}