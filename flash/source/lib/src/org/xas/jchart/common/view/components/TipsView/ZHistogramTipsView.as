package org.xas.jchart.common.view.components.TipsView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
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
	import org.xas.jchart.common.ui.TipsUI;
	
	public class ZHistogramTipsView extends BaseTipsView
	{	
		private var curTips:TipsUI;
		private var curIndex:int;
		private var tipsBox:Array;
		
		public function ZHistogramTipsView()
		{
			super();
			tipsBox = new Array();
		}
		
		override protected function buildData():void{
			
		}
		
		private function getDataByIndex( _ix:int ):Object{
			var _d:Object = { items: [], beforeItems: [], afterItems: [] };
			var _orgData:Object = _config.displaySeries[ _ix ];
			
			if(!_orgData){ return null; }
			
			_d.name = StringUtils.printf( _config.tooltipHeaderFormat, _orgData.name.replace( /[\r\n]+/g, '' ) );
			
			Common.each( _config.tooltipSerial, function( _sk:int, _sitem:Object ):void{
				if(  _sitem.data ){
					var _name:String = _sitem.name + ''
					, _value:String = StringUtils.printf( _config.tooltipSerialFormat, 
						Common.moneyFormat( _sitem.data[ _ix ], 3, Common.floatLen( _sitem.data[ _ix ] ) ) );
					
					_d.beforeItems.push( {
						'name': _name.replace( /[\r\n]+/g, '' )
						, 'value': _value
					});
				}
			});
			
			Common.each( _orgData.data, function( _sk:int, _sitem:Number ):void{
				var _name:String = ""
				, _fmt:String = _orgData.format ? _orgData.format : _config.tooltipPointFormat;
				
				_orgData.label && ( _name = _orgData.label[ _sk ] );
				BaseConfig.ins.categories 
					&& BaseConfig.ins.categories[ BaseConfig.ins.displaySeriesIndexMap[ _sk ] ] 
					&& ( _name = BaseConfig.ins.categories[ BaseConfig.ins.displaySeriesIndexMap[ _sk ] ] );
				
				
				_d.items.push( {
					'name': _name.replace( /[\r\n]+/g, '' )
					, 'value': StringUtils.printf( _fmt, _sitem,
						Number( _sitem / _config.c.totalArray[ _ix ] * 100 ).toFixed( 2 ) )
				});
			});
			
			Common.each( _config.tooltipAfterSerial, function( _sk:int, _sitem:Object ):void{
				if(  _sitem.data ){
					var _name:String = _sitem.name + ''
					, _value:String = StringUtils.printf( _config.tooltipAfterSerialFormat, 
						Common.moneyFormat( _sitem.data[ _ix ], 3, Common.floatLen( _sitem.data[ _ix ] ) ) );
					
					_d.afterItems.push( {
						'name': _name.replace( /[\r\n]+/g, '' )
						, 'value': _value
					});
				}
			});
			
			return _d;
		}
		
		override protected function showTips( _evt: JChartEvent ):void{
			var _tips:TipsUI;
			if( tipsBox[ 0 ] ){
				_tips = tipsBox[ 0 ];
				_tips.show( new Point( 10000, 0 ) );
			} else {
				addChild( _tips = new TipsUI() );
				var _d:Object = getDataByIndex( 0 );
				_d && _tips.buildLayout( _d ).show( new Point( 10000, 0 ) );
				tipsBox[ 0 ] = _tips;
			}
			curTips = _tips;
			curIndex = -1;
		}
		
		override protected function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				, _pos:Object, _d:Object
				, _tips:TipsUI;
			
			_pos = { x: _srcEvt.stageX, y: _srcEvt.stageY };
			
			_d = getDataByIndex( _ix );
			
			if( curTips && curIndex != _ix ){
				curTips.hide();
			}
			
			if( tipsBox[ _ix ] ) {
				_tips = tipsBox[ _ix ];
				
				if( _config.hoverBgEnabled && _config.c.dataRect && _config.c.dataRect[ _ix ]){
					_tips.update( _d, _pos, null, _config.c.dataRect[ _ix ] )
						.show(new Point( _pos.x, _pos.y ) );
				}else{
					_tips.update( _d, _pos ).show(new Point( _pos.x, _pos.y ) );
				}
			} else {
				addChild( _tips = new TipsUI() );
				_tips.buildLayout( getDataByIndex( _ix ) ).show( new Point( _pos.x, _pos.y ) );
				tipsBox[ _ix ] = _tips;
			}
			curTips = _tips;
			curIndex = _ix;
		}
		
		override protected function hideTips( _evt: JChartEvent ):void{
			if( !curTips ){
				return;
			}
			curTips.hide();
		}
	}
}