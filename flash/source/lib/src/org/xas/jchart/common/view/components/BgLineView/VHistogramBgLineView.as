package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	
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
 
	public class VHistogramBgLineView extends BaseBgLineView
	{
		private var _hboldLine:Sprite;
		private var _vsideLine:Sprite;
		private var _config:Config;
		
		public function VHistogramBgLineView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function update( _evt:JChartEvent ):void{			
			super.update( _evt );			
		}
		
		//竖线
		override protected function drawHLine():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.vpoint )  ) return;
			
			if( !_config.hlineEnabled ) {
				addChildAt( _hboldLine = new Sprite(), 0 );
				_hboldLine.graphics.lineStyle( 1, 0x999999, .35 );
				_hboldLine.graphics.moveTo( _config.c.chartX, _config.c.chartY + _config.c.chartHeight + _config.xArrowLength );
				_hboldLine.graphics.lineTo( _config.c.chartX, _config.c.chartY  );
				return;	
			}
			
			Common.each( _config.c.vpointReal, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point
				, _sy:Number = _sp.y, _ey:Number = _ep.y
				;
				
				if( _config.vlineEnabled && _config.yAxisEnabled ){
					_ey += _config.xArrowLength;
				}
				
				var _ele:DSprite = new DSprite();
				
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );
				
				var _delay:Number = 0;
				
				_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
				
				if( _config.animationEnabled ){
					_ele.max = Math.ceil( _ey - _sy );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{		
						TweenLite.to( _ele, _config.animationDuration
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
					_ele.graphics.moveTo( _sp.x, _sy );
					_ele.graphics.lineTo( _ep.x, _ey );
				}
				
			});
		}
		
		//横线
		override protected function drawVLine():void{
			if( !( _config.c && _config.c.hlinePoint )  ) return;
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
				
				_vsideLine.graphics.moveTo( _config.c.chartX - 10
					, _config.c.chartY + _config.c.chartHeight  );
				
				_vsideLine.graphics.lineTo( _config.c.chartX + _config.c.chartWidth 
					, _config.c.chartY + _config.c.chartHeight );
				return;
			}
			
			if( 
				( 
					!_config.vlineEnabled 
					&& !_config.hlineEnabled 
					&& _config.yAxisEnabled
				)
			) {
				
				Common.each( _config.c.vpointReal, function( _k:int, _item:Object ):void{
					var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _sp.x, _ex:Number = _config.c.chartX
					;
					if( !_config.yAxisEnabled ){
//						_sx += _config.c.arrowLength - 2;
					}
					
					graphics.moveTo( _sp.x, _ep.y );
					graphics.lineTo( _ep.x, _ep.y );
				});
				return;
			}
			
			if( !_config.vlineEnabled ) return;
			
			var _delay:Number = 0;
			_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
			
			Common.each( _config.c.hlinePoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point
				, _endX:Number = _config.c.chartX + _config.c.chartWidth + 1
				;
				
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );				
				
				if( _config.animationEnabled ){
					_ele.max = Math.ceil( _endX - _sp.x );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, _config.animationDuration
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
					_ele.graphics.lineTo( _endX, _ep.y );
				}
			});
		}
		
		override protected function drawLineArrow():void{
			if( !( _config.c && _config.c.hpoint )  ) return;
			if( !_config.vlineEnabled ) return;
			
			var _delay:Number = 0;
			_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
			if( !_config.xAxisEnabled ) return;
			
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point
				, _endY:Number = _config.c.chartY + _config.c.chartHeight + _config.yArrowLength
				, _startX:Number = _config.c.chartX - _config.xArrowLength
				, _endX:Number = _config.c.chartX
				;
				
				if( !_config.displayAllLabel ){
					if( !( _k in _config.labelDisplayIndex ) ){
						return;
					}
				}
				
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );
				
				if( _config.animationEnabled ){
					_ele.max = Math.ceil( _config.xArrowLength );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, _config.animationDuration
							, { 
								count: _ele.max
								, onUpdate: function():void{
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _startX, _sp.y );
									_ele.graphics.lineTo( _endX, _ep.y );
								}
							});
					});
					
				}else{
					_ele.graphics.moveTo( _startX, _sp.y );
					_ele.graphics.lineTo( _endX, _ep.y );
				}
				
//				graphics.moveTo( _sp.x, _sp.y );
//				graphics.lineTo( _ep.x, _ep.y );
				
			});	
			
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point
				, _endY:Number = _config.c.chartY + _config.c.chartHeight + _config.yArrowLength
				, _startX:Number = _config.c.chartX - _config.xArrowLength
				, _endX:Number = _config.c.chartX
				;
			});
		}
	}
}