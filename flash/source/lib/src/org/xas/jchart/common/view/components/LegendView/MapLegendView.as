package org.xas.jchart.common.view.components.LegendView
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class MapLegendView extends BaseLegendView
	{	
		private var linesize:uint = 0.5;
		private var legendArrow:Sprite;
		private var _config:Config;
		
		public function MapLegendView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function showChart( ):void{
			this.graphics.clear();
			var _highColor:String = _config.c.highColor;
			var _lowColor:String = _config.c.lowColor;
			var _m:Matrix = new Matrix();
			var _d:Object = _config.c.legend;
			_m.createGradientBox( _d.height, _d.width, 0, _d.pY, 0 );
			this.graphics.lineStyle(linesize, 0xcccccc);
			this.graphics.beginGradientFill(
				GradientType.LINEAR, 
				[_lowColor, _highColor], 
				[1, 1], 
				[0x00, 0xFF],
				_m, 
				SpreadMethod.PAD
			);
			this.graphics.drawRect( _d.pY, -_d.pX, _d.height, _d.width );
			this.rotation = 90;
			
			legendArrow = new Sprite();
			legendArrow.graphics.lineStyle(linesize, 0x666666);
			legendArrow.graphics.beginFill( 0x666666, 1 );
			legendArrow.graphics.drawTriangles(
				Vector.<Number>([ 
					10,10, 5,5, 0,10
				])
			);
			legendArrow.x = _d.pY;
			legendArrow.y = _d.width - _d.pX;
			legendArrow.visible = false;
			
			addChild(legendArrow);
		}
		
		override protected function updateLegendArrow( _evt:JChartEvent ):void{
			var _d:Object = _config.c.legend,
				_dataOp:Number =  _evt.data.data.value / _config.maxNum;
			
			legendArrow.visible = true;
			legendArrow.alpha = 1;
			TweenLite.to( legendArrow, .3, {
				x: _d.pY - legendArrow.width / 2 + _d.height * _dataOp,
				y: -_d.pX + _d.width - legendArrow.height / 2
			});
			
		}
		
		override protected function hideLegendArrow( _evt:JChartEvent ):void{
			TweenLite.to( legendArrow, .3, {
				alpha: 0
			});
		}
		
	}
}