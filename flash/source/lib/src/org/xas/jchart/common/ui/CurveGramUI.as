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
			_data = _data || {};
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
			//if( data.animationEnabled && _vectorPath && _vectorPath.length > 1 && false ){
			if( data.animationEnabled && _vectorPath && _vectorPath.length > 1 ){
				animationDraw();
			}else{
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
			_g.lineStyle( 1, 0xff0000, 1 );
			_g.beginFill( 0xff0000, 1);
			//_maskLine.alpha = 1;
			//_jline.mask = _maskLine;
			addChild( _maskLine );
				
			var _data:BaseLineData = new BaseLineData();
			var _drawPointLen:Number = 1;
			var _pathPoint :Vector.<Point> = new Vector.<Point>;
			var tmpPoint:Point;
			var _totalLength:Number = _data.totalLineLength( _vectorPath );
			_maskLine.count = 0;
						
			_jline.mask = _maskLine;
			addChild( _jline );
			
			//_jline.y += 1;
			//_maskLine.y += 1;
			
		 	TweenLite.delayedCall( data.delay, function():void{
				TweenLite.to( _maskLine, data.duration, { count: _totalLength
					, onUpdate: function():void{
						
						_pathPoint = _data.calPosition( _vectorPath, _maskLine.count );
						for( var _i:Number = _drawPointLen - 1; _i < _pathPoint.length; _i++ ){
							tmpPoint = _pathPoint[ _i ];
							//_g.lineTo( tmpPoint.x, tmpPoint.y );
							
							_g.moveTo( _prePoint.x, _prePoint.y - 5 );
							_g.lineTo( tmpPoint.x, tmpPoint.y - 5 );
							_g.lineTo( tmpPoint.x, tmpPoint.y + 5 );							
							_g.lineTo( _prePoint.x, _prePoint.y + 5 );
							_g.lineTo( _prePoint.x, _prePoint.y - 5 );
							
							_g.moveTo( tmpPoint.x, tmpPoint.y );
							_prePoint = tmpPoint;
						}
						_drawPointLen = _pathPoint.length;
						//_jline.mask = _maskLine;
						if( _maskLine.count == _totalLength ){
							//_jline.mask = _maskLine;
							//addChild( _jline );
							//_jline.parent.removeChild( _jline );
							//_maskLine.parent && _maskLine.parent.removeChild( _maskLine );
							//staticDraw();
							//_jline.mask = _maskLine as Sprite;							
							drawIcon();
						}
					}
				});
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
			
			if( _jline && _jline.parent ){
			}
			
			graphics.lineStyle( 2, _color );
			if( _vectorPath ){
				_jline = new JLine( _vectorPath, _lineType, { thickness: 2, lineColor: _color } );
				
				/*
				var _mask:Sprite = new Sprite();
				_mask.graphics.lineStyle( 4, 0, 1 );
				//_mask.graphics.beginFill( 0 );
				Common.each( _vectorPath, function( _k:int, _item:Point ):void{
					if( _k === 0 ){
						_mask.graphics.moveTo( _item.x, _item.y );
						return;
					}
					
					var _prePoint:Point = _vectorPath[ _k - 1 ];
					_mask.graphics.lineTo( _item.x, _item.y );
				});
									
				_jline.mask = _mask;
				*/
				
				addChild( _jline );
			}else{
				graphics.drawPath( _cmd, _path );
			}

			drawIcon();
		}
		
		private function drawIcon():void{
			
			if( !this.data.pointEnabled ) return;
			
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

