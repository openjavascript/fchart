package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.*;
	
	public class CurveGramBgLineView extends BaseBgLineView
	{
		private var _items:Vector.<VLineIcon>;
		public function get items():Vector.<VLineIcon>{ return _items; }
		private var _preIndex:int = -1;
		private var _config:Config;
		
		private var _hboldLine:Sprite;
		private var _vsideLine:Sprite;
		
		public function CurveGramBgLineView()
		{
			super();
			
			_config = BaseConfig.ins as Config;
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			super.update( _evt );				
		}
		//横线
		override protected function drawHLine():void{
			if( !( _config.c && _config.c.vpoint )  ) return;
			var _startX:Number = _config.c.chartX;
			if( _config.yAxisEnabled ){
				_startX -= _config.yArrowLength;
			}
						
			if( !_config.hlineEnabled ) {
				addChildAt( _hboldLine = new Sprite(), 0 );
				_hboldLine.graphics.lineStyle( 1, 0x999999, .35 );
				_hboldLine.graphics.moveTo( _startX, _config.c.chartY + _config.c.chartHeight );
				_hboldLine.graphics.lineTo( _config.c.chartX + _config.c.chartWidth, _config.c.chartY + _config.c.chartHeight );
				return;	
			}	
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point
				, _sx:Number = _startX, _ex:Number = _ep.x
				;
				var _ele:DSprite = new DSprite();
				
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );
				
				var _delay:Number = 0;
				_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
				
				if( _config.animationEnabled ){
					_ele.max = Math.ceil( _ex - _sx );
					_ele.count = 0;
					
					//Log.log( _ele.max, _ep.x, _sp.x );
					TweenLite.delayedCall( _delay, function():void{		
						TweenLite.to( _ele, _config.animationDuration
							, { 
								count: _ele.max
								//, ease: Expo.easeIn
								, onUpdate: function():void{
									//Log.log( _ele.count );
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _sx, _sp.y );
									_ele.graphics.lineTo( _sx + _ele.count, _ep.y );
								}
							} );
					});
					
				}else{
					_ele.graphics.moveTo( _sx, _sp.y );
					_ele.graphics.lineTo( _ex, _ep.y );
				}
				
			});
		}
		//竖线
		override protected function drawVLine():void{
			var _endY:Number = _config.c.chartY + _config.c.chartHeight + 1;
			if( _config.xAxisEnabled ){
				_endY += _config.xArrowLength;
			}
			
			if( !( _config.c && _config.c.hpointReal )  ) return;
			if( 
				( 
					!_config.vlineEnabled 
					&& !_config.hlineEnabled 
					&& _config.yAxisEnabled
				)
				|| _config.vsideLineEnabled
			) {
				addChildAt( _vsideLine = new Sprite(), 0 );
				_vsideLine.graphics.lineStyle( 1, 0x999999, .35 );
				_vsideLine.graphics.moveTo( _config.c.chartX, _config.c.chartY );
				_vsideLine.graphics.lineTo( _config.c.chartX, _endY );
				return;
			}
			
			if( 
				( 
					!_config.vlineEnabled 
					&& !_config.hlineEnabled 
					&& _config.yAxisEnabled
				)
			) {
				Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
					var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _sp.x, _ex:Number = _sx
					;
					if( !_config.yAxisEnabled ){
					}
					
					graphics.moveTo( _sx, _sp.y );
					graphics.lineTo( _ex, _endY );
				});
			}
			
			_items = new Vector.<VLineIcon>;
			if( !_config.vlineEnabled ) return;
			Common.each( _config.c.hpointReal, function( _k:int, _item:Object ):void{
				var _tmp:VLineIcon
				, _hpItem:Object = _item
				, _sp:Point =_item.start as Point
				, _ep:Point = ( _hpItem.end as Point ).clone();
				;
				if( !_config.displayAllLabel ){
					if( ( _k in _config.labelDisplayIndex ) ){
						_ep.y = _endY;	
					}
				}else{
					_ep.y = _endY;	
				}
				
				addChild( _tmp = new VLineIcon( _sp, _ep ) );
				!_config.vlineEnabled && ( _tmp.visible = false );
				_items.push( _tmp );
				//graphics.moveTo( _sp.x, _sp.y );
				//graphics.lineTo( _ep.x, _ep.y );
			});	
		}
		
		override protected function drawLineArrow():void{
		}
		
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{	
			
			if( _preIndex >= 0 ){
				_items[ _preIndex ].unhover();
				!_config.vlineEnabled && ( _items[ _preIndex ].visible = false );
			}
			_preIndex = -1;
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _items && _items.length ) ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ){
				_items[ _preIndex ].unhover();
				!_config.vlineEnabled && ( _items[ _preIndex ].visible = false );
			}
			_ix >= 0 && _items[ _ix ].hover();
			!_config.vlineEnabled && ( _items[ _ix ].visible = true );
			
			_preIndex = _ix;
			
		}
	}
}