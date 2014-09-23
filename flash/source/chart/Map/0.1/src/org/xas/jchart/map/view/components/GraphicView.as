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
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
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
		
		private var _mask:Sprite = new Sprite();
		
		public function GraphicView()
		{
			super(); 
			_config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		private function addToStage( _evt:Event ):void{
		}

		private function update( _evt:JChartEvent ):void{
			graphics.clear();
			
			if( !( BaseConfig.ins.cd.series && BaseConfig.ins.cd.series[0].data ) ) return;
			_boxs = new Vector.<JSprite>();
			
			var _c:Object = BaseConfig.ins.c;
			var _op:Number = _c.op;
			var _startX:Number = ( BaseConfig.ins.stageWidth - _op * _c.oriWidth ) / 2;
			var _startY:Number = ( _c.mapHeight - _op * _c.oriHeight ) / 2;
			var _baseX:Number = _c.oriX1;
			var _baseY:Number = _c.oriY1;
			var _midLine:Number = _startY + _op * _c.oriHeight / 2;
			var _tmpY:Number = 0;
			var _tmpX:Number = 0;
			var _box:JSprite;
			var _type:String;
			
			_ms.x = _c.minX;
			_ms.y = _c.minY;
			_ms.width = _c.maxX - _c.minX;
			_ms.height = _c.maxY - _c.minY;
			
			_mapStage.graphics.beginFill( 0xffffff, 1 );
			//_mapStage.graphics.lineStyle(1,0x000000);
			_mapStage.graphics.drawRect( _ms.x, _ms.y, _ms.width, _ms.height );
			
			_cameraStage.graphics.beginFill( 0xffffff, 0 );
			//_cameraStage.graphics.lineStyle(1,0xff0000);
			_cameraStage.graphics.drawRect( 0, 0, _ms.width, _ms.height );
			_cameraStage.x = _ms.x;
			_cameraStage.y = _ms.y;
			_cameraStage.width = _ms.width;
			_cameraStage.height = _ms.height;
			
			Common.each( _config.mapData, function( _i:int, _item:Object ):void{
				_box = new JSprite( { index: _i, data: _item } );
				_type = _item.type;

				_box.graphics.beginFill( _c.colorArray[ _i ], 1 );
				_box.graphics.lineStyle(0.5, 0xffffff);
				Common.each( _item.coordinates, function( _k:int, _sitem:Object ):void{
					if( _type == "MultiPolygon" ){
						Common.each( _sitem, function( _j:int, _vitem:Object ):void{
							_tmpX = _startX + ( _vitem[0] - _baseX ) * _op;
							_tmpY = _startY + ( _vitem[1] - _baseY ) * _op;
							if( _j == 0 ){
								_box.graphics.moveTo( _tmpX, _midLine * 2 - _tmpY );
							} else {
								_box.graphics.lineTo( _tmpX, _midLine * 2 - _tmpY );
							}
						});
					} else {
						_tmpX = _startX + ( _sitem[0] - _baseX ) * _op;
						_tmpY = _startY + ( _sitem[1] - _baseY ) * _op;
						if( _k == 0 ){
							_box.graphics.moveTo( _tmpX, _midLine * 2 - _tmpY );
						} else {
							_box.graphics.lineTo( _tmpX, _midLine * 2 - _tmpY );
						}
					}
				});
				
				_box.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				_box.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				_box.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				
				_boxs.push( _box );
				
				_cameraStage.addChild( _box );
			});
			
			_cameraStage.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			
			_mask.graphics.beginFill( 0x000000 );
			_mask.graphics.drawRect( _ms.x, _ms.y, _ms.width + 1, _ms.height + 1  );
			this.mask = _mask;
			
			_mapStage.addChild( _cameraStage );
			addChild( _mapStage );
			addChild( _mask );
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			_preIndex = -1;
		}
		
		private function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			if( !_boxs[ _ix ] ) return;
			
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			
			_boxs[ _ix ].alpha = .65;
			_preIndex = _ix;
		}
		
		protected function onMouseOver( _evt:MouseEvent ):void{
			var _target:JSprite = _evt.target as JSprite;
			var _ix:int = _target.data.index;
			
//			var ct:ColorTransform = new ColorTransform();
//			ct.color = BaseConfig.ins.c.hoverColor;
//			_target.transform.colorTransform = ct;
			
			TweenPlugin.activate( [TintPlugin] );
			TweenLite.to( _target, 0, { tint: _config.hoverColor } );
			
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, { evt:_evt, index: _ix } ) );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_LEGEND_ARROW, { evt:_evt, data: _target.data.data } ) );
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
			
//			var ct:ColorTransform = new ColorTransform();
//			_target.transform.colorTransform = ct;
			
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_LEGEND_ARROW, { evt:_evt, index: _ix } ) );
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, { evt:_evt, index: _ix } ) );
		}
		
		protected function onMouseWheel( _evt:MouseEvent ):void{
			if( !_config.zoomEnabled ){
				return;
			}

			var _spd:Number = _config.zoomSpeed,
				_scaleOp:Number = _evt.delta * _config.zoomRate,
				_minX:Number = 0, _maxX:Number = 0,
				_minY:Number = 0, _maxY:Number = 0;
			
			if( _cameraStage.width * ( 1 + _scaleOp ) < _ms.width ){//缩小边界
				TweenLite.to(_cameraStage, _spd, {
					x: _ms.x,
					y: _ms.y,
					scaleX: 1,
					scaleY: 1
				});
				return;
			}
			
			_minX = _cameraStage.x + _evt.localX * ( -_scaleOp );
			_maxX = _minX + _ms.width * ( _cameraStage.scaleX + _scaleOp );
			_minY = _cameraStage.y + _evt.localY * ( -_scaleOp );
			_maxY = _minY + _ms.height * ( _cameraStage.scaleY + _scaleOp );
			
			_minX > _ms.x && ( _minX = _ms.x );
			( _maxX < _ms.x + _ms.width ) && ( _minX = _minX + _ms.x + _ms.width - _maxX );
			_minY > _ms.y && ( _minY = _ms.y );
			( _maxY < _ms.y + _ms.height ) && ( _minY = _minY + _ms.y + _ms.height - _maxY );
			
			TweenLite.to(_cameraStage, _spd, {
				x: _minX,
				y: _minY,
				scaleX: _cameraStage.scaleX + _scaleOp,
				scaleY: _cameraStage.scaleY + _scaleOp
			});
		}
	}
}