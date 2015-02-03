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
	import org.xas.jchart.common.ui.widget.JFillLine;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<CurveGramUI>;
		
		private var _preIndex:int = -1;
		private var _nowIndex:int;
		
		private var _config:Config;
				
		private var _seriesAr:Array;
		private var _coordinate:Object;
		
		public function GraphicView( _seriesAr:Array, _coordinate:Object )
		{
			super(); 
			
			_config = BaseConfig.ins as Config;
			this._seriesAr = _seriesAr;
			this._coordinate = _coordinate;
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			addEventListener( JChartEvent.UPDATE, update );
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		private function addToStage( _evt:Event ):void{
		}
		
		private function update( _evt:JChartEvent ):void{
			
			if( !( _coordinate && _coordinate.paths && _coordinate.paths.length ) ) return;
			
			graphics.clear();
			_boxs = new Vector.<CurveGramUI>;
			
			var _delay:Number = 0;
			BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
			
			Common.each( _coordinate.paths, function( _k:int, _item:Object ):void{
				
				var _cmd:Vector.<int> = _item.cmd as Vector.<int>
				, _path:Vector.<Number> = _item.path as Vector.<Number>
				, _gitem:CurveGramUI
				, _vectorPath:Vector.<Point> = _coordinate.vectorPaths[ _k ] as Vector.<Point>
				;
				
				//Log.log( '_item.data.displayIndex:', _item.data.displayIndex );
				if( _config.isFillLine( _item.data ) ){
					addChild( 
						new JFillLine( 
							_vectorPath
							, { 
								thickness: 2
								, lineColor: _config.itemColor( _item.data.displayIndex )
								, fillOpacity: _config.lineFillOpacity( _item.data ) 
								, delayShow: _delay + BaseConfig.ins.animationEnabled
								, animationEnabled: BaseConfig.ins.animationEnabled
								, duration: BaseConfig.ins.animationDuration
								, delay: _delay
								
							}
							, _config.isLineGradient( _item.data )
						) 
					);
				}
				
			});
			
			Common.each( _coordinate.paths, function( _k:int, _item:Object ):void{
				
				var _cmd:Vector.<int> = _item.cmd as Vector.<int>
				, _path:Vector.<Number> = _item.path as Vector.<Number>
				, _gitem:CurveGramUI
				, _vectorPath:Vector.<Point> = _coordinate.vectorPaths[ _k ] as Vector.<Point>
				;
				
				addChild(
					_gitem = new CurveGramUI(
						_cmd
						, _path
						, _config.itemColor( _item.data.displayIndex )
						, _vectorPath 
						, _config.lineDashStyle( _item.data )
						, {
							animationEnabled: BaseConfig.ins.animationEnabled
							, duration: BaseConfig.ins.animationDuration
							, delay: _delay
							, turnColor: true
							, iconRadius: 4
							, index: _item.data.displayIndex
							, seriesIndex: _item.data.displayIndex
							, pointEnabled: BaseConfig.ins.pointEnabled( _item.data )
							, hoverShow: BaseConfig.ins.pointHoverShow( _item.data )

						}
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
					( _k  < _boxs.length ) && _boxs[ _k ] && _boxs[ _k ].items 
					&& ( _preIndex  < _boxs[ _k ].items.length ) && _boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			_preIndex = -1;
			
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;
			
			_nowIndex = _ix;
			
			if( !_boxs || _boxs.length == 0 ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
					
					( _k  < _boxs.length ) && _boxs[ _k ].items  
					&& ( _preIndex < _boxs[ _k ].items.length ) && _boxs[ _k ].items[ _preIndex ].unhover();
					
				});
			}
			Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
				
				( _k  < _boxs.length ) && _boxs[ _k ].items
				&& ( _ix < _boxs[ _k ].items.length ) && _boxs[ _k ].items[ _ix ].hover();
				
			});
			
			_preIndex = _ix;
		}

		

	}
}
