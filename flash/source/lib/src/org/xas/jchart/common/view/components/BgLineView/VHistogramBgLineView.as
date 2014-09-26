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
 
	public class VHistogramBgLineView extends BaseBgLineView
	{
		private var _hboldLine:Sprite;
		private var _vboldLine:Sprite;
		
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
				, _sx:Number = _sp.x, _ex:Number = _ep.x
				;
				
				graphics.moveTo( _sx, _sp.y );
				graphics.lineTo( _ex, _ep.y  );
				
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
				|| BaseConfig.ins.vboldLineEnabled
			) {
				addChildAt( _vboldLine = new Sprite(), 0 );
				_vboldLine.graphics.lineStyle( 1, 0x999999, .35 );
				
				_vboldLine.graphics.moveTo( BaseConfig.ins.c.chartX - 10
					, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight  );
				
				_vboldLine.graphics.lineTo( BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth 
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
			
			Common.each( BaseConfig.ins.c.hlinePoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});	
		}
		
		override protected function drawLineArrow():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hpoint )  ) return;
			if( !BaseConfig.ins.vlineEnabled ) return;
			
			Common.each( BaseConfig.ins.c.hpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				if( !BaseConfig.ins.displayAllLabel ){
					if( !( _k in BaseConfig.ins.labelDisplayIndex ) ){
						return;
					}
				}
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});	
		}
	}
}