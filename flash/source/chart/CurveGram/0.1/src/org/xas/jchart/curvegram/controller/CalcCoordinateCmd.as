package org.xas.jchart.curvegram.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import mx.containers.Panel;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.*;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.common.view.mediator.BgLineMediator.CurveGramBgLineMediator;
	import org.xas.jchart.common.view.mediator.BgMediator.StackBgMediator;
	import org.xas.jchart.common.view.mediator.CreditMediator.BaseCreditMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.CurveGramGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.GroupMediator.BaseGroupMediator;
	import org.xas.jchart.common.view.mediator.GroupMediator.CurveGramGropuMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.CurveGramHLabelMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.SeriesLabelMediator.CurveGramSeriesLabelMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator.BaseSubtitleMediator;
	import org.xas.jchart.common.view.mediator.TestMediator.BaseTestMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.HistogramTipsMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator.BaseTitleMediator;
	import org.xas.jchart.common.view.mediator.ToggleBgMediator.CurveGramToggleBgMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.BaseVLabelMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.StackVLabelMediator;
	import org.xas.jchart.common.view.mediator.VTitleMediator.BaseVTitleMediator;
	import org.xas.jchart.curvegram.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		private var _config:Config;
		
		public function CalcCoordinateCmd()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override public function execute(notification:INotification):void{
			
			_c = _config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x + _config.vlabelSpace + 2;
			_c.minY = _c.y + _config.vspace * 2;
			_c.maxX = _c.x + _config.stageWidth - _config.vspace;
			_c.maxY = _c.y + _config.stageHeight - _config.vspace;			
			//_c.arrowLength = 0;
			
			var _yPad:Number = _c.minY;
						
			facade.registerMediator( new StackBgMediator( ) )		
			 
			if( _config.cd ){
				
				if( _config.titleEnable ){
					facade.registerMediator( new BaseTitleMediator( _config.titleText ) )	
					_config.c.title = { x: _config.stageWidth / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;			
				}
				
				if( _config.subtitleEnable ){
					facade.registerMediator( new BaseSubtitleMediator( _config.subtitleText ) )
					
					_config.c.subtitle = { x: _config.stageWidth / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height + 5;
				}
				
				if( _config.groupEnabled ){
					if( _config.cd.subtitle && _config.cd.subtitle.text ){
						facade.registerMediator( new CurveGramGropuMediator( _config.c.minY - 5 ) );
					}else{
						facade.registerMediator( new CurveGramGropuMediator( _config.c.minY ) );
					}
					_config.c.minY += pGroupMediator.maxHeight;
				}
				 
				if( _config.legendEnabled ){
					
					facade.registerProxy( new LegendProxy() );
					facade.registerMediator( new BaseLegendMediator() );
					
					pLegendProxy.dataModel.calLegendPosition( pLegendMediator.view );
				}
				
				if( _config.vtitleEnabled ){
					facade.registerMediator( new BaseVTitleMediator( _config.vtitleText ) )
					
					_config.c.vtitle = { x: _config.c.minX, y: _config.c.x + _config.c.height / 2, item: pVTitleMediator };
					_config.c.minX += pVTitleMediator.view.width - _config.vlabelSpace;
				}
				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new BaseCreditMediator( _config.cd.credits.text, _config.cd.credits.href ) )
					
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}	
				
				_config.c.maxX -= 5;
				
				_config.c.linePadding = 0;
				if( !_config.vlineEnabled ){
					_config.c.linePadding = 60;
					_config.c.vlabelSpace = 5;
					_config.c.minX += _config.c.vlabelSpace;
				};
				
				if( _config.yAxisEnabled ){
					facade.registerMediator( new StackVLabelMediator() );
					_config.c.minX += pVLabelMediator.maxWidth;
					_config.c.minX += _config.yArrowLength;
				}
				
//				_config.c.hoverPadY = 10;
//				if( _config.hoverBgEnabled ){
//					facade.registerMediator( new HoverBgMediator() );
//					_config.c.minY += _config.c.hoverPadY;
//					_yPad += _config.c.hoverPadY;
//				}
				
				_config.c.serialLabelPadY = 15;
				if( _config.serialLabelEnabled ){
					facade.registerMediator( new CurveGramSeriesLabelMediator() );
//					_config.c.minY += _config.c.serialLabelPadY;
//					_yPad += _config.c.serialLabelPadY;
				}
				
				if( _config.categories && _config.categories.length ){
					if( _config.displayAllLabel ){
						_config.c.labelWidth = _config.c.chartWidth / ( _config.categories.length ) / 2;
					}else{
						_config.c.labelWidth = _config.c.chartWidth / 7;
					}
				}
				
				if( _config.xAxisEnabled ){
					facade.registerMediator( new CurveGramHLabelMediator() );
					_config.c.maxY -= pHLabelMediator.maxHeight;
					
					var _tmpMaxWidth:Number = pHLabelMediator.maxWidth;
					
					if( _tmpMaxWidth < 0 ){
						_config.c.minX += Math.abs( _tmpMaxWidth );
					} else {
						_config.c.maxX -= _tmpMaxWidth;
					}
				}
				
				_config.c.chartWidth = _config.c.maxX - _config.c.minX - _config.hspace;
				
				if( _config.graphicHeight ){
					var _hpad:Number = _config.c.maxY - _config.graphicHeight;
					_config.c.chartHeight = _config.graphicHeight - _yPad;		
					_config.c.maxY -= _hpad;
					
					if( _config.c.legend ){
						_config.c.legend.y -= _hpad;
					}
					
					if( _config.c.credits ){
						_config.c.credits.y -= _hpad;
					}
				}else{	
					_config.c.chartHeight = _config.c.maxY - _config.c.minY;
				}
				
				_config.c.chartX = _config.c.minX + _config.yArrowLength - 2;
				_config.c.chartY = _config.c.minY;
				
				sendNotification( JChartEvent.DISPLAY_ALL_CHECK );
				
				facade.registerMediator( new CurveGramGraphicBgMediator() );	
				_config.tooltipEnabled && facade.registerMediator( new HistogramTipsMediator() );

				
				if( _config.toggleBgEnabled ){	
					facade.registerMediator( new CurveGramToggleBgMediator() );
				}
				
				calcChartPoint();
				
				calcGraphic();	
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new BaseTestMediator( DefaultData.instance.data ) );	
				}
			}
									
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{			
			facade.registerMediator( new GraphicMediator() );
			
			_config.c.paths = [];
			_config.c.vectorPaths = [];
			if( !( _config.series && _config.series.length ) ) return;
			_config.c.partWidth = _config.c.itemWidth / _config.displaySeries.length;
			
			Common.each( _config.displaySeries, function( _k:int, _item:Object ):void {
				
				var _cmd:Vector.<int> = new Vector.<int>
				, _path:Vector.<Number> = new Vector.<Number>
				, _positions:Array = []
				, _vectorPath:Vector.<Point> = new Vector.<Point>;				
				
				Common.each( _item.data, function( _sk:int, _num:Number ):void {
					var _rectItem:Object = {}
						, _pointItem:Object = _config.c.hpointReal[ _sk ]
						, _sp:Point = _pointItem.start as Point
						, _ep:Point = _pointItem.end as Point
						, _h:Number, _x:Number, _y:Number
						, _itemNum:Number
						, _dataHeight:Number = _config.c.vpart * _config.rateZeroIndex
						, _dataY:Number
						, _sNum:Number = _num
						, _customRate:Boolean = _config.isAutoRate
						, _minYvalue:Number;
						
						if( _config.isItemPercent && _config.displaySeries.length > 1 ) {
							_h = _config.c.vpart * _config.rateZeroIndex;
							if( _num > 0 ){
								_h = ( _num / _config.itemMax( _sk ) || 1 ) * _h;
							}
							if( _num == 0 ){
								_h = 0;
							}
							_y = _sp.y + _dataHeight - _h;
							
							if( _sk === 0 ) {
								//Log.log( _num / _config.itemMax( _sk ) * 100, _num, _config.itemMax( _sk ) );
							}
						} else {
							if( Common.isNegative( _num ) && _num != 0 ) {
								if( _customRate ) {
									_minYvalue = _config.realRate[ 0 ];
									
									_num = Math.abs( _num ) - _minYvalue;
									
									_h = ( _num / Math.abs( _config.finalMaxNum * 
										_config.rate[ _config.rate.length - 1 ] ) ) *
										( _config.c.chartHeight - _dataHeight );
										
									_y = _sp.y + _dataHeight + _h;
								} else {
									_num = Math.abs( _num );
									_h = ( _num / Math.abs( _config.finalMaxNum * 
										_config.rate[ _config.rate.length - 1 ] ) ) *
										( _config.c.chartHeight - _dataHeight );
									
									_y = _sp.y + _dataHeight + _h;
								}
							} else {
								if( _customRate ) {
									_minYvalue = _config.realRate[ _config.realRate.length - 1 ];
									
									_h = ( _num > _minYvalue ) ? ( ( ( _num -_minYvalue ) /
										( _config.chartMaxNum - _minYvalue ) || 1 ) * _dataHeight ) : 0;
									_y = _sp.y + _dataHeight - _h;
								} else {
									_h = ( _num == 0 ) ? 0 : ( ( _num / _config.chartMaxNum || 1 ) * _dataHeight );
									_y = _sp.y + _dataHeight - _h;
								}
							}
						}
						_x = _sp.x;
						
						_cmd.push( _sk === 0 ? 1 : 2 );
						_path.push( _x, _y );
						_vectorPath.push( new Point( _x, _y ) );
						_positions.push( { x: _x, y: _y, value: _sNum } );
				});
				
				_config.c.paths.push( { cmd: _cmd, path: _path, position: _positions, data: _item } );
				_config.c.vectorPaths.push( _vectorPath );
			});

		}
		
		private function calcChartPoint():void{
			facade.registerMediator( new CurveGramBgLineMediator() );
			
			calcChartVPoint();
			calcChartHPoint();
		}
		
		private function calcChartVPoint():void{
			var _partN:Number = _config.c.chartHeight / ( _config.rate.length -1 );
			_config.c.vpart = _partN;
			_config.c.itemHeight = _partN / 2;
			_config.c.vpoint = [];
			_config.c.vpointReal = [];
			
			var _padX:Number = 0;
			if( !_config.yAxisEnabled ){

			} 
			
			Common.each( _config.rate, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.chartY + _partN * _k;
				_config.c.vpoint.push( {
					start: new Point( _config.c.chartX, _n )
					, end: new Point( _config.c.chartX +_config.c.chartWidth, _n )
				});
				 
				_config.c.vpointReal.push( {
					start: new Point( _config.c.chartX, _n )
					, end: new Point( _config.c.chartX +_config.c.chartWidth, _n )
				});
			});
		}
		
		private function calcChartHPoint():void{
			var _partN:Number = 　_config.c.chartWidth / ( ( _config.realItemLength - 1 ) || 1 ) 
				, _rpartN:Number = ( _config.c.chartWidth - _config.c.linePadding ) / ( ( _config.realItemLength - 1 ) || 1)
				;
			_config.c.hpart = _partN;
			_config.c.rhpart = _rpartN;
			_config.c.hpoint = [];
			_config.c.hlinePoint = [];
			_config.c.hpointReal = [];
			_config.c.itemWidth = _partN / 2;
			_config.c.ritemWidth = _rpartN / 2;
									
			Common.each( _config.series[0].data, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.chartX + _partN * _k
					, _rn:Number = _config.c.chartX + _rpartN * _k +  _config.c.linePadding / 2
					;
								
				_config.c.hlinePoint.push( {
					start: new Point( _n, _config.c.chartY )
					, end: new Point( _n, _config.c.chartY + _config.c.chartHeight )
				});
				
				_config.c.hpoint.push( {
					start: new Point( _n, _config.c.chartY + _config.c.chartHeight )
					, end: new Point( _n, _config.c.chartY + _config.c.chartHeightY  )
				});
				
				_config.c.hpointReal.push( {
					start: new Point( _rn, _config.c.chartY )
					, end: new Point( _rn, _config.c.chartY + _config.c.chartHeight)
				});
			});
		}
		
		private function get pGroupMediator():BaseGroupMediator{
			return facade.retrieveMediator( BaseGroupMediator.name ) as BaseGroupMediator;
		}
		
		private function get pLegendMediator():BaseLegendMediator{
			return facade.retrieveMediator( BaseLegendMediator.name ) as BaseLegendMediator;
		}
		
		private function get pHLabelMediator():BaseHLabelMediator{
			return facade.retrieveMediator( BaseHLabelMediator.name ) as BaseHLabelMediator;
		}
		
		private function get pVLabelMediator():BaseVLabelMediator{
			return facade.retrieveMediator( BaseVLabelMediator.name ) as BaseVLabelMediator;
		}
		
		private function get pCreditMediator():BaseCreditMediator{
			return facade.retrieveMediator( BaseCreditMediator.name ) as BaseCreditMediator;
		}
		
		private function get pVTitleMediator():BaseVTitleMediator{
			return facade.retrieveMediator( BaseVTitleMediator.name ) as BaseVTitleMediator;
		}
		
		private function get pSubtitleMediator():BaseSubtitleMediator{
			return facade.retrieveMediator( BaseSubtitleMediator.name ) as BaseSubtitleMediator;
		}
		
		private function get pTitleMediator():BaseTitleMediator{
			return facade.retrieveMediator( BaseTitleMediator.name ) as BaseTitleMediator;
		}
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		private function get pLegendProxy():LegendProxy{
			return facade.retrieveProxy( LegendProxy.name ) as LegendProxy;
		}
		
		private function get pLineProxy():LineProxy{
			return facade.retrieveProxy( LineProxy.name ) as LineProxy;
		}
		
		private function corner():uint{
			return 20;
		}
	}
}
