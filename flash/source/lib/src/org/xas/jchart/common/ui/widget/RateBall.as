package org.xas.jchart.common.ui.widget
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;

	public class RateBall extends Sprite
	{
		private var _cp:Point;
		private var _radius:Number, _borderWidth:Number = 20;
		
		public function get borderSize():Number{ return  _radius - _borderWidth; }
		
		private var _bg:Sprite;
		private var _innerBg:Sprite;
		
		private var _border:Sprite, _borderMask:Sprite;
		private var _dataInnerBg:Sprite, _dataInnerBgMask:Sprite;
		
		private var _value:Number, _maxValue:Number;
		
		private var _rate:Number;
		private var _text:TextField;
		
		private var _textStyle:Array;
		
		
		public function RateBall( 
			_value:Number
			, _maxValue:Number
			, _cp:Point
			, _radius:Number
			, _borderWidth:Number
			, _textStyle:Array = null
		)
		{			
			this._value = _value;
			this._maxValue = _maxValue < _value ? _value : _maxValue;
			
			_rate = this._value / this._maxValue;
			
			//Log.log( this._value, this._maxValue );
			
			this._cp = _cp;
			this._radius = _radius;
			this._borderWidth = _borderWidth;
			this._textStyle = _textStyle;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		protected function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		protected function init():void{
			
			addChild( _bg = new Sprite() );
			_bg.graphics.beginFill( 0xECECEC );
			_bg.graphics.drawCircle( _cp.x, _cp.y, _radius );
			
			addChild( _innerBg = new Sprite() );
			_bg.graphics.beginFill( 0xffffff );
			_bg.graphics.drawCircle( _cp.x, _cp.y, borderSize );
			
			_borderMask = new Sprite();
			_borderMask.graphics.beginFill( 0xffffff );
			_borderMask.graphics.drawRect( 0, maskY, _cp.x + _radius, _cp.y + _radius );
			
			addChild( _border = new Sprite() );
			_border.graphics.beginFill( 0xFEB556 );
			_border.mask = _borderMask;
			_border.graphics.drawCircle( _cp.x, _cp.y, _radius );
			
			_dataInnerBgMask = new Sprite();
			_dataInnerBgMask.graphics.beginFill( 0xffffff );
			_dataInnerBgMask.graphics.drawRect( 0, maskY, _cp.x + _radius, _cp.y + _radius );
			
			addChild( _dataInnerBg = new Sprite() );
			_dataInnerBg.graphics.beginFill( 0xFDF0F2 );
			_dataInnerBg.mask = _dataInnerBgMask;
			_dataInnerBg.graphics.drawCircle( _cp.x, _cp.y, borderSize );
			
			if( BaseConfig.ins.serialLabelEnabled ){
				addChild( _text = new TextField( ) );
				_text.text =
					StringUtils.printf( BaseConfig.ins.dataLabelFormat, Common.moneyFormat( _value, 3, Common.floatLen( _value ) )) ;
				_text.autoSize = TextFieldAutoSize.LEFT;
				_textStyle && Common.implementStyle( _text, _textStyle );
				_text.x = _cp.x - _text.width / 2;
				_text.y = _cp.y - _text.height / 2;
			}
			
		}
		
		protected function get maskY():Number{
			var _r:Number = ( _cp.y - _radius ) + _radius * 2 * ( 1 - _rate );			
			return _r;
		}
	}
}