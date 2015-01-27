package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
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

	public class HStackBgLineView extends BaseBgLineView
	{
		private var _hboldLine:Sprite;
		private var _vsideLine:Sprite;
		
		private var _hlineLs:Vector.<DSprite>;
		private var _vlineLs:Vector.<DSprite>;
		
		public function HStackBgLineView()
		{
			super();
		}
		
		override protected function update( _evt:JChartEvent ):void{			
			super.update( _evt );			
		}
		//横线
		override protected function drawHLine():void{
			if( !( config.c && config.c.vpoint )  ) return;
			
			var _startX:Number = config.c.chartX, _tmp:Number;

			
			if( !config.vlineEnabled ) {
				addChildAt( _hboldLine = new Sprite(), 0 );
				_hboldLine.graphics.lineStyle( 1, 0x999999, .35 );
				_hboldLine.graphics.moveTo( _startX, config.c.chartY + config.c.chartHeight );
				_hboldLine.graphics.lineTo( config.c.chartX + config.c.chartWidth, config.c.chartY + config.c.chartHeight );
				return;	
			}	
			
			_hlineLs = new Vector.<DSprite>;
			
			Common.each( config.c.vpoint, function( _k:int, _item:Object ):void{
				
				var _ele:DSprite = new DSprite()
					,_sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _startX, _ex:Number = _ep.x
					, _delay:Number = 0
					;

				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );
				
				config.xAxisEnabled && ( _delay = config.animationDuration / 2 );
				
				if( config.animationEnabled ){
					_ele.max = Math.ceil( _ex - _sx );
					_ele.count = 0;
					
					//Log.log( _ele.max, _ep.x, _sp.x );
					TweenLite.delayedCall( _delay, function():void{		
						TweenLite.to( _ele, config.animationDuration
							, { 
								count: _ele.max
								//, ease: Expo.easeIn
								, onUpdate: function():void{
									//Log.log( _ele.count );
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _startX, _sp.y );
									_ele.graphics.lineTo( _startX + _ele.count, _ep.y );
								}
							} );
					});
					
				}else{
					_ele.graphics.moveTo( _startX, _sp.y );
					_ele.graphics.lineTo( _ex, _ep.y );
				}
				
				
				_hlineLs.push( _ele );
			});
		}
		//竖线
		override protected function drawVLine():void{
			
			if( !( config.c && config.c.hlinePoint )  ) return;
			var _endY:Number = config.c.chartY + config.c.chartHeight + 1
				, _tmpY:Number = _endY
				, _plus:Number = 1
				, _hboldLine:Sprite
				;
			if( config.yAxisEnabled ){
				_tmpY += config.xArrowLength;
				_endY += config.xArrowLength;
			}
			if( !config.hlineEnabled ) {
				addChildAt( _hboldLine = new Sprite(), 0 );
				_hboldLine.graphics.lineStyle( 1, 0x999999, .35 );
				_hboldLine.graphics.moveTo( config.c.chartX, _tmpY );
				_hboldLine.graphics.lineTo( config.c.chartX, config.c.chartY );
				return;	
			}	
				
			if( 
				( 
					!config.vlineEnabled 
						&& !config.hlineEnabled 
						&& config.xAxisEnabled
				)
				|| config.vsideLineEnabled
			) {
				addChildAt( _vsideLine = new Sprite(), 0 );
				_vsideLine.graphics.lineStyle( 1, 0x999999, .35 );
				_vsideLine.graphics.moveTo( config.c.chartX, config.c.chartY  );
				_vsideLine.graphics.lineTo( config.c.chartX, _tmpY );
				return;
			}
			
			if( 
				( 
					!config.vlineEnabled 
					&& !config.hlineEnabled 
					&& config.xAxisEnabled
				)
			) {
				_vlineLs = new Vector.<DSprite>;
				
				Common.each( config.c.vpoint, function( _k:int, _item:Object ):void{
					var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _sp.x, _ex:Number = _sx
					;
					if( !config.xAxisEnabled ){
//						_sx += config.c.arrowLength - 2;
					}
					
					graphics.moveTo( _sx, _sp.y );
					graphics.lineTo( _ex, _endY );
				});
			}
			
			if( !config.hlineEnabled ) return;
			
			var _delay:Number = 0;
			config.xAxisEnabled && ( _delay = config.animationDuration / 2 );
			
		
			Common.each( config.c.hlinePoint, function( _k:int, _item:Object ):void{
				if( _k >= config.realItemLength ) return;
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );				
				
				if( config.animationEnabled ){
					_ele.max = Math.ceil( _endY - _sp.y );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, config.animationDuration
							, { 
								count: _ele.max
								//, ease: Expo.easeIn
								, onUpdate: function():void{
									//Log.log( _ele.count );
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _sp.x, _endY );
									_ele.graphics.lineTo( _sp.x, _endY - _ele.count );
								}
							} );
					});
					
				}else{
					_ele.graphics.moveTo( _sp.x, _sp.y );
					_ele.graphics.lineTo( _ep.x, _endY );
				}
				
			});	
		}
		
		override protected function drawLineArrow():void{
			if( !( config.c && config.c.varrowPoint )  ) return;
//			if( !config.vlineEnabled ) return;
			if( !config.xAxisEnabled ) return;
			
			var _delay:Number = 0;
			config.xAxisEnabled && ( _delay = config.animationDuration / 2 );
			
			Common.each( config.c.varrowPoint, function( _k:int, _item:Object ):void{
				if( _k >= config.realItemLength ) return;
				var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _sp.x
					, _ex:Number = _ep.x
					;
				
				if( !config.displayAllLabel ){
					if( !( _k in config.labelDisplayIndex ) ){
						return;
					}
				}
		
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );				
				
				if( config.animationEnabled ){
					_ele.max = Math.ceil( _ep.x - _sp.x );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, config.animationDuration
							, { 
								count: _ele.max
								//, ease: Expo.easeIn
								, onUpdate: function():void{
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _sp.x, _sp.y );
									_ele.graphics.lineTo( _ep.x, _ep.y );
								}
							} );
					});
					
				}else{
					_ele.graphics.moveTo( _sp.x, _sp.y );
					_ele.graphics.lineTo( _ep.x, _ep.y );
				}
				
			});	
		}
	}
} 