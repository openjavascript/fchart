package org.xas.jchart.common.view.components.GraphicBgView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class RadarGraphicBgView extends BaseGraphicBgView
	{	
		private var _config:Config;
		
		public function RadarGraphicBgView()
		{
			super();
			
			_config = BaseConfig.ins as Config;
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}

		override protected function showChart( _evt: JChartEvent ):void {
			
			var _bgColor:uint = 0xcccccc
				, _bgAlpha:Number = 0
				
				, _borderColor:uint = 0xcccccc
				, _borderAlpha:uint = 0
				, _borderThickness:uint = 1
				;
			
			if( 'bgColor' in BaseConfig.ins.chartParams ) {
				_bgColor = BaseConfig.ins.chartParams.bgColor;
				_borderColor = BaseConfig.ins.chartParams.bgColor;
			}
			
			if( BaseConfig.ins.chartParams.graphic ) {
				'bgColor' in BaseConfig.ins.chartParams.graphic 
					&& ( _bgColor = BaseConfig.ins.chartParams.graphic.bgColor );
				
				'bgAlpha' in BaseConfig.ins.chartParams.graphic 
					&& ( _bgAlpha = BaseConfig.ins.chartParams.graphic.bgAlpha );
				
				'borderColor' in BaseConfig.ins.chartParams.graphic 
					&& ( _borderColor = BaseConfig.ins.chartParams.graphic.borderColor );
				
				'borderAlpha' in BaseConfig.ins.chartParams.graphic 
					&& ( _borderAlpha = BaseConfig.ins.chartParams.graphic.borderAlpha );
				
				'borderThickness' in BaseConfig.ins.chartParams.graphic 
					&& ( _borderThickness = BaseConfig.ins.chartParams.graphic.borderThickness );
			}
			
			var _g:Graphics = this.graphics;
			
			_g.clear();
			_g.beginFill( _bgColor, _bgAlpha );
//			_g.beginFill( 0xcccccc, 1 );
			_g.lineStyle( _borderThickness, _borderColor, _borderAlpha );
			
			var _outerPointList:Vector.<Point> = _config.c.radarBgPoint[ 0 ];
			Common.each( _outerPointList, function( _idx:Number, _point:Point ):void {
				if( _idx === 0 ) {
					_g.moveTo( _point.x, _point.y );
				}
				_g.lineTo( _point.x, _point.y );
			} );
			_g.lineTo( _outerPointList[0].x, _outerPointList[0].y );
			_g.endFill();
		}
		
		override protected function addToStage( _evt:Event ):void {
			this.root.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		override protected function onMouseMove( _evt:MouseEvent ):void {
			
			var _mousePoint:Point = new Point( _evt.stageX, _evt.stageY )
				,  _partAngle:Number = _config.c.partAngle;
			
			if( this.hitTestPoint( _mousePoint.x, _mousePoint.y, true ) ) {//检测 mouseEnter
				
				dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, _evt ) );
				
				var _pointAngle:Number = ( GeoUtils.pointAngle( _config.c.centerPoint, _mousePoint ) + 90 ) % 360
					, _index:int = ( _pointAngle + _partAngle / 2 ) / _partAngle;
				
				_index = Math.max( 0, _index );
				if( _index > _config.categories.length - 1 ) {
					_index = 0;
				}
				
				dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _index } ) );
			} else {
				dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt ) );
			}
		}
	}
}