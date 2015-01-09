package org.xas.jchart.common.view.components.SerialLabel
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
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
	
	public class HistogramSerialLabelView extends BaseSerialLabelView
	{	
		private var _config:BaseConfig;
		
		public function HistogramSerialLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();			
			this.graphics.beginFill( 0xcccccc, .13 );
						
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.rects ) ) return;
			//Log.log( BaseConfig.ins.floatLen );
			Common.each( BaseConfig.ins.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					
					if( BaseConfig.ins.serialLabelEnabled ){
						
						var _label:JTextField = new JTextField( _sitem )
							, _x:Number = 0
							, _y:Number = 0
							;
							
						_label.text = BaseConfig.ins.serialDataLabelValue( _sk, _k );
						
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
						
						_x = _sitem.x + _sitem.width / 2 - _label.width / 2;
						if( _sitem.value >= 0 ){
							_y = _sitem.y - _label.height - 2;
						}else{
							_y = _sitem.y + _sitem.height + 2;
						}
						
						if( _x < 0 ){ 
							_x = 0;
						}else if( _x + _label.width >= _config.stageWidth ){
							_x = _config.stageWidth - _label.width;
						}
						
						if( _y < 0 ){
							_y = 0;
						}else if( _y + _label.height > _config.stageHeight ){
							_y = _config.stageHeight - _label.height;
						}
						
						_label.x = _x;
						_label.y = _y;
						
						if( BaseConfig.ins.animationEnabled ){
							_label.alpha = 0;
							TweenLite.delayedCall( BaseConfig.ins.animationDuration, 
								function():void{
									TweenLite.to( _label, BaseConfig.ins.animationDuration
										, { 
											alpha: 1, ease: Expo.easeOut 
										} );
								});
						}
						
						addChild( _label );
						
						( _label.height > _maxHeight ) && ( _maxHeight = _label.height );
					}
					
				});
			});
		}

	}
}