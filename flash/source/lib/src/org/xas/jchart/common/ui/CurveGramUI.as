package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Linear;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	
	import mx.skins.halo.PopUpMenuIcon;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.proxy.LineProxy;
	import org.xas.jchart.common.proxy.data.line.BaseLineData;
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
		
		private var _config:Config;
		private var _turnColor:Boolean;
		
		private var _iconRadius:int = 5;
		
		public function CurveGramUI( 
			_cmd:Vector.<int>
			, _path:Vector.<Number>
			, _color:uint
			, _vecotrPath:Vector.<Point> = null
			, _lineType:String = 'Solid'
			, _data:Object = null
		) {
			_data = _data || {};
			
			( 'duration' in _data ) &&  ( _duration =  _data.duration );
			( 'delay' in _data ) &&  ( _delay =  _data.delay );
			( 'turnColor' in _data ) &&  ( _turnColor =  _data.turnColor );
			( 'iconRadius' in _data ) &&  ( _iconRadius =  _data.iconRadius );

			super(_data);
			
			this._cmd = _cmd;
			this._path = _path;
			this._color = _color;
			this._vectorPath = _vecotrPath;
			this._lineType = _lineType;
			this._thickness = 2;
			
			this._config = BaseConfig.ins as Config;			

			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			if( data.animationEnabled && _vectorPath && _vectorPath.length > 1 ) {
				animationDraw();
			} else {
				staticDraw();
			}
		}
		
		private function animationDraw():void{
			
			_jline = new JLine( _vectorPath, _lineType, { thickness: 2, lineColor: _color } );
			var _tmp:JLine = new JLine( _vectorPath, _lineType, { thickness: 4, lineColor: _color } );
			var _maskLine:JLine = new JLine( null, null, {} );
			var _g:Graphics = _maskLine.graphics;
			_g.moveTo( _vectorPath[0].x, _vectorPath[0].y );
			var _prePoint:Point = _vectorPath[0];
//			_g.lineStyle( 1, 0xff0000, 1 );
			_g.beginFill( 0xff0000, 1);
			addChild( _maskLine );
				
			var _data:BaseLineData = new BaseLineData();
			var _drawPointLen:Number = 1;
			var _pathPoint :Vector.<Point> = new Vector.<Point>;
			var tmpPoint:Point;
			var _totalLength:Number = _data.totalLineLength( _vectorPath );
			_maskLine.count = 0;
						
			_jline.mask = _maskLine;
			addChild( _jline );
			
		 	TweenLite.delayedCall( data.delay, function():void{
				TweenLite.to( _maskLine, data.duration, { count: _totalLength
					, onUpdate: function():void{
						
						_pathPoint = _data.calPosition( _vectorPath, _maskLine.count );
						for( var _i:Number = _drawPointLen - 1; _i < _pathPoint.length; _i++ ){
							tmpPoint = _pathPoint[ _i ];
							
							_g.moveTo( _prePoint.x, _prePoint.y - 5 );
							_g.lineTo( tmpPoint.x, tmpPoint.y - 5 );
							_g.lineTo( tmpPoint.x, tmpPoint.y + 5 );							
							_g.lineTo( _prePoint.x, _prePoint.y + 5 );
							_g.lineTo( _prePoint.x, _prePoint.y - 5 );
							
							_g.moveTo( tmpPoint.x, tmpPoint.y );
							_prePoint = tmpPoint;
						}
						_drawPointLen = _pathPoint.length;
						if( _maskLine.count == _totalLength ){
							_jline.mask = null;
							_maskLine.visible = false;
							drawIcon();
						}
					}
				});
			});
		}
		
		private function staticDraw():void{
			
			graphics.lineStyle( 2, _color );
			if( _vectorPath ){
				_jline = new JLine( _vectorPath, _lineType, { thickness: 2, lineColor: _color } );
				addChild( _jline );
			} else {
				graphics.drawPath( _cmd, _path );
			}

			drawIcon();
		}
		
		private function drawIcon():void{
			
			if( !this.data.pointEnabled ) return;
			
			var _lineBreakEnable:Boolean = _config.lineBreakEnable
				, _x:Number
				, _y:Number
				, _tmp:Point
				, _tmpItem:CircleIcon;
			
			_point = new Vector.<Point>;
			_items = new Vector.<CircleIcon>();
			
			while( _path.length ) {
				
				_x = _path.shift();
				_y = _path.shift();
				_tmp = new Point( _x, _y );
				_tmpItem = new CircleIcon( _tmp, _color, _iconRadius, _turnColor );
				
				_point.push( _tmp );
				_items.push( _tmpItem );
				
				if( _config.c.maxY != _y || !_lineBreakEnable ) {
					addChild( _tmpItem  );
				}
			}
		}
	}
}

