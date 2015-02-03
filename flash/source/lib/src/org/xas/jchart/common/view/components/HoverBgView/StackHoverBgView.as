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

	public class StackHoverBgView extends BaseHoverBgView
	{
		private var _config:Config;
		
		public function StackHoverBgView()
		{			
			super();
			
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function update( _evt:JChartEvent ):void{
			
			//Log.log( 'StackHoverBgView' );
			graphics.clear();
			
			if( !( _config.c && _config.c.dataRect ) ) return;
			_boxs = new Vector.<Sprite>();
			
			Common.each( _config.c.stackItems, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite()
					, _bgColor:uint = 0xF0F0F0
					, _borderColor:uint = 0xB4B4B4
					, _borderWidth:uint = 2
					, _y:Number
					, _h:Number
					, _pad:Number = 15
					;
				
				( 'bgColor' in _config.hoverBgStyle ) && ( _bgColor = _config.hoverBgStyle.bgColor );
				( 'borderColor' in _config.hoverBgStyle ) && ( _borderColor = _config.hoverBgStyle.borderColor );
				( 'borderWidth' in _config.hoverBgStyle ) && ( _borderWidth = _config.hoverBgStyle.borderWidth );
				
				_box.graphics.beginFill( _bgColor );
				_box.graphics.lineStyle( _borderWidth, _borderColor );
				
				if( _item.realWidth && _item.height ){
					_y = _item.y;
					_h = _item.height;
					
					if( _item.hasPositive ){
						if( _y  - _pad >= _config.c.chartY ){
							_h += _pad;
							_y -= _pad;
						}else{
							_h = _h + ( _y - _config.c.chartY );
							_y = _config.c.chartY;
						}
					}
					
					if( _item.hasNegative ){
						_h += _pad;
						if( _y + _h > _config.c.chartY + _config.c.chartHeight ){
							_h = _config.c.chartY + _config.c.chartHeight - _y;
						}
					}
					
					_box.graphics.drawRect( 
						_item.realX
						, _y
						, _item.realWidth
						, _h 
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