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
	
	public class VHistogramSerialLabelView extends BaseSerialLabelView
	{	
		private var _config:Config;
		
		public function VHistogramSerialLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<Vector.<TextField>>;
			if( !( _config.displaySeries.length && _config.displaySeries[0].data.length ) ) return;
			Common.each( _config.displaySeries[0].data, function( _k:int, _item:Number ):void{
				var _temp:Vector.<TextField> = new Vector.<TextField>();
				Common.each( _config.displaySeries, function( _sk:int, _sitem:Object ):void{
					var _label:JTextField = new JTextField( _sitem );
					_label.text = _config.serialDataLabelValue( _sk, _k );
					
					_label.autoSize = TextFieldAutoSize.LEFT;
					_label.selectable = false;
					_label.textColor = _config.itemColor( _sk );
					_label.mouseEnabled = false;
					
					var _maxStyle:Object = {};
					if( _sitem.value == _config.maxValue ){
						_maxStyle = _config.maxItemParams.style || _maxStyle;
					}
					
					Common.implementStyle( _label, [ { size: 14 }, _maxStyle ] );
					EffectUtility.textShadow( _label as TextField, { color: _config.itemColor( _sk ), size: 12 }, 0xffffff );
					_temp.push( _label );
					
					( _label.height > _maxHeight ) && ( _maxHeight = _label.height );
					( _label.width > _maxWidth ) && ( _maxWidth = _label.width );
					_label.x = -1000;
					addChild( _label );
				});
				_labels.push( _temp );
			});
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
						
			if( !( _config.c && _config.c.rects ) ) return;
			Common.each( _config.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					
					if( _config.serialLabelEnabled ){
						
						var _label:TextField = _labels[ _k ][ _sk ];
						
						_label.y = _sitem.y + _sitem.height / 2 - _label.height / 2;
						
						if( _sitem.value >= 0 ){
							_label.x = _sitem.x + 5 + (!!_sitem.width ? _sitem.width : 0);
						}else{
							_label.x = _sitem.x - _label.width - 5;
						}
						
						if( _config.animationEnabled ){
							_label.alpha = 0;
							TweenLite.delayedCall( _config.animationDuration, 
								function():void{
									TweenLite.to( _label, _config.animationDuration
										, { 
											alpha: 1, ease: Expo.easeOut 
										} );
								});
						}
					}
					
				});
			});
		}

	}
}