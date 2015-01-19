package org.xas.jchart.common.view.components.GraphicBgView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class PieGraphicBgView extends BaseGraphicBgView
	{	
		public function PieGraphicBgView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			var _bgColor:uint = 0xcccccc
				, _bgAlpha:Number = 0
				
				, _borderColor:uint = 0xcccccc
				, _borderAlpha:uint = 0
				, _borderThickness:uint = 1
				;
			
			if( 'bgColor' in BaseConfig.ins.chartParams ){
				_bgColor = BaseConfig.ins.chartParams.bgColor;
				_borderColor = BaseConfig.ins.chartParams.bgColor;
			}
//			if( 'bgAlpha' in BaseConfig.ins.chartParams ){
//				_bgAlpha = BaseConfig.ins.chartParams.bgAlpha;
//			}
			
			if( BaseConfig.ins.chartParams.graphic ){
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
			
			this.graphics.beginFill( _bgColor, _bgAlpha );
			this.graphics.lineStyle( _borderThickness, _borderColor, _borderAlpha );
			this.graphics.drawRect(
				0, 0, BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight 
			);
			this.x = BaseConfig.ins.c.chartX;
			this.y = BaseConfig.ins.c.chartY;
			this.graphics.endFill();
		}


	}
}