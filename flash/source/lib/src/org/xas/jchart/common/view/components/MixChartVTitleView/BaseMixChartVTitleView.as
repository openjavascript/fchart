package org.xas.jchart.common.view.components.MixChartVTitleView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.ui.text.RotationText;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.BaseMixChartModelItem;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.DisplayRotation;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class BaseMixChartVTitleView extends JSprite 
	{
		protected var _textf:DisplayRotation;		
		
		protected var _getWidth:Number = 0;
		public function get getWidth():Number{ return _getWidth; }
		
		protected var _getHeight:Number = 0;
		public function get getHeight():Number{ return _getHeight; }
		
		protected var _index:Number = 0;
		public function get index():Number{ return _index; }
		
		protected var _model:BaseMixChartModelItem;
		public function get model():BaseMixChartModelItem{ return _model; }
		
		protected var _config:Config;

		
		public function BaseMixChartVTitleView( _index:int, _model:BaseMixChartModelItem )
		{
			super();
			
			this._model = _model;
			this._index = _index;
			
			this.visible = false;

			_config = BaseConfig.ins as Config;
			
			if( !_model.hasVTitle ) return;
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );		
		}
		
		private function addToStage( _evt:Event ):void{ 
			
			var _angle:Number = -90;
			_model.isOpposite && ( _angle = 90 );

			_textf = new DisplayRotation( _model.vtitleText, _angle, function( _stf:TextField ):void{
				
				var _color:uint = 0x838383;
				
				if( _config.mixModel.items.length > 1 && _model.displaySeries.length === 1 ){
					_color = _config.itemColor( _model.displaySeries[0].displayIndex );
				}else if( _config.mixModel.items.length > 1 && _model.displaySeries.length === 0 ){
					_color = 0x333333;
				}
				
				Common.implementStyle( _stf, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.title.style
					, { color: _color }
					, _model.vtitleStyle
				] );
				
				_getWidth = _stf.height;
				_getHeight = _stf.width;
			});
			addChild( _textf );			
		}		
		
		protected function update( _evt:JChartEvent ):void{
			if( !( _index in _config.c.vtitle ) ) return;
			
//			this.visible = true;
//			//Log.log( 'aaaaaaaaaaaa', _config.c.vtitle[ _index ].x, _config.c.vtitle[ _index ].y );
//			this.x = _config.c.vtitle[ _index ].x || 0;
//			this.y = _config.c.vtitle[ _index ].y || 0;
			
			
			
			var _tf:JSprite = this, _item:Object = _config.c.vtitle[ _index ];
			
			if( _config.animationEnabled ){
				
				if( _model.isOpposite ){
					_tf.y = _item.y;
					_tf.x = _model.left + 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									x: _item.x
									, y: _item.y
									, ease: Expo.easeOut } );
						});
				}else{		
					_tf.y = _item.y;
					_tf.x = _model.left - _tf.width - 200;
					
					TweenLite.delayedCall( 0, 
						function():void{
							TweenLite.to( _tf, _config.animationDuration
								, { 
									x: _item.x
									, y: _item.y
									, ease: Expo.easeOut 
								} );
						});
				}
				
			}else{
				this.x = _item.x || 0;
				this.y = _item.y || 0;
			}
			this.visible = true;
		}

	}
}