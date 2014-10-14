package org.xas.jchart.map.view.components
{
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<JSprite>;
		private var _preIndex:int = -1;
		private var lowColor:uint = 0xffffff;
		private var _cameraStage:Sprite = new Sprite();
		private var _mapStage:Sprite = new Sprite();
		private var _ms:Object = new Object();
		private var _config:Config;
		private var _dragPoint:Object;
		private var _pointList:Array = new Array();
		
		private var _mask:Sprite = new Sprite();
		
		public function GraphicView()
		{
			super(); 
			_config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );
			addEventListener( JChartEvent.UPDATE_MOUSEWHEEL, onUpdateMouseWheel );
		}
		
		private function addToStage( _evt:Event ):void{
		}

		private function update( _evt:JChartEvent ):void{
			graphics.clear();
			
			if( !( BaseConfig.ins.cd.series && BaseConfig.ins.cd.series[0].data ) ) return;
			_boxs = new Vector.<JSprite>();
			
			var _c:Object = BaseConfig.ins.c;
			var _op:Number = _c.op;
			var _startX:Number = ( _c.mapWidth - _op * _c.oriWidth ) / 2;
			var _startY:Number = ( _c.mapHeight - _op * _c.oriHeight ) / 2;
			var _baseX:Number = _c.oriX1;
			var _baseY:Number = _c.oriY1;
			var _midLine:Number = _startY + _op * _c.oriHeight / 2;
			var _tmpObj:Object;
			var _box:JSprite;
			var _type:String;
			
			_ms.x = _c.minX;
			_ms.y = _c.minY;
			_ms.width = _c.maxX - _c.minX;
			_ms.height = _c.maxY - _c.minY;
			
			_mapStage.graphics.beginFill( 0xffffff, 1 );
			_mapStage.graphics.drawRect( _ms.x, _ms.y, _ms.width, _ms.height );
			
			_cameraStage.graphics.beginFill( 0xffffff, 0 );
			_cameraStage.graphics.drawRect( 0, 0, _ms.width, _ms.height );
			_cameraStage.x = _ms.x;
			_cameraStage.y = _ms.y;
			_cameraStage.width = _ms.width;
			_cameraStage.height = _ms.height;
			
			Common.each( _config.mapData, function( _i:int, _item:Object ):void{
				_box = new JSprite( { index: _i, data: {
					id: _item.id,
					name: _item.name,
					value: _item.value
				} });
				_type = _item.type;

				_box.graphics.beginFill( _c.colorArray[ _i ], 1 );
				_box.graphics.lineStyle(0.5, 0xffffff);
				
				Common.each( _item.coordinates, function( _k:int, _sitem:Object ):void{
					if( _type == "MultiPolygon" ){
						Common.each( _sitem, function( _j:int, _vitem:Object ):void{
							_tmpObj = {
								x: _startX + ( _vitem[0] - _baseX ) * _op,
								y: _startY + ( _vitem[1] - _baseY ) * _op
							}
							if( _j == 0 ){
								_box.graphics.moveTo( _tmpObj.x, _midLine * 2 - _tmpObj.y );
							} else {
								_box.graphics.lineTo( _tmpObj.x, _midLine * 2 - _tmpObj.y );
							}
						});
					} else {
						_tmpObj = {
							x: _startX + ( _sitem[0] - _baseX ) * _op,
							y: _startY + ( _sitem[1] - _baseY ) * _op
						}
						if( _k == 0 ){
							_box.graphics.moveTo( _tmpObj.x, _midLine * 2 - _tmpObj.y );
						} else {
							_box.graphics.lineTo( _tmpObj.x, _midLine * 2 - _tmpObj.y );
						}
					}
				});
				
				_box.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				_box.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				_box.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				_box.addEventListener( MouseEvent.CLICK, onMouseClick );
				
				_boxs.push( _box );
				
				_cameraStage.addChild( _box );
			});
			
			_cameraStage.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			_cameraStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			_mask.graphics.beginFill( 0x000000 );
			_mask.graphics.drawRect( _ms.x, _ms.y, _ms.width + 1, _ms.height + 1  );
			this.mask = _mask;
			
			_mapStage.addChild( _cameraStage );
			addChild( _mapStage );
			addChild( _mask );
			
			if( ExternalInterface.available && _config.c.initedCallback ){
				ExternalInterface.call( _config.c.initedCallback );
			}
		}
		
		protected function onMouseOver( _evt:MouseEvent ):void{
			var _target:JSprite = _evt.target as JSprite;
			var _ix:int = _target.data.index;
			
			TweenPlugin.activate( [TintPlugin] );
			TweenLite.to( _target, 0, { tint: _config.hoverColor } );
			
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, { evt:_evt, index: _ix } ) );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_LEGEND_ARROW, { evt:_evt, data: _target.data.data } ) );
			
			if( ExternalInterface.available && _config.c.hoverCallback ){
				ExternalInterface.call( _config.c.hoverCallback, _boxs[ _ix ].data );
			}
		}
		
		protected function onMouseMove( _evt:MouseEvent ):void{
			var _target:JSprite = _evt.target as JSprite;
			var _ix:int = _target.data.index;
			
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt:_evt, index: _ix } ) );
		}
		
		protected function onMouseOut( _evt:MouseEvent ):void{
			var _target:JSprite = _evt.target as JSprite;
			var _ix:int = _target.data.index;
			
			TweenPlugin.activate( [TintPlugin] );
			TweenLite.to( _target, .5, {tint: null} );
			
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_LEGEND_ARROW, { evt:_evt, index: _ix } ) );
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, { evt:_evt, index: _ix } ) );
		}
		
		protected function onMouseClick( _evt:MouseEvent ):void{
			var _target:JSprite = _evt.target as JSprite;
			var _ix:int = _target.data.index;
			
			if( ExternalInterface.available && _config.c.clickCallback ){
				ExternalInterface.call( _config.c.clickCallback, _boxs[ _ix ].data );
			}
		}
		
		protected function onUpdateMouseWheel( _evt:JChartEvent ):void{
			var _data:Object = _evt.data as Object;
			if( ExternalInterface.available ){
				//ExternalInterface.call( 'console.log', 'flash onUpdateMouseWheel:', _data.delta );
				_data.localX = mouseX - _ms.x;
				_data.localY = mouseY - _ms.y;
				
				updateMouseWheel( _data );
			}
		}
		
		protected function onMouseWheel( _evt:MouseEvent ):void{
			var _tmp:Point = new Point( _ms.x, _ms.y );
			updateMouseWheel( { delta: _evt.delta, localX: _evt.localX, localY: _evt.localY } );
		}
		
		protected function updateMouseWheel( _data:Object ):void{
			if( !_config.zoomEnabled ){
				return;
			}
			
			var _spd:Number = _config.zoomSpeed,
				_scaleOp:Number = _data.delta * _config.zoomRate,
				_minX:Number = 0, _maxX:Number = 0,
				_minY:Number = 0, _maxY:Number = 0;
			
			if( ExternalInterface.available ){
				//ExternalInterface.call( 'console.log', '_data.delta:', _data.delta );
				//ExternalInterface.call( 'console.dir',  _data );
			}else{
				//Log.log( '_data.delta:', _data.delta, _config.zoomRate, _config.zoomSpeed );
			}
			
			if( _cameraStage.width * ( 1 + _scaleOp ) < _ms.width ){//缩小边界
				TweenLite.to(_cameraStage, _spd, {
					x: _ms.x,
					y: _ms.y,
					scaleX: 1,
					scaleY: 1
				});
				return;
			}
			
			_minX = _cameraStage.x + _data.localX * ( -_scaleOp );
			_maxX = _minX + _ms.width * ( _cameraStage.scaleX + _scaleOp );
			_minY = _cameraStage.y + _data.localY * ( -_scaleOp );
			_maxY = _minY + _ms.height * ( _cameraStage.scaleY + _scaleOp );
			
			_minX > _ms.x && ( _minX = _ms.x );
			_minY > _ms.y && ( _minY = _ms.y );
			
			_maxX < _ms.x + _ms.width 
				&& ( _minX = _minX + _ms.x + _ms.width - _maxX );
			_maxY < _ms.y + _ms.height 
				&& ( _minY = _minY + _ms.y + _ms.height - _maxY );
			
			TweenLite.to(_cameraStage, _spd, {
				x: _minX,
				y: _minY,
				scaleX: _cameraStage.scaleX + _scaleOp,
				scaleY: _cameraStage.scaleY + _scaleOp
			});	
		}
		
		protected function onMouseDown( _evt:MouseEvent ):void{
			_dragPoint = {
				x: _evt.localX,
				y: _evt.localY
			};
			
			_cameraStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_cameraStage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseDrag);
		}
		
		protected function onMouseUp( _evt:MouseEvent ):void{
			Mouse.cursor = MouseCursor.AUTO;
			_cameraStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_cameraStage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseDrag);
			
			
//			if(_pointList.length < 2){ return; }
//			var _acc:Number = 10;
//			var _durTime:Number = ( _pointList[1].time - _pointList[0].time )/100;
//			var _sX:Number = _pointList[1].x - _pointList[0].x;
//			var _sY:Number = _pointList[1].y - _pointList[0].y;
//			var _s:Number = Math.sqrt( Math.pow( _sX, 2 ) + Math.pow( _sY, 2 ) );
//			var _spd:Number = _s / _durTime;
//			var _totT:Number = _spd / _acc;
//			Log.log(_totT);
//			var _fulS:Number = _acc * Math.pow( _totT, 2);
//			Log.log("_fulS : "+_fulS);
//			var _fuX:Number = _cameraStage.x + _sX / _s * _fulS;
//			var _fuY:Number = _cameraStage.y + _sY / _s * _fulS;
//			
//			TweenLite.to( _cameraStage, _totT, {
//				x: _fuX,
//				y: _fuY
//			});
			
			_pointList = new Array();
		}
		
		private function onMouseDrag( _evt:MouseEvent ):void{
			Mouse.cursor = MouseCursor.HAND;
			var tmpX:Number = _cameraStage.x + _evt.localX - _dragPoint.x;
			var tmpY:Number = _cameraStage.y + _evt.localY - _dragPoint.y;
			
			tmpX > _config.c.minX && ( tmpX = _config.c.minX );
			tmpY > _config.c.minY && ( tmpY = _config.c.minY );
			
			tmpX + _cameraStage.width < _config.c.maxX 
				&& ( tmpX = _config.c.maxX - _cameraStage.width );
			tmpY + _cameraStage.height < _config.c.maxY 
				&& ( tmpY = _config.c.maxY - _cameraStage.height );
			
			_cameraStage.x = tmpX;
			_cameraStage.y = tmpY;
			
//			_pointList.push({
//				x: _evt.stageX,
//				y: _evt.stageY,
//				time: new Date().time
//			});
//			_pointList.length > 2 && _pointList.pop();
		}
		
	}
}