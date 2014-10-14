package org.xas.jchart.common.view.components.GraphicBgView
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class TrendGraphicBgView extends BaseGraphicBgView
	{
		public function TrendGraphicBgView()
		{
			super();
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			this.graphics.beginFill( 0xffffff, 0 );
			this.graphics.drawRect(
				0, 0, BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight 
			);
			this.x = BaseConfig.ins.c.chartX;
			this.y = BaseConfig.ins.c.chartY;
			this.graphics.endFill();
			
			var tmp:Sprite = new Sprite();
			tmp.graphics.clear();
			tmp.graphics.beginFill( 0xffffff, 1 );
			tmp.graphics.drawRect(
				0, 0, BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight 
			);
			tmp.graphics.endFill();
			addChild(tmp);
		}
		
		override protected function onMouseMove( _evt:MouseEvent ):void{
			var _point:Object = { x: _evt.stageX, y: _evt.stageY }
				, _rect:Object = { 
					x: BaseConfig.ins.c.chartX
						, y: BaseConfig.ins.c.chartY
						, x2: BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth
						, y2: BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartHeight 
				}
				, _ix:int = 0;
			
			if( !Common.pointRectangleIntersection( _point, _rect ) ) return;
			
			_ix = ( _point.x  - _rect.x ) / BaseConfig.ins.c.rhpart;
			
			var _itemLen:int = ( BaseConfig.ins.categories.length - 1 ) * 2
				, _partWidth:Number = ( BaseConfig.ins.c.chartWidth - BaseConfig.ins.c.linePadding ) / _itemLen
				, _realX:Number = _evt.stageX - ( BaseConfig.ins.c.chartX + BaseConfig.ins.c.linePadding / 2 );
			
			_ix = Math.floor( _realX / _partWidth  );
			_ix > 1 && ( _ix = Math.round( _ix / 2 ) );
			
			_ix < 0 && ( _ix = 0 );
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _ix } ) );
		}
	}
}