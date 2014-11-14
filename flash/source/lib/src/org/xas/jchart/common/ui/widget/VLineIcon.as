package org.xas.jchart.common.ui.widget
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	
	public class VLineIcon extends Sprite
	{
		private var _spoint:Point, _epoint:Point;
		private var _color:uint, _hoverColor:uint;
		private var _unHoverOpa:Number, _hoverOpa:Number;
		private var _lineWidth:Number;
		
		public function VLineIcon( _spoint:Point, _epoint:Point
								   , _color:uint = 0x999999, _hoverColor:uint = 0x000000
								   , _unHoverOpa:Number = .35, _hoverOpa:Number = .35
								   , _lineWidth:Number = 1
		)
		{
			super();
			
			this._spoint = _spoint;
			this._epoint = _epoint;
			this._color = _color;
			this._hoverColor = _hoverColor;
			this._unHoverOpa = _unHoverOpa;
			this._hoverOpa = _hoverOpa;
			this._lineWidth = _lineWidth;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			
			var _ele:DSprite = new DSprite();
			var _sp:Point = _spoint, _ep:Point = _epoint;
			
			_ele.graphics.clear();
			_ele.graphics.beginFill( _color );
			_ele.graphics.lineStyle( _lineWidth, _color, _unHoverOpa );
			
			addChild( _ele );
			
			var _delay:Number = 0;
			BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
			
			if( BaseConfig.ins.animationEnabled ){
				_ele.max = Math.ceil( _ep.y - _sp.y );
				_ele.count = 0;
				
				TweenLite.delayedCall( _delay, function():void{						
					TweenLite.to( _ele, BaseConfig.ins.animationDuration
						, { 
							count: _ele.max
							//, ease: Expo.easeIn
							, onUpdate: function():void{
								//Log.log( _ele.count );
								_ele.graphics.clear();
								_ele.graphics.lineStyle( _lineWidth, _color, _unHoverOpa );
								_ele.graphics.moveTo( _sp.x, _ep.y );
								_ele.graphics.lineTo( _sp.x, _ep.y - _ele.count );
							}
						} );
				});
				
			}else{
				_ele.graphics.moveTo( _sp.x, _sp.y );
				_ele.graphics.lineTo( _ep.x, _ep.y );
			}
		}
		
		public function hover():void{
			graphics.clear();
			graphics.beginFill( _hoverColor );
			graphics.lineStyle( _lineWidth, _hoverColor, _hoverOpa );
			graphics.moveTo( _spoint.x, _spoint.y );
			graphics.lineTo( _epoint.x, _epoint.y );
		}
		
		public function unhover():void{
			graphics.clear();
			graphics.beginFill( _color );
			graphics.lineStyle( _lineWidth, _color, _unHoverOpa );
			graphics.moveTo( _spoint.x, _spoint.y );
			graphics.lineTo( _epoint.x, _epoint.y );
		}
	}
}