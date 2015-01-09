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
			ProjectInfo.getInstance( BaseConfig.ins as Config, { facadeName: _name } );
		}
	}
}