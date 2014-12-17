package org.xas.jchart.common.ui.widget
{
	import com.greensock.TweenLite;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.proxy.data.line.BaseLineData;

	public class JFillLine extends JSprite
	{
		private var _path:Vector.<Point>;
		private var _type:String;
		
		public static const SOLID:String = 'Solid';
		
		public static const SHORT_DASH:String = 'ShortDash';
		public static const SHORT_DASH_LEN:Number = 8;
		public static const SHORT_DASH_SPACE:Number = 5;
		
		public static const DASH:String = 'Dash';
		public static const DASH_LEN:Number = 8;
		public static const DASH_SPACE:Number = 10;
		
		public static const LONG_DASH:String = 'LongDash';
		public static const LONG_DASH_LEN:Number = 20;
		public static const LONG_DASH_SPACE:Number = 10;
		
		public static const SHORT_DOT:String = 'ShortDot';
		public static const SHORT_DOT_RADIUS:Number = .5;
		public static const SHORT_DOT_SPACE:Number = 5;
		
		public static const DOT:String = 'Dot';
		public static const DOT_RADIUS:Number = .5;
		public static const DOT_SPACE:Number = 10;
		
		private var _ins:JFillLine;
		private var _thickness:int = 2;
		private var _lineColor:uint = 0x00ff00;
		private var _isGradient:Boolean;
		private var _opacity:Number = .35;
		private var _delayShow:Number = 0;
		
		public function JFillLine( _path:Vector.<Point>, _data:Object=null, _isGradient:Boolean = false )
		{
			_ins = this;
			_data = _data || {};
			super(_data);
			
			this._path = _path;
			this._isGradient = _isGradient;
			
			_data.thickness && ( _thickness = _data.thickness );
			_data.lineColor && ( _lineColor = _data.lineColor );
			_data.delayShow && ( _delayShow = _data.delayShow );
			'fillOpacity' in _data && ( _opacity = _data.fillOpacity );
			
			_ins = this;
			
			init();
		}
		
		private function init():void{
			if( !( _path && _path.length > 1 ) ) return;
			
			if( data.animationEnabled && _path && _path.length > 1 ){
				animationDraw();
				
			}
			staticDraw();

		}
		
		private function animationDraw():void{
			var _maskLine:JLine = new JLine( null, null, {} )
				, _rect:Sprite = new Sprite();
				;

			_ins.mask = _rect;
			addChild( _rect );
			
			var _data:BaseLineData = new BaseLineData();
			var _pathPoint :Vector.<Point> = new Vector.<Point>;
			var _totalLength:Number = _data.totalLineLength( _path );
			_maskLine.count = 0;
			
			TweenLite.delayedCall( data.delay, function():void{
				TweenLite.to( _maskLine, data.duration, { count: _totalLength
					, onUpdate: function():void{
						
						
						_pathPoint = _data.calPosition( _path, _maskLine.count );	
						var _tmpPoint:Point = _pathPoint[ _pathPoint.length -1 ];
						
						_rect.graphics.clear();
						_rect.graphics.beginFill( 0xffffff );
						
						_rect.graphics.drawRect( 
							BaseConfig.ins.c.chartX, BaseConfig.ins.c.chartY
							, _tmpPoint.x - BaseConfig.ins.c.chartX
							, BaseConfig.ins.c.chartHeight + 2
						);


						if( _maskLine.count == _totalLength ){							
							_ins.mask = null;
							_rect.visible = false;
							_rect && _rect.parent && _rect.parent.removeChild( _rect );
						}
						
					}
				});
			});
			
		}
		
		private function staticDraw():void{

			this.graphics.lineStyle( 0, _lineColor );
			
			if( _isGradient ){
				var _minY:Number = minY()
					, _realY:Number = _minY - BaseConfig.ins.c.chartY
					, _realY1:Number = _minY - BaseConfig.ins.c.chartY
					, _height:Number = BaseConfig.ins.c.chartHeight - _realY
					, _matrix:Matrix = new Matrix()
					, _colors:Array = [ _lineColor, 0xffffff ]
					, _alphas:Array = [ .8, .0 ]
					, _ratios:Array = [  0,  255 ]
					;
				
				_matrix.createGradientBox(
					BaseConfig.ins.c.chartWidth
					, _height
					, (Math.PI/180)*90, 0, _minY
				);
				
				this.graphics.beginGradientFill(GradientType.LINEAR, _colors, _alphas, _ratios, _matrix);
			}else{
				this.graphics.beginFill( _lineColor, _opacity );
			}				
			solidLine(); 
			this.graphics.endFill();
		}
		
		private function minY():Number{
			var _r:Number = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight;
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _item.y < _r ){
					_r = _item.y;
				}
			});
			
			return _r;
		}

		
		private function solidLine():void{
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _k === 0 ){
					_ins.graphics.moveTo( _item.x, _item.y );
					return;
				}
				
				var _prePoint:Point = _path[ _k - 1 ];
				_ins.graphics.lineTo( _item.x, _item.y );
			});
			
			var _first:Point = _path[0]
				, _last:Point = _path[ _path.length - 1 ]
				;
						
			_ins.graphics.lineTo( _last.x, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight );
			_ins.graphics.lineTo( _first.x, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight );
			_ins.graphics.lineTo( _first.x, _first.y );
		}
	}
}