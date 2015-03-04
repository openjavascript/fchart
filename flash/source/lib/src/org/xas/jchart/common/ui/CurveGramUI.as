package org.xas.jchart.common.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
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
	
	public class CurveGramUI extends JSprite
	{
		private var _cmd:Vector.<int>;
		private var _path:Vector.<Number>;
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
		
		private var _lineSmooth:Boolean = false;
		
		public function CurveGramUI( 
			_cmd:Vector.<int>
			, _path:Vector.<Number>
			, _color:uint
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
			( 'lineSmooth' in _data ) && ( _lineSmooth = _data.lineSmooth );
			
			if( this.data.hoverShow ){
				_iconRadius = 3;
			}	
			
			this._cmd = _cmd;
			this._path = _path;
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
			var _newVectorPath:Vector.<Point> = new Vector.<Point>();
			
			if( _config.lineSmoothEnable ) {
				var _p:Point
					, _newPoint: Point
					, _smoothType: String = _config.lineSmoothType;
				
				_newVectorPath.push( _vectorPath[ 0 ] );
				for( var _idx:Number = 1; _idx < _vectorPath.length; _idx++ ) {
					_p = _vectorPath[ _idx ] as Point;
					
					if( _smoothType == "0" ){
						_newPoint = new Point( _vectorPath[ _idx - 1 ].x, _p.y );
					} else if ( _smoothType == "1" ) {
						_newPoint = new Point( _p.x, _vectorPath[ _idx - 1 ].y );
					}
					
					_newVectorPath.push( _newPoint );
					_newVectorPath.push( _p );
				}
			}
			if( data.animationEnabled && _vectorPath && _vectorPath.length > 1 ) {
				animationDraw( _newVectorPath );
			} else {
				staticDraw( _newVectorPath );
			}
		}
		
		private function animationDraw( _pathData:Vector.<Point> ):void{
			
			if( !_pathData || _pathData.length == 0 ) {
				_pathData = _vectorPath as Vector.<Point>;
			}
			
			var _maskLine:JLine = new JLine( null, null, {} );
			var _g:Graphics = _maskLine.graphics;
			var _prePoint:Point = _pathData[0];
			var _data:BaseLineData = new BaseLineData();
			var _drawPointLen:Number = 1;
			var _pathPoint :Vector.<Point> = new Vector.<Point>;
			var tmpPoint:Point;
			var _totalLength:Number = _data.totalLineLength( _pathData );
			var _maskWidth:Number = 2;
			var _tmpAngle:Number;
			var _tmpCosWidth:Number;
			var _tmpSinWidth:Number;
			
			_g.moveTo( _prePoint.x, _prePoint.y );
			_g.beginFill( 0xff0000, 1);
			
			_jline = new JLine( _pathData, _lineType, { thickness: 2, lineColor: _color } );			
			
			_maskLine.count = 0;
			_jline.mask = _maskLine;

			if( _config.lineEnable ) {
				addChild( _jline );
				addChild( _maskLine );
			}
			
		 	TweenLite.delayedCall( data.delay, function():void{
				TweenLite.to( _maskLine, data.duration, { count: _totalLength
					, onUpdate: function():void{
						
						_pathPoint = _data.calPosition( _pathData, _maskLine.count );
						
						for( var _i:Number = _drawPointLen - 1; _i < _pathPoint.length; _i++ ) {
							tmpPoint = _pathPoint[ _i ];
							
							if( _config.lineSmoothEnable ){//平滑动画
								_tmpAngle = GeoUtils.pointAngle( _prePoint, tmpPoint );
								if( _tmpAngle > 90 ) {
									_tmpAngle = _tmpAngle % 90;
								}
								
								if( !isNaN( _tmpAngle ) ) {
									if( _prePoint.y > tmpPoint.y ) {
										_tmpAngle = 90 - _tmpAngle;
										
										_tmpSinWidth = _maskWidth * Math.sin( GeoUtils.radians( _tmpAngle ) );
										_tmpCosWidth = _maskWidth * Math.cos( GeoUtils.radians( _tmpAngle ) );
										
										_g.moveTo( _prePoint.x - _tmpSinWidth, _prePoint.y - _tmpCosWidth );
										_g.lineTo( _prePoint.x + _tmpSinWidth, _prePoint.y + _tmpCosWidth );
										_g.lineTo( tmpPoint.x + _tmpSinWidth, tmpPoint.y + _tmpCosWidth );
										_g.lineTo( tmpPoint.x - _tmpSinWidth, tmpPoint.y - _tmpCosWidth );
										_g.lineTo( _prePoint.x - _tmpSinWidth, _prePoint.y - _tmpCosWidth );
									} else {
										_tmpSinWidth = _maskWidth * Math.sin( GeoUtils.radians( _tmpAngle ) );
										_tmpCosWidth = _maskWidth * Math.cos( GeoUtils.radians( _tmpAngle ) );
										
										_g.moveTo( _prePoint.x - _tmpSinWidth, _prePoint.y + _tmpCosWidth );
										_g.lineTo( _prePoint.x + _tmpSinWidth, _prePoint.y - _tmpCosWidth );
										_g.lineTo( tmpPoint.x + _tmpSinWidth, tmpPoint.y - _tmpCosWidth );
										_g.lineTo( tmpPoint.x - _tmpSinWidth, tmpPoint.y + _tmpCosWidth );
										_g.lineTo( _prePoint.x - _tmpSinWidth, _prePoint.y + _tmpCosWidth );
									}
								}
							} else {//直接连接动画
								_g.moveTo( _prePoint.x, _prePoint.y - 5 );
								_g.lineTo( tmpPoint.x, tmpPoint.y - 5 );
								_g.lineTo( tmpPoint.x, tmpPoint.y + 5 );							
								_g.lineTo( _prePoint.x, _prePoint.y + 5 );
								_g.lineTo( _prePoint.x, _prePoint.y - 5 );
							}
							_g.moveTo( tmpPoint.x, tmpPoint.y );
							_prePoint = tmpPoint;
						}
						_drawPointLen = _pathPoint.length;
						if( _maskLine.count == _totalLength ){
							_jline.mask = null;
							_maskLine.visible = false;
							drawIcon();
						}
					}
				});
			});
		}
		
		private function staticDraw( _pathData:Vector.<Point> ):void{
			
			if( !_pathData || _pathData.length == 0 ) {
				_pathData = _vectorPath as Vector.<Point>;
			}
			
			graphics.lineStyle( 2, _color );
			if( _pathData ){
				if( _config.lineEnable ) {
					_jline = new JLine( _pathData, _lineType, { thickness: 2, lineColor: _color } );
					addChild( _jline );
				}
			} else {
				graphics.drawPath( _cmd, _path );
			}
			drawIcon();
		}
		
		private function drawIcon():void{
			
			if( !this.data.pointEnabled ) return;
			
			var _lineBreakEnable:Boolean = _config.lineBreakEnable
				, _x:Number
				, _y:Number
				, _tmp:Point
				, _tmpItem:CircleIcon;
			
			_point = new Vector.<Point>;
			_items = new Vector.<CircleIcon>();

	
			var _count:int = 0;
			while( _path.length ) {
				
				_x = _path.shift();
				_y = _path.shift();
				_tmp = new Point( _x, _y );
				_tmpItem = new CircleIcon( _tmp, _color, _iconRadius, _turnColor, { dataIndex: _count } );
				
				_point.push( _tmp );
				_items.push( _tmpItem );
				_tmpItem.addEventListener( MouseEvent.CLICK, pointClick );
				
				if( this.data.hoverShow ){
					_tmpItem.visible = false;
				}
				
				if( _config.c.maxY != _y || !_lineBreakEnable ) {
					addChild( _tmpItem  );
				}
				_count++;
			}
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

