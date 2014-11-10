package org.xas.jchart.common.proxy.data.line
{
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;

	public class BaseLineData
	{
		public var _config:Config = BaseConfig.ins as Config;
		private var _totalLength:Number;
		private var _path:Vector.<Number>;
		public function BaseLineData() {
		}
		
		/**
		 * 计算点（Point）位于线集合的位置
		 */
		public function calPointOnLine(  ):void {
			
		}
		
		/**
		 * @param _vectorPath
		 * 传入一个Line集合(Vector),计算Line集合的总长度 ，
		 */
		public function totalLineLength( _vectorPath:Vector.<Point> ):Number {
			
			var _nextPoint:Point;
			var _tmpLength:Number = 0;
			_totalLength = 0;
			_path = new Vector.<Number>;
			Common.each( _vectorPath, function( _idx:Number, _item:Point ):void{
				if( _idx + 1 >= _vectorPath.length ){
					return;
				}
				_nextPoint = _vectorPath[ _idx + 1 ];
				_tmpLength = GeoUtils.pointLength( _item.x, _item.y, _nextPoint.x, _nextPoint.y );
				_path.push( _tmpLength );
				_totalLength += _tmpLength;
			});
			
			return _totalLength;
		}
		
		/**
		 * 
		 * @param _length
		 * 根据距离原点的距离，计算应该画至的位置，返回路径Vector
		 * 
		 */
		public function calPosition( _vectorPath:Vector.<Point>, _length:Number ):Vector.<Point>{
			
			var _totalLength:Number = totalLineLength( _vectorPath );
			var _result:Vector.<Point> = new Vector.<Point>;
			
			for( var _i:Number = 0; _i < _path.length; _i++ ){
				_result.push( _vectorPath[ _i ] );
				if( _length > _path[ _i ] ){
					_length -= _path[ _i ];
				} else {
					var _targetPoint:Point = GeoUtils.moveByAngle( 
						GeoUtils.pointAngle( _vectorPath[ _i ], _vectorPath[ _i + 1 ] ), _vectorPath[ _i ], _length );
					_result.push( _targetPoint );
					break;
				}
			}
			return _result;
		}
		
	}
}