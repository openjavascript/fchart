package org.xas.jchart.curvegram.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.data.test.MixChartData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.LegendProxy;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.curvegram.view.mediator.CurveGramGraphicMediator;
	import org.xas.jchart.histogram.view.mediator.*;
	
	public class CurveGram_CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _config:Config;
		private var _type:String;
		private var _seriesAr:Array;
		private var _gtype:Object;
		
		public function CurveGram_CalcCoordinateCmd()
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
			
			facade.registerMediator( new CurveGramGraphicMediator( _seriesAr, _gtype ) );
		}
		
		private function calc():void{			
			_gtype.paths = [];
			_gtype.vectorPaths = [];
			if( !( _config.series && _config.series.length ) ) return;
			_gtype.partWidth = _config.c.itemWidth / _seriesAr.length;
			
			//Log.log( _config.c.itemWidth );
			
			Common.each( _seriesAr, function( _k:int, _seitem:Object ):void {
				
				var _model:MixChartModelItem = _config.mixModel.items[ _seitem.modelIndex ]
				, _item:Object = _seitem.data
				, _cmd:Vector.<int> = new Vector.<int>
				, _path:Vector.<Number> = new Vector.<Number>
				, _positions:Array = []
				, _vectorPath:Vector.<Point> = new Vector.<Point>
				;				
				
				Common.each( _item.data, function( _sk:int, _num:Number ):void {
					var _rectItem:Object = {}
					, _pointItem:Object = _config.c.hpointReal[ _sk ]
					, _sp:Point = _pointItem.start as Point
					, _ep:Point = _pointItem.end as Point
					, _h:Number, _x:Number, _y:Number
					, _itemNum:Number
					, _dataHeight:Number = _config.c.vpart * _model.rateZeroIndex
					, _dataY:Number
					, _sNum:Number = _num
					, _customRate:Boolean = _model.isAutoRate
					, _minYvalue:Number;
					
					if( _config.isItemPercent && _seriesAr.length > 1 ) {
						_h = _config.c.vpart * _model.rateZeroIndex;
						if( _num > 0 ){
							_h = ( _num / _model.itemMax( _sk ) || 1 ) * _h;
						}
						if( _num == 0 ){
							_h = 0;
						}
						_y = _sp.y + _dataHeight - _h;
						
						if( _sk === 0 ) {
							//Log.log( _num / _model.itemMax( _sk ) * 100, _num, _model.itemMax( _sk ) );
						}
					} else {
						if( Common.isNegative( _num ) && _num != 0 ) {
							if( _customRate ) {
								_minYvalue = _model.realRate[ 0 ];
								
								_num = Math.abs( _num ) - _minYvalue;
								
								_h = ( _num / Math.abs( _model.finalMaxNum * 
									_model.rate[ _model.rate.length - 1 ] ) ) *
								( _config.c.chartHeight - _dataHeight );
								
								_y = _sp.y + _dataHeight + _h;
							} else {
								_num = Math.abs( _num );
								_h = ( _num / Math.abs( _model.finalMaxNum * 
									_model.rate[ _model.rate.length - 1 ] ) ) *
								( _config.c.chartHeight - _dataHeight );
								
								_y = _sp.y + _dataHeight + _h;
							}
						} else {
							if( _customRate ) {
								_minYvalue = _model.realRate[ _model.realRate.length - 1 ];
								
								_h = ( _num > _minYvalue ) ? ( ( ( _num -_minYvalue ) /
									( _model.chartMaxNum - _minYvalue ) || 1 ) * _dataHeight ) : 0;
								_y = _sp.y + _dataHeight - _h;
							} else {
								_h = ( _num == 0 ) ? 0 : ( ( _num / _model.chartMaxNum || 1 ) * _dataHeight );
								_y = _sp.y + _dataHeight - _h;
							}
						}
					}
					_x = _sp.x;
					_x += _config.c.itemWidth;
					
					_cmd.push( _sk === 0 ? 1 : 2 );
					_path.push( _x, _y );
					_vectorPath.push( new Point( _x, _y ) );
					_positions.push( { x: _x, y: _y, value: _sNum } );
				});
				
				_gtype.paths.push( { cmd: _cmd, path: _path, position: _positions, data: _item } );
				_gtype.vectorPaths.push( _vectorPath );
			});

		}

		
		
	}
}
