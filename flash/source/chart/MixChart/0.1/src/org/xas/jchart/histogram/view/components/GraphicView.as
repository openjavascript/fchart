package org.xas.jchart.histogram.view.components
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
	import org.xas.jchart.common.ui.HistogramUI;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<Sprite>;
		private var _preIndex:int = -1;
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
			
			//Log.log( [ 'PChartHistogramMediator GraphicView', new Date().getTime() ] );
			graphics.clear();
			
			if( !( _config.c && _coordinate.rects ) ) return;
			_boxs = new Vector.<Sprite>();
			
			var _delay:Number = 0;
			_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
			
			//Log.log( _config.maxValue );
			//Log.printFormatJSON( _coordinate.rects );
			Common.each( _coordinate.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
							
					var _color:uint = _config.itemColor( _sk );
					if( _sitem.value == _config.maxValue ){
						//Log.log( _config.maxValue, _sitem.value );
						if( 'style' in _config.maxItemParams && 'color' in _config.maxItemParams.style ){
							_color = _config.maxItemParams.style.color;
						}
					}
					
					var _item:HistogramUI = new HistogramUI(
						_sitem.x, _sitem.y
						, _sitem.width, _sitem.height
						, _color 
						, {
							animationEnabled: _config.animationEnabled
							, isNegative: _sitem.isNegative
							, duration: _config.animationDuration
							, delay: _delay
							, index: _sk
							, seriesIndex: _k
							, dataIndex: _k
						}
					);
					//_item.mouseEnabled = false;
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