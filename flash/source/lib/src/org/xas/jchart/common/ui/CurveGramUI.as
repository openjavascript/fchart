package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.ui.icon.*;
	import org.xas.jchart.common.ui.widget.JLine;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class CurveGramUI extends JSprite
	{
		private var _cmd:Vector.<int>;
		private var _path:Vector.<Number>;
		private var _color:Number;
		private var _point:Vector.<Point>;
		private var _items:Vector.<CircleIcon>;
		public function get items():Vector.<CircleIcon>{ return _items; }
		private var _jline:JLine;
		private var _vectorPath:Vector.<Point>;
		private var _lineType:String;
		private var _thickness:Number;
		
		private var _duration:Number = .75;
		private var _delay:Number = 0;
		public var tint:Number = 0;
		
		public function CurveGramUI( 
			_cmd:Vector.<int>
			, _path:Vector.<Number>
			, _color:uint
			, _vecotrPath:Vector.<Point> = null
			, _lineType:String = 'Solid'
			, _data:Object = null
		)
		{
			super(_data);
			
			this._cmd = _cmd;
			this._path = _path;
			this._color = _color;
			this._vectorPath = _vecotrPath;
			this._lineType = _lineType;
			this._thickness = 2;
			
			_data = _data || {};
			
			( 'duration' in _data ) &&  ( _duration =  _data.duration );　 
			( 'delay' in _data ) &&  ( _delay =  _data.delay );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			
			graphics.lineStyle( 2, _color );
			data.animationEnabled = false;
			
			if( data.animationEnabled && _vectorPath && _vectorPath.length > 1 ){
				animationDraw();
			}else{
				staticDraw();
			}
		}
		
		private function animationDraw():void{
			var _ins:CurveGramUI = this;
			//_ins.tint = 0;
			//_ins.x = _x;
			_jline = new JLine( _vectorPath, _lineType, { thickness: 2, lineColor: 0x0000ff } );
			addChild( _jline );
//			Log.log(_vectorPath);
//			Log.log('---------------------');
			if( _vectorPath ) {
				Log.log(_color);
				tint = _color;
				TweenLite.delayedCall( _delay, function():void{
					TweenLite.to( _ins, _duration, { tint: _color, ease: Circ.easeInOut });
				});
				
//				TweenLite.delayedCall( _delay, function():void{
//					var _linePath:Vector.<Point> = new Vector.<Point>;
//					_linePath[0] = _vectorPath[0];
//					for(var i:Number = 1; i < _vectorPath.length; i++){
//						_linePath[1] = _vectorPath[i];
//						Log.log(_linePath);
//						TweenLite.to( _ins, _duration, { count: 2, ease: Circ.easeInOut
//							, onUpdate: function():void{
//								_jline = new JLine( _linePath, _lineType, { thickness: 1, lineColor: _color } );
//								addChild( _jline );
//							}
//						});
//						_linePath.shift();
//					};
//					
//				});
			} else {
				graphics.drawPath( _cmd, _path );
			}
			
		}
		
		private function staticDraw():void{
			
			if( _vectorPath ){
				_jline = new JLine( _vectorPath, _lineType, { thickness: 2, lineColor: _color } );
				addChild( _jline );
			}else{
				graphics.drawPath( _cmd, _path );
			}
			_point = new Vector.<Point>;
			_items = new Vector.<CircleIcon>();
			while( _path.length ){
				var _x:Number = _path.shift(), _y:Number = _path.shift()
					, _tmp:Point = new Point( _x, _y )
					, _tmpItem:CircleIcon = new CircleIcon( _tmp, _color )
					;
				_point.push( _tmp );
				_items.push( _tmpItem );
				addChild( _tmpItem  );
			}
		}
	}
}

