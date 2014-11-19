package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.DSprite;
	import com.greensock.TweenLite;
 
	public class VHistogramBgLineView extends BaseBgLineView
	{
		private var _hboldLine:Sprite;
		private var _vsideLine:Sprite;
		
		public function VHistogramBgLineView()
		{
			super();
		}
		
		override protected function update( _evt:JChartEvent ):void{			
			super.update( _evt );			
		}
		
		override protected function drawHLine():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.vpoint )  ) return;
			
			if( !BaseConfig.ins.hlineEnabled ) {
				addChildAt( _hboldLine = new Sprite(), 0 );
				_hboldLine.graphics.lineStyle( 1, 0x999999, .35 );
				_hboldLine.graphics.moveTo( BaseConfig.ins.c.minX, BaseConfig.ins.c.maxY );
				_hboldLine.graphics.lineTo( BaseConfig.ins.c.minX, BaseConfig.ins.c.minY  );
				return;	
			}
			
			Common.each( BaseConfig.ins.c.vpointReal, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point
				, _sy:Number = _sp.y, _ey:Number = _ep.y
				;
				
				var _ele:DSprite = new DSprite();
				
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );
				
				var _delay:Number = 0;
				
				BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
				
				if( BaseConfig.ins.animationEnabled ){
					_ele.max = Math.ceil( _ey - _sy );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{		
						TweenLite.to( _ele, BaseConfig.ins.animationDuration
							, { 
								count: _ele.max
								, onUpdate: function():void{
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _sp.x, _ey );
									_ele.graphics.lineTo( _ep.x, _ey - _ele.count );
								}
							} );
					});
					
				} else {
					_ele.graphics.moveTo( _sp.x, _sp.y );
					_ele.graphics.lineTo( _ep.x, _ep.y );
				}
				
			});
		}
		
		override protected function drawVLine():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hlinePoint )  ) return;
			if( 
				( 
					!BaseConfig.ins.vlineEnabled 
					&& !BaseConfig.ins.hlineEnabled 
					&& BaseConfig.ins.yAxisEnabled
				)
				|| BaseConfig.ins.vsideLineEnabled
			) {
				addChildAt( _vsideLine = new Sprite(), 0 );
				_vsideLine.graphics.lineStyle( 1, 0x999999, .35 );
				
				_vsideLine.graphics.moveTo( BaseConfig.ins.c.chartX - 10
					, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight  );
				
				_vsideLine.graphics.lineTo( BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth 
					, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight );
			}
			
			if( 
				( 
					!BaseConfig.ins.vlineEnabled 
					&& !BaseConfig.ins.hlineEnabled 
					&& BaseConfig.ins.yAxisEnabled
				)
			) {
				
				Common.each( BaseConfig.ins.c.vpointReal, function( _k:int, _item:Object ):void{
					var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _sp.x, _ex:Number = BaseConfig.ins.c.chartX
					;
					if( !BaseConfig.ins.yAxisEnabled ){
						_sx += BaseConfig.ins.c.arrowLength - 2;
					}
					
					graphics.moveTo( _sp.x, _ep.y - BaseConfig.ins.c.arrowLength );
					graphics.lineTo( _ep.x, _ep.y );
				});
			}
			
			if( !BaseConfig.ins.vlineEnabled ) return;
			
			var _delay:Number = 0;
			BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
			
			Common.each( BaseConfig.ins.c.hlinePoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );				
				
				if( BaseConfig.ins.animationEnabled ){
					_ele.max = Math.ceil( _ep.x - _sp.x );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, BaseConfig.ins.animationDuration
							, { 
								count: _ele.max
								
								, onUpdate: function():void{
									
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _sp.x, _ep.y );
									_ele.graphics.lineTo( _sp.x + _ele.count, _ep.y );
								}
							} );
					});
				}else{
					_ele.graphics.moveTo( _sp.x, _sp.y );
					_ele.graphics.lineTo( _ep.x, _ep.y );
				}
			});
		}
		
		override protected function drawLineArrow():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hpoint )  ) return;
			if( !BaseConfig.ins.vlineEnabled ) return;
			
			var _delay:Number = 0;
			BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
			
			Common.each( BaseConfig.ins.c.hpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				if( !BaseConfig.ins.displayAllLabel ){
					if( !( _k in BaseConfig.ins.labelDisplayIndex ) ){
						return;
					}
				}
				
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );
				
				if( BaseConfig.ins.animationEnabled ){
					_ele.max = Math.ceil( _ep.y - _sp.y );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, BaseConfig.ins.animationDuration
							, { 
								count: _ele.max
								, onUpdate: function():void{
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _sp.x, _sp.y );
									_ele.graphics.lineTo( _ep.x, _ep.y );
								}
							});
					});
					
				}else{
					_ele.graphics.moveTo( _sp.x, _sp.y );
					_ele.graphics.lineTo( _ep.x, _ep.y );
				}
				
//				graphics.moveTo( _sp.x, _sp.y );
//				graphics.lineTo( _ep.x, _ep.y );
				
			});	
		}
	}
}