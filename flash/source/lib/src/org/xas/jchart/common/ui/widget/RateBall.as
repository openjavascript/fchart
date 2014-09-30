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
		private var _textFormat:String;
		private var _displayText:Boolean;
		
		private var _borderBgColor:uint;
		private var _borderBgFillColor:uint;
		private var _dataBorderBgColor:uint;
		private var _dataBorderBgFillColor:uint;
		
		/*
		, _item.borderBgColor || 0xECECEC
		, _item.borderBgFillColor || 0xffffff
		, _item.dataBorderBgColor || 0xFEB556
		, _item.dataBorderBgFillColor || 0xFDF0F2
		*/
		
		public function RateBall( 
			_value:Number
			, _maxValue:Number
			, _cp:Point
			, _radius:Number
			, _borderWidth:Number
			, _textStyle:Array = null
			, _textFormat:String = '{0}'
			, _displayText:Boolean = true
			  
			, _borderBgColor:uint = 0xECECEC
			, _borderBgFillColor:uint = 0xffffff
			, _dataBorderBgColor:uint = 0xFEB556
			, _dataBorderBgFillColor:uint = 0xFDF0F2
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
			this._textFormat = _textFormat;			
			this._displayText = _displayText;	
			
			this._borderBgColor = _borderBgColor;	
			this._borderBgFillColor = _borderBgFillColor;	
			this._dataBorderBgColor = _dataBorderBgColor;	
			this._dataBorderBgFillColor = _dataBorderBgFillColor;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		protected function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		protected function init():void{
			
			addChild( _bg = new Sprite() );
			_bg.graphics.beginFill( _borderBgColor );
			_bg.graphics.drawCircle( _cp.x, _cp.y, _radius );
			
			addChild( _innerBg = new Sprite() );
			_bg.graphics.beginFill( _borderBgFillColor );
			_bg.graphics.drawCircle( _cp.x, _cp.y, borderSize );
			
			_borderMask = new Sprite();
			_borderMask.graphics.beginFill( 0xffffff );
			_borderMask.graphics.drawRect( 0, maskY, _cp.x + _radius, _cp.y + _radius );
			
			addChild( _border = new Sprite() );
			_border.graphics.beginFill( _dataBorderBgColor );
			_border.mask = _borderMask;
			_border.graphics.drawCircle( _cp.x, _cp.y, _radius );
			
			_dataInnerBgMask = new Sprite();
			_dataInnerBgMask.graphics.beginFill( 0xffffff );
			_dataInnerBgMask.graphics.drawRect( 0, maskY, _cp.x + _radius, _cp.y + _radius );
			
			addChild( _dataInnerBg = new Sprite() );
			_dataInnerBg.graphics.beginFill( _dataBorderBgFillColor );
			_dataInnerBg.mask = _dataInnerBgMask;
			_dataInnerBg.graphics.drawCircle( _cp.x, _cp.y, borderSize );
			
			if( _displayText ){
				addChild( _text = new TextField( ) );
				_text.text =
					StringUtils.printf( _textFormat, Common.moneyFormat( _value, 3, Common.floatLen( _value ) )) ;
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