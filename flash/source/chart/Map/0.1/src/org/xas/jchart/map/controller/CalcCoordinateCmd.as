package org.xas.jchart.map.controller
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
	import org.xas.jchart.common.data.test.MapData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.map.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		private var _config:Config;
		
		public function CalcCoordinateCmd(){
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override public function execute(notification:INotification):void{
			
			_c = _config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x + _config.vlabelSpace + 2;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _config.stageWidth - 5;
			_c.maxY = _c.y + _config.stageHeight - 5;
			
			facade.registerMediator( new BgMediator( ) );
			var _yPad:Number = _c.minY;
			
			if( _config.cd ){
				
				//标题
				if( _config.cd.title && _config.cd.title.text ){
					facade.registerMediator( new TitleMediator( _config.cd.title.text ) )
					_config.c.title = { x: _config.stageWidth / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;
				}
				
				//副标题
				if( _config.cd.subtitle && _config.cd.subtitle.text ){
					facade.registerMediator( new SubtitleMediator( _config.cd.subtitle.text ) );
					_config.c.subtitle = { x: _config.stageWidth / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height + 5;
				}
				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new CreditMediator( _config.cd.credits.text, _config.cd.credits.href ) );
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}
				
				//设置地图显示区域
				if( _config.cd.series && _config.cd.series.length ){
					_config.c.hoverColor = _config.hoverColor;
					_config.c.highColor = _config.highColor;
					_config.c.zoom = _config.zoomEnabled;
					
					_config.c.oriX1 = 0, _config.c.oriX2 = 0,
					_config.c.oriY1 = 0, _config.c.oriY2 = 0,
					_config.c.maxValue = 0;
					_config.c.colorArray = [];
					_config.c.mapData = _config.mapData;
					Common.each( _config.mapData, function( _i:int, _item:Object ):void{
						
						_config.c.maxValue < _item.value && ( _config.c.maxValue = _item.value );
						
						_config.c.colorArray[ _i ] = parseInt( calcColor( _item.value ), 16);
						
						Common.each( _item.coordinates, function( _k:int, _sitem:Object ):void{
							if( _item.type == "MultiPolygon" ){
								Common.each( _sitem, function( _j:int, _vitem:Object ):void{
									caleMapData( _vitem[0], _vitem[1] );
								});
							} else {
								caleMapData( _sitem[0], _sitem[1] );
							}
						});
					});
					
					_config.c.oriWidth = _config.c.oriX2 - _config.c.oriX1;
					_config.c.oriHeight = _config.c.oriY2 - _config.c.oriY1;
					
					_config.c.mapWidth = _config.c.maxX - _config.c.minX;
					_config.c.mapHeight = _config.c.maxY - _config.c.minY;
					if( _config.c.mapWidth / _config.c.mapHeight 
						> _config.c.oriWidth / _config.c.oriHeight ){
						_config.c.op = _config.c.mapHeight / _config.c.oriHeight;
					} else {
						_config.c.op = _config.c.mapWidth / _config.c.oriWidth;
					}
					
					//初始化tips
					_config.tooltipEnabled && facade.registerMediator( new TipsMediator() );
					
					//初始化callback
					_config.c.initedCallback = _config.initedCallback;
					_config.c.hoverCallback = _config.hoverCallback;
					_config.c.clickCallback = _config.clickCallback;
				}
				
				//计算颜色带图例
				if( _config.legendEnabled ){
					_config.c.legend = new Object();
					_config.c.legend.width = 30;
					_config.c.legend.height = _config.c.mapHeight * 2 / 7;
					_config.c.legend.pX = 50 + _config.c.legend.width;
					_config.c.legend.pY = _config.c.maxY - _config.c.legend.height - 5;
					
					facade.registerMediator( new LegendMediator() );
					facade.registerMediator( new VLabelMediator() );
				}
				
				calcGraphic();
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new TestMediator( MapData.instance.data ) );
				}
			}
			sendNotification( JChartEvent.SHOW_CHART );
		}
		
		private function caleMapData( _pointX:Number, _pointY:Number ):void{
			//_sitem[1] = _sitem[1] * 1.3;
			_config.c.oriX1 == 0 && ( _config.c.oriX1 = _pointX );
			_config.c.oriY1 == 0 && ( _config.c.oriY1 = _pointY );
			_pointX < _config.c.oriX1 && ( _config.c.oriX1 = _pointX );
			_pointX > _config.c.oriX2 && ( _config.c.oriX2 = _pointX );
			_pointY < _config.c.oriY1 && ( _config.c.oriY1 = _pointY );
			_pointY > _config.c.oriY2 && ( _config.c.oriY2 = _pointY );
		}
		
		private function calcGraphic():void{
			//地图路径数据
			facade.registerMediator( new GraphicMediator() );
		}
		
		public function calcColor( _value:Number ):String{
			var _realOp:Number = 1 - _value / _config.maxNum,
				_Hrgb:Object = Hex2RGB( numChange( _config.highColor, 10, 16 ) ),
				_Lrgb:Object = Hex2RGB( numChange( _config.lowColor, 10, 16 ) );
			
			return RGB2Hex(
				( parseInt( _Lrgb._r, 16 ) * _realOp + 
					parseInt( _Hrgb._r, 16 ) * ( 1 - _realOp ) ).toString( 16 ),
				( parseInt( _Lrgb._g, 16 ) * _realOp + 
					parseInt( _Hrgb._g, 16 ) * ( 1 - _realOp ) ).toString( 16 ),
				( parseInt( _Lrgb._b, 16 ) * _realOp + 
					parseInt( _Hrgb._b, 16 ) * ( 1 - _realOp ) ).toString( 16 )
			);
		}
		
		public function Hex2RGB( _colorStr:String ):Object{
			var _res:Object = new Object(),
				_fullhex:String = "";
			
			if( _colorStr.length < 6){
				for(var i:Number = 0;i<6 - _colorStr.length;i++){
					_fullhex = _fullhex.concat("0");
				}
				_fullhex = _fullhex.concat(_colorStr);
			} else {
				_fullhex = _colorStr;
			}
			
			_res._r = _fullhex.substr( 0, 2);
			_res._g = _fullhex.substr( 2, 2);
			_res._b = _fullhex.substr( 4, 2);
			return _res;
		}
		
		private function RGB2Hex( _r:String, _g:String, _b:String ):String{
			var _nr:Number = parseInt( _r, 16 );
			_r = _nr > 255 ? "ff" : _nr.toString(16);
			_r.length < 2 && ( _r = "0" + _r );
			var _ng:Number = parseInt( _g, 16 );
			_g = _ng > 255 ? "ff" : _ng.toString(16);
			_g.length < 2 && ( _g = "0" + _g );
			var _nb:Number = parseInt( _b, 16 );
			_b = _nb > 255 ? "ff" : _nb.toString(16);
			_b.length < 2 && ( _b = "0" + _b );
			return _r + _g + _b;
		}
		
		public function numChange(txt:String,radix:uint,target:uint):String{
			var num:Number = parseInt(txt,radix);
			return num.toString(target);
		}
		
		private function calcChartPoint():void{
			
		}
		
		private function get pSubtitleMediator():SubtitleMediator{
			return facade.retrieveMediator( SubtitleMediator.name ) as SubtitleMediator;
		}
		
		private function get pTitleMediator():TitleMediator{
			return facade.retrieveMediator( TitleMediator.name ) as TitleMediator;
		}
		
		private function get pCreditMediator():CreditMediator{
			return facade.retrieveMediator( CreditMediator.name ) as CreditMediator;
		}
		
		private function get pGraphicBgMediator():GraphicBgMediator{
			return facade.retrieveMediator( GraphicBgMediator.name ) as GraphicBgMediator;
		}
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		private function corner():uint{
			return 20;
		}
	}
}
