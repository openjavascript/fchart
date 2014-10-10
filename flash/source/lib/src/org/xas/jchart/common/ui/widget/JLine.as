package org.xas.jchart.common.ui.widget
{
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;

	public class JLine extends JSprite
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
		
		private var _ins:JLine;
		private var _thickness:int = 2;
		private var _lineColor:uint = 0x00ff00;
		
		public function JLine( _path:Vector.<Point>, _type:String = 'Solid', _data:Object=null)
		{
			_ins = this;
			_data = _data || {};
			super(_data);
			
			this._path = _path;
			this._type = _type;
			
			_data.thickness && ( _thickness = _data.thickness );
			_data.lineColor && ( _lineColor = _data.lineColor );
			
			init();
		}
		
		private function init():void{
			if( !( _path && _path.length > 1 ) ) return;
			this.graphics.lineStyle( _thickness, _lineColor );
			
			switch( _type ){
				case DOT: dotLine(); break;
				case SHORT_DOT: shortDotLine(); break;
				
				case DASH: dashLine(); break;
				case SHORT_DASH: shortDashLine(); break;
				case LONG_DASH: longDashLine(); break;
				
				default: solidLine(); break;
			}
		}
				
		private function dotLine():void{			
			
			var _prePoint:Point;
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _k === 0 ){
					_ins.graphics.moveTo( _item.x, _item.y );
					return;
				}	
				
				if( !_prePoint ){
					_prePoint = _path[ _k - 1 ];
				}
				
				var _angle:Number = GeoUtils.pointAngle( _prePoint, _item )
				, _diameter:Number = GeoUtils.pointLength( _prePoint.x, _prePoint.y, _item.x, _item.y )
				, _count:Number = 0
				, _tmpPoint:Point = _prePoint.clone()
				;	
				
				_ins.graphics.moveTo( _prePoint.x, _prePoint.y );
				//Log.log( _angle, _diameter );
				while( _count < ( _diameter - DOT_RADIUS ) ){
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, DOT_RADIUS );
					_ins.graphics.drawCircle( _tmpPoint.x, _tmpPoint.y, DOT_RADIUS );
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, DOT_RADIUS + DOT_SPACE );
					_ins.graphics.moveTo( _tmpPoint.x, _tmpPoint.y );
					
					_count += DOT_RADIUS + DOT_SPACE;
				}
				_prePoint = _item.clone();
			});
		}
		
		private function shortDotLine():void{			
			
			var _prePoint:Point;
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _k === 0 ){
					_ins.graphics.moveTo( _item.x, _item.y );
					return;
				}	
				
				if( !_prePoint ){
					_prePoint = _path[ _k - 1 ];
				}
				
				var _angle:Number = GeoUtils.pointAngle( _prePoint, _item )
				, _diameter:Number = GeoUtils.pointLength( _prePoint.x, _prePoint.y, _item.x, _item.y )
				, _count:Number = 0
				, _tmpPoint:Point = _prePoint.clone()
				;	
				
				_ins.graphics.moveTo( _prePoint.x, _prePoint.y );
				//Log.log( _angle, _diameter );
				while( _count < ( _diameter - SHORT_DOT_RADIUS ) ){
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, SHORT_DOT_RADIUS );
					_ins.graphics.drawCircle( _tmpPoint.x, _tmpPoint.y, SHORT_DOT_RADIUS );
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, SHORT_DOT_RADIUS + SHORT_DOT_SPACE );
					_ins.graphics.moveTo( _tmpPoint.x, _tmpPoint.y );
					
					_count += SHORT_DOT_RADIUS + SHORT_DOT_SPACE;
				}
				_prePoint = _item.clone();
			});
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
		}
		
		private function longDashLine():void{			

			var _prePoint:Point;
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _k === 0 ){
					_ins.graphics.moveTo( _item.x, _item.y );
					return;
				}	
				
				if( !_prePoint ){
					_prePoint = _path[ _k - 1 ];
				}
				
				var _angle:Number = GeoUtils.pointAngle( _prePoint, _item )
				, _diameter:Number = GeoUtils.pointLength( _prePoint.x, _prePoint.y, _item.x, _item.y )
				, _count:Number = 0
				, _tmpPoint:Point = _prePoint.clone()
				, _maxDiameter:Number = _diameter - LONG_DASH_LEN
				;	
				
				_ins.graphics.moveTo( _prePoint.x, _prePoint.y );
				//Log.log( _angle, _diameter );
				while( _count <= _maxDiameter ){
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, LONG_DASH_LEN );
					_ins.graphics.lineTo( _tmpPoint.x, _tmpPoint.y );
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, LONG_DASH_SPACE );
					_ins.graphics.moveTo( _tmpPoint.x, _tmpPoint.y );
					
					_count += LONG_DASH_LEN + LONG_DASH_SPACE;
					
					if( _count > _maxDiameter && _count < _diameter ){
						_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, _diameter - _count);
						_ins.graphics.lineTo( _tmpPoint.x, _tmpPoint.y );
						_ins.graphics.moveTo( _item.x, _item.y );
					}
				}
				_prePoint = _item.clone();
			});
		}
				
		private function dashLine():void{			
			
			var _prePoint:Point;
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _k === 0 ){
					_ins.graphics.moveTo( _item.x, _item.y );
					return;
				}	
				
				if( !_prePoint ){
					_prePoint = _path[ _k - 1 ];
				}
				
				var _angle:Number = GeoUtils.pointAngle( _prePoint, _item )
				, _diameter:Number = GeoUtils.pointLength( _prePoint.x, _prePoint.y, _item.x, _item.y )
				, _count:Number = 0
				, _tmpPoint:Point = _prePoint.clone()
				;	
				
				_ins.graphics.moveTo( _prePoint.x, _prePoint.y );
				//Log.log( _angle, _diameter );
				while( _count < ( _diameter - DASH_LEN ) ){
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, DASH_LEN );
					_ins.graphics.lineTo( _tmpPoint.x, _tmpPoint.y );
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, DASH_SPACE );
					_ins.graphics.moveTo( _tmpPoint.x, _tmpPoint.y );
					
					_count += DASH_LEN + DASH_SPACE;
				}
				_prePoint = _item.clone();
			});
		}
				
		private function shortDashLine():void{	
			
			var _prePoint:Point;
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _k === 0 ){
					_ins.graphics.moveTo( _item.x, _item.y );
					return;
				}	
				
				if( !_prePoint ){
					_prePoint = _path[ _k - 1 ];
				}
				
				var _angle:Number = GeoUtils.pointAngle( _prePoint, _item )
				, _diameter:Number = GeoUtils.pointLength( _prePoint.x, _prePoint.y, _item.x, _item.y )
				, _count:Number = 0
				, _tmpPoint:Point = _prePoint.clone()
				;	
				
				_ins.graphics.moveTo( _prePoint.x, _prePoint.y );
				//Log.log( _angle, _diameter );
				while( _count < ( _diameter - SHORT_DASH_LEN ) ){
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, SHORT_DASH_LEN );
					_ins.graphics.lineTo( _tmpPoint.x, _tmpPoint.y );
					_tmpPoint = GeoUtils.moveByAngle( _angle, _tmpPoint, SHORT_DASH_SPACE );
					_ins.graphics.moveTo( _tmpPoint.x, _tmpPoint.y );
					
					_count += SHORT_DASH_LEN + SHORT_DASH_SPACE;
				}
				_prePoint = _item.clone();
			});
			
		}
	}
}