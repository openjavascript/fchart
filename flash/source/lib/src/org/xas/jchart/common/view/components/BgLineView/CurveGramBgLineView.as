package org.xas.jchart.common.view.components.BgLineView
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
		
		override protected function drawHLine():void{
			if( !( _config.c && _config.c.vpoint )  ) return;
			
			if( !BaseConfig.ins.hlineEnabled ) {
				addChildAt( _hboldLine = new Sprite(), 0 );
				_hboldLine.graphics.lineStyle( 1, 0x999999, .35 );
				_hboldLine.graphics.moveTo( BaseConfig.ins.c.chartX, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight );
				_hboldLine.graphics.lineTo( BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight );
				return;	
			}	
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});
		}
		
		override protected function drawVLine():void{
			if( !( _config.c && _config.c.hpointReal )  ) return;
			
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
				_vsideLine.graphics.moveTo( BaseConfig.ins.c.chartX, BaseConfig.ins.c.chartY - 5 );
				_vsideLine.graphics.lineTo( BaseConfig.ins.c.chartX, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight + 5 );
			}
			
			if( 
				( 
					!BaseConfig.ins.vlineEnabled 
					&& !BaseConfig.ins.hlineEnabled 
					&& BaseConfig.ins.yAxisEnabled
				)
			) {
				
				Common.each( BaseConfig.ins.c.vpoint, function( _k:int, _item:Object ):void{
					var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point
					, _sx:Number = _sp.x, _ex:Number = BaseConfig.ins.c.chartX
					;
					if( !BaseConfig.ins.yAxisEnabled ){
						_sx += BaseConfig.ins.c.arrowLength - 2;
					}
					
					graphics.moveTo( _sx, _sp.y );
					graphics.lineTo( _ex, _ep.y );
				});
			}

			_items = new Vector.<VLineIcon>;
			Common.each( _config.c.hpointReal, function( _k:int, _item:Object ):void{
				var _tmp:VLineIcon
				, _hpItem:Object = _item
				, _sp:Point =_item.start as Point
				, _ep:Point = ( _hpItem.end as Point ).clone();
				;
				_ep.y += _config.c.arrowLength;	
				
				if( !BaseConfig.ins.displayAllLabel ){
					if( !( _k in BaseConfig.ins.labelDisplayIndex ) ){
						_ep.y -= _config.c.arrowLength;	
					}
				}
				
				addChild( _tmp = new VLineIcon( _sp, _ep ) );
				!BaseConfig.ins.vlineEnabled && ( _tmp.visible = false );
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
				!BaseConfig.ins.vlineEnabled && ( _items[ _preIndex ].visible = false );
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
				!BaseConfig.ins.vlineEnabled && ( _items[ _preIndex ].visible = false );
			}
			_ix >= 0 && _items[ _ix ].hover();
			!BaseConfig.ins.vlineEnabled && ( _items[ _ix ].visible = true );
			
			_preIndex = _ix;
			
		}
	}
}