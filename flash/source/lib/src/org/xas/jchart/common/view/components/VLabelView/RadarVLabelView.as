package org.xas.jchart.common.view.components.VLabelView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class RadarVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		private var _preIndex:int = -1;
		
		private var _vlabels:Vector.<Vector.<TextField>>;
		
		public function RadarVLabelView()
		{
			super();
			
			_vlabels = new Vector.<Vector.<TextField>>();
			
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );

			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void {
		}
		
		private function updateTips( _evt: JChartEvent ):void {
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;
			
			if( !( _vlabels && _vlabels.length ) ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ) {
				
				Common.each( _vlabels[ _preIndex ], function( _idx:Number, _label:TextField ):void {
					TweenLite.to( _label, _config.animationDuration, {
						alpha: 0
						, ease: Expo.easeOut 
					} );
				} );
			}
			
			Common.each( _vlabels[ _ix ], function( _idx:Number, _label:TextField ):void {
				TweenLite.to( _label, _config.animationDuration, {
					alpha: 1
					, ease: Expo.easeOut 
				} );
			} );
			
			_preIndex = _ix;
		}
		
		private function hideTips( _evt: JChartEvent ):void {
			
			if( _preIndex >= 0 ){
				Common.each( _vlabels[ _preIndex ], function( _idx:Number, _label:TextField ):void {
					TweenLite.to( _label, _config.animationDuration, {
						alpha: 0
						, ease: Expo.easeOut 
					} );
				} );
			}
			_preIndex = -1;
		}	
		
		override protected function update( _evt:JChartEvent ):void {
			var _titem:TextField
			, _t:String
			, _rateObj:Object;
			
			Common.each( _config.c.radarBgPoint, function( _i:Number, _list:Vector.<Point> ):void {
				Common.each( _list, function( _idx:Number, _item:Point ):void {
					_titem = new TextField();
					
					_rateObj = _config.c.rateList[ _idx ];
					
					var _floatLen:int = BaseConfig.ins.realRateFloatLen;
					
					if( BaseConfig.ins.floatLen === 0 && BaseConfig.ins.maxNum > 10 ){
						_floatLen = 0;
					}
					
					if( BaseConfig.ins.cd && BaseConfig.ins.cd.yAxis && ( 'realRateFloatLen' in BaseConfig.ins.cd.yAxis ) ){
						_floatLen = BaseConfig.ins.realRateFloatLen;
					}
					
					_t = Common.moneyFormat( _rateObj.realRate[ _i ], 3, _floatLen || 0 );
					
					if( BaseConfig.ins.isPercent ){
						_titem.text = _t + '%';
					}
					
					_titem.text = StringUtils.printf( BaseConfig.ins.yAxisFormat, _t );
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.yAxis.labels.style
						, { color: 0x838383 }
						, BaseConfig.ins.vlabelsStyle
					] );
					
					_titem.x = _item.x;
					_titem.y = _item.y;
					_titem.alpha = 0;
					_titem.visible = true;
					_titem.mouseEnabled = false;
					
					_titem.filters = new Array( new GlowFilter( 0xeeeeee,1,2,2,255 ) );
					_titem.textColor = 0x666666;
					
					addChild( _titem );
					
					if( _vlabels.length <= _idx ) {
						_vlabels[ _idx ] = new Vector.<TextField>();
					}
					
					_vlabels[ _idx ][ _i ] = _titem;
					
				} );
			} );
		}
	}
}