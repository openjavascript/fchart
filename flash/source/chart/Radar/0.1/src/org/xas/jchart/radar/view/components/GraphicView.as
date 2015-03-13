package org.xas.jchart.radar.view.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.RadarUI;
	import org.xas.jchart.common.ui.widget.JFillLine;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<RadarUI>;
		
		private var _config:Config;
		
		public function GraphicView()
		{
			super();
			
			_config = BaseConfig.ins as Config;
			
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
			_boxs = new Vector.<RadarUI>;
			
			if( !( _config.c && _config.c.pathVector && _config.c.pathVector.length ) ) return;
			
			Common.each( _config.c.pathVector, function( _idx:Number, _item:Object ):void {
				var _gitem:RadarUI
				, _vectorPath:Vector.<Point> = _item.path as Vector.<Point>;
				
				addChild(
					_gitem = new RadarUI(
						_config.itemColor( _idx )
						, _vectorPath 
						, _config.lineDashStyle( _item.data )
						, {
							animationEnabled: BaseConfig.ins.animationEnabled
							, duration: BaseConfig.ins.animationDuration + _idx * 0.1
							, delay: 0
							, index: _idx
							, seriesIndex: _idx
							, pointEnabled: BaseConfig.ins.pointEnabled( _item.data )
							, hoverShow: BaseConfig.ins.pointHoverShow( _item.data )
						}
					)
				);
				
				_boxs.push( _gitem );
			} );
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{
		}
		
		private function updateTips( _evt: JChartEvent ):void{
			
		}
		
	}
}
