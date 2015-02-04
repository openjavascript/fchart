package org.xas.jchart.common.ui.TipsUI
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.ui.widget.JSprite;
	
	public class BaseTipsUILayout extends JSprite
	{		
		protected var _nameTxf:TextField;
		protected var _valTxf:TextField;
		protected var _ins:BaseTipsUILayout;
		protected var _config:Config;
		
		protected var _eleData:Object;
		
		protected var _serialData:Object;
		protected var _afterSerialData:Object;
		
		protected var _offsetY:Number = 10;
		protected var _offsetX:Number = 15;
		
		protected var _headerIcon:Sprite;
		
		public function BaseTipsUILayout(_data:Object=null)
		{
			super(_data);
			_ins = this;
			_config = BaseConfig.ins as Config;
		}
		
		public function isFont( _fontName:String ):Boolean{
			
			if( _fontName === 'SimSun' ) return true;
			
			var t:TextField = new TextField();
			t.defaultTextFormat = new TextFormat(_fontName,20);
			t.text="中文";
			t.autoSize = "left";
			//trace(t.height);
			//addChild(t);
			var ta:TextField = new TextField();
			ta.defaultTextFormat = new TextFormat("SimSun",20);
			ta.text="中文";
			ta.autoSize = "left";	
			
			return t.height !==  ta.height;
		}
		
		public function buildLayout( _data:Object ):void{
			this._data = _data;
			
			//Log.printJSON( _afterSerial  );
			
			_ins.graphics.clear();
			ElementUtility.removeAllChild( _ins );
			
			_ins.addChild( _nameTxf = new TextField() );
			Common.implementStyle( _nameTxf, [ 
				DefaultOptions.tooltip.style
				, { size: 14 }
				, _config.tooltipHeaderStyle()
			] );
			
			_nameTxf.text = _data.name || '';
			_nameTxf.y = _offsetY;			
			
			if( _config.tooltipHeaderIconEnabled ){
				_headerIcon = new Sprite();
				_headerIcon.graphics.beginFill( 0x5DC068 );
				if( 'color' in _config.tooltipHeaderIconStyle ){
					_headerIcon.graphics.beginFill( _config.tooltipHeaderIconStyle.color );
				}
				if( isFont( 'Microsoft YaHei' ) ){
					_headerIcon.graphics.drawRect( 0, _offsetY + 4, 6, _nameTxf.height - 7 );
				}else{
					_headerIcon.graphics.drawRect( 0, _offsetY, 6, _nameTxf.height );
				}
				addChild( _headerIcon );
			}
			
			var _y:Number = _nameTxf.height + _config.tooltipHeaderYSpace() + _offsetY
				;
			
			_eleData = {
				name: _nameTxf
				, items: []
			};
			
			_serialData = {
				items: []
			};
			
			_afterSerialData = {
				items: []
			};
			
			if( _data.beforeItems ){
				Common.each( _data.beforeItems, function( _k:int, _item:Object ):void{
					if( !_item ) return;					
					var _styles:Object = { color: _config.tooptipSerialItemColor( _k ) };
					
					_ins.addChild( _nameTxf = new TextField() );
					_nameTxf.text = _item.name + ': ';
					Common.implementStyle( _nameTxf, [ DefaultOptions.tooltip.style, _styles, _config.tooltipLabelStyle() ] );
					_nameTxf.y = _y;
					
					
					_ins.addChild( _valTxf = new TextField() );
					_valTxf.text = '0';
					Common.implementStyle( _valTxf, [ DefaultOptions.tooltip.style, _styles, _config.tooltipValueStyle() ] );
					_valTxf.y = _y;
					
					_y += _nameTxf.height + _config.tooltipItemYSpace();
					
					
					_serialData.items.push( { 'name': _nameTxf, 'value': _valTxf } );
				});
			}
			
			if( _data.items ){
				Common.each( _data.items, function( _k:int, _item:Object ):void{
					if( !_item ) return;				
					if( 'k' in _item ) _k = _item.k;
					var _styles:Object = { color: _config.itemColor( _k ) };
					
					_ins.addChild( _nameTxf = new TextField() );
					_nameTxf.text = _item.name + ': ';
					Common.implementStyle( _nameTxf, [ DefaultOptions.tooltip.style, _styles, _config.tooltipLabelStyle() ] );
					_nameTxf.y = _y;
					
					
					_ins.addChild( _valTxf = new TextField() );
					_valTxf.text = _item.value;
					Common.implementStyle( _valTxf, [ DefaultOptions.tooltip.style, _styles, _config.tooltipValueStyle() ] );
					_valTxf.y = _y;
					
					_y += _nameTxf.height + _config.tooltipItemYSpace();
					
					_eleData.items.push( { 'name': _nameTxf, 'value': _valTxf } );
				});
			}
			
			if( _data.afterItems && _data.afterItems.length ){
				Common.each( _data.afterItems, function( _k:int, _item:Object ):void{
					if( !_item ) return;					
					var _styles:Object = { color: _config.tooptipAfterSerialItemColor( _k ) };
					
					_ins.addChild( _nameTxf = new TextField() );
					_nameTxf.text = _item.name + ': ';
					Common.implementStyle( _nameTxf, [ DefaultOptions.tooltip.style, _styles, _config.tooltipLabelStyle() ] );
					_nameTxf.y = _y;
					
					
					_ins.addChild( _valTxf = new TextField() );
					_valTxf.text = '0';
					Common.implementStyle( _valTxf, [ DefaultOptions.tooltip.style, _styles, _config.tooltipValueStyle() ] );
					_valTxf.y = _y;
					
					_y += _nameTxf.height + _config.tooltipItemYSpace();
					
					_afterSerialData.items.push( { 'name': _nameTxf, 'value': _valTxf } );
				});
			}
			
			updateLayout();
		}
		
		public function updateLayout( _data:Object = null, _colors:Array = null ):void{
			
			if( !_eleData ) return;
			
			_ins.graphics.clear();
			graphics.clear();
			graphics.beginFill( 0xffffff, .95 );
			graphics.lineStyle( 1, 0x999999, .35 );
			
			_nameTxf = _eleData.name as TextField;
			
			var _nameMaxLen:Number = 0
				, _valueMaxLen:Number = 0
				, _y:Number = _offsetY + _nameTxf.height
				;
			
			_nameTxf.x = _offsetX;
			_nameTxf.y = _offsetY;
			
			if( _headerIcon ){
				_nameTxf.x = _headerIcon.x + _headerIcon.width + 4;
			}
			
			if( _data ){
				_nameTxf.text = _data.name;
			}
			
			Common.each( _serialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_nameTxf.text = _data.beforeItems[ _k ].name + ': ';		
					_valTxf.text = _data.beforeItems[ _k ].value;		
				}
				
				_nameTxf.width > _nameMaxLen && ( _nameMaxLen = _nameTxf.width );
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_nameTxf.text = _data.items[ _k ].name + ': ';		
					_valTxf.text = _data.items[ _k ].value;		
				}
				
				_nameTxf.width > _nameMaxLen && ( _nameMaxLen = _nameTxf.width );
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			
			Common.each( _afterSerialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_nameTxf.text = _data.afterItems[ _k ].name + ': ';
					_valTxf.text = _data.afterItems[ _k ].value;		
				}
				
				_nameTxf.width > _nameMaxLen && ( _nameMaxLen = _nameTxf.width );
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			
			
			Common.each( _serialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2 + _nameMaxLen - _nameTxf.width;					
				_valTxf.x = _offsetX * 2 + _nameMaxLen + _config.tooltipValueLabelXSpace();
			});
			
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2 + _nameMaxLen - _nameTxf.width;					
				_valTxf.x = _offsetX * 2 + _nameMaxLen + ( _valueMaxLen - _valTxf.width ) + _config.tooltipValueLabelXSpace();
			});
			
			Common.each( _afterSerialData.items, function( _k:int, _item:Object ):void{
				_nameTxf = _item.name as TextField;
				_valTxf = _item.value as TextField;
				
				_nameTxf.x = _offsetX * 2 + _nameMaxLen - _nameTxf.width;					
				_valTxf.x = _offsetX * 2 + _nameMaxLen + _config.tooltipValueLabelXSpace();
			});
			
			
			if( _colors && _colors.length ){
				if( _colors.length === 1 ){
					Common.each( _eleData.items, function( _k:int, _item:Object ):void{
						_nameTxf = _item.name as TextField;
						_valTxf = _item.value as TextField;
						
						_nameTxf.textColor = _colors[0];
						_valTxf.textColor = _colors[0];
					});
				}else{
					
				}
			}
			
			graphics.drawRoundRect( 
				0, 0
				, _ins.width + _offsetX * 2
				, _ins.height + _offsetY * 2
				, 10, 10 
			);
		}
	}
}