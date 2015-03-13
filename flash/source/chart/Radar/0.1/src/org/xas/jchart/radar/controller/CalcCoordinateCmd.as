package org.xas.jchart.radar.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import mx.containers.Panel;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.proxy.*;
	import org.xas.jchart.common.proxy.data.rate.BaseRateData;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.common.view.mediator.BgLineMediator.RadarBgLineMediator;
	import org.xas.jchart.common.view.mediator.CreditMediator.BaseCreditMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator.RadarGraphicBgMediator;
	import org.xas.jchart.common.view.mediator.GroupMediator.BaseGroupMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.BaseHLabelMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator.RadarHLabelMediator;
	import org.xas.jchart.common.view.mediator.LegendMediator.BaseLegendMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator.BaseSubtitleMediator;
	import org.xas.jchart.common.view.mediator.TestMediator.BaseTestMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator.RadarTipsMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator.BaseTitleMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.BaseVLabelMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator.RadarVLabelMediator;
	import org.xas.jchart.common.view.mediator.VTitleMediator.BaseVTitleMediator;
	import org.xas.jchart.radar.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		private var _config:Config;
		private var _proxy:BaseRateData;
		
		public function CalcCoordinateCmd()
		{
			super();
			_config = BaseConfig.ins as Config;
			_proxy = new BaseRateData();
		}
		
		override public function execute(notification:INotification):void{
			
			_c = _config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x + _config.vlabelSpace + 2;
			_c.minY = _c.y + _config.vspace * 2;
			_c.maxX = _c.x + _config.stageWidth - _config.vspace;
			_c.maxY = _c.y + _config.stageHeight - _config.vspace;
			
			var _yPad:Number = _c.minY;
						
			if( _config.cd ){
				
				if( _config.titleEnable){
					facade.registerMediator( new BaseTitleMediator( _config.titleText ) )	
					_config.c.title = { x: _c.width / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;			
				}
				
				if( _config.subtitleEnable ){
					facade.registerMediator( new BaseSubtitleMediator( _config.subtitleText ) )
					
					_config.c.subtitle = { x: _c.width / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height + 5;
				}
				
				if( _config.vtitleEnabled ){
					facade.registerMediator( new BaseVTitleMediator( _config.vtitleText ) )
					
					_config.c.vtitle = { x:_config.c.minX, y:_config.c.x +_config.c.height / 2, item: pVTitleMediator };
					_config.c.minX += pVTitleMediator.view.width - 5;
				}
				
				if(_config.cd.credits &&_config.cd.credits.enabled && (_config.cd.credits.text ||_config.cd.credits.href ) ){
					facade.registerMediator( new BaseCreditMediator(_config.cd.credits.text,_config.cd.credits.href ) )
					
					_config.c.credits = { x:_config.c.maxX, y:_config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}
				
				if(_config.legendEnabled ) {
					facade.registerProxy( new LegendProxy() );
					facade.registerMediator( new BaseLegendMediator() );
					
					pLegendProxy.dataModel.calLegendPosition( pLegendMediator.view );
				}
				
				if( _config.xAxisEnabled ) {
					facade.registerMediator( new RadarHLabelMediator() );
				}
				
				if( _config.yAxisEnabled ) {
					facade.registerMediator( new RadarVLabelMediator() );
				}
				
				_config.c.chartWidth =_config.c.maxX -_config.c.minX;
				_config.c.chartHeight =_config.c.maxY -_config.c.minY;	
				
				_config.c.chartX =_config.c.minX;
				_config.c.chartY =_config.c.minY;
				
				_config.c.chartMaxX =_config.c.chartX +_config.c.chartWidth;
				_config.c.chartMaxY =_config.c.chartY +_config.c.chartHeight;
				
				facade.registerMediator( new RadarGraphicBgMediator() );
				if( _config.tooltipEnabled ) {
					facade.registerMediator( new RadarTipsMediator() );
				}
				
				if( _config.dataLabelEnabled ) {
					//facade.registerMediator( new BasePieLabelMediator() );	
					//_maxLabelWidth = pPieLabelMediator.maxWidth;
					//_maxLabelHeight = pPieLabelMediator.maxHeight;
				}
				
				calcBackgroundPoint();
				facade.registerMediator( new RadarBgLineMediator() );
				
				calcLabelPoint();

				calcGraphic();
				
				if( !ExternalInterface.available ) {
					facade.registerMediator( new BaseTestMediator( DefaultData.instance.data ) );	
				}
			}
			
			sendNotification( JChartEvent.SHOW_CHART );
		}
		
		private function calcBackgroundPoint():void {
			
			_config.c.radarBgPoint = [];
			_config.c.radarAngle = [];
			
			var _angle:Number = 360
				, _range:Number = 5
				, _categoriesLen:int = _config.categories.length
				, _partAngle:Number
				, _radius:Number = calcRadius(_config.c.chartWidth,_config.c.chartHeight )
				
				, centerPoint:Point = new Point(
					_config.c.chartX + _config.c.chartWidth / 2
					, _config.c.chartY + _config.c.chartHeight / 2
				)
				, _basePoint:Point = new Point( centerPoint.x, _config.c.chartY )
				, _radarPart:Vector.<Point>
				, _partRange:Number = _radius / _range
				, _nowRadius:Number = _radius;
			
			if( _categoriesLen == 0 ) {
				var _dataMaxLen:Number = 0;
				var _itemDataLen:Number;
				var _displaySeries:Array = _config.displaySeries;
				Common.each( _displaySeries, function( _idx:Number, _item:Object ):void {
					_itemDataLen = _item.data.length;
					_dataMaxLen = Math.max( _itemDataLen, _dataMaxLen );
				} );
				_categoriesLen = _dataMaxLen
			}
			
			_partAngle = 360 / _categoriesLen
			
			_config.c.radius = _radius;
			_config.c.range = _range;
			_config.c.centerPoint = centerPoint;
			_config.c.partAngle = _partAngle;
			
			for( var _i:int = 0; _i < _range; _i++  ) {
				_radarPart = new Vector.<Point>();
				
				_nowRadius -= _partRange;
				
				var _nowAngle:Number = 0
					, _remotePoint:Point;
				
				for( var _j:Number = 0; _j < _categoriesLen; _j++ ) {
					_remotePoint = calcPointByCenter( centerPoint, _nowRadius, _nowAngle );
					
					if( !_config.c.radarAngle[ _j ] ) {
						_config.c.radarAngle[ _j ] = _nowAngle;
					}
					
					_radarPart.push( _remotePoint );
					_nowAngle += _partAngle;
				}
				_config.c.radarBgPoint.push( _radarPart );
			}
		}
		
		private function calcGraphic():void {
			facade.registerMediator( new GraphicMediator() );
			
			if( !( _config.series && _config.series.length ) ) return;
			
			var _dataMaxLen:Number = 0;
			var _itemDataLen:Number;
			var _displaySeries:Array = _config.displaySeries;
			Common.each( _displaySeries, function( _idx:Number, _item:Object ):void {
				_itemDataLen = _item.data.length;
				_dataMaxLen = Math.max( _itemDataLen, _dataMaxLen );
			} );
			
			_config.c.dataList = new Array();
			_config.c.rateList = new Array();
			
			var _tmpDataArr:Array;
			var _tmpRateObj:Object;
			var _zeroRange:Number;//零值点距原点的距离倍数
			var _outerRange:Number;//最大值距原零值点的距离倍数
			var _center:Point = _config.c.centerPoint;//原点
			var _partHeight:Number = _config.c.radius / _config.c.range;//每一个角每一段的长度
			var _tmpHeight:Number;//动态点到原点的距离
			var _tmpRange:Number;//动态点到指定点的距离倍数
			var _outPoint:Point;//每一个角最大值点
			var _tmpAngle:Number;
			for( var _i:Number = 0; _i < _dataMaxLen; _i++ ) {
				_tmpDataArr = new Array();
				Common.each( _displaySeries, function( _idx:Number, _item:Object ):void {
					_tmpDataArr[ _idx ] = {
						'data': _item.data[ _i ] || 0
					};
				} );
				
				_tmpRateObj = _proxy.calcRate( _tmpDataArr );
				
				_config.c.rateList[ _i ] = _tmpRateObj;
				
				_tmpAngle = _config.c.radarAngle[ _i ];
				
				_outPoint = _config.c.radarBgPoint[ 0 ][ _i ] as Point;
				
				Common.each( _tmpDataArr, function( _n:Number, _o:Object ):void {
					
					_zeroRange = ( _config.c.range - 1 ) - _tmpRateObj.rateZeroIndex;
					_outerRange = ( _config.c.range - 1 ) - _zeroRange;
					
					if( _o.data <= 0 ) {
						if( _tmpRateObj.minNum == 0 ) {
							_tmpRange = 0;
						} else {
							_tmpRange = _o.data / _tmpRateObj.minNum;
						}
						
						_tmpHeight = _zeroRange * _partHeight * ( 1 - _tmpRange );
					} else {
						_tmpRange = _o.data / _tmpRateObj.maxNum;
						_tmpHeight = _zeroRange * _partHeight + _outerRange * _partHeight * _tmpRange;
					}
					
					_tmpDataArr[ _n ].position = calcPointByCenter( _center, _tmpHeight, _tmpAngle );
				} );
				
				_config.c.dataList[ _i ] = _tmpDataArr;
			}
			
			_config.c.pathVector = [];
			for( var _j:Number = 0; _j < _displaySeries.length; _j++ ) {
				_config.c.pathVector[ _j ] = {
					'path' : new Vector.<Point>
					, 'data' : _displaySeries[ _j ].data
				};
				Common.each( _config.c.dataList, function( _n:Number, _item:Object ):void {
					_config.c.pathVector[ _j ].path[ _n ] = _item[ _j ].position as Point;
				} );
			}
		}
		
		private function calcLabelPoint():void {
			
			var labelMargin:Number = 30
				, _radius:Number = _config.c.radius
				, _partRadius:Number = _radius / _config.c.range
				, _tmpPoint:Point
				, _center:Point = _config.c.centerPoint
				, _angle:Number;
			
			_radius = _radius - _partRadius + Math.min( _partRadius, labelMargin );
			
			_config.c.hpoint = [];
			
			for( var _idx:Number = 0; _idx < _config.categories.length; _idx++ ) {
				
				_angle = _config.c.radarAngle[ _idx ];
				
				_tmpPoint = calcPointByCenter( _center, _radius, _angle );
				
				_config.c.hpoint.push( _tmpPoint );
			}
		}
		
		private function calcRadius( _w:Number, _h:Number ):Number{
			var _radius:Number = Math.min( _w, _h );
			
			_radius /= 2;
			
			return _radius;
		}
		
		private function calcPointByCenter( _center:Point, _radius:Number, _angle:Number ):Point {
			return new Point(
				_center.x + _radius * Math.sin( _angle * Math.PI/180 )
				, _center.y - _radius * Math.cos( _angle * Math.PI/180 )
			);
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
