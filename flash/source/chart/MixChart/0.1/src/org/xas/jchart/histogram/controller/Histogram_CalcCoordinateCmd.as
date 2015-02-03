package org.xas.jchart.histogram.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.core.utils.formatter.Formatter;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.BaseMixChartModelItem;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.data.test.MixChartData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.LegendProxy;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.histogram.view.mediator.*;
	
	public class Histogram_CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _config:Config;
		private var _type:String;
		private var _seriesAr:Array;
		private var _gtype:Object;
		
		public function Histogram_CalcCoordinateCmd()
		{
			super();
			
			_config = BaseConfig.ins as Config;
		}
		
		override public function execute(notification:INotification):void{
			_type = notification.getType();
			_seriesAr = notification.getBody() as Array;
			if( !( _seriesAr && _seriesAr.length ) ) return;;
			//Log.printJSON( _seriesAr );
			//Log.printFormatJSON( _seriesAr );
			//_model = _config.mixModel.items[ _body.modelIndex ];
			//if( !_model ) return
			
			//Log.log( [ _type, new Date().getTime() ] );
			_gtype = _config.c.mix[ _type ];
			calc();
			//Log.printJSON( _gtype );
			//Log.log( Formatter.json( _gtype ) );
			//Log.printFormatJSON( _gtype );
			
			facade.registerMediator( new HistogramGraphicMediator( _seriesAr, _gtype ) );
		}
		
		private function calc():void{			
			
			_gtype.rects = [];
			_gtype.dataRect = [];
			
			if( !( _config.series && _config.series.length ) ) return;
			
			_gtype.partSpace = 0; 
			_gtype.partWidth = 
				_config.c.itemWidth /_seriesAr.length
				;
			
			if( _seriesAr.length > 1 ){				
				_gtype.partSpace = 4; 
				_gtype.partWidth = 
					(
						_config.c.itemWidth - (_seriesAr.length - 1) * _gtype.partSpace
					) / _seriesAr.length
					;
			}
			
			//_gtype.partWidth > 50 && ( _gtype.partWidth = 50 );
			var _partWidth:Number = _gtype.partWidth
				;
			//_partWidth > 50 && ( _partWidth = 50 );
			if( _partWidth > 50 ){
				_partWidth = 50;
			}
			
			
			Common.each( _config.cd.xAxis.categories, function( _k:int, _item:Object ):void{
				
				var _items:Array = []
				, _pointItem:Object = _config.c.hlinePoint[ _k ]
				, _sp:Point = _pointItem.start as Point
				, _ep:Point = _pointItem.end as Point
				//, _x:Number = _sp.x + ( _gtype.itemWidth - _gtype.itemWidth / 2 )
				, _x:Number = _sp.x 
				+ ( _config.c.itemWidth 
					- _partWidth * _seriesAr.length / 2
					- _gtype.partSpace * ( ( _seriesAr.length || 1 ) - 1 ) / 2 
				)
				, _tmp:Number = 0
				, _tmpDataRect:Object = {
					x: _sp.x, y: _sp.y
					, width: _config.c.itemWidth * 2
					, height: _ep.y - _sp.y 
				}
				, _tmpYAr:Array = []
				, _tmpHAr:Array = []
				;
				
				Common.each( _seriesAr, function( _sk:int, _seitem:Object ):void{
					var _model:BaseMixChartModelItem =  _config.mixModel.items[ _seitem.modelIndex ] 
					, _rectItem:Object = {}
					, _sitem:Object = _seitem.data
					, _num:Number = _sitem.data[ _k ]
					, _itemNum:Number
					, _h:Number = 0, _y:Number
					, _dataHeight:Number
					, _maxNum:Number = _model.chartMaxNum
					;
					
					if( _model.isAutoRate && !_model.hasNegative ){
						_num -= _model.minNum;
						_maxNum -= _model.minNum;
						//Log.log( [_num, _model.minNum, _num - _model.minNum ] );
					}
					
					
					if( _config.isItemPercent && _seriesAr.length > 1 ){
						_h = _config.c.vpart * _model.rateZeroIndex;
						_h = ( _num / _model.itemMax( _k ) || 0 ) * _h;
						_y = _sp.y 
						+ _config.c.vpart * _model.rateZeroIndex - _h
						;
						if( _k === 0 ){
							//Log.log( _num / _model.itemMax( _k ) * 100, _num, _model.itemMax( _k ) );
						}
					}else{
						
						if( Common.isNegative( _num ) || _num == 0 ){
							_num = Math.abs( _num );
							_dataHeight = _config.c.vpart * _model.rateZeroIndex;
							
							_h = _config.c.chartHeight - _dataHeight;
							_y = _sp.y + _dataHeight ;
							_h = 
							( _num / 
								Math.abs( _model.finalMaxNum * _model.rate[ _model.rate.length - 1 ] ) ) 
							* _h;
							//Log.log( _h, _model.finalMaxNum );
							_rectItem.isNegative = true;
						}else{
							_h = _config.c.vpart * _model.rateZeroIndex;
							//Log.log( [ _gtype.vpart, _model.rateZeroIndex, _gtype.vpart * _model.rateZeroIndex ].join(', ' ) ); 
							_h = ( _num / _maxNum || 1 ) * _h;
							//Log.log( [ _num, _model.chartMaxNum, _num / _model.chartMaxNum ] );
							_y = _sp.y 
							+ _config.c.vpart * _model.rateZeroIndex - _h
							;
						}
					}						
					//Log.log( _h, _y );
					
					_rectItem.x = _x + _sk * _partWidth + _gtype.partSpace * _sk;
					_h = _h || 1;
					
					_rectItem.y = _y;
					_rectItem.width = _partWidth;
					_rectItem.height = _h;
					_rectItem.value = _sitem.data[ _k ];
					
					_tmpYAr.push( _y );
					_tmpHAr.push( _h );
					
					_items.push( _rectItem );
				});
				
				_tmpDataRect.y = Math.min.apply( null, _tmpYAr );
				_tmpDataRect.height = Math.max.apply( null, _tmpHAr );
				
				if( _config.hoverBgEnabled ){
					_tmpDataRect.y -= _config.c.hoverPadY;
					_tmpDataRect.height += _config.c.hoverPadY
				}
				
				if( _config.serialLabelEnabled ){
					_tmpDataRect.y -= _config.c.serialLabelPadY;
					_tmpDataRect.height += _config.c.serialLabelPadY
				}
				
				_gtype.rects.push( _items );
				_gtype.dataRect.push( _tmpDataRect );
			});
		}
		
		
	}
}
