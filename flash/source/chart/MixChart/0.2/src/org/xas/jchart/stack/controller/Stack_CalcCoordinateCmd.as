package org.xas.jchart.stack.controller
{
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.StackMixChartModelItem;
	import org.xas.jchart.stack.view.mediator.StackGraphicMediator;
	
	public class Stack_CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _config:Config;
		private var _type:String;
		private var _seriesAr:Array;
		private var _gtype:Object;
		
		public function Stack_CalcCoordinateCmd()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override public function execute(notification:INotification):void{
			_type = notification.getType();
			_seriesAr = notification.getBody() as Array;
			if( !( _seriesAr && _seriesAr.length ) ) return;
			
			
			var _columns:Object = {};
			_gtype = _config.c.mix[ _type ]; 
			_gtype.columns = _columns;
			
			
			Common.each( _seriesAr, function( _k:int, _item:Object ):void{
				if( !( _item.modelIndex in _columns ) ){
					_columns[ _item.modelIndex ] = { data: [], modelIndex: _item.modelIndex };
				}
				_columns[ _item.modelIndex ].data.push( _item );
			});
			
			
			if( !_config.itemLength ) return;
			
			_gtype.partSpace = 0; 
			if( _config.mixModel.columnLen > 1 ){				
				_gtype.partSpace = 4; 
			}

			if( _seriesAr.length > 1 ){		
				_gtype.partWidth = 
					(
						_config.c.itemWidth - (_config.mixModel.columnLen - 1) * _gtype.partSpace
					) / _config.mixModel.columnLen
					;
				
				if( _gtype.partWidth < 1 ){				
					_gtype.partSpace = 0; 
					_gtype.partWidth = 
						(
							_config.c.itemWidth - (_config.mixModel.columnLen - 1) * _gtype.partSpace
						) / _config.mixModel.columnLen
						;
				}
			}
			
			if( _gtype.partWidth > 50 ){
				_gtype.partWidth = 50;
			}
			
			Common.each( _columns, function( _k:int, _data:Object ):void{
				calc( _data );
			});

//			
			facade.registerMediator( new StackGraphicMediator( _seriesAr, _gtype ) );
		}
		
		private function calc( _data:Object ):void{	
			var _modelIndex:int = _data.modelIndex
				, _partWidth:Number = _gtype.partWidth
				, _partSpace:Number = _gtype.partSpace
				, _modelItem:StackMixChartModelItem = _config.mixModel.items[ _modelIndex ] as StackMixChartModelItem
				;

			if( !( _data && _data.data && _data.data.length ) ) return;
//			Log.log( _modelItem.minNum, _modelItem.maxNum, _modelItem.finalMaxNum, _modelItem.chartMaxNum );
			
			_data.rects = [];
			_data.dataRect = [];
			_data.stackItems = [];

						
			var _positiveOffset:Number
				, _positiveHeight:Number = _config.c.vpart * _config.rateZeroIndex
				
				, _negativeOffset:Number
				, _negativeHeight:Number = _config.c.chartHeight - _config.c.vpart * _config.rateZeroIndex
				;
				
			Common.each( _config.displaySeries[0].data, function( _k:int, _item:Object ):void{
				_positiveOffset = 0;
				_negativeOffset = 0;
				
				var _items:Array = []
				, _pointItem:Object = _config.c.hlinePoint[ _k ]
				, _sp:Point = _pointItem.start as Point
				, _ep:Point = _pointItem.end as Point
				, _x:Number = _sp.x 
				+ ( _config.c.itemWidth 
					- _partWidth * _config.mixModel.columnLen / 2
					- _gtype.partSpace * ( ( _config.mixModel.columnLen || 1 ) - 1 ) / 2 
				)
				, _tmp:Number = 0
				, _tmpDataRect:Object = {
					x: _sp.x, y: _config.c.chartY
					, width: _config.c.hpart
					, height: _config.c.chartHeight 
				}
				, _stackItem:Object = {
					data: {
						negative: []
						, positive: []
					}
				}
				, _rectY:Number = _sp.y + _positiveHeight
				, _xpad:Number = 0
				;
				
				Common.each( _data.data, function( _sk:int, _sitem:Object ):void{
					if( _k === 0 ){
//						Log.log( _k, _sk, _sitem.data.data[ _k ] );
//						Log.printFormatJSON( _sitem );
					}
					var _rectItem:Object = {}
					, _itemNum:Number
					, _h:Number = 0, _y:Number
					, _num:Number = _sitem.data.data[ _k ]
					, _maxNum:Number = _modelItem.chartMaxNum
					, _columnIndex:int = _sk
					;
					
					if( 'columnIndex' in _sitem.data ){
						_columnIndex = _sitem.data.columnIndex;
					}
					
					if( _config.isAutoRate && !_config.hasNegative ){
						_num -= _modelItem.minNum / _modelItem.displaySeries.length;
						_maxNum -= _modelItem.minNum;
					}
					//						Log.log( _num, _maxNum );
					
					if( Common.isNegative( _num ) || _num == 0 ){
						_num = Math.abs( _num );
						
						_h = _negativeHeight;
						_h = 
						( _num / 
							Math.abs( _modelItem.finalMaxNum * _modelItem.rate[ _modelItem.rate.length - 1 ] ) ) 
						* _h || 0;
						_y = _sp.y + _positiveHeight + _negativeOffset ;
						
						_negativeOffset += _h;
						
						if( _num ){
							_stackItem.hasNegative = _rectItem.isNegative = true
						}
					}else{
						
						_h = ( _num / _maxNum || 1 ) * _positiveHeight || 0;
						
						_y = _sp.y + _positiveHeight - _h - _positiveOffset;

						_positiveOffset += _h;
						_rectY = _y;
						
						_stackItem.hasPositive = true;
					}
					if( !_h ) return;
//					_rectItem.x = _x;
					_xpad = _columnIndex * _partWidth + _gtype.partSpace * _columnIndex;
					_rectItem.x = _x + _xpad;
					
					_rectItem.k = _k;
					_rectItem.sk = _sk;
					_rectItem.y = _y;
					_rectItem.width = _gtype.partWidth;
					_rectItem.height = _h;
					_rectItem.value = _sitem.data.data[ _k ];
					_rectItem.color = _config.itemColor( _sitem.data.displayIndex );
					
					_items.push( _rectItem );
					
					if( _rectItem.isNegative ){
						_stackItem.data.negative.push( _rectItem );
					}else{
						_stackItem.data.positive.push( _rectItem );
					}
					
				});
				
				_stackItem.width = _gtype.partWidth;
				_stackItem.height = ( _positiveOffset + _negativeOffset ) || 0;
				_stackItem.x = _x + _xpad;
				_stackItem.y = _rectY;
				_stackItem.k = _k;
				_stackItem.realX = _sp.x;
				_stackItem.realY = _config.c.chartY;
				_stackItem.realWidth = _config.c.hpart;
				_stackItem.realHeight = _config.c.chartHeight;
				
				if( _k === 0 ){
//					Log.printFormatJSON( _stackItem );
				}
				
				_data.rects.push( _items );
				_data.dataRect.push( _tmpDataRect );
				_data.stackItems.push( _stackItem );
			});

//			Log.printFormatJSON( _data );
			
		}

	}
}