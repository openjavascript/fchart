package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;

	public class StackUI extends BaseUI
	{
		protected var _items:Vector.<Sprite>;
		
		public function StackUI( _data:Object = null )
		{
			super( _data );
		}
		

		override protected function initStatck():void{
			if( !( data && data.data) ) return;
			
			_items = new Vector.<Sprite>();
			
			if( data.data && data.data.positive && data.data.positive.length ){		
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
			
			TweenLite.delayedCall( data.delay || 0, function():void{
//				Log.log( data.delay );
				_mask.graphics.beginFill( 0xffffff );
				positiveAnimation();
				negativeAnimation();
			});
		}
		
		private function positiveAnimation():void{
			if( !( data.data && data.data.positive && data.data.positive.length ) ) return;
			var _lastItem:Object = data.data.positive[ data.data.positive.length - 1 ]
				, _firstItem:Object = data.data.positive[ 0 ]
				, _startY:Number = data.data.positive[ 0 ].y + data.data.positive[ 0 ].height
				, _endY:Number = data.data.positive[ 0 ].y
				, _obj:Object;
				;
			Common.each( data.data && data.data.positive, function( _k:int, _item:Object ):void{
				if( _item.y < _endY ) _endY = _item.y;
				if( _item.y + _item.height > _startY ) _startY = _item.y + _item.height;
			});
			_obj = { count:_startY };
				
			if( _startY == _endY ) return;
			
//			Log.log( _startY, _endY, data.width );
//			Log.log( 1 );
			
			TweenLite.to( _obj, data.duration, { count: _endY, ease:Circ.easeInOut
				, onUpdate: 
				function():void{
//					Log.log( _startY, _endY, _obj.count );
					if( !( data.width && _obj.count ) ) return; 
					_mask.graphics.drawRect( data.x, _obj.count, data.width, _startY - _obj.count );
				}
			} );
		}
		
		private function negativeAnimation():void{
//			Log.log( 2 );
			if( !( data.data && data.data.negative && data.data.negative.length ) ) return;
			var _lastItem:Object = data.data.negative[ data.data.negative.length - 1 ]
				, _firstItem:Object = data.data.negative[ 0 ]
				, _startY:Number = _firstItem.y
				, _endY:Number = _lastItem.y + _lastItem.height
				, _obj:Object;
			;
			
			Common.each( data.data && data.data.negative, function( _k:int, _item:Object ):void{
				if( _item.y < _startY ) _startY = _item.y;
				if( _item.y + _item.height > _endY ) _endY = _item.y + _item.height;
			});
			
			_obj = { count:_startY };
			if( _startY == _endY ) return;
			TweenLite.to( _obj, data.duration, { count: _endY, ease:Circ.easeInOut
				, onUpdate: 
				function():void{

					if( !( data.width && _obj.count ) ) return;
					_mask.graphics.drawRect( data.x, _startY, data.width, _obj.count - _startY );
				}
			} );
		}
		
		private function drawItem( _itemData:Object, _position:Object = null ):void{
			if( !( _itemData.width > 0 && _itemData.height > 0 ) ) return;
			if( !( _itemData.width && _itemData.height ) ) return; 
			_position = _position || {};
			var _tmp:Sprite = new Sprite()
				, _x:Number = _itemData.x
				, _y:Number = _itemData.y
				, _width:Number = _itemData.width
				, _height:Number = _itemData.height
				;
			
			_tmp.graphics.beginFill( _itemData.color, 1 );
			_tmp.graphics.lineStyle( 0, _itemData.color, 0 );
			_tmp.graphics.drawRect( _x, _y, _width, _height );
			
			addChild( _tmp );
			_items.push( _tmp );	
		}
	}
}