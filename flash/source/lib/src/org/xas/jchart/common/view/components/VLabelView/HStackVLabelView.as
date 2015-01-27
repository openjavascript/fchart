package org.xas.jchart.common.view.components.VLabelView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class HStackVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		public function HStackVLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			var _labelRotate:Boolean = config.labelRotationEnable;
			var _twidth:Number = config.c.labelWidth;
			
			_twidth < 16 && ( _twidth = 16 );
			
			if( config.cd && config.cd.xAxis && config.cd.xAxis.categories ){
				
				Common.each( config.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = _t
					_titem.text = StringUtils.printf( config.xAxisFormat, _t );
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.yAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': 'center' }
						, config.vlabelsStyle
					] );
					
					if( config.xAxisWordwrap ) {
						_titem.width = _twidth * 1.5;
						_titem.wordWrap = true;
					} 
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
					_titem.width > _maxWidth && ( _maxWidth = _titem.width );
					_titem.x = -1000;
					addChild( _titem );
					
					_labels.push( _titem );
					
				} );								
			}			
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( _config.c && _config.c.vpoint ) ) return;
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				if( _k >= _labels.length ) return;
				var _tf:TextField = _labels[ _k ]
					, _x:Number = _item.start.x
					, _y:Number = _item.start.y
					;
					
				_x -= _tf.width;
				_x -= _config.xArrowLength;
				_x -= _config.vspace;
				
				_y -= _tf.height / 2;
				_y += _config.c.vpart / 2;
								
				if( _config.animationEnabled ){
					_tf.visible = true;
					_tf.y = _y;
					_tf.x = _x - 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									x: _x
									, y: _y
									, ease: Expo.easeOut } );
						});
				}else{
					_tf.x = _x;
					_tf.y = _y;
				}
				
			});
		}


	}
}