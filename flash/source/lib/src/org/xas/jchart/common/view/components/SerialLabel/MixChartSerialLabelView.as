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
	
	public class MixChartSerialLabelView extends BaseSerialLabelView
	{	
		private var _config:BaseConfig;
		
		public function MixChartSerialLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();			
			this.graphics.beginFill( 0xcccccc, .13 );
			
			Common.each( _config.c.mix, function( _mtype:String, _mdata:Object ):void{
//				Log.log( _mtype );
//				Log.printFormatJSON( _mdata.srcData );
				switch( _mtype ){
					case 'line': {
						initLine( _mdata );
						break;
					}
					default: {
						initBar( _mdata );
						break;
					}
				}
			});
			

		}
		
		private function initLine( _mdata:Object ):void{
			
			if( !( _mdata && _mdata.paths && _mdata.paths.length ) ) return;
			var _list:Vector.<JTextField> = new Vector.<JTextField>();
			
			var _p:BaseSerialLabelView = this;
			
			if( _config.animationEnabled ){
				_p.visible = false;
			}
			
			this.graphics.clear();			
			this.graphics.beginFill( 0xcccccc, .13 );
			
			var _labelSpace:Number = 4;
			Common.each( _mdata.paths, function( _k:int, _item:Object ):void{
				
				var _position:Array = _item.position as Array
				;
				if( !seriesEnabled( _mdata.srcData, _k ) ) return;
				//Log.log( _values );
				
				Common.each( _position, function( _sk:int, _sitem:Object ):void{
					if( _config.serialLabelEnabled ){
						var _label:JTextField = new JTextField( _sitem.value )
						, _x:Number = 0
						, _y:Number = 0
						, _seriesIx:int = _mdata.srcData[ _k ].data.displayIndex
						;
						
						if( _sitem.data ){
							_seriesIx = _sitem.data.displayIndex;
						}
						
						//_label.text = StringUtils.printf( _config.dataLabelFormat, Common.moneyFormat( _sitem.value, 3, _config.floatLen ) );
						_label.text = _config.serialDataLabelValue( _seriesIx, _sk );
						
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
			});
			
			if( _config.animationEnabled ){
				
				var _delay:Number = 0;
				_config.xAxisEnabled && ( _delay = _config.animationDuration / 2 );
				
				TweenLite.delayedCall( 1, function():void{
					_p.visible = true;
				});
				
			}

		}
		
		private function initBar( _mdata:Object ):void{
			if( !( _mdata && _mdata.rects ) ) return;
//			Log.printFormatJSON( _mdata.srcData );
//			Log.log( 'MixChartSerialLabelView 1' );
			//Log.log( _config.floatLen );
			Common.each( _mdata.rects, function( _k:int, _item:Object ):void{
//				Log.printFormatJSON( _item );
				var _box:Sprite = new Sprite();
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
//					if( _k > 0 ) return;
//					if( !seriesEnabled( _mdata.srcData, _k ) ) return;
					if( !seriesEnabled( _mdata.srcData, _sk ) ) return;
//					if( _sk > 0 ) return;
					if( _config.serialLabelEnabled ){
						
						var _label:JTextField = new JTextField( _sitem )
							, _x:Number = 0
							, _y:Number = 0
							;
							
						if( _sitem.data ){
							_sk = _sitem.data.displayIndex;
						}
							
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
					
				});
			});
		}

		override protected function seriesEnabled( _srcData:Object, _k:int ):Boolean{
			var _r:Boolean = _config.superSerialLabelEnabled, _tmp:Object;
			
			if( _srcData && ( _tmp = _srcData[ _k ] ) ){
//				"data":
//				{
//					"dataLabels":
//					{
//						"enabled": false
//					}, 
//				Log.printFormatJSON( _srcData[ _k ] )
//				_r = _config.superSerialLabelEnabled;
				_tmp.data 
					&& _tmp.data.dataLabels
					&& ( 'enabled' in _tmp.data.dataLabels )
					&& ( _r = StringUtils.parseBool( _tmp.data.dataLabels.enabled ) );
				
				_tmp.data 
					&& _tmp.data.dataLabel
					&& ( 'enabled' in _tmp.data.dataLabel )
					&& ( _r = StringUtils.parseBool( _tmp.data.dataLabel.enabled ) );
			}
			
			return _r;
		}
	}
}