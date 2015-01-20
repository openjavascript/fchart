package org.xas.jchart.common.ui.widget
{	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.sensors.Accelerometer;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class DountPart extends JSprite
	{
		private var _centerPoint:Point;
		public function get centerPoint():Point{ return _centerPoint; }
		
		private var _outRadius:Number;
		public function get outRadius():Number{ return _outRadius; }
		
		private var _inRadius:Number;
		public function get inRadius():Number{ return _inRadius; }
		
		private var _beginAngle:Number;
		public function get beginAngle():Number{ return _beginAngle; }
		
		private var _endAngle:Number;
		public function get endAngle():Number{ return _endAngle; }
		
		public function get midAngle():Number{ return _beginAngle + ( _endAngle - _beginAngle ) / 2; }
		
		private var _seriesAngle:Number = 0;
		public function get seriesAngle():Number{ return _seriesAngle; }
		
		private var  _angleStepCount:Number = 0;
		public function get anglePadCount():Number{ return _angleStepCount; }
		
		private var _countAngle:Number = 0;
		public function get countAngle():Number{ return _countAngle; }
		
		private var _offsetAngle:Number;
		
		private var angleStep:Number = .5;	
		
		private var _style:Object;
		private var _hoverStyle:Object;
		
		private var _dataIndex:int = 0;
		public function get dataIndex():int{ return _dataIndex; }
		
		private var _dountSprite:Sprite;
		private var _config:Config;
		
		
		private var _lineColor:uint = 0xffffff, _fillColor:uint = 0x000000;
		private var _originCenterPoint:Point;
		private var _ins:DountPart		
		private var _preItem:DountPart;
		
		private var _count:Number = 0;
		public function get count():Number{ return _count; }
		public function set count( _setter:Number ):void{ _count = _setter; }
		
		private var _moveDistance:Number = 10;
		
		private var _innerRadiusSprite:Sprite;
		private var _innerRadiusEnabled:Boolean = false;
		private var _innerRadiusThickness:uint = 1;
		private var _innerRadiusMargin:uint = 2;
		public function get innerRadius():Number{
			return _inRadius - _innerRadiusMargin - _innerRadiusThickness;
		}
		
		public function DountPart( 
			_centerPoint:Point
			, _beginAngle:Number, _endAngle:Number
			, _outRadius:Number = 100	
			, _inRadius:Number = 90
			, _dataIndex:int = 0
			, _style:Object = null
			, _hoverStyle:Object = null
			, _offsetAngle:Number = 0
			, _data:Object = null
		)
		{						
			super( _data || {} );
			_config = BaseConfig.ins as Config;
			_ins = this;
			
			this._centerPoint = _centerPoint;
			this._originCenterPoint = _centerPoint.clone();
			this._beginAngle = _beginAngle + _offsetAngle;
			this._endAngle = _endAngle + _offsetAngle;
			this._outRadius = _outRadius;
			this._inRadius = _inRadius;
			this._dataIndex = _dataIndex;
			this._offsetAngle = _offsetAngle;
			
			this._style = _style;
			this._hoverStyle = _hoverStyle;
			
//			if( _dataIndex > 0 ) return;
			if( data.preItem ){
				_preItem = data.preItem as DountPart;
			}else{				
				_seriesAngle = _config.angleMargin;
			}
			
			if( 'moveDistance' in data ){
				_moveDistance = data.moveDistance;
			}
			
			if( 'innerRadiusEnabled' in data ){
				_innerRadiusEnabled = data.innerRadiusEnabled;
			}
			
			if( 'innerRadiusThickness' in data ){
				_innerRadiusThickness = data.innerRadiusThickness;
			}
//			_innerRadiusThickness = 2;
			
			if( 'innerRadiusMargin' in data ){
				_innerRadiusMargin = data.innerRadiusMargin;
			}
						
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			addEventListener( MouseEvent.CLICK, onMouseClick );
			
			addEventListener( JChartEvent.UPDATE, onUpdate );
						
			draw();
		}
		
		private function draw():void{	
			
			ElementUtility.removeAllChild( this );
			addChild( _dountSprite = new Sprite() );
			addChild( _innerRadiusSprite = new Sprite() );
			//addChild( _lineSprite = new Sprite() );
			
			if( _style && _style.color ){
				_lineColor = _style.color;
				_fillColor = _style.color;
			}
			
//			_lineColor = 0xff0000;		
			
			_dountSprite.graphics.beginFill( _fillColor );	
			_dountSprite.graphics.lineStyle(1, _lineColor);
			
			_innerRadiusSprite.graphics.lineStyle(_innerRadiusThickness, _lineColor);
//			_dountSprite.graphics.lineStyle(1, 0x000000 );
			
			_centerPoint.x = 0;
			_centerPoint.y = 0;
						
			_ins.x = _originCenterPoint.x;
			_ins.y = _originCenterPoint.y;
			
			_countAngle = _beginAngle;
			angleStep = .5;
						
			if( _config.animationEnabled ){
				animationDraw();
			}else{
				normalDraw();
			}
		}
		
		private function normalDraw():void{
			
			_dountSprite.graphics.clear();
			_dountSprite.graphics.beginFill( _fillColor );	
			_dountSprite.graphics.lineStyle(1, _lineColor);
			
			_innerRadiusSprite.graphics.clear();
			_innerRadiusSprite.graphics.lineStyle(_innerRadiusThickness, _lineColor);
			_countAngle = _beginAngle;
			
			var p1:Point, p2:Point, tmpPoint:Point
			, lp:Point, lp2:Point, ltmpPoint:Point
			; 
			
			p1 = GeoUtils.moveByAngle
				( 
					_beginAngle
					, _centerPoint
					, _inRadius  
				)
				;
			_dountSprite.graphics.moveTo( p1.x, p1.y );
						
			_endAngle = fixEndAngle( _beginAngle, _endAngle );
			
			Common.drawCircleArc( 
				_dountSprite.graphics
				, _centerPoint
				, _inRadius
				, _countAngle
				, _endAngle
				, angleStep
			);
			
			
			p2 = GeoUtils.moveByAngle
				( 
					_endAngle
					, _centerPoint
					, _outRadius 
				)
				;
			_dountSprite.graphics.lineTo( p2.x, p2.y );
						
			_countAngle = _endAngle;
						
			_endAngle = fixEndAngle( _beginAngle, _endAngle );
			
			Common.drawCircleArc( 
				_dountSprite.graphics
				, _centerPoint
				, _outRadius
				, _countAngle
				, _beginAngle
				, angleStep
			);
			_dountSprite.graphics.lineTo( p1.x, p1.y );
			
			if( _innerRadiusEnabled ){
				p1 = GeoUtils.moveByAngle
					( 
						_beginAngle
						, _centerPoint
						, innerRadius  
					)
					;
				_innerRadiusSprite.graphics.moveTo( p1.x, p1.y );
				
				Common.drawCircleArc( 
					_innerRadiusSprite.graphics
					, _centerPoint
					, innerRadius
					, _beginAngle
					, _endAngle
					, angleStep
				);	
			}
						
			dispatchEvent( new JChartEvent( JChartEvent.READY, { index: dataIndex } ) );
		}
		
		private function animationDraw():void{	
			var _innerStartPoint:Point =
					GeoUtils.moveByAngle
					( 
						_beginAngle
						, _centerPoint
						, _inRadius  
					)
				, _innerEndPoint:Point =
					GeoUtils.moveByAngle
					( 
						_endAngle
						, _centerPoint
						, _inRadius  
					)
				, _outerStartPoint:Point = 
					GeoUtils.moveByAngle
					( 
						_beginAngle
						, _centerPoint
						, _outRadius  
					)
				, _outerEndPoint:Point = 
					GeoUtils.moveByAngle
						( 
							_endAngle
							, _centerPoint
							, _outRadius  
						)
				;
			
			_dountSprite.graphics.moveTo(_innerStartPoint.x, _innerStartPoint.y );
			_endAngle = fixEndAngle( _beginAngle, _endAngle );
			
			_dountSprite.graphics.lineStyle( 1, _fillColor );
			
			if( _innerRadiusEnabled ){
				var innerFirstPoint:Point = GeoUtils.moveByAngle
					( 
						_beginAngle
						, _centerPoint
						, innerRadius  
					)
					;
				_innerRadiusSprite.graphics.moveTo( innerFirstPoint.x, innerFirstPoint.y );
	
			}
			
			TweenLite.to( this, _config.animationDuration
				, { 
					count: _endAngle - _countAngle 
					, onUpdate: function():void{
						
						var _curAngle:Number = _beginAngle + _count
							, _tmpAngle:Number = _countAngle
							, _anglePad:Number = 0
						;
						
						var _innerStartPointTmp:Point =
						GeoUtils.moveByAngle
						( 
							_tmpAngle
							, _centerPoint
							, _inRadius  
						)
						, _innerEndPointTmp:Point =
						GeoUtils.moveByAngle
						( 
							_curAngle
							, _centerPoint
							, _inRadius  
						)
						, _outerStartPointTmp:Point = 
						GeoUtils.moveByAngle
						( 
							_tmpAngle
							, _centerPoint 
							, _outRadius  
						)
						, _outerEndPointTmp:Point = 
						GeoUtils.moveByAngle
						( 
							_curAngle
							, _centerPoint
							, _outRadius  
						); 
						
						Common.drawCircleArc( 
							_dountSprite.graphics
							, _centerPoint
							, _outRadius
							, _tmpAngle
							, _curAngle
							, angleStep
						);
						
						if( _innerRadiusEnabled ){
							Common.drawCircleArc( 
								_innerRadiusSprite.graphics
								, _centerPoint
								, innerRadius
								, _tmpAngle
								, _curAngle
								, angleStep
							);
						}
					
							
						_dountSprite.graphics.lineTo( _innerEndPointTmp.x, _innerEndPointTmp.y );
						
						Common.drawCircleArc( 
							_dountSprite.graphics
							, _centerPoint
							, _inRadius
							, _curAngle
							, _tmpAngle
							, angleStep 
						);
						
						_dountSprite.graphics.moveTo( _outerEndPointTmp.x, _outerEndPointTmp.y );	
						
						_anglePad = _curAngle - _countAngle;
						_angleStepCount += _anglePad;
						_countAngle = _curAngle;						
						
						if( _preItem && _dataIndex  ){
							var _rangle:Number =  _preItem.seriesAngle + _config.offsetAngle - _preItem.endAngle
							;
							
							if( _innerRadiusEnabled ){
								_innerRadiusSprite.rotation = _rangle;
							}
							
							_dountSprite.rotation = _rangle;
							_ins.x = _originCenterPoint.x;
							_ins.y = _originCenterPoint.y;
							
						}
						
						if( !_dataIndex ){
							_seriesAngle += _anglePad ;
//							Log.log( _seriesAngle );
						}else if( _preItem ){
							_seriesAngle = _preItem.seriesAngle + _angleStepCount + ( _dataIndex - 1) * _config.angleMargin;
						} 
						
					}
					, onComplete: 
					function():void{		
						if( !_dataIndex ){								
							_seriesAngle = _config.offsetAngle + Math.abs( _endAngle - _beginAngle );
						}else if( _preItem ){
							_seriesAngle = _preItem.seriesAngle + Math.abs( _endAngle - _beginAngle );
						}
						_dountSprite.rotation = 0;
						_innerRadiusSprite.rotation = 0;
						
						normalDraw();		
//						_dountSprite.graphics.endFill();	
						
//						dispatchEvent( new JChartEvent( JChartEvent.READY, { index: dataIndex } ) );
					}
				} 
			);
		}
		
		private function fixEndAngle( _bangle:Number, _eangle:Number ):Number{
			
			if( _bangle > _eangle ){
				_eangle += 360;
			}
			
			
			if( _bangle == _eangle ){
				_eangle += 360;		
			}	
			return _eangle;
		}
		
		private function onUpdate( _evt:JChartEvent ):void{
			update( _selected = _evt.data as Boolean );	
			this.dispatchEvent( 
				new JChartEvent( 
					JChartEvent.UPDATE_STATUS
					, { selected: _selected, dataIndex: dataIndex, index: dataIndex, type: 'click' }
				) 
			);	
		}
		
		private function update( _setter:Boolean ):void{
			//Log.log( 'PiePart selected', _selected );
			var _matrix:Matrix = new Matrix()
				, _point:Point
				, _obj:Object
				, _tw:TweenLite
				;
			
			//TweenLite.defaultEase = com.greensock.easing.Elastic;
			TweenLite.killTweensOf( _ins, true );
			
			if( _selected ){
				_obj = { x:_originCenterPoint.x, y: _originCenterPoint.y };
				_point = Common.distanceAngleToPoint( _moveDistance, midAngle );
				_point = _point.add( _originCenterPoint );
				_tw = new TweenLite( _obj, .5, { 
					x: _point.x
					, y: _point.y
					, onUpdate:
					function():void{
						//Log.log( _obj.x, _obj.y );
						_matrix.tx = _obj.x;
						_matrix.ty = _obj.y;
						_ins.transform.matrix = _matrix;
					}
					, ease: com.greensock.easing.Expo.easeOut
				} );
				/*
				_matrix.tx = _point.x;
				_matrix.ty = _point.y;
				*/
			} else {
				_obj = { x: _ins.transform.matrix.tx, y: _ins.transform.matrix.ty };
				_tw = new TweenLite( _obj, .5, { 
					x: _originCenterPoint.x
					, y: _originCenterPoint.y
					, onUpdate:
					function():void{
						//Log.log( _obj.x, _obj.y );
						_matrix.tx = _obj.x;
						_matrix.ty = _obj.y;
						_ins.transform.matrix = _matrix;
					}
					, ease: com.greensock.easing.Expo.easeOut
				} );
			}
//			_ins.transform.matrix = _matrix;			
		}

		
		
		public function unselected():void{
			update( _selected = false );
		}
		
		private var _selected:Boolean = false;
		public function get isSelected():Boolean{ return this._selected; }
		
		public function selected( _select:Boolean ):DountPart{
			this.dispatchEvent( new JChartEvent( JChartEvent.UPDATE, _select ) );
			return this;
		}
		
		public function toggle():DountPart{
			selected( !_selected );
			return this;
		}
		
		protected function onMouseOver( _evt:MouseEvent ):void{
			if( _config.selectableEnabled ){
				flash.ui.Mouse.cursor = MouseCursor.BUTTON;	
			}
		}
		
		protected function onMouseOut( _evt:MouseEvent ):void{
			flash.ui.Mouse.cursor = MouseCursor.AUTO;	
		}
		
		private function onMouseClick( _evt:MouseEvent ):void
		{
			//Log.log( 'PiePart click' );
			//selected( !_selected );
		}


	}
}