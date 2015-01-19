package org.xas.jchart.common
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	import flash.display.Graphics;
	
	public class Common
	{		
				
		public static function numberUp( _in:Number, _floatLen:int = 5, _upBound:Number = 5 ):Number{
			_upBound = _upBound < 0 ? 0 : _upBound;
			var _out:Number = 0, _inStr:String = _in.toFixed( _floatLen )
				, _oldBound:Number = _upBound
				, _part:Array = _inStr.split( '.' )
				, _int:Number = Math.abs( _part[0] ), _float:Number = parseFloat( '0.' + _part[ 1 ] )
				, _isNegative:Boolean = _in < 0
				, _ar:Array
				, i:int, j:int, tmp:Number
				, _midNum:int, _char:int
				;
			
			if( _upBound <=0 ){
				return _in;
			}
			
			if( /[1-9]/.test( _int.toString( ) ) ){
				tmp = Math.pow( 10, _int.toString().length - 1  );
				//Log.log( [tmp, _in, _oldBound, _upBound ].join() );
				_char = parseInt( _int.toString().charAt( 0 ));
				_out = tmp + tmp / 10 * _upBound;
				//Log.log( [_out ].join() );
				
				if( _out < _in && tmp > 0 ){
					do{
						_upBound = _upBound + _oldBound;
						_out = tmp + tmp / 10 * ( _upBound );					
					}while( _out < _in );
				}
				
			}else{						
				for( _ar = _float.toFixed( _floatLen ).split(''), i = 0, j = _ar.length; i < j; i++ ){
					if( _ar[i] != '0' && _ar[i] != '.' ){
						
						tmp = parseFloat( _ar.slice( 0, i ).join('') + '1'  );
						_out = tmp + tmp / 10 * _upBound;
						//Log.log( [_out ].join() );
						
						if( _out < _in && tmp > 0 ){
							do{
								_upBound = _upBound + _oldBound;
								_out = tmp + tmp / 10 * ( _upBound );					
							}while( _out < _in );
						}
						
						break;
					}
				}
			}
			
			_isNegative && ( _out = -_out );
			
			return _out;
		}
		
		public static function percentDown( _in:Number, _deep:int = 1 ):Number{
			
			var _out:Number = 0
				, _find:Boolean
				, _inStr:String = _in.toString()
				, _tmpAr:Array = _inStr.split( '' )
				, _findCount:int = 1
				;
			
			Common.each( _tmpAr, function( _k:int, _item:String ):void{
				if( /[1-9]/.test( _item ) ){
					_find = true;
					if( _findCount > _deep ){
						_tmpAr[ _k ] = 0;
					}else{
						_tmpAr[ _k ] = 1;
					}
				}
				if( _find && /[0-9]/.test( _item ) ){
					_findCount++;
				}
			});
			
			_out = Number( _tmpAr.join('' ) );
			
			return _out;
		}
		
		public static function calcRotationLabelPoint( _item:TextField, _angle:Number ):Rectangle{
			
			var _r:Rectangle = new Rectangle()
				, _rpoint:Point, _tmpPoint:Point
				, _cpoint:Point = new Point( _item.x, _item.y )
				, _rect:Rectangle = _item.getRect( _item )
				, _bound:Rectangle = _item.getBounds( _item )
				, _rwidth:Number, _rheight:Number
				, _oangle:Number = _angle
				, _absAngle:Number = Math.abs( _angle )
				;
			
			if( _absAngle > 0 ){
				_item.rotationZ = _angle;
				
				_angle %= 180;
				if( _angle === 0 ){
					_angle = _oangle;
				}
			}

			
			_rwidth = _item.width;
			_rheight = _item.height;
			
			
//			if( _angle > 0 ){
//				_tf.x = _newPoint.x + _rect.height / 2;
//			}else{
//				_tf.x = _newPoint.x - _rect.height / 2;
//			}
			_tmpPoint = new Point( _item.x, _item.y );
			if( _angle === 0 ){
				var _tf:TextFormat = _item.defaultTextFormat;
				_item.text = _item.text.replace( /[\r\n\-]+/g, '' ).split('').join('\r');
				_tf.leading = -4;
				_item.setTextFormat( _tf );
				_tmpPoint.y -= 1;
				_tmpPoint.x -= _item.width / 2;	
			}else if( _angle < 0 ){
				_rpoint = GeoUtils.moveByAngle( _angle, new Point( 0, 0 ), _rect.width );
				_tmpPoint = _cpoint.subtract( _rpoint );
				
//				Log.log( _angle, _absAngle );
				
				if( _absAngle >= 180 ){	
					_tmpPoint.y += 18;
					_tmpPoint.x -= 4;				
				}else if( _absAngle >= 170  ){
					_tmpPoint.y += 16;
					_tmpPoint.x -= 7;
				}else if( _absAngle >= 160 ){
					_tmpPoint.y += 14;
					_tmpPoint.x -= 9;
				}else if( _absAngle >= 150 ){
					_tmpPoint.y += 12;
					_tmpPoint.x -= 9;
				}else if( _absAngle >= 140 ){
					_tmpPoint.y += 10;
					_tmpPoint.x -= 11;
				}else if( _absAngle >= 130 ){
					_tmpPoint.y += 8;
					_tmpPoint.x -= 11;
				}else if( _absAngle >= 120 ){
					_tmpPoint.y += 5;
					_tmpPoint.x -= 12;
				}else if( _absAngle >= 110 ){
					_tmpPoint.y += 4;
					_tmpPoint.x -= 11;
				}else if( _absAngle >= 100 ){
					_tmpPoint.y += 2;
					_tmpPoint.x -= 10;
				}else if( _absAngle >= 90 ){
					_tmpPoint.x -= _rect.height / 2;
				}else if( _absAngle >= 80 ){
					_tmpPoint.y -= 1;
					_tmpPoint.x -= 9;
				}else if( _absAngle >= 70 ){
					_tmpPoint.y -= 2;
					_tmpPoint.x -= 7;
				}else if( _absAngle >= 60 ){
					_tmpPoint.y -= 3;
					_tmpPoint.x -= 5;
				}else if( _absAngle >= 50 ){
					_tmpPoint.y -= 3;
					_tmpPoint.x -= 3;
				}else if( _absAngle >= 40 ){
					_tmpPoint.y -= 3;
					_tmpPoint.x -= 4;
				}else if( _absAngle >= 30 ){
					_tmpPoint.y -= 3;
				}else if( _absAngle >= 20 ){
					_tmpPoint.x += 4;
					_tmpPoint.y -= 3;
				}else if( _absAngle >= 10 ){
					_tmpPoint.x += 3;
					_tmpPoint.y -= 3;
				}else{
					_tmpPoint.x += 4;
					_tmpPoint.y -= 3;
				}
			}else{
				_tmpPoint = new Point( _item.x, _item.y );
				if( _absAngle >= 180 ){
					_tmpPoint.x += 6;
					_tmpPoint.y += 19;			
				}else if( _absAngle >= 170  ){
					_tmpPoint.x += 7;
					_tmpPoint.y += 18;
				}else if( _absAngle >= 160 ){
					_tmpPoint.x += 8;
					_tmpPoint.y += 17;
				}else if( _absAngle >= 150 ){
					_tmpPoint.x += 9;
					_tmpPoint.y += 15;
				}else if( _absAngle >= 140 ){
					_tmpPoint.x += 10;
					_tmpPoint.y += 13;
				}else if( _absAngle >= 130 ){
					_tmpPoint.x += 10;
					_tmpPoint.y += 10;
				}else if( _absAngle >= 120 ){
					_tmpPoint.x += 11;
					_tmpPoint.y += 8;
				}else if( _absAngle >= 110 ){
					_tmpPoint.x += 11;
					_tmpPoint.y += 6;
				}else if( _absAngle >= 100 ){
					_tmpPoint.x += 11;
					_tmpPoint.y += 4;
				}else if( _absAngle >= 90 ){
					_tmpPoint.x += _rect.height / 2;
					_tmpPoint.y += 2;
				}else if( _absAngle >= 80 ){
					_tmpPoint.x += 9;
					_tmpPoint.y += 1;
				}else if( _absAngle >= 70 ){
					_tmpPoint.x += 8;
					_tmpPoint.y -= 0;
				}else if( _absAngle >= 60 ){
					_tmpPoint.x += 6;
					_tmpPoint.y -= 1;
				}else if( _absAngle >= 50 ){
					_tmpPoint.x += 4;
					_tmpPoint.y -= 1;
				}else if( _absAngle >= 40 ){
					_tmpPoint.x += 2;
					_tmpPoint.y -= 2;
				}else if( _absAngle >= 30 ){
					_tmpPoint.x -= 0;
					_tmpPoint.y -= 2;
				}else if( _absAngle >= 20 ){
					_tmpPoint.x -= 2;
					_tmpPoint.y -= 1;
				}else if( _absAngle >= 10 ){
					_tmpPoint.x -= 3;
					_tmpPoint.y -= 1;
				}else{
					_tmpPoint.x -= 4;
					_tmpPoint.y -= 0;
				}
			}
			_r.x = _tmpPoint.x;
			_r.y = _tmpPoint.y;
			_r.width = _item.width;
			_r.height = _item.height;
			
			//Log.log( _absAngle, _r.height );
			if( _absAngle == 90 ){
				_r.height += 8; 
			}
			//Log.log( _absAngle, _r.height );

			return _r;
		}
		
		public static function trans( d:DisplayObject ):void {
			var tr:Transform = d.transform;
			var m:Matrix = tr.matrix;
			m.scale( .5, 2 );
			m.translate( 50, 100 );
			tr.matrix = m;
			d.transform = tr;
		}
		
		
		public static function numberDown( _in:Number, _deep:int = 1 ):Number{
			
			var _out:Number = 0
				, _find:Boolean
				, _inStr:String = _in.toString()
				, _tmpAr:Array = _inStr.split( '' )
				, _findCount:int = 1
				;
						
			Common.each( _tmpAr, function( _k:int, _item:String ):void{
				if( /[1-9]/.test( _item ) ){
					_find = true;
					if( _findCount > _deep ){
						_tmpAr[ _k ] = 0;
					}
				}
				if( _find && /[0-9]/.test( _item ) ){
					_findCount++;
				}
			});
				
			_out = Number( _tmpAr.join('' ) );
			
			return _out;
		}
			
		public static function isNegative( _num:Number ):Boolean{
			return _num < 0;
		}
		
		public static function　pointRectangleIntersection( p:Object, r:Object ):Boolean {
			return p.x >= r.x && p.x <= r.x2 && p.y >= r.y && p.y <= r.y2;
		}
		
		
		
		/**
		 * 逗号格式化金额
		 * @method  moneyFormat
		 * @param   {int|string}    _number
		 * @param   {int}           _len
		 * @param   {int}           _floatLen
		 * @param   {int}           _splitSymbol
		 * @return  string
		 * @static
		 */
		public static function moneyFormat(_number:*, _len:uint = 3, _floatLen:uint = 2, _splitSymbol:String = ',' ):String{
			var _def:String = '0.00';
			!_len && ( _len = 3 );
			!_splitSymbol && ( _splitSymbol = ',' );
			var _isNegative:Boolean = false, _r:String;
			
			
			//_number = parseFinance( _number, _floatLen );
			
			
			if( typeof _number == 'string' ){
				_number = _number.replace( /[,]/g, '' );
				if( !/^[\d\.]+$/.test( _number ) ) return _def;
				if( _number.split('.').length > 2 ) return _def;
			}
			
			_number = _number || 0;
			_number += ''; 
			
			/^\-/.test( _number ) && ( _isNegative = true );
			
			_number = _number.replace( /[^\d\.]/g, '' );
			
			var _parts:Array = _number.split('.'), _sparts:Array = [];
			
			while( _parts[0].length > _len ){
				var _tmp:String = _parts[0].slice( _parts[0].length - _len, _parts[0].length );
				//console.log( _tmp );
				_sparts.push( _tmp );
				_parts[0] = _parts[0].slice( 0, _parts[0].length - _len );
			}
			_sparts.push( _parts[0] );
			
			_parts[0] = _sparts.reverse().join( _splitSymbol );
			
			if( _floatLen ){
				!_parts[1] && ( _parts[1] = '' );
				_parts[1] += new Array( _floatLen + 1 ).join('0');
				_parts[1] = _parts[1].slice( 0, _floatLen );
			}else{
				_parts.length > 1 && _parts.pop();
			}
			_r = _parts.join('.');
			_isNegative && ( _r = '-' + _r );
			
			return _r;
		}

		
		/**
		 * 扩展对象属性
		 * @method  extendObject
		 * @param   {object}    _source
		 * @param   {object}    _new
		 * @param   {bool}      _overwrite      是否覆盖已有属性, default = true  
		 * @return  object
		 * @static
		 */
		public static function extendObject( _source:Object, _new:Object, _overwrite:Boolean = true ):Object{
			if( _source && _new ){
				for( var k:String in _new ){
					if( _overwrite ){
						_source[ k ] = _new[ k ];
					}else if( !( k in _source ) ){
						_source[ k ] = _new[ k ];
					}
				}
			}
			return _source;
		}
		
		public static function implementStyle( _txf:TextField
											  	, _styleList:Array
												, _autoSize:String = TextFieldAutoSize.LEFT 
												  , _selectable:Boolean = false
												  , _mouseEnabled:Boolean = true
												
		):TextField{
		
			if( _styleList && _styleList.length ){
				var _style:Object = {}, _tf:TextFormat = new TextFormat();
				Common.each( _styleList, function( _k:int, _item:Object ):void{
					_style = extendObject( _style, _item );
				});
				
				Common.each( _style, function( _k:String, _item:* ):void{
					_tf[ _k ] = _item;
				});
				
				_txf.setTextFormat( _tf );
				_txf.defaultTextFormat = _tf;
			}
			_txf.selectable = _selectable;
			_txf.mouseEnabled = _mouseEnabled;
			_txf.autoSize = _autoSize;
			
			return _txf;
		}
		
		public static function hasNegative( _data:Array ):Boolean{
			var _r:Boolean = false;
			
			if( _data && _data.length ){
				Common.each( _data, function( _ix:int, _item:Object ):*{
					var _tmp:Number = Math.min.apply( null, _item.data );
					if( _tmp < 0 ){
						_r = true;
						return false;
					}
				});
			}			

			return _r;
		}
		
		public static function hasPositive( _data:Array ):Boolean{
			var _r:Boolean = false;
			
			if( _data && _data.length ){
				each( _data, function( _ix:int, _item:Object ):*{
					var _tmp:Number = Math.min.apply( null, _item.data );
					if( _tmp > 0 ){
						_r = true;
						return false;
					}
				});
			}
import flash.geom.Point;

			return _r;
		}
		
		/**
		 * 从长度和角度求坐标点
		 * @method  distanceAngleToPoint
		 * @param  {Number} _distance
		 * @param  {Number} _angle
		 * @return Point
		 * @static
		 */
		public static function distanceAngleToPoint( _distance:Number, _angle:Number ):Point{
			var _radian:Number = Common.radians( _angle );					
			return new Point(
				Math.cos( _radian  ) * _distance
				, Math.sin( _radian ) * _distance
			)
		}
		/**
		 * 从角度获取弧度
		 * @method  radians
		 * @param   {Number} _angle
		 * @return  {Number}
		 * @static
		 */
		public static function radians( _angle:Number ):Number{ return _angle * Math.PI / 180; }
		/**
		 * 从弧度获取角度
		 * @method  degree
		 * @param   {Number} _radians
		 * @return  {Number}
		 * @static
		 */
		public static function degree( _radians:Number ):Number{ return _radians / Math.PI * 180; }

		public static function isFloat( _num:Number ):Boolean{
			_num = Math.abs( _num );
			return ( _num - parseInt( _num + '' ) ) > 0;
		}
		
		/**
		 * 判断两个矩形是否有交集
		 */
		public static function intersectRect( r1:Object, r2:Object ):Boolean {
			return !(
				r2.x > ( r1.x + r1.width ) || 
				( r2.x + r2.width ) < r1.x || 
				r2.y > ( r1.y + r1.height ) ||
				( r2.y + r2.height ) < r1.y
			);
		}
		
		/**
		 * 把坐标和宽高生成一个 rectangle 数据
		 */
		public static function locationToRect( _x:Number, _y:Number, _width:Number, _height:Number ):Object{
			var _r:Object = {
				'left': _x
				, 'top': _y
				, 'right': _x + _width
					, 'bottom': _y + _height 
			};
			return _r;
		}
		/**
		 * 把 rectangle 数据 转换为 中心点坐标数据
		 */
		public static function rectToCenterPoint( _rect:Object ):Object{
			var _r:Object = {
				'x': _rect.left + _rect.width / 2
					, 'y': _rect.top + _rect.height / 2
			};
			return _r;
		}
		public static function displayToCenterPoint( _display:*, _side:int = 0, _offsetX:Number = 0, _offsetY:Number = 0 ):Object{
			var _do:DisplayObject = _display as DisplayObject, _r:Object = { x: 0, y: 0 };			
			if( _do ){
				switch( _side ){
					case 1: //right bottom
					{
						_r = { 'x': _do.x + _do.width + _offsetX, 'y': _do.y + _do.height + _offsetY };
						break;
					}
					case 2: //right mid
					{
						_r = { 'x': _do.x + _do.width + _offsetX, 'y': _do.y + _do.height / 2 + _offsetY };
						break;
					}
					case 3: //left mid
					{
						_r = { 'x': _do.x + _offsetX, 'y': _do.y + _do.height / 2 + _offsetY };
						break;
					}
					case 4: //left bottom
					{
						_r = { 'x': _do.x + _offsetX, 'y': _do.y + _do.height  + _offsetY };
						break;
					}
					case 5: //center bottom
					{
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _do.height  + _offsetY };
						break;
					}
					case 6: //center top
					{
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _offsetY };
						break;
					}
					case 7: //center mid
					{
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _offsetY };
						break;
					}
					default: 
					{						
						_r = { 'x': _do.x + _do.width / 2 + _offsetX, 'y': _do.y + _do.height / 2 +_offsetY };
						break;
					}
						
				}
			};
			return _r;
		}

		public static function lineLength( x1:Number, y1:Number, x2:Number, y2:Number ):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			
			return Math.sqrt( dx * dx + dy * dy );
		}
		
		/**
		 * 求两点之间连线的角度
		 */
		public static function lineAngle(px1:Number, py1:Number, px2:Number, py2:Number):Number 
		{
			//两点的x、y值
			var x:Number = px2-px1;
			var y:Number = py2-py1;
			var h:Number = 0;
			var radian:Number = 0;
			var angle:Number = 0;
			var cos:Number = 0;
			
			h = Math.sqrt(Math.pow(x, 2)+Math.pow(y, 2));
			//斜边长度
			cos = x/h;
			radian = Math.acos(cos);
			//求出弧度
			angle = 180/(Math.PI/radian);
			//用弧度算出角度    
			if (y<0) {
				angle = -angle;
			} else if ((y == 0) && (x<0)) {
				angle = 180;
			}
			
			angle = fixAngle( angle );
			
			return angle;
		}
		
		public static function fixAngle($angle:Number):Number
		{
			if( $angle < 0 ) $angle = 360 + $angle;
			return $angle;
		}
		
		
		public static function moveByAngle( $angle:Number, $centerPoint:Point, $diameter:Number ):Point
		{
			var result:Point = new Point(0, 0);
			var radian:Number;
			
			radian = $angle * Math.PI / 180;					
			result.x = $centerPoint.x + Math.cos( radian  ) * $diameter;
			result.y = $centerPoint.y + Math.sin( radian ) * $diameter;
			
			return result;
		}
		
		public static function floatLen( _n:*, _dot:int = 9 ):int{
			var _s:String = parseFinance( _n || 0, _dot ) + '', _r:int = 0, _ar:Array;
			_ar = _s.split( '.' );
			if(_ar.length > 1 ){
				//Log.log( 'zzzzzzzzzz', _n, _ar[1], _s );
				_ar[1].length > _r && ( _r = _ar[1].length );
			}
			return _r;
		}
		
		/**
		 * 取小数点的N位
		 * <br />JS 解析 浮点数的时候，经常出现各种不可预知情况，这个函数就是为了解决这个问题
		 * @method  parseFinance
		 * @static
		 * @param   {number}    _i
		 * @param   {int}       _dot, default = 2
		 * @return  number
		 */
		public static function parseFinance( _i:Number, _dot:int = 2 ):Number{
			_i = parseFloat( _i.toString() ) || 0;
			_i && ( _i = parseFloat( _i.toFixed( _dot ) ) );
			
			return _i;
		}
		
		public static function drawCircleArc( 
			_g:Graphics
			, _centerPoint:Point 
			, _radius:Number
			, _startAngle:Number
			, _endAngle:Number
			, _angleStep:Number = .5
			, _data:Object = null
		):Object {
			_data = _data || {};
			var _r:Object = {
					centerPoint: _centerPoint
					, radius: _radius
					
					, startAngle: _startAngle
					, endAngle: _endAngle
					
					, angleStep: _angleStep
					
					, countAngle: _startAngle
					, data: _data
				}
				, _tmpPoint:Point
				;
			
			if( 'color' in _data ){
				_g.lineStyle( 1, _data.color );
			}
			
			if( 'firstColor' in _data ){
				_g.lineStyle( 1, _data.firstColor );
			}
			
			while( true )
			{
				
				if( _startAngle > _endAngle ){
					if( _r.countAngle <= _endAngle )
					{
						_r.countAngle = _endAngle;
						_tmpPoint = GeoUtils.moveByAngle( _endAngle, _centerPoint, _radius );
						_g.lineTo( _tmpPoint.x, _tmpPoint.y );
						break;
					}
					_tmpPoint = GeoUtils.moveByAngle( _r.countAngle, _centerPoint, _radius );
					_g.lineTo( _tmpPoint.x, _tmpPoint.y );				
					_r.countAngle -= _angleStep;
					
				}else{
					if( _r.countAngle >= _endAngle )
					{
						_r.countAngle = _endAngle;
						_tmpPoint = GeoUtils.moveByAngle( _endAngle, _centerPoint, _radius );
						_g.lineTo( _tmpPoint.x, _tmpPoint.y );
						break;
					}
					_tmpPoint = GeoUtils.moveByAngle( _r.countAngle, _centerPoint, _radius );
					_g.lineTo( _tmpPoint.x, _tmpPoint.y );				
					_r.countAngle += _angleStep;
				}
				if( 'color' in _data ){
					_g.lineStyle( 1, _data.color );
				}
			}
			
			return _r;
		}
		
		public static function each( _items:*, _cb:Function, _isReverse:Boolean = false ):*{
			var i:int, j:int, k:String;
			
			if( 'length' in _items ){				
				if( _isReverse ){
					for( i = _items.length - 1; i >= 0; i-- ){
						if( _cb( i, _items[ i ] ) === false ) break;
					}		
				}else{
					for( i = 0, j = _items.length; i < j; i++ ){
						if( _cb( i, _items[ i ] ) === false ) break;
					}		
				}		
			}else{
				for( k in _items ){
					if( _cb( k, _items[ k ] ) === false ) break;
				}
			}
			
			return _items;
		}
	}
}