package org.xas.core.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public final class ElementUtility
	{
		public function ElementUtility()
		{
		}
		
		/*********************************************************
		 * 清除给定对象的所有子容器
		 * @param	disp 显示对象
		 * @date	2010-
		 * @author 	邱少伟
		 **********************************************************/
		public static function removeAllChild( disp:* ):void
		{
			try
			{				
				while( disp.numChildren )
				{
					var child:* = disp.getChildAt( 0 );
					if( child )
					{
						disp.removeChild( child );	
					}					
					child = null;
				}	
			}
			catch(ex:Error){}
		}
		
		public static function center( $v:DisplayObject, _offsetPoint:Point = null, _subtract:Boolean = true ):void
		{
			if( !_offsetPoint ){
				_offsetPoint = new Point( $v.root.stage.stageWidth / 2, $v.root.stage.stageHeight / 2 );
			}
			if( _subtract ){
				_offsetPoint.x -= $v.width / 2;
				_offsetPoint.y -=  $v.height / 2
			}
			$v.x = _offsetPoint.x;
			$v.y = _offsetPoint.y;
		}
		
		public static function topIndex($display:DisplayObject):void
		{
			try{ $display.parent.addChild( $display ); } catch( ex:Error ){}
		}
	}
}