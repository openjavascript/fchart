package org.xas.jchart.curvegram.view.components
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
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<CurveGramUI>;
		private var _preIndex:int = -1;
		
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
			
			if( !( _config.c && _config.c.paths && _config.c.paths.length ) ) return;
			
			graphics.clear();
			_boxs = new Vector.<CurveGramUI>;
			Common.each( _config.c.paths, function( _k:int, _item:Object ):void{
			
				var _cmd:Vector.<int> = _item.cmd as Vector.<int>
					, _path:Vector.<Number> = _item.path as Vector.<Number>
					, _gitem:CurveGramUI
					, _vectorPath:Vector.<Point> = _config.c.vectorPaths[ _k ] as Vector.<Point>
					;
				
				addChild( 
					_gitem = new CurveGramUI( 
						_cmd
						, _path
						, _config.itemColor( _k )
						, _vectorPath 
						, _config.lineDashStyle( _item.data )
					) 
				);
				_boxs.push( _gitem );
			});
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{	
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
					_boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			_preIndex = -1;
			
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
					_preIndex >= 0 && _boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
				_ix >= 0 && _boxs[ _k ].items[ _ix ].hover();
			});
			
			_preIndex = _ix;
		}
		
	}
}