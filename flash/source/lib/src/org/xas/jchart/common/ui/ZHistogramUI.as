package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.ui.HistogramUI;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class ZHistogramUI extends HistogramUI
	{
		private var _x:Number, _y:Number, _w:Number, _h:Number;
		private var _color:Number;
		private var _maxY:Number;
		private var _duration:Number = .75;
		private var _data:Object;
		
		public function ZHistogramUI( 
			_x:Number, _y:Number
			, _w:Number, _h:Number
			, _color:uint
			, _duration:Number
			, _data:Object = null
		) {
			this._x = _x;
			this._y = _y;
			this._w = _w;
			this._h = _h;
			this._maxY = _y + _h;
			this._color = _color;
			this._duration = _duration;
			
			this._data = _data || {};
			
			super( _x, _y, _w, _h, _color, _data);
		}
		
		override protected function animationDraw():void{
			var _ins:ZHistogramUI = this;
			
			_ins.count = 0;
			_ins.x = _x;
			
			TweenLite.delayedCall( _data.delay, function():void{
				
				if( data.isNegative ){
					_ins.y = _y;
					TweenLite.to( _ins, _duration, { count: _h, ease:Linear.easeNone
						, onUpdate: 
						function():void{
							graphics.clear();
							graphics.beginFill( _color, 1 );
							graphics.drawRect( 0, 0, _w, count );
						}
					} );
				} else {
					_ins.y = _y;
					TweenLite.to( _ins, _duration, { count: _h, ease:Linear.easeNone
						, onUpdate: 
						function():void{
							graphics.clear();
							graphics.beginFill( _color, 1 );
							graphics.drawRect( 0, 0, _w, count );
							_ins.y = _maxY - count;
						}
					} );
				}		
			});
		}
		
	}
}