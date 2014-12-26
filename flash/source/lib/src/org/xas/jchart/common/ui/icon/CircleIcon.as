package org.xas.jchart.common.ui.icon
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	
	public class CircleIcon extends Sprite
	{
		private var _point:Point;
		private var _color:uint;
		private var _radius:Number;
		private var _turnColor:Boolean;
		
		public function CircleIcon( _point:Point
									, _color:uint = 0x000000
									, _radius:Number = 5
									, _turnColor:Boolean = false
									)
		{
			super();
			
			this._point = _point;
			this._color = _color;
			this._radius = _radius;
			this._turnColor = _turnColor;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			this.x = _point.x;
			this.y = _point.y;	
			
			if( _turnColor ){					
				graphics.beginFill( 0xffffff );
				graphics.lineStyle( 2, _color );
				graphics.drawCircle( 0, 0, _radius );
			}
			displayMode( _turnColor );
		}
		
		public function hover():void{			
			displayMode( !_turnColor );
		}
		
		public function unhover():void{
			displayMode( _turnColor );
		}
		
		private function displayMode( _isTurn:Boolean ):void{			
			if( _turnColor ){	
				if( !_isTurn ){		
					this.scaleX = this.scaleY = 1.2;
				}else{				
					this.scaleX = this.scaleY = 1;
				}				
			}else{				
				graphics.clear();
				if( !_isTurn ){		
					graphics.beginFill( _color );
					graphics.lineStyle( 2, 0xffffff );
					graphics.drawCircle( 0, 0, _radius );
				}else{				
					graphics.beginFill( 0xffffff );
					graphics.lineStyle( 2, _color );
					graphics.drawCircle( 0, 0, _radius );
				}
			}
		}
	}
}