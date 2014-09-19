package org.xas.jchart.common.view.components.LegendView
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import flash.events.MouseEvent;
	
	public class MapLegendView extends BaseLegendView
	{	
		private var linesize:uint = 0.5;
		private var legendArrow:Sprite;
		
		public function MapLegendView()
		{
			super();
		}
		
		override protected function showChart( ):void{
			this.graphics.clear();
			
			var _m:Matrix = new Matrix();
			var _d:Object = BaseConfig.ins.c.legend;
			_m.createGradientBox( _d.height, _d.width, 0, _d.pY, 0 );
			this.graphics.lineStyle(linesize, 0xcccccc);
			this.graphics.beginGradientFill(
				GradientType.LINEAR, 
				[0xffffff, 0x2f7ed8], 
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
			legendArrow.visible = false;
			
			addChild(legendArrow);
		}
		
		override protected function updateLegendArrow( _evt:JChartEvent ):void{
			var _d:Object = BaseConfig.ins.c.legend,
				_dataOp:Number =  _evt.data.data.value / BaseConfig.ins.maxNum;
			
			legendArrow.x = _d.pY - legendArrow.width / 2 + _d.height * _dataOp;
			legendArrow.y = -_d.pX + _d.width - legendArrow.height / 2;
			legendArrow.visible = true;
		}
		
		override protected function hideLegendArrow( _evt:JChartEvent ):void{
			legendArrow.visible = false;
		}
		
	}
}