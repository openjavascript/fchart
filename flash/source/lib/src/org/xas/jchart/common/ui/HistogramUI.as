package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class HistogramUI extends JSprite
	{
		private var _x:Number, _y:Number, _w:Number, _h:Number;
		private var _color:Number;
		private var _maxY:Number;
		public var count:Number = 0;
		private var _duration:Number = .75;
		private var _delay:Number = 0;
		
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
			( 'delay' in _data ) &&  ( _delay =  _data.delay );　 
			
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
			
			addEventListener( MouseEvent.CLICK, itemClick );
		}
		
		private function staticDraw():void{
			this.x = _x;
			this.y = _y;
			graphics.drawRect( 0, 0, _w, _h );
		}
		
		protected function animationDraw():void{
			var _ins:HistogramUI = this;
			
			_ins.count = 0;
			_ins.x = _x;
			
			
			TweenLite.delayedCall( _delay, function():void{
				
				if( data.isNegative ){
					_ins.y = _y;				
					TweenLite.to( _ins, _duration, { count: _h, ease:Circ.easeInOut
						, onUpdate: 
						function():void{
							graphics.clear();
							graphics.beginFill( _color, 1 );
							graphics.drawRect( 0, 0, _w, count );
						}
					} );
				}else{
					_ins.y = _maxY;				
					TweenLite.to( _ins, _duration, { count: _h, ease:Circ.easeInOut
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
		
		private function itemClick( _evt:MouseEvent ):void{
			if( !this.data ) return;
			var _data:Object;
			
			if( !( ( 'seriesIndex' in this.data )||( 'dataIndex' in this.data )  ) ) return;
			
			_data = Common.extendObject( { 
				seriesIndex: this.data.seriesIndex
				, dataIndex: this.data.dataIndex
			}, {} );
			//Log.printFormatJSON( _ui.data );
			BaseConfig.ins.facade.sendNotification( JChartEvent.UI_ITEM_CLICK, _data, 'bar' );
		}
	}
}