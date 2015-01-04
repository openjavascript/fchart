package org.xas.jchart.vzhistogram.view.components
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Linear;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
	import org.xas.jchart.common.ui.VHistogramUI;
	import org.xas.jchart.common.ui.ZHistogramUI;
	import org.xas.jchart.common.ui.widget.DSprite;
	import org.xas.jchart.common.ui.widget.JLine;
	import org.xas.jchart.common.ui.widget.JSprite;
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
			
			var _delay:Number = 0
				, animateEnable:Boolean = BaseConfig.ins.animationEnabled;
			BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
			
			Common.each( BaseConfig.ins.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				var _totalHeight:Number = 0;
				var _totalWidth:Number = 0;
				var _startX:Number = 0;
				var _startY:Number = 0;
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					if( _sk == 0 ) {
						_startX = _sitem.x;
						_startY = _sitem.y;
						_totalHeight = _sitem.height;
					}
					_totalWidth += _sitem.width;
					
					var _color:uint = BaseConfig.ins.itemColor( _sk );
					if( _sitem.value == BaseConfig.ins.maxValue ){
						if( 'style' in BaseConfig.ins.maxItemParams && 'color' in BaseConfig.ins.maxItemParams.style ){
							_color = BaseConfig.ins.maxItemParams.style.color;
						}
					}
					
					var _item:VHistogramUI = new VHistogramUI(
						_sitem.x, _sitem.y
						, _sitem.width, _sitem.height
						, _color
						, { animationEnabled: false }
					);
					_item.mouseEnabled = false;
					_box.addChild( _item );
				});
				
				_boxs.push( _box );
				
				if( animateEnable ){
					_totalWidth += 1;
					var _mask:DSprite = new DSprite( { count: 0 } );

					_mask.x = _startX;
					_mask.y = _startY;
					
					_box.mask = _mask;
					addChild( _mask );
					_mask.count = 0;
					
					
					TweenLite.delayedCall( _delay, function():void{
						TweenLite.to( _mask, BaseConfig.ins.animationDuration, { count: _totalWidth
							, ease:Circ.easeInOut
							, onUpdate: function():void{
									
								_mask.graphic
								_mask.graphics.beginFill( 0xff0000 );
								_mask.graphics.drawRect( 
									0, 0
									, _mask.count
									, _totalHeight
								);
								
								if( _mask.count == _totalWidth ){
									_mask.parent && _mask.parent.removeChild( _mask );
								}
							}
						} );
					} );
				}
				
				addChild( _box );
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
				, _ix:int = _evt.data.index as int;
			
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