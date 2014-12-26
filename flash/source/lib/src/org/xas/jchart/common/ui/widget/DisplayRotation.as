package org.xas.jchart.common.ui.widget
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	{
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.display.Sprite;
		import flash.geom.Matrix;
		import flash.text.TextField;
		import flash.text.TextFieldAutoSize;
		
		public class DisplayRotation extends JSprite
		{
			protected var _text:String;
			protected var _angle:Number;
			protected var _initTextCallback:Function;
			
			protected var _tf:TextField;
			
			protected var _bitmapData:BitmapData;
			protected var _bitmap:Bitmap;
			
			public function DisplayRotation( $text:String, $angle:Number = 0, $initTextCallback:Function = null, _data:Object = null )
			{
					
				_data = _data || {};
				
				_text = $text;
				_angle = $angle;
				_initTextCallback = $initTextCallback;
				
				_data.text = _text;
				_data.angle = _angle;
				_data.initTextCallback = _initTextCallback
				
				super( _data );
				
				init();
			}
			
			protected function init():void
			{ 
				_tf = new TextField();
				_tf.text = _text;
				_tf.autoSize = TextFieldAutoSize.LEFT;
				_tf.mouseEnabled = false;
				_tf.selectable = false;
				
				if( _initTextCallback != null )
				{
					_initTextCallback( _tf ); 
				}
				
				_bitmapData = new BitmapData( _tf.width + 10, _tf.height + 4, true, 0 ); 
				var mtx:Matrix = new Matrix();
				_bitmapData.draw( _tf, mtx, null, null, null, true );
				
				_bitmap = new Bitmap( _bitmapData, "auto", true );
				
				rotateAroundCenter( _bitmap, _angle );
				
				addChild( _bitmap );
			}
			
			public function rotateAroundCenter(object:DisplayObject, angleDegrees:Number):void {
				
				if (object.rotation == angleDegrees) {
					return;
				}
				
				var matrix:Matrix = object.transform.matrix;
				var rect:Rectangle = object.getBounds(object);
				
				matrix.translate( -((rect.width / 2) ), -( (rect.height / 2) ));
				matrix.rotate((angleDegrees / 180) * Math.PI);
				
				object.transform.matrix = matrix;
				
				object.rotation = Math.round(object.rotation);
			}
		}
	}
}