package org.xas.jchart.common.view.components.TipsView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.display3D.IndexBuffer3D;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.TipsUI.TipsUI;
	
	public class TrendTipsView extends BaseTipsView
	{	
		public function TrendTipsView()
		{
			super();
		}
		
		override protected function buildData():void{
			if( !_config.tooltipEnabled ) return;
			if( !( _config.categories && _config.categories.length ) ){
				return;
			}
			
			_data = {};

			!_config.cd.tooltip.dynLoading && 
			Common.each( _config.dataFlow,function( _sk:int, _sitem:Object ):void{
				_data[ _sk ] = getDataByIndex( _sk );
			});
		}
		
		override protected function showTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;			
			if( !( _config.categories && _config.categories.length ) ) return;
			_tips.buildLayout( getDataByIndex( 0 ) ).show( new Point( 10000, 0 ) );
		}
		
		override protected function updateTips( _evt: JChartEvent ):void{
			if( !_config.tooltipEnabled ) return;
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				, _x:Number, _y:Number
				, _pos:Object;

			if( !( _config.categories && _config.categories.length ) ) return;
			
			_x = _srcEvt.stageX;
			_y = _srcEvt.stageY;
			_pos = { x: _x, y: _y };
			
			var _tipsData:Object = _data[ _ix ] ? _data[ _ix ] : getDataByIndex( _ix );
			
			_tips.update( _tipsData, _pos );
			
			if( _config.cd.tooltip.fixed ){
				_tips.x = _x < ( _config.c.chartWidth / 2 + _config.c.minX ) ? 
					( _config.c.maxX - _tips.width ) : _config.c.minX;
				_tips.y = _config.c.minY;
				_tips.height > _config.c.chartHeight && ( _tips.height = _config.c.chartHeight );
			}
		}
		
		public function getDataByIndex( _ix:Number ):Object{
			var dateStr:String = _config.getTipsHeader( _ix );
			dateStr = dateStr.indexOf(':') > 0 ? dateStr : dateStr + ' 00:00:00 ';
			var date:Date = new Date();
			date.time = Date.parse( convertDateStr( dateStr ) );
			var xq:String = "";
			switch( date.getDay() ){
				case 0 : { xq = "日";break; }
				case 1 : { xq = "一";break; }
				case 2 : { xq = "二";break; }
				case 3 : { xq = "三";break; }
				case 4 : { xq = "四";break; }
				case 5 : { xq = "五";break; }
				case 6 : { xq = "六";break; }
			}
			
			var _tipsData:Object = { items: [], beforeItems: [], afterItems: [] };
			_tipsData.name = StringUtils.printf( _config.tooltipHeaderFormat, 
				_config.getTipsHeader( _ix ), ' 星期' + xq ).replace( /[\r\n]+/g, '' );
			
			Common.each( _config.tooltipAfterSerial, function( _sk:int, _sitem:Object ):void{
				var _data:Number = _config.dataFlow[ _ix ][ _sitem.data ];
				var ft:String = _sitem.format ? _sitem.format : _config.tooltipSerialFormat;
				var _value:String = _data > 10000 ? ( _data/10000 ).toFixed(2) + '万' : _data + '';
				_tipsData.afterItems.push( {
					'name': ( _sitem.name + '' ).replace( /[\r\n]+/g, '' ),
					'value': StringUtils.printf( ft, _value )
				});
			});
			
			_data[ _ix ] = _tipsData;
			return _tipsData;
		}
		
		public static function convertDateStr(dateStr:String):String{  
			var strArr:Array = dateStr.split(" ");  
			var fStr:String = "{0} {1} {2}";  
			return format(fStr, (strArr[0] as String).split("-").join("/"), strArr[1], "GMT");  
		}
		
		public static function format(str:String, ...args):String{
			for(var i:int = 0; i<args.length; i++){  
				str = str.replace(new RegExp("\\{" + i + "\\}", "gm"), args[i]);  
			}  
			return str;  
		}
	}
}