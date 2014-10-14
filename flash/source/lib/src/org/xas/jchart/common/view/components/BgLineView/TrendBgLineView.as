package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.GameInput;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.*;
	
	public class TrendBgLineView extends BaseBgLineView
	{
		private var _items:Vector.<VLineIcon>;
		public function get items():Vector.<VLineIcon>{ return _items; }
		private var _preIndex:int = -1;
		private var _config:Config;
		private var btmTips:Sprite;
		private var btLabel:TextField;
		private var _tmpLine:Sprite;
		private var _baseLine:Sprite;
		
		public function TrendBgLineView()
		{
			super();
			
			_config = BaseConfig.ins as Config;
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			super.update( _evt );				
		}
		
		override protected function drawHLine():void{
			if( !( _config.c && _config.c.vpoint )  ) return;
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
			});
		}
		
		override protected function drawVLine():void{
			if( !( _config.c && _config.c.hpointReal && _config.c.hpointReal[0] )  ) return;
			
			var _hlabelNum:Number = _config.hlabelNum;
			if( _config.c.hpointReal.length < _hlabelNum ){
				_hlabelNum = _config.c.hpointReal.length;
			}
			var _r:Number = Math.floor( _config.c.hpointReal.length / ( _hlabelNum - 1 ) );
			var _num:Number = 0;
			_items = new Vector.<VLineIcon>;
			
			_tmpLine = new Sprite();
			var _g:Graphics = _tmpLine.graphics;
			_g.clear();
			_g.lineStyle( 1, 0xbdb1b7, 1 );
			_g.moveTo( 0, _config.c.hpointReal[0].start.y );
			_g.lineTo( 0, _config.c.hpointReal[0].end.y );
			_tmpLine.visible = false;
			addChild( _tmpLine );
			
			if( _config.baseDate ){
				_baseLine = new Sprite();
				var _h:Number = _config.c.minY + ( 1 - Number( _config.baseDate ) 
					/ _config.finalMaxNum ) * _config.c.chartHeight;
				var _g2:Graphics = _baseLine.graphics;
				_g2.clear();
				_g2.lineStyle( 1, 0x67bf67, 1 );
				_g2.moveTo( _config.c.minX + 5, _h );
				_g2.lineTo( _config.c.maxX + 1, _h );
				addChild( _baseLine );
			}
			
			for( var i:Number = 0; i < _hlabelNum; i++ ){
				var _tmp:VLineIcon
				, _pr:Object = _config.c.hpointReal[ _num ];
				if( i == _hlabelNum - 1 ){
					_pr = _config.c.hpointReal[ _config.c.hpointReal.length - 1 ];
				}
				
				var _sp:Point = _pr.end as Point
				, _ep:Point = ( _pr.end as Point ).clone();
				_ep.y += _config.c.arrowLength;
				
				if( !BaseConfig.ins.displayAllLabel ){
					if( !( _num in BaseConfig.ins.labelDisplayIndex ) ){
						_ep.y -= _config.c.arrowLength;	
					}
				}
				addChild( _tmp = new VLineIcon( _sp, _ep ) );
				_num += _r;
			}
			drawBtmTips();
		}
		
		private function drawBtmTips():void{
			
			btLabel = new TextField();
			btLabel.text = 'text';
			btLabel.autoSize = TextFieldAutoSize.CENTER;
			btLabel.wordWrap = true; 
			Common.implementStyle( btLabel, [
				DefaultOptions.title.style
				, DefaultOptions.xAxis.labels.style
				, { 'size': 12, color: 0xffffff, 'align': 'center' }
				, _config.labelsStyle
			] );
			btLabel.width = 70;
			btLabel.height = 20;
			
			btmTips = new Sprite();
			var _g:Graphics = btmTips.graphics;
			_g.clear();
			_g.beginFill( 0xbdc1c7, 1 );
			btmTips.graphics.drawRect( 0, 0, 70, 20 );
			btmTips.visible = false;
			btmTips.x = -100;
			btmTips.y = _config.c.hpointReal[ 0 ].end.y + 1;
			btmTips.addChild( btLabel )
			addChild(btmTips);
		}
		
		override protected function drawLineArrow():void{
		}
		
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{
			if( !_tmpLine ){
				return;
			}
			_tmpLine.visible = false;
			btmTips.visible = false;
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int;
			
			if( !_config.c.hpointReal || null == _config.c.hpointReal[ _ix ] ){
				return;
			}
			
			var _x:Number = _config.c.hpointReal[ _ix ].start.x;
			_tmpLine.visible = true;
			_tmpLine.x = _x;
				
			!BaseConfig.ins.vlineEnabled && ( _items[ _ix ].visible = true );
			
			_preIndex = _ix;
			btmTips.visible = true;
			btmTips.x = _x - btmTips.width / 2;
			if( _srcEvt.stageX + btmTips.width / 2 > _config.c.maxX ){
				btmTips.x = _config.c.maxX - btmTips.width;
			}
			
			btLabel.text = _config.categories[ _ix ];
		}
	}
}