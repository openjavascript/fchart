package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;

	public class HStackUI extends BaseUI
	{
		protected var _items:Vector.<Sprite>;
		
		public function HStackUI( _data:Object = null )
		{
			super( _data );
		}
		

		override protected function initStatck():void{
			if( !( data && data.data) ) return;
			
			_items = new Vector.<Sprite>();
			
//			Log.printFormatJSON( data );
			if( data.data && data.data.positive && data.data.positive.length ){		
//				Log.log( 111 );
				Common.each( data.data.positive, function( _k:int, _item:Object ):void{
					drawItem( _item );
				});
			}
			
			if( data.data && data.data.negative && data.data.negative.length ){
				Common.each( data.data.negative, function( _k:int, _item:Object ):void{
					drawItem( _item );
				});
			}
		}
		
		override protected function initAnimation():void{
//			super.initAnimation(); return;
			
			addChild( this.mask = _mask = new Sprite() );
			
			super.initAnimation();
//			addChild( _mask = new Sprite() );
			
			TweenLite.delayedCall( data.delay || 0, function():void{
//				Log.log( data.delay );
				_mask.graphics.beginFill( 0xff0000 );
				positiveAnimation();
				negativeAnimation();
			});
		}
		
		private function positiveAnimation():void{
			if( !( data.data && data.data.positive && data.data.positive.length ) ) return;
			var _lastItem:Object = data.data.positive[ data.data.positive.length - 1 ]
				, _firstItem:Object = data.data.positive[ 0 ]
				, _startX:Number = data.data.positive[ 0 ].x
				, _endX:Number = data.data.positive[ 0 ].x + data.data.positive[ 0 ].width 
				, _obj:Object;
				;
			Common.each( data.data && data.data.positive, function( _k:int, _item:Object ):void{
				_item.x < _startX && ( _startX = _item.x );
				_item.x + _item.width > _endX && ( _endX = _item.x + _item.width );
			});
			_obj = { count:_startX };
				
			if( _startX == _endX ) return;
			
//			data.duration += 2;
			
//			Log.log( _startX, _endX, data.width, data.y, data.height );
//			Log.log( 1 );
			
			TweenLite.to( _obj, data.duration, { count: _endX, ease:Circ.easeInOut
				, onUpdate: 
				function():void{
					if( data.k === 2 ){
//						Log.log( _startX, data.y, _obj.count, data.height );
					}
					if( !( data.width && _obj.count ) ) return; 
					_mask.graphics.drawRect( _startX, data.y, _obj.count - _startX, data.height );
				}
			} );
		}
		
		private function negativeAnimation():void{
//			Log.log( 2 );
			if( !( data.data && data.data.negative && data.data.negative.length ) ) return;
			var _lastItem:Object = data.data.negative[ data.data.negative.length - 1 ]
				, _firstItem:Object = data.data.negative[ 0 ]
				, _startX:Number = _lastItem.x + _lastItem.width
				, _endX:Number = _firstItem.x
				, _obj:Object;
			;
			
			Common.each( data.data && data.data.negative, function( _k:int, _item:Object ):void{
				if( _item.x + _item.width  > _startX ) _startX = _item.x + _item.width;
				if( _item.x < _endX ) _endX = _item.x;
			});
			 
			_obj = { count:_startX };
			if( _startX == _endX ) return;
			TweenLite.to( _obj, data.duration, { count: _endX, ease:Circ.easeInOut
				, onUpdate: 
				function():void{

					if( !( data.width && _obj.count ) ) return;
					_mask.graphics.drawRect( _obj.count, data.y, _startX - _obj.count, data.height );
				}
			} );
		}
		
		private function drawItem( _itemData:Object, _position:Object = null ):void{
			if( !( _itemData.width > 0 && _itemData.height > 0 ) ) return;
			_position = _position || {};
			var _tmp:Sprite = new Sprite()
				, _x:Number = _itemData.x
				, _y:Number = _itemData.y
				, _width:Number = _itemData.width
				, _height:Number = _itemData.height
				;
			
//			Log.log( _x, _y, _width, _height );
			
			_tmp.graphics.beginFill( _itemData.color, 1 );
			_tmp.graphics.lineStyle( 0, _itemData.color, 0 );
			_tmp.graphics.drawRect( _x, _y, _width, _height );
			
			addChild( _tmp );
			_items.push( _tmp );	
		}
	}
}
