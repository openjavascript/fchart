package org.xas.jchart.common.ui.widget
{	
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.easing.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.osmf.elements.F4MElement;
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class PiePart extends JSprite
	{
		private var _centerPoint:Point;
		public function get centerPoint():Point{ return _centerPoint; }
		
		private var _startPoint:Point;
		
		private var _radius:Number;
		public function get radius():Number{ return _radius; }
		
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
		
		private var angleStep:Number = .5;		
		
		private var _offsetAngle:Number;
		
		private var _style:Object;
		private var _hoverStyle:Object;
		
		private var _dataIndex:int = 0;
		public function get dataIndex():int{ return _dataIndex; }
		
		private var _config:Config;
		
				
		private var _lineColor:uint = 0xffffff
					, _fillColor:uint = 0x000000
					;
		
		private var tempPoint:Point;
		
		private var _count:Number = 0;
		public function get count():Number{ return _count; }
		public function set count( _setter:Number ):void{ _count = _setter; }
		
		private var _originCenterPoint:Point;
		private var _part:Sprite;
		private var _ins:PiePart
		
		private var _preItem:PiePart;
		
		private var _moveDistance:Number = 10;
		
		
		public function PiePart( 
			_centerPoint:Point
			 , _beginAngle:Number, _endAngle:Number
			 , _radius:Number = 100	
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
			this._radius = _radius;
			this._dataIndex = _dataIndex;
			this._offsetAngle = _offsetAngle;
			
			this._style = _style;
			this._hoverStyle = _hoverStyle;
			
			if( data.preItem ){
				_preItem = data.preItem as PiePart;
			}
			
			if( 'moveDistance' in data ){
				_moveDistance = data.moveDistance;
			}
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			
			addChild( _part = new Sprite() );
			
			_part.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			_part.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			_part.addEventListener( MouseEvent.CLICK, onMouseClick );
			
			addEventListener( JChartEvent.UPDATE, onUpdate );
			
			draw();
		}
		
		private function draw():void{
						
			if( _style && _style.color ){
				_fillColor = _style.color;
			}
			
			_part.graphics.lineStyle(1, _lineColor);
			_part.graphics.beginFill( _fillColor );
			
			_centerPoint.x = 0;
			_centerPoint.y = 0;
			
			
			_startPoint = GeoUtils.moveByAngle
				( 
					_beginAngle
					, _centerPoint
					, _radius 
				);
						
			_countAngle = _beginAngle;
			angleStep = .5;
			
			
			if( _countAngle > _endAngle ){
				_endAngle += 360;
			}
			
			if( _countAngle == _endAngle || ( _countAngle == 0 && _endAngle == 360 ) ){
				_part.graphics.lineStyle( 1, _fillColor );
			}
			
			if( _countAngle == _endAngle ){
				_endAngle += 360;		
			}
			
			_ins.x = _originCenterPoint.x;
			_ins.y = _originCenterPoint.y;
			
			_part.graphics.moveTo( _centerPoint.x, _centerPoint.y );
			_part.graphics.lineTo( _startPoint.x, _startPoint.y );
						
			if( _config.animationEnabled ){
				animationDraw();
			}else{
				normalDraw();
			}
		}
		
		private function normalDraw():void{


			Common.drawCircleArc( 
				_part.graphics
				, _centerPoint
				, _radius
				, _countAngle
				, _endAngle
				, angleStep 
			);

			_part.graphics.endFill();
			
			dispatchEvent( new JChartEvent( JChartEvent.READY, { index: dataIndex } ) );
		}
		
		private function animationDraw():void{			
//			normalDraw();
			
			TweenLite.to( this, _config.animationDuration
				, { 
					count: _endAngle - _countAngle
					, onUpdate: function():void{
						var cur:Number = _beginAngle + _count
							, _tmpAngle:Number = _countAngle
							, _anglePad:Number = 0
							;
							
						Common.drawCircleArc( 
							_part.graphics
							, _centerPoint
							, _radius
							, _tmpAngle
							, cur
							, angleStep 
						);

						_anglePad = cur - _countAngle;
						_angleStepCount += _anglePad;
						_countAngle = cur;						
						
						if( _preItem && _dataIndex  ){
							var _rangle:Number =  _preItem.seriesAngle + _config.offsetAngle - _preItem.endAngle
								;
													
							_part.rotation = _rangle;
							_ins.x = _originCenterPoint.x;
							_ins.y = _originCenterPoint.y;
						}
						
						if( !_dataIndex ){
							_seriesAngle += _anglePad;
						}else if( _preItem ){
							_seriesAngle = _preItem.seriesAngle + _angleStepCount;
						}
						
					}
					, onComplete: 
						function():void{		
							if( !_dataIndex ){								
								_seriesAngle = _config.offsetAngle + Math.abs( _endAngle - _beginAngle );
							}else if( _preItem ){
								_seriesAngle = _preItem.seriesAngle + Math.abs( _endAngle - _beginAngle );
							}
							_part.rotation = 0;
							_part.graphics.endFill();									
							dispatchEvent( new JChartEvent( JChartEvent.READY, { index: dataIndex } ) );
						}
				} 
			);
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
			
//			Log.log( 'update:', _selected );
			
			//TweenLite.defaultEase = com.greensock.easing.Elastic;
			if( _selected ){
				_obj = { x:0, y: 0 };
				_point = Common.distanceAngleToPoint( _moveDistance, midAngle );
				_tw = new TweenLite( _obj, .5, { 
					x: _point.x
					, y: _point.y
					, onUpdate:
					function():void{
						//Log.log( _obj.x, _obj.y );
						_matrix.tx = _obj.x;
						_matrix.ty = _obj.y;
						_part.transform.matrix = _matrix;
					}
					, ease: com.greensock.easing.Expo.easeOut
				} );
				/*
				_matrix.tx = _point.x;
				_matrix.ty = _point.y;
				*/
			} else {
				if( !( _part && _part.transform && _part.transform.matrix ) ) return; 
				_obj = { x:_part.transform.matrix.tx, y: _part.transform.matrix.ty };
				_point = Common.distanceAngleToPoint( _moveDistance, midAngle );
				_tw = new TweenLite( _obj, .5, { 
					x: 0
					, y: 0
					, onUpdate:
					function():void{
						//Log.log( _obj.x, _obj.y );
						_matrix.tx = _obj.x;
						_matrix.ty = _obj.y;
						_part.transform.matrix = _matrix;
					}
					, ease: com.greensock.easing.Expo.easeOut
				} );
			}
			_part.transform.matrix = _matrix;			
		}
		
		public function unselected():void{
			update( _selected = false );
		}
		
		private var _selected:Boolean = false;
		public function get isSelected():Boolean{ return this._selected; }
		
		public function selected( _select:Boolean ):PiePart{
			this.dispatchEvent( new JChartEvent( JChartEvent.UPDATE, _select ) );
			return this;
		}
		
		public function toggle():PiePart{
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