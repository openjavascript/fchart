package org.xas.jchart.common.view.components.SerialLabel
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class VHistogramSerialLabelView extends BaseSerialLabelView
	{	
		public function VHistogramSerialLabelView()
		{
			super();
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();			
			this.graphics.beginFill( 0xcccccc, .13 );
						
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.rects ) ) return;
			Common.each( BaseConfig.ins.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					
					if( BaseConfig.ins.serialLabelEnabled ){
						
						var _label:JTextField = new JTextField( _sitem );
						_label.text = StringUtils.printf( BaseConfig.ins.dataLabelFormat, Common.moneyFormat( _sitem.value, 3, BaseConfig.ins.floatLen ) );
						
						_label.autoSize = TextFieldAutoSize.LEFT;
						_label.selectable = false;
						_label.textColor = BaseConfig.ins.itemColor( _sk );
						_label.mouseEnabled = false;
						
						var _maxStyle:Object = {};
						if( _sitem.value == BaseConfig.ins.maxValue ){
							_maxStyle = BaseConfig.ins.maxItemParams.style || _maxStyle;
						}
						
						Common.implementStyle( _label, [ { size: 14 }, _maxStyle ] );
						EffectUtility.textShadow( _label as TextField, { color: BaseConfig.ins.itemColor( _sk ), size: 12 }, 0xffffff );
						
						_label.y = _sitem.y + _sitem.height / 2 - _label.height / 2;
						
						//Log.log(_sitem.x);
						if( _sitem.value >= 0 ){
							_label.x = _sitem.x + 5 + (!!_sitem.width ? _sitem.width : 0);
						}else{
							_label.x = _sitem.x - _label.width - 5;
						}
						//Log.log( _label.x);
						addChild( _label );
						
						( _label.height > _maxHeight ) && ( _maxHeight = _label.height );
					}
					
				});
			});
		}

	}
}