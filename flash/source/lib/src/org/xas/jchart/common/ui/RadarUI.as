package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	
	import mx.skins.halo.PopUpMenuIcon;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.LineProxy;
	import org.xas.jchart.common.proxy.data.line.BaseLineData;
	import org.xas.jchart.common.ui.icon.*;
	import org.xas.jchart.common.ui.widget.JLine;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class RadarUI extends JSprite
	{
		private var _color:Number;
		private var _point:Vector.<Point>;
		private var _items:Vector.<CircleIcon>;
		public function get items():Vector.<CircleIcon>{ return _items; }
		private var _jline:JLine;
		private var _vectorPath:Vector.<Point>;
		private var _lineType:String;
		private var _thickness:Number;
		
		private var _duration:Number = .75;
		private var _delay:Number = 0;
		public var tint:Number = 0;
		
		private var _config:Config;
		private var _turnColor:Boolean;
		
		private var _iconRadius:int = 5;
		
		public function RadarUI( 
			_color:uint
			, _vecotrPath:Vector.<Point> = null
			, _lineType:String = 'Solid'
			, _data:Object = null
		) {
			_data = _data || {};
			super(_data);
					
			( 'duration' in _data ) &&  ( _duration =  _data.duration );
			( 'delay' in _data ) &&  ( _delay =  _data.delay );
			( 'turnColor' in _data ) &&  ( _turnColor =  _data.turnColor );
			( 'iconRadius' in _data ) &&  ( _iconRadius =  _data.iconRadius );
			
			if( this.data.hoverShow ) {
				_iconRadius = 3;
			}	
			
			this._color = _color;
			this._vectorPath = _vecotrPath;
			this._lineType = _lineType;
			this._thickness = 2;
			
			this._config = BaseConfig.ins as Config;			

			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
			addEventListener( JChartEvent.UPDATE_STATUS, updateStatus );
		}
		
		private function updateStatus( _evt:JChartEvent ):void{
			var _data:Object = _evt.data
				, _index:int = _data.index
				;
			
			if( _data.action == 'show' ){
				if( this.data.hoverShow ){
					items[ _index ].visible = true;
				}
				items[ _index ].hover();
			}else{
				if( this.data.hoverShow ){
					items[ _index ].visible = false;
				}
				items[ _index ].unhover();
			}
		}
		
		private function init():void{
			if( data.animationEnabled && _vectorPath && _vectorPath.length > 1 ) {
				animationDraw( _vectorPath );
			} else {
				staticDraw( _vectorPath );
			}
		}
		
		private function animationDraw( _pathData:Vector.<Point> ):void{
			
			var _pointMovePath:Vector.<Object> = new Vector.<Object>()
				, _centerPoint:Point = _config.c.centerPoint as Point
				, _initPath:Vector.<Point> = new Vector.<Point>()
				, _angles:Array = _config.c.radarAngle;
			
			
			Common.each( _vectorPath, function( _idx:Number, _p:Point ):void {
				_pointMovePath[ _idx ] = {
					'pointLength': GeoUtils.pointLength(
						_p.x, _p.y
						, _centerPoint.x, _centerPoint.y
					)
					, 'angle': _angles[ _idx ]
				}
				
				_initPath.push( new Point( _centerPoint.x, _centerPoint.y ) );
			} );
			
			_jline = new JLine( _initPath, _lineType, { thickness: 2, lineColor: _color } );
			_jline.count = 0;
			
			if( _config.lineEnable ) {
				addChild( _jline );
			}
			
			var _percent:Number = 100
				, _tmpPathObj:Object
				, _tmpLen:Number;
			
			TweenLite.delayedCall( data.duration, function():void {
				TweenLite.to( _jline, _config.animationDuration, { 
					count: _percent
					, ease: Expo.easeInOut
					, onUpdate: function():void {
						
						Common.each( _initPath, function( _idx:Number, _p:Point ):void {
							
							_tmpPathObj = _pointMovePath[ _idx ];
							
							_tmpLen = _tmpPathObj.pointLength * _jline.count / _percent;
							
							_initPath[ _idx ] = GeoUtils.calcPointByCenter( _centerPoint, _tmpLen, _tmpPathObj.angle );
						} );
						
						var _g:Graphics = _jline.graphics;
						_g.clear();
						_g.lineStyle( 2, _color );
						Common.each( _initPath, function( _idx:Number, _p:Point ):void {
							if( _idx === 0 ) {
								_g.moveTo( _p.x, _p.y );
							} else {
								_g.lineTo( _p.x, _p.y );
							}
						} );
						_g.lineTo( _initPath[ 0 ].x, _initPath[ 0 ].y );
						
						if( _jline.count === _percent ) {
							drawIcon();
						}
					}
				} );
			} );
		}
		
		private function staticDraw( _pathData:Vector.<Point> ):void{
			graphics.lineStyle( 2, _color );
			
			Common.each( _vectorPath, function( _idx:Number, _point:Point ):void {

				if( _idx === 0 ){
					graphics.moveTo( _point.x, _point.y );
				} else {
					graphics.lineTo( _point.x, _point.y );
				}
			} );
			
			graphics.lineTo( _vectorPath[ 0 ].x, _vectorPath[ 0 ].y );
			drawIcon();
		}
		
		private function drawIcon():void{
			
			if( !this.data.pointEnabled ) return;
			
			_point = new Vector.<Point>;
			_items = new Vector.<CircleIcon>();

			var _count:int = 0
				, _tmpItem:CircleIcon
				, _data:Object = this.data;
			
			Common.each( _vectorPath, function( _idx:Number, _point:Point ):void {
				_tmpItem = new CircleIcon( _point, _color, _iconRadius, _turnColor, { dataIndex: _count } );
				
				_tmpItem.addEventListener( MouseEvent.CLICK, pointClick );
				
				_items.push( _tmpItem );
				
				if( _data.hoverShow ){
					_tmpItem.visible = false;
				}
				
				addChild( _tmpItem  );
				_count++;
			} );
		}
		
		private function pointClick( _evt:MouseEvent ):void{
			var _ui:CircleIcon = _evt.currentTarget as CircleIcon, _data:Object;
			if( !_ui.data ) return;
			_data = Common.extendObject( { seriesIndex: this.seriesIndex }, _ui.data );
			//Log.printFormatJSON( _ui.data );
			BaseConfig.ins.facade.sendNotification( JChartEvent.UI_ITEM_CLICK, _data, 'line' );
		}
		
		public function get seriesIndex():int{
			return this.data.seriesIndex || this.data.index;
		}
	}
}

