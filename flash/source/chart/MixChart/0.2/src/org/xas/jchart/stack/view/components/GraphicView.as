package org.xas.jchart.stack.view.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class GraphicView extends Sprite
	{
		private var _boxs:Vector.<Sprite>;
		private var _preIndex:int = -1;
		private var _config:Config;
		
		private var _seriesAr:Array;
		private var _coordinate:Object;
		
		public function GraphicView( _seriesAr:Array, _coordinate:Object )
		{
			super(); 
			
			_config = BaseConfig.ins as Config;
			this._seriesAr = _seriesAr;
			this._coordinate = _coordinate;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			addEventListener( JChartEvent.UPDATE, update );
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		private function addToStage( _evt:Event ):void{
			
			_boxs = new Vector.<Sprite>();
			
			Common.each( _coordinate.columns, function( _k:int, _item:Object ):void{
//				Log.marker( '#' );
//				Log.printFormatJSON( _item );
				var _tmp:SubGraphicView = new SubGraphicView( _item );
				addChild( _tmp );
				_boxs.push( _tmp );
//				Log.log( '_coordinate.columns: ', _k );
			});
		}
		
		private function update( _evt:JChartEvent ):void{
			Common.each( _boxs, function( _k:int, _item:SubGraphicView ):void{
				_item.dispatchEvent( new JChartEvent( JChartEvent.UPDATE ) );
			});
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{			
			Common.each( _boxs, function( _k:int, _item:SubGraphicView ):void{
				_item.dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt.data ) );
			});
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			Common.each( _boxs, function( _k:int, _item:SubGraphicView ):void{
				_item.dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, _evt.data ) );
			});
		}

	}
}