package org.xas.jchart.piegraph.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.PieGraphUI;
	import org.xas.jchart.common.ui.widget.PiePart;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<PieGraphUI>;
		
		private var _preIndex:int = -1;
		private var _piePart:Vector.<PiePart>;
		
		private var _hideTimer:Timer;
		private var _config:Config;
		private var _selectedIndex:int = -1;
		
		private var _ready:Boolean;
		
		public function GraphicView()
		{
			super(); 
			_config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			_hideTimer = new Timer( 200, 1 );
			_hideTimer.addEventListener( TimerEvent.TIMER, onTimerHideDone );

		}
		
		private function addToStage( _evt:Event ):void{			
			addEventListener( JChartEvent.SELECTED, onSelected );
		}
		
		public function update():void{
			
			if( !( _config.c && _config.c.piePart && _config.c.piePart.length ) ) return;
//			Log.printFormatJSON( _config.displaySeriesIndexMap );
			
			graphics.clear();
			_piePart = new Vector.<PiePart>();
			
			if( !_config.dataInited ){
				Common.each( _config.displaySeries, function( _k:int, _item:Object ):void{
					if( _item.selected ){
						_selectedIndex = _k;
					}
				});
			}
			
//			Log.log( 'GraphicView: _config.selected = ', _config.selected );
			
			if( _config.selected >= 0 ){
				Common.each( _config.displaySeries, function( _k:int, _item:Object ):void{
					if( _config.selected === _config.displaySeriesIndexMap[ _k ] ){
						_selectedIndex = _k;
					}
				});
//				Log.log( _selectedIndex, _config.selected );
			}
			
			Common.each( _config.c.piePart, function( _k:int, _item:Object ):void{
				
				if( _item.data.y === 0 ) return;
				
				var _preItem:PiePart;
				_k && _piePart.length && ( _preItem = _piePart[ _piePart.length - 1 ] );
				
				var _pp:PiePart = new PiePart( 
										new Point( _item.cx, _item.cy )
										, _item.startAngle, _item.endAngle
										, _item.radius
										, _k
										, { 
											'color': _config.itemColor( _k )
										}
										, {}
										, 0
										, {
											'seriesIndex': _config.displaySeriesIndexMap[ _k ]
											, 'preItem': _preItem
											, 'moveDistance': _config.moveDistance * 1
										}
									);				
				_piePart.push( _pp );
				
				_pp.addEventListener( JChartEvent.UPDATE_STATUS, onPiePartUpdateStatus );
				_pp.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				_pp.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				_pp.addEventListener( MouseEvent.CLICK, onMouseClick );
				_pp.addEventListener( JChartEvent.READY, onItemReady );
				_pp.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				
				addChild( _pp );
				
				//Log.log( _item.cx, _item.cy, _item.startAngle, _item.endAngle, _item.radius );
			});
						
		}
		
		private function onItemReady( _evt:JChartEvent ):void{
			var _data:Object = _evt.data || {}
				, _index:int = _data.index || 0
				;
			if( _data.index === ( _config.c.piePart.length - 1 ) ){				
//				Log.log( 'onItemReady:', _data.index, _selectedIndex, _piePart.length - 1 );
//				Log.log( 'onItemReady', _selectedIndex );
				
				_ready = true;
				dispatchEvent( new JChartEvent( JChartEvent.SELECTED, { index: _selectedIndex } ) );
				_config.facade.sendNotification( JChartEvent.READY );
			}
		}
		
		private function onSelected( _evt:JChartEvent ):void{
			if( !_ready ) return;
			var _data:Object = _evt.data || {}
				, _index:int = _data.index || 0
				;
			if( !_piePart.length ) return;
			
			if( _index >= 0 && _index <= (_piePart.length - 1 ) && _piePart.length > 1 ){
				_piePart[ _index ].toggle();
//				Log.log( _index );
			}
		}
				
		protected function onMouseOver( _evt:MouseEvent ):void{
			if( !_ready ) return;
			
			_hideTimer.running && _hideTimer.stop();
//			root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, _evt ) );
			//Log.log( 'show tips' );
			
		}
		
		protected function onMouseOut( _evt:MouseEvent ):void{
			if( !_ready ) return;
			try{
//				root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				//dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt ) );
				_hideTimer.running && _hideTimer.stop();
				_hideTimer.start();
			}catch( ex:Error ){}
			//Log.log( 'hide tips' );
			
		}
		
		protected function onTimerHideDone( _evt:TimerEvent ):void{
			//Log.log( 'timer done' );
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS ) );
		}
		
		protected function onMouseClick( _evt:MouseEvent ):void{
			if( !_ready ) return;
//			Log.log( 'onMouseClick' );
			var _pp:PiePart = _evt.currentTarget as PiePart;
			if( !(　_pp && _config.displaySeries.length >= 2 ) )  return;
//			_pp.toggle();
			dispatchEvent( new JChartEvent( JChartEvent.SELECTED, { index: _pp.dataIndex } ) );
		}
		
		protected function onMouseMove( _evt:MouseEvent ):void{
//			Log.log( 1 );
			if( !_ready ) return;
			//Log.log( 'GraphicView onMouseMove', new Date().getTime() );
			var _pp:PiePart = _evt.currentTarget as PiePart;
//			Log.log( 2 );
			if( !_pp ) return;
//			Log.log( 3 );
			//Log.log( _pp.dataIndex );
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _pp.dataIndex } ) );
		}	
				
		private function onPiePartUpdateStatus( _evt:JChartEvent ):void{
			if( !_ready ) return;
			var _data:Object = _evt.data as Object
				, _oindex:int = _config.displaySeriesIndexMap[ _data.index ]
				;
				
			if( _piePart.length === 1 ) {
				return;
			}
			
			if( _oindex > -1 && _oindex != _config.selected ){
				Common.each( _piePart, function( _k:int, _item:PiePart ):Boolean{
					var _r:Boolean = true, _tindex:int = _config.displaySeriesIndexMap[ _item.dataIndex ];
					if( _config.selected === _tindex ){
						_r = false;
						_item.unselected();
					}
					
					return _r;
				});
			}			
			
			if( _data.selected ){
				_config.selected = _oindex;
			}else{
				_config.selected = -1;
			}					
//			Log.log( 'onPiePartUpdateStatus: _config.selected = ', _config.selected );
//			Log.log( _config.selected, _data.selected );			
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{	
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:PieGraphUI ):void{
					_boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			_preIndex = -1;
			
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:PieGraphUI ):void{
					_preIndex >= 0 && _boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			Common.each( _boxs, function( _k:int, _item:PieGraphUI ):void{
				_ix >= 0 && _boxs[ _k ].items[ _ix ].hover();
			});
			
			_preIndex = _ix;
		}
		
	}
}