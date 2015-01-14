package org.xas.core.utils
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class ImageUtils
	{
		public function ImageUtils()
		{
		}
		
		public static function save( _displayObject:DisplayObjectContainer,  _name:String = 'flashimg.jpg', _quality:int = 100 ):void{
			var bmd:BitmapData = new BitmapData( _displayObject.stage.width, _displayObject.stage.height );
			bmd.draw( _displayObject );
			
			var jpg:JPGEncoder = new JPGEncoder( _quality );
			var imageBytes:ByteArray = jpg.encode( bmd );
			
			var fr:FileReference = new FileReference();
			fr.save( imageBytes,  _name );
		}
		
		public static function saveSprite( _displayObject:DisplayObjectContainer,  _name:String = 'flashimg.jpg', _quality:int = 100 ):void{
			var bmd:BitmapData = new BitmapData( _displayObject.width, _displayObject.height );
			bmd.draw( _displayObject );
			
			var jpg:JPGEncoder = new JPGEncoder( _quality );
			var imageBytes:ByteArray = jpg.encode( bmd );
			
			var fr:FileReference = new FileReference();
			fr.save( imageBytes,  _name );
		}
		
		public static function saveBitmapData( _bitmapData:BitmapData,  _name:String = 'flashimg.jpg', _quality:int = 100 ):void{
			
			var jpg:JPGEncoder = new JPGEncoder( _quality );
			var imageBytes:ByteArray = jpg.encode( _bitmapData );
			
			var fr:FileReference = new FileReference();
			fr.save( imageBytes,  _name );
		}
	}
}