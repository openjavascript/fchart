package org.xas.jchart.common
{
	import flash.display.DisplayObjectContainer;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.xas.core.i.IContextMenu;
	import org.xas.core.model.ContextMenuData;
	import org.xas.core.utils.Log;
	import org.xas.core.utils.SystemUtils;
	import org.xas.core.utils.URLUtils;
	import org.xas.jchart.common.controller.*;
	import org.xas.jchart.common.data.ProjectInfo;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseFacade extends Facade implements IFacade
	{
		private var _name:String;
		public function get name():String{ return _name; }
		
		public function BaseFacade( _name:String)
		{
			this._name = _name;
			super( _name );			
			BaseConfig.ins.setFacade( this );
		}
		
		override protected function initializeController():void{		
			super.initializeController();	
			//Log.log( 'BaseFacade.initializeController' );
			
			registerCommand( JChartEvent.INITED, InitedCmd );
			
			registerCommand( JChartEvent.SHOW_CHART			, GlobalShowChartCmd );
			registerCommand( JChartEvent.DRAW				, GlobalDrawCmd );
			
			registerCommand( JChartEvent.UI_ITEM_CLICK		, UIItemClickCmd );
			registerCommand( JChartEvent.ITEM_CLICK			, ItemClickCmd );
			registerCommand( JChartEvent.GROUP_CLICK		, GroupClickCmd );
			
			registerCommand( JChartEvent.DISPLAY_ALL_CHECK	, DisplayAllCheckCmd );
			registerCommand( JChartEvent.ROTATION_LABELS	, GlobalRotationLabelsCmd );
			
//			Log.log( 'BaseFacade', new Date().getTime() );
			initContentMenu();
		}
		
		protected function initContentMenu():void{
			
			var _list:Vector.<ContextMenuData> = new Vector.<ContextMenuData>()
				, _menu:ContextMenu
				;
					
			_list.push( new ContextMenuData( 'about ' + ProjectInfo.name , true, ProjectInfo.url )  );				
			_menu = SystemUtils.contentmenuX( BaseConfig.ins.root as DisplayObjectContainer, _list );
			
			Common.each( _menu.customItems, function( _k:int, _item:ContextMenuItem ):void{
				initMenuEvent( _item, _list[ _k ] );
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