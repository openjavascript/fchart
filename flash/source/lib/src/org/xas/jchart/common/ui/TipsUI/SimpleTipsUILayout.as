package org.xas.jchart.common.ui.TipsUI
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.xas.core.utils.ElementUtility;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;

	public class SimpleTipsUILayout extends BaseTipsUILayout
	{
		public function SimpleTipsUILayout(_data:Object=null)
		{
			super(_data);
			_offsetX = 5;
			_offsetY = 5;
		}
		
		override public function buildLayout( _data:Object ):void{
			this._data = _data;
			
			//Log.printJSON( _afterSerial  );
			
			_ins.graphics.clear();
			ElementUtility.removeAllChild( _ins );
			
			var _y:Number = _offsetY;
			
			_eleData = {
				items: []
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
					
					_ins.addChild( _valTxf = new TextField() );
					_valTxf.text = '0';
					Common.implementStyle( _valTxf, [ 
						DefaultOptions.tooltip.style
						, _styles
						, { color: 0xffffff }
						, _config.tooltipValueStyle()
					] );
					_valTxf.y = _y;
					
					_y += _valTxf.height + _config.tooltipItemYSpace();
					
					
					_serialData.items.push( { 'name': _nameTxf, 'value': _valTxf } );
				});
			}
			
			if( _data.items ){
				Common.each( _data.items, function( _k:int, _item:Object ):void{
					if( !_item ) return;				
					if( 'k' in _item ) _k = _item.k;
					var _styles:Object = { color: _config.itemColor( _k ) };
							
					_ins.addChild( _valTxf = new TextField() );
					_valTxf.text = _item.value;
					Common.implementStyle( _valTxf, [ 
						DefaultOptions.tooltip.style
						, _styles
						, _config.tooltipValueStyle() 						
						, { color: 0xffffff }
					] );
					_valTxf.y = _y;
					
					_y += _valTxf.height + _config.tooltipItemYSpace();
					
					_eleData.items.push( { 'value': _valTxf } );
				});
			}
			
			if( _data.afterItems && _data.afterItems.length ){
				Common.each( _data.afterItems, function( _k:int, _item:Object ):void{
					if( !_item ) return;					
					var _styles:Object = { color: _config.tooptipAfterSerialItemColor( _k ) };
							
					
					_ins.addChild( _valTxf = new TextField() );
					_valTxf.text = '0';
					Common.implementStyle( _valTxf, [ 
						DefaultOptions.tooltip.style
						, _styles						
						, { color: 0xffffff }
						, _config.tooltipValueStyle() 
					] );
					_valTxf.y = _y;
					
					_y += _valTxf.height + _config.tooltipItemYSpace();
					
					_afterSerialData.items.push( { 'value': _valTxf } );
				});
			}
			
			updateLayout();
		}
		
		
		override public function updateLayout( _data:Object = null, _colors:Array = null ):void{
			if( !_eleData ) return;
			
			_ins.graphics.clear();
			graphics.clear();
			graphics.beginFill( _config.itemColor( 0 ), .95 );
			graphics.lineStyle( 1, _config.itemColor( 0 ), .35 );
			
			var _nameMaxLen:Number = 0
				, _valueMaxLen:Number = 0
				, _y:Number = _offsetY
				;
			
			Common.each( _serialData.items, function( _k:int, _item:Object ):void{
				_valTxf = _item.value as TextField;
				
				if( _data ){		
					_valTxf.text = _data.beforeItems[ _k ].value;		
				}
				
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_valTxf.text = _data.items[ _k ].value;		
				}
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			
			Common.each( _afterSerialData.items, function( _k:int, _item:Object ):void{
				_valTxf = _item.value as TextField;
				
				if( _data ){
					_valTxf.text = _data.afterItems[ _k ].value;		
				}
				
				_valTxf.width > _valueMaxLen && ( _valueMaxLen = _valTxf.width );
			});
			
			
			Common.each( _serialData.items, function( _k:int, _item:Object ):void{
				_valTxf = _item.value as TextField;
					
				_valTxf.x = _offsetX + _nameMaxLen + _config.tooltipValueLabelXSpace();
			});
			
			Common.each( _eleData.items, function( _k:int, _item:Object ):void{
				_valTxf = _item.value as TextField;
				_valTxf.x = _offsetX + _nameMaxLen + ( _valueMaxLen - _valTxf.width ) + _config.tooltipValueLabelXSpace();
			});
			
			Common.each( _afterSerialData.items, function( _k:int, _item:Object ):void{
				_valTxf = _item.value as TextField;
							
				_valTxf.x = _offsetX + _nameMaxLen + _config.tooltipValueLabelXSpace();
			});
			
			
			if( _colors && _colors.length ){
				if( _colors.length === 1 ){
					Common.each( _eleData.items, function( _k:int, _item:Object ):void{
						_valTxf = _item.value as TextField;
						_valTxf.textColor = _colors[0];
					});
				}else{
					
				}
			}
			
			graphics.drawRoundRect( 
				0, 0
				, _ins.width + _offsetX * 2 + 6
				, _ins.height + _offsetY * 2
				, 10, 10 
			);
		}
	}
}