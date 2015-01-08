package org.xas.core.model
{
	import flash.net.URLRequest;
	
	import org.xas.core.i.IContextMenu;

	public class ContextMenuData implements IContextMenu
	{
		private var _url:String;
		public function get url():String{ return _url; }
		public function set url($v:String):void{ _url = $v; }
		
		private var _text:String;
		public function get text():String{ return _text; }
		public function set text($v:String):void{ _text = $v; }
		
		private var _enable:Boolean;
		public function get enable():Boolean{ return _enable; }
		public function set enable($v:Boolean):void{ _enable = $v; }
		
		
		public function ContextMenuData( $text:String, $enable:Boolean, _url:String = '' )
		{
			text = $text;
			enable = $enable;
			this._url = _url;
		}
	}
}