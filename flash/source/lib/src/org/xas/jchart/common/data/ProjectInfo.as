package org.xas.jchart.common.data
{
	import flash.display.DisplayObjectContainer;
	import flash.events.ContextMenuEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.xas.core.model.ContextMenuData;
	import org.xas.core.utils.SystemUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;

	public class ProjectInfo extends EventDispatcher
	{
		public static const url:String = "http://fchart.openjavascript.org/docs_api/classes/JC.FChart.html";
		public static const name:String = "JC.FChart";
		
		protected static var _instance:ProjectInfo;
		
		protected var _config:Config;
		protected var _data:Object;
		
		public static function getInstance( _config:Config = null, _data:Object = null ):ProjectInfo{
			if( !_instance ){
				_instance = new ProjectInfo( _config, _data );
			}
			
			
			return _instance;
		}
		
		public function ProjectInfo( _config:Config, _data:Object )
		{
			if( _instance ){
				throw new Error( 'ProjectInfo is singleton, pls use ProjectInfo.getInstance()!' );
			} 
			
			this._config = _config;
			this._data = _data;
			
			init();
		}
		
		protected var _menuData:Vector.<ContextMenuData>;
		
		protected function init():void{
			initContentMenu();
		}
				
		protected function initContentMenu():void{
			
			var _menu:ContextMenu
				, _menuData:Vector.<ContextMenuData> = new Vector.<ContextMenuData>();
				;
			
			_menuData.push( new ContextMenuData( 'about ' + ProjectInfo.name , true, ProjectInfo.url )  );	
			
			if( _config.chartName ){
				_menuData.push( new ContextMenuData( 'about ' + _config.chartName , true, _config.chartUrl )  );	
			}
			
			_menu = SystemUtils.contentmenuX( BaseConfig.ins.root as DisplayObjectContainer, _menuData );
					
			Common.each( _menu.customItems, function( _k:int, _item:ContextMenuItem ):void{
				initMenuEvent( _item, _menuData[ _k ] );
			});
		}
		
		protected function initMenuEvent( _item:ContextMenuItem, _data:ContextMenuData ):void{
			_item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, function( _evt:ContextMenuEvent ):void{
				if( _data.url ){
					//					Log.log( _data.url );
					//URLUtils.openWindow( _data.url, 'JCFChart' );
					var _url:URLRequest = new URLRequest( _data.url );
					navigateToURL( _url, 'JCFChart' );
				}
			});
		}
	}
}