package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.data.line.BaseLineData;
	import org.xas.jchart.common.ui.widget.*;
	
	public class RadarBgLineView extends BaseBgLineView
	{
		private var _items:Vector.<DSprite>;
		private var _preIndex:int = -1;
		private var _config:Config;
		
		private var _linedata:BaseLineData;
		
		private var _baseBg:JSprite;
		
		public function RadarBgLineView()
		{
			super();
			
			_config = BaseConfig.ins as Config;
			
			_linedata = new BaseLineData();
				
			_items = new Vector.<DSprite>();
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			super.update( _evt );				
		}
		
		//横线
		override protected function drawHLine():void {
			if( !( _config.c && _config.c.radarBgPoint )  ) return;
			
			var _ele:DSprite = new DSprite()
				, _animationEnabled:Boolean = _config.animationEnabled
				, _delay:Number = 0;
			
			_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
			
			Common.each( _config.c.radarBgPoint, function( _i:Number, _list:Vector.<Point> ):void {
				
				_ele.graphics.lineStyle( 1, 0x999999, .35 );
				_ele.graphics.beginFill( 
					_i % 2 == 0 ? 0xf9f9f9 : 0xe6e6e6
					, 1
				);
				_ele.mouseEnabled = false;
				
				Common.each( _list, function( _idx:Number, _item:Point ):void {
					if( _idx === 0 ) {
						_ele.graphics.moveTo( _item.x, _item.y );
					}
					_ele.graphics.lineTo( _item.x, _item.y );
				});
				_ele.graphics.lineTo( _list[0].x, _list[0].y );
				
				if( _animationEnabled ) {
					_ele.alpha = 0;
					_ele.count = 0;
					TweenLite.delayedCall( 0, function():void {
						TweenLite.to( _ele, _config.animationDuration
							, {
								count: 100
								, ease: Expo.easeIn
								, onUpdate: function():void{
									_ele.alpha = _ele.count / 100;
								}
							} );
					} );
				}
				
				addChild( _ele );
				
			} );
		}
		
		//竖线
		override protected function drawVLine():void {
			if( !( _config.c && _config.c.radarBgPoint )  ) return;
			
			var _cPoint:Point = _config.c.centerPoint;
			
			var _outPoints:Vector.<Point> = _config.c.radarBgPoint[ 0 ];
			
			if( _config.animationEnabled ) {
				
				Common.each( _outPoints, function( _i:Number, _item:Point ):void {
					var _ele:DSprite = new DSprite();
					_ele.max = Math.ceil( GeoUtils.pointLength( _cPoint.x, _cPoint.y, _item.x, _item.y ) );
					_ele.count = 0;
					
					addChild( _ele );
					
					_items.push( _ele );
					
					var _angle:Number = GeoUtils.pointAngle( _cPoint, _item );
					
					TweenLite.delayedCall( 0, function():void {
						TweenLite.to( _ele, _config.animationDuration
							, { 
								count: _ele.max
								, ease: Expo.easeIn
								, onUpdate: function():void{
									_ele.graphics.clear();
									_ele.graphics.lineStyle( 1, 0x999999, .35 );
									_ele.graphics.moveTo( _cPoint.x, _cPoint.y );
									_ele.graphics.lineTo( 
										_cPoint.x + _ele.count * Math.cos( _angle * Math.PI/180 )
										, _cPoint.y + _ele.count * Math.sin( _angle * Math.PI/180 )
									);
								}
							} );
					} );
				} );
			} else {
				Common.each( _outPoints, function( _i:Number, _item:Point ):void {
					
					var _ele:JSprite = new JSprite();
					
					_ele.graphics.lineStyle( 1, 0x999999, .35 );
					_ele.graphics.moveTo( _item.x, _item.y );
					_ele.graphics.lineTo( _cPoint.x, _cPoint.y );
					
					addChild( _ele );
				} );
			}
		}
		
		override protected function drawLineArrow():void{}
		
		private function showTips( _evt: JChartEvent ):void {}
		
		private function hideTips( _evt: JChartEvent ):void {
			
//			if( _preIndex >= 0 ){
//				TweenLite.to( _items[ _preIndex ], _config.animationDuration, {
//					alpha: 1
//					, ease: Expo.easeOut 
//				} );
//			}
			
			if( _preIndex >= 0 ) {
				var _it:DSprite = _items[ _preIndex ];
				var colorInfo:ColorTransform = _it.transform.colorTransform;
				colorInfo.color = 0x999999; 
				_it.transform.colorTransform = colorInfo;
			}
			
			_preIndex = -1;
		}		
		
		private function updateTips( _evt: JChartEvent ):void {
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;
			
			if( !( _items && _items.length ) ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ) {
				
				var _it:DSprite = _items[ _preIndex ];
				var colorInfo:ColorTransform = _it.transform.colorTransform;
				colorInfo.color = 0x999999; 
				_it.transform.colorTransform = colorInfo;
				
//				TweenLite.to( _items[ _preIndex ], _config.animationDuration, {
//					alpha: 1
//					, ease: Expo.easeOut 
//				} );
			}
			
			var _it2:DSprite = _items[ _ix ];
			var colorInfo2:ColorTransform = _it2.transform.colorTransform;
			colorInfo2.color = 0x000000; 
			_it2.transform.colorTransform = colorInfo2;
			
//			TweenLite.to( _items[ _ix ], _config.animationDuration, {
//				alpha: 5
//				, ease: Expo.easeOut 
//			} );
			
			_preIndex = _ix;
		}
	}
}