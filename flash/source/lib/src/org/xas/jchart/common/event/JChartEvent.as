package org.xas.jchart.common.event
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.xas.core.events.BaseEvent;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	
	public class JChartEvent extends BaseEvent
	{
		public static const PROCESS:String = 'process';
		public static const CALC_COORDINATE:String = 'calc_coordinate';
		
		public static const DRAW:String = 'draw';
		public static const CLEAR:String = 'clear';
		
		public static const SHOW_CHART:String = 'show_chart';
		
		public static const MOUSE_ENTER:String = 'mouse_enter';
		public static const MOUSE_LEAVE:String = 'mouse_leave';
		
		public static const UPDATE_TIPS:String = 'update_tips';
		public static const SHOW_TIPS:String = 'show_tips';
		public static const HIDE_TIPS:String = 'hide_tips';
		
		public static const UPDATE:String = 'update';
		public static const UPDATE_STATUS:String = 'update_status';
		public static const FILTER_DATA:String = 'filter_data';
		
		public static const SHOW_LEGEND_ARROW:String = 'show_legend_arrow';
		public static const HIDE_LEGEND_ARROW:String = 'hide_legend_arrow';
		
		public static const SHOW_SERIES_LABEL:String = 'show_series_label';
		public static const HIDE_SERIES_LABEL:String = 'hide_series_label';
		
		public static const UPDATE_MOUSEWHEEL:String = 'update_mousewheel';
		
		public static const UI_ITEM_CLICK:String = 'uiItemClick';
		public static const GROUP_CLICK:String = 'groupclick';
		public static const ITEM_CLICK:String = 'itemclick';
		public static const ITEM_HOVER:String = 'itemhover';
		public static const INITED:String = 'inited';
		public static const LEGEND_UPDATE:String = 'legendupdate';;
		
		public static const DISPLAY_ALL_CHECK:String = 'display_all_check';
		
		public static const RESET_HLABELS:String = "reset_hlabels";
		public static const RESET_VLABELS:String = "reset_vlabels";
		public static const ROTATION_LABELS:String = 'rotation_labels';
		public static const ROTATION_LABELS_YAXIS:String = 'rotation_labels_yaxis';
				
		public static const MIX_CHART_CALC_COORDINATE_PREFIX:String = 'mix_chart_calc_coordinate_';
		public static const MIX_CHART_CALC_COORDINATE_BAR:String = MIX_CHART_CALC_COORDINATE_PREFIX +　'bar';
		public static const MIX_CHART_CALC_COORDINATE_LINE:String = MIX_CHART_CALC_COORDINATE_PREFIX +　'line';
		public static const MIX_CHART_CALC_COORDINATE_PIE:String = MIX_CHART_CALC_COORDINATE_PREFIX +　'pie';
		
		public function JChartEvent($type:String, $data:Object=null)
		{
			super($type, $data);
		}
		
		public static function mouseEnter( _ele:DisplayObject, _cb:Function ):void{
			
			var _isOver:Boolean = false, _isOut:Boolean = false;
			
			_ele.root.stage.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
			_ele.root.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseOut );
			_ele.root.stage.addEventListener( Event.MOUSE_LEAVE, stageLeave );
			_ele.root.stage.addEventListener( Event.RESIZE, remove );
			_ele.addEventListener( Event.REMOVED_FROM_STAGE, remove );
			
			
			function stageLeave( _evt:Event ):void{				
				_isOver = false;
				_isOut = true;
			}
				
			function remove( _evt:Event ):void{				
				_ele.root.stage.removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				_ele.root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseOut );
				_ele.root.stage.removeEventListener( Event.MOUSE_LEAVE, stageLeave );
				_ele.root.stage.removeEventListener( Event.RESIZE, remove );
				_ele.removeEventListener( Event.REMOVED_FROM_STAGE, remove );
			}
			
			function onMouseOver( _evt:MouseEvent ):void{
				if( _isOver ) return;
				if( _isOut ) return;
				_isOver = true;
				_cb.call( _ele, _evt );
			}
			
			function onMouseOut( _evt:MouseEvent ):void{
				//Log.log( _evt.stageX, _evt.stageY, _ele.x, _ele.y, _ele.width, _ele.height );
				if( Common.pointRectangleIntersection( 
					{ x: _evt.stageX, y: _evt.stageY }
					, { x: _ele.x, y: _ele.y, x2: _ele.x + _ele.width, y2: _ele.y + _ele.height }		
				)){	
					_isOut = false;
				}else{
					_isOver = false;
					_isOut = true;
				}
			}
		}
		
		public static function mouseLeave( _ele:DisplayObject, _cb:Function ):void{
			
			var _isOver:Boolean = false, _isOut:Boolean = false;
			
			_ele.root.stage.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );	
			_ele.root.stage.addEventListener( Event.RESIZE, remove );			
			_ele.addEventListener( Event.REMOVED_FROM_STAGE, remove );
			
			function remove( _evt:Event ):void{				
				_ele.root.stage.removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				_ele.root.stage.removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				_ele.root.stage.removeEventListener( Event.RESIZE, remove );			
				_ele.removeEventListener( Event.REMOVED_FROM_STAGE, remove );
			}
			
			function onMouseOver( _evt:MouseEvent ):void{
				
				if( _isOver ) return;
				if( _isOut ) return;
				_isOver = true;
				
				_ele.root.stage.removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				_ele.root.stage.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
			}
			
			function onMouseOut( _evt:MouseEvent ):void{
				//Log.log( _evt.stageX, _evt.stageY, _ele.x, _ele.y, _ele.width, _ele.height );
				if( Common.pointRectangleIntersection( 
					{ x: _evt.stageX, y: _evt.stageY }
					, { x: _ele.x, y: _ele.y, x2: _ele.x + _ele.width, y2: _ele.y + _ele.height }		
				)){	
					_isOut = false;
				}else{
					_isOver = false;
					if( !_isOut ){
						_cb.call( _ele, _evt );
					}
					_isOut = true;
				}
			}
		}

	}
}