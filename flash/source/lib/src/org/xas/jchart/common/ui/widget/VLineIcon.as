package org.xas.jchart.common.ui.widget
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	
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
			unhover();
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