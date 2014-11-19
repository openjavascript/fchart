package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.ui.HistogramUI;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class VHistogramUI extends JSprite
	{
		private var _x:Number, _y:Number, _w:Number, _h:Number;
		private var _color:Number;
		private var _maxX:Number;
		private var _duration:Number = .75;
		private var _delay:Number = 0;
		public var count:Number = 0;
		
		public function VHistogramUI( 
			_x:Number, _y:Number
			, _w:Number, _h:Number
			, _color:uint
			, _data:Object = null
		) {
			
			_data = _data || {};
			super( _data );
			
			this._x = _x;
			this._y = _y;
			this._w = _w;
			this._h = _h;
			this._maxX = _x + _w;
			this._color = _color;
			
			( 'duration' in _data ) &&  ( _duration = _data.duration );　 
			( 'delay' in _data ) &&  ( _delay = _data.delay );
			
			init();
		}
		
		private function init():void{
			
			if( _w > 0 && _h > 0 ){
				graphics.beginFill( _color, 1 );
				
				if( data.animationEnabled ){
					animationDraw();
				}else{
					staticDraw();
				}
			}
		}
		
		private function staticDraw():void{
			this.x = _x;
			this.y = _y;
			graphics.drawRect( 0, 0, _w, _h );
		}
		
		private function animationDraw():void{

			var _ins:VHistogramUI = this;
			
			_ins.count = 0;
			_ins.y = _y;
			
			TweenLite.delayedCall( _delay, function():void{
				
				if( data.isNegative ){
					_ins.x = _maxX;				
					TweenLite.to( _ins, _duration, { count: _w, ease:Circ.easeInOut
						, onUpdate: 
						function():void{
							graphics.clear();
							graphics.beginFill( _color, 1 );
							graphics.drawRect( 0, 0, count, _h );
							_ins.x = _maxX - count;
						}
					} );
				} else {
					_ins.x = _x;
					TweenLite.to( _ins, _duration, { count: _w, ease:Circ.easeInOut
						, onUpdate: 
						function():void{
							graphics.clear();
							graphics.beginFill( _color, 1 );
							graphics.drawRect( 0, 0, count, _h );
						}
					} );
				}		
			});
		}
	}
}