package org.xas.jchart.common.view.components.SerialLabel
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	
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
	
	public class CurveGramSerialLabelView extends BaseSerialLabelView
	{	
		protected var _list:Vector.<JTextField>;
		private var _config:Config;
		
		public function CurveGramSerialLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			
			if( !( _config.c && _config.c.paths && _config.c.paths.length ) ) return;
			_list = new Vector.<JTextField>();
			
			var _p:BaseSerialLabelView = this;
			
			if( _config.animationEnabled ){
				_p.visible = false;
			}
						
			this.graphics.clear();			
			this.graphics.beginFill( 0xcccccc, .13 );
			
			var _labelSpace:Number = 4;
			
			Common.each( _config.c.paths, function( _k:int, _item:Object ):void{
				
				var _position:Array = _item.position as Array
					;
				//Log.log( _values );
				if( !seriesEnabled( config.displaySeries, _k ) ) return;
					
				Common.each( _position, function( _sk:int, _sitem:Object ):void{
					if( _config.serialLabelEnabled ){
						var _label:JTextField = new JTextField( _sitem.value )
						, _x:Number = 0
						, _y:Number = 0
						;
						
						//_label.text = StringUtils.printf( _config.dataLabelFormat, Common.moneyFormat( _sitem.value, 3, _config.floatLen ) );
						_label.text = _config.serialDataLabelValue( _k, _sk );
						
						_label.autoSize = TextFieldAutoSize.LEFT;
						_label.selectable = false;
						_label.textColor = _config.itemColor( _k );
						_label.mouseEnabled = false;
						
						var _maxStyle:Object = {};
						if( _sitem.value == _config.maxValue ){
							_maxStyle = _config.maxItemParams.style || _maxStyle;
						}
						
						Common.implementStyle( _label, [ { size: 14 }, _maxStyle ] );
						EffectUtility.textShadow( _label as TextField, { color: _config.itemColor( _k ), size: 12 }, 0xffffff );
						
						_x = _sitem.x - _label.width / 2;
						if( _sitem.value >= 0 ){
							_y = _sitem.y - _label.height - _labelSpace;
						}else{
							_y = _sitem.y + 4;
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
						
						addChild( _label );
						_list.push( _label );
						
						( _label.height > _maxHeight ) && ( _maxHeight = _label.height );
					}
					
				});
				
				//addChild( _gitem = new CurveGramUI( _cmd, _path, _config.itemColor( _k ) ) );
				//_boxs.push( _gitem );
			});
			
			if( _config.animationEnabled ){
				
				var _delay:Number = 0;
				_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
				
				TweenLite.delayedCall( 1, function():void{
					_p.visible = true;
				});
				
			}
						
			/*
			if( !( _config.c && _config.c.rects ) ) return;
			Common.each( _config.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					
					if( _config.serialLabelEnabled ){
						
						var _label:JTextField = new JTextField( _sitem );
						_label.text = StringUtils.printf( _config.dataLabelFormat, Common.moneyFormat( _sitem.value, 3, _config.floatLen ) );
						
						_label.autoSize = TextFieldAutoSize.LEFT;
						_label.selectable = false;
						_label.textColor = _config.itemColor( _sk );
						_label.mouseEnabled = false;
						
						var _maxStyle:Object = {};
						if( _sitem.value == _config.maxValue ){
							_maxStyle = _config.maxItemParams.style || _maxStyle;
						}
						
						Common.implementStyle( _label, [ { size: 14 }, _maxStyle ] );
						
						_label.x = _sitem.x + _sitem.width / 2 - _label.width / 2;
						if( _sitem.value >= 0 ){
							_label.y = _sitem.y - _label.height;
						}else{
							_label.y = _sitem.y + _sitem.height;
						}
						
						addChild( _label );
						
						( _label.height > _maxHeight ) && ( _maxHeight = _label.height );
					}
					
				});
			});
			*/
		}

	}
}