package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class HistogramUI extends JSprite
	{
		private var _x:Number, _y:Number, _w:Number, _h:Number;
		private var _color:Number;
		private var _maxY:Number;
		public var count:Number = 0;
		private var _duration:Number = .75;
		
		public function HistogramUI( 
			_x:Number, _y:Number
			, _w:Number, _h:Number
			, _color:uint
			, _data:Object = null
		)
		{
			_data = _data || {};
			super( _data );
			
			this._x = _x;
			this._y = _y;
			this._w = _w;
			this._h = _h;
			this._maxY = _y + _h;
			
			this._color = _color;
			//this._isAnimation = _isAnimation;
			//this._isNegative = _isNegative;
			( 'duration' in _data ) &&  ( _duration =  _data.duration );　 
			
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
			var _ins:HistogramUI = this;
			
			this.count = 0;
			this.x = _x;
			
			if( data.isNegative ){
				this.y = _y;				
				TweenLite.to( this, _duration, { count: _h, ease:Circ.easeInOut
					, onUpdate: 
					function():void{
						graphics.clear();
						graphics.beginFill( _color, 1 );
						graphics.drawRect( 0, 0, _w, count );
					}
				} );
			}else{
				this.y = _maxY;				
				TweenLite.to( this, _duration, { count: _h, ease:Circ.easeInOut
					, onUpdate: 
					function():void{
						graphics.clear();
						graphics.beginFill( _color, 1 );
						graphics.drawRect( 0, 0, _w, count );
						_ins.y = _maxY - count;
					}
				} );
			}
		}
	}
}