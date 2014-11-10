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
			
			this._config = BaseConfig.ins as Config;
			
			_data = _data || {};
			
			( 'duration' in _data ) &&  ( _duration =  _data.duration );　 
			( 'delay' in _data ) &&  ( _delay =  _data.delay );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			
			data.animationEnabled = true;
			
			if( data.animationEnabled && _vectorPath && _vectorPath.length > 1 ){
				animationDraw();
			}else{
				staticDraw();
			}
		}
		
		private function animationDraw():void{
			
			var _maskLine:JLine = new JLine( null, null, {} );
			var _g:Graphics = _maskLine.graphics;
			_g.moveTo( _vectorPath[0].x, _vectorPath[0].y );
			_g.lineStyle( 2,_color );
			addChild( _maskLine );
				
			var _data:BaseLineData = new BaseLineData();
			var _drawPointLen:Number = 1;
			var _pathPoint :Vector.<Point> = new Vector.<Point>;
			var tmpPoint:Point;
			var _totalLength:Number = _data.totalLineLength( _vectorPath );
			_maskLine.count = 0;
			TweenLite.to( _maskLine, 1.4, { count: _totalLength
				, onUpdate: function():void{
					_pathPoint = _data.calPosition( _vectorPath, _maskLine.count );
					for( var _i:Number = _drawPointLen - 1; _i < _pathPoint.length; _i++ ){
						tmpPoint = _pathPoint[ _i ];
						_g.lineTo( tmpPoint.x, tmpPoint.y );
					}
					_drawPointLen = _pathPoint.length;
					if( _maskLine.count == _totalLength ){
						staticDraw();
						_maskLine.parent && _maskLine.parent.removeChild( _maskLine );
					}
				}
			});
			
		}
		
		private function drawLine( _maskLine:JLine, _pos:Number, _g:Graphics ,_durTime:Number, _t:Number ):void{
			if( _pos + 1 >= _vectorPath.length ){
				staticDraw();
				_maskLine.parent && _maskLine.parent.removeChild( _maskLine );
				return;
			}
			
			_maskLine.count = 0;
			var _basePoint:Point = _vectorPath[ _pos ];
			var _endPoint:Point = _vectorPath[ ++_pos ];
			_g.moveTo( _basePoint.x, _basePoint.y );
			var _total:Number = GeoUtils.pointLength( _basePoint.x, _basePoint.y, _endPoint.x, _endPoint.y );
			var _targetPoint:Point;
			
			TweenLite.to( _maskLine, _total / _t, { count: _total, ease:Linear.easeNone
				, onUpdate: function():void{
					
					_targetPoint = GeoUtils.moveByAngle( 
						GeoUtils.pointAngle( _basePoint, _endPoint ), _basePoint, _maskLine.count );
					
					_g.lineTo( _targetPoint.x, _targetPoint.y );

					if( _maskLine.count >= _total ){
						drawLine( _maskLine, _pos, _g, _durTime, _t );
					}
				}
			});
		}
		
		private function staticDraw():void{
			graphics.lineStyle( 2, _color );
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

