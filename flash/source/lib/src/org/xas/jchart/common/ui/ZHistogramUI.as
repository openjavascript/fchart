package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.ui.widget.JSprite;
	import org.xas.jchart.common.ui.HistogramUI;
	
	public class ZHistogramUI extends HistogramUI
	{
		private var _x:Number, _y:Number, _w:Number, _h:Number;
		private var _color:Number;
		private var _maxY:Number;
		private var _duration:Number = .75;
		private var _delay:Number = 0;
		
		public function ZHistogramUI( 
			_x:Number, _y:Number
			, _w:Number, _h:Number
			, _color:uint
			, _data:Object = null
		)
		{
			this._x = _x;
			this._y = _y;
			this._w = _w;
			this._h = _h;
			this._maxY = _y + _h;
			this._color = _color;
			
			_data = _data || {};
			
			super( _x, _y, _w, _h, _color, _data);
		}
		
		override protected function animationDraw():void{
			var _ins:ZHistogramUI = this;
			
			_ins.count = 0;
			_ins.y = _y;
			
			TweenLite.delayedCall( _delay, function():void{
				
				if( data.isNegative ){
					_ins.x = _x;				
					TweenLite.to( _ins, _duration, { count: _w, ease:Circ.easeInOut
						, onUpdate: 
						function():void{
							graphics.clear();
							graphics.beginFill( _color, 1 );
							graphics.drawRect( 0, 0, count, _h );
						}
					} );
				}else{
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