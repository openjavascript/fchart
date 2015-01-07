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

	public class HistogramBgLineView extends BaseBgLineView
	{
		private var _hboldLine:Sprite;
		private var _vsideLine:Sprite;
		
		private var _hlineLs:Vector.<DSprite>;
		private var _vlineLs:Vector.<DSprite>;
		
		private var _config:Config;
		
		public function HistogramBgLineView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function update( _evt:JChartEvent ):void{			
			super.update( _evt );			
		}
		//横线
		override protected function drawHLine():void{
			if( !( BaseConfig.ins.c && _config.c.vpoint )  ) return;
			
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
			
			_hlineLs = new Vector.<DSprite>;
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				
				var _ele:DSprite = new DSprite();
				
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point
				, _sx:Number = _startX, _ex:Number = _ep.x
				;
				if( !_config.yAxisEnabled ){
//					_sx += _config.c.arrowLength - 2;
				}
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
			if( !( _config.c && _config.c.hlinePoint )  ) return;
			var _endY:Number = _config.c.chartY + _config.c.chartHeight + 1, _tmpY:Number = _endY, _plus:Number = 1;
			if( _config.xAxisEnabled ){
				_tmpY += _config.xArrowLength;
			}
				
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
				_vsideLine.graphics.moveTo( _config.c.chartX, _config.c.chartY  );
				_vsideLine.graphics.lineTo( _config.c.chartX, _tmpY );
				return;
			}
			
			if( 
				( 
					!_config.vlineEnabled 
					&& !_config.hlineEnabled 
					&& _config.yAxisEnabled
				)
			) {
				_vlineLs = new Vector.<DSprite>;
				
				Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
					var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _sp.x, _ex:Number = _sx
					;
					if( !_config.xAxisEnabled ){
//						_sx += _config.c.arrowLength - 2;
					}
					
					graphics.moveTo( _sx, _sp.y );
					graphics.lineTo( _ex, _endY );
				});
			}
			
			if( !_config.vlineEnabled ) return;
			
			var _delay:Number = 0;
			_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
			
			
			Common.each( _config.c.hlinePoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );				
				
				if( _config.animationEnabled ){
					_ele.max = Math.ceil( _endY - _sp.y );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, _config.animationDuration
							, { 
								count: _ele.max
								//, ease: Expo.easeIn
								, onUpdate: function():void{
									//Log.log( _ele.count );
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _sp.x, _ep.y + _plus );
									_ele.graphics.lineTo( _sp.x, _ep.y + _plus- _ele.count );
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
			if( !( _config.c && _config.c.hpoint )  ) return;
			if( !_config.vlineEnabled ) return;

			var _endY:Number = _config.c.chartY + _config.c.chartHeight;
			if( _config.xAxisEnabled ){
				_endY += _config.xArrowLength;
			}
			
			var _delay:Number = 0;
			_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
			
			Common.each( _config.c.hpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				if( !_config.displayAllLabel ){
					if( !( _k in _config.labelDisplayIndex ) ){
						return;
					}
				}
				if( !_config.displayAllLabel ){
					if( ( _k in _config.labelDisplayIndex ) ){
						_ep.y = _endY;	
					}
				}else{
					_ep.y = _endY;	
				}
				
				
				var _ele:DSprite = new DSprite();
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				addChild( _ele );				
				
				if( _config.animationEnabled ){
					_ele.max = Math.ceil( _ep.y - _sp.y );
					_ele.count = 0;
					
					TweenLite.delayedCall( _delay, function():void{						
						TweenLite.to( _ele, _config.animationDuration
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