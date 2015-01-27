package org.xas.jchart.common.view.components.HoverBgView
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.HistogramUI;

	public class HStackHoverBgView extends BaseHoverBgView
	{
		private var _config:Config;
		
		public function HStackHoverBgView()
		{			
			super();
			
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function update( _evt:JChartEvent ):void{
			
//			Log.log( 'StackHoverBgView' );
			graphics.clear();
			
			if( !( _config.c && _config.c.stackItems ) ) return;
			_boxs = new Vector.<Sprite>();
//			Log.log( 1111111111 );
			
			Common.each( _config.c.stackItems, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite()
					, _bgColor:uint = 0xF0F0F0
					, _borderColor:uint = 0xB4B4B4
					, _borderWidth:uint = 2
					, _x:Number
					, _w:Number
					, _pad:Number = 15
					;
				
				( 'bgColor' in _config.hoverBgStyle ) && ( _bgColor = _config.hoverBgStyle.bgColor );
				( 'borderColor' in _config.hoverBgStyle ) && ( _borderColor = _config.hoverBgStyle.borderColor );
				( 'borderWidth' in _config.hoverBgStyle ) && ( _borderWidth = _config.hoverBgStyle.borderWidth );
				
				_box.graphics.beginFill( _bgColor );
				_box.graphics.lineStyle( _borderWidth, _borderColor );
				
				if( _item.realWidth && _item.height ){
					_x = _item.x;
					_w = _item.width;
					
					if( _item.hasPositive ){
						_w += _pad;
						if( _x + _w > _config.c.chartX + _config.c.chartWidth ){
							_w = _config.c.chartX + _config.c.chartWidth - _x;
						}
					}
					
					if( _item.hasNegative ){
						if( _x - _pad >= _config.c.chartX ){
							_w += _pad;
							_x -= _pad;
						}else{
							_w = _w + ( _x - _config.c.chartX );
							_x = _config.c.chartX;
						}
					}
					
					_box.graphics.drawRect( 
						_x
						, _item.y
						, _w
						, _item.height
					);
				}
				
					
				_box.visible = false;

				_boxs.push( _box );
				addChild( _box );
			});
		}
		
		override protected function showTips( _evt: JChartEvent ):void{
		}
		
		override protected function hideTips( _evt: JChartEvent ):void{	
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].visible = false;
			}
			_preIndex = -1;
		}		
		
		override protected function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			if( !_boxs[ _ix ] ) return;
			
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].visible = false;
			}
			
			_boxs[ _ix ].visible = true;
			_preIndex = _ix;
		}
		
	}
}