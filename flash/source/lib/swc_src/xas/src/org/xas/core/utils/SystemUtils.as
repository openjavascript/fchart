package org.xas.core.utils
{	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.xas.core.i.IContextMenu;
	import org.xas.core.model.ContextMenuData;
	
	public class SystemUtils
	{
		
		public static function contentmenu( $root:DisplayObjectContainer, $list:Vector.<IContextMenu> ):ContextMenu
		{			
			var cm:ContextMenu;
			var cmi:ContextMenuItem;
			var icm:IContextMenu;
			
			if( $list && $list.length )
			{
				cm = new ContextMenu();		
				cm.hideBuiltInItems(); 
				
				for( var i:int = 0; i < $list.length; i++ )
				{
					icm = $list[i];
					cmi = new ContextMenuItem( icm.text );
					cmi.enabled = icm.enable;
					
					cm.customItems.push(cmi);
				}
				$root.contextMenu = cm;	
			}
			
			return cm;
		}	
		
		public static function contentmenuX( $root:DisplayObjectContainer, $list:Vector.<ContextMenuData> ):ContextMenu
		{			
			var cm:ContextMenu;
			var cmi:ContextMenuItem;
			var icm:IContextMenu;
			
			if( $list && $list.length )
			{
				cm = new ContextMenu();		
				cm.hideBuiltInItems(); 
				
				for( var i:int = 0; i < $list.length; i++ )
				{
					icm = $list[i];
					cmi = new ContextMenuItem( icm.text );
					cmi.enabled = icm.enable;
					
					cm.customItems.push(cmi);
				}
				$root.contextMenu = cm;	
			}
			
			return cm;
		}
	}
}