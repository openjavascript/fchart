package org.xas.jchart.common.view.components.SerialLabel
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
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
	
	public class StackSerialLabelView extends BaseSerialLabelView
	{	
		private var _config:BaseConfig;
		
		public function StackSerialLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();			
			this.graphics.beginFill( 0xcccccc, .13 );
						
			if( !( _config.c && _config.c.rects ) ) return;
			//Log.log( _config.floatLen );
			Common.each( _config.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
										
					_sk = _sitem.sk;
					_k = _sitem.k; 
					if( !_sitem.value ) return;
					
					if( _config.serialLabelEnabled ){
						
						var _label:JTextField = new JTextField( _sitem )
							, _x:Number = 0
							, _y:Number = 0
							;
							
						_label.text = _config.serialDataLabelValue( _sk, _k );
						
						_label.autoSize = TextFieldAutoSize.LEFT;
						_label.selectable = false;
						_label.textColor = _config.itemColor( _sk ); 
						_label.mouseEnabled = false;
						
						var _maxStyle:Object = {};
						if( _sitem.value == _config.maxValue ){
							_maxStyle = _config.maxItemParams.style || _maxStyle;
						}
						
						Common.implementStyle( _label, [ 
							{ color: 0xffffff, size: 14 }
							, _maxStyle ] 
						);
						
						EffectUtility.textShadow( _label as TextField, 
							{ color: 0xffffff, size: 12 }
							, _config.itemColor( _sk ) 
						);
///						_label.filters = [new GlowFilter(_config.itemColor( _sk ), 1, 2, 2, 16, 1, true )];
						
						_x = _sitem.x + _sitem.width / 2 - _label.width / 2;
						if( _sitem.value >= 0 ){
							_y = _sitem.y + _sitem.height / 2 - _label.height / 2;
						}else{
							_y = _sitem.y + _sitem.height / 2 - _label.height / 2;
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
						
						if( _sitem.height < _label.height ){
							_label.visible = false;
						}
						
						_label.x = _x;
						_label.y = _y;
						
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
						
						addChild( _label );
						
						( _label.height > _maxHeight ) && ( _maxHeight = _label.height );
					}
					
				} );
			});
		}

	}
}