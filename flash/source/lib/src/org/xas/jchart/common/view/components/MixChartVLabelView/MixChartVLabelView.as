package org.xas.jchart.common.view.components.MixChartVLabelView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Sprite;
	import flash.events.Event;
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
	import org.xas.jchart.common.data.mixchart.MixChartModelItem.BaseMixChartModelItem;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class MixChartVLabelView extends BaseVLabelView
	{
		private var _config:Config;
		
		public function MixChartVLabelView( _index:int, _model:BaseMixChartModelItem )
		{
			super( _index, _model );
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
//			Log.printFormatJSON( _model.realRate );
			
			Common.each( _model.realRate, function( _k:int, _item:Number ):*{
				
				var _floatLen:int = _model.realRateFloatLen
					;
				
				if( _model.floatLen === 0 && _model.maxNum > 10 ){
					_floatLen = 0;
				}
					
				 
				if( _model.params && ( 'realRateFloatLen' in _model.params ) ){
					_floatLen = _model.realRateFloatLen;
				}
								
//				_t = Common.moneyFormat( _item, 3, _floatLen || 0 );
				_t = Common.moneyFormat( 
					_item
					, 3
					, _model.yAxisAbbrNumber( _item, _floatLen || 0 )
					, ','
					, _model.yAxisAbbrNumberEnabled 
				);
				
				_titem = new TextField();				
				
				if( _config.isPercent ){
					_titem.text = _t + '%';
				}else{
				}
				_titem.text = StringUtils.printf( _model.yAxisFormat, _t );
				
				var _color:uint = 0x838383;
				
				if( _config.mixModel.items.length > 1 && _model.displaySeries.length === 1 ){
					_color = _config.itemColor( _model.displaySeries[0].displayIndex );
				}else if( _config.mixModel.items.length > 1 && _model.displaySeries.length === 0 ){
					_color = 0xcccccc;
				}
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, { color: _color }
					, _model.vlabelsStyle
				] );
											
				if( _config.animationEnabled ){
					_titem.visible = false;
				}
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
			});			
			//Log.log( 'maxwidth', _maxWidth );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( _config.c && _config.c.vpoint ) ) return;
			
			//return;
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ]
					, _ex:Number = 0; 
					;
					
				if( _model.isOpposite ){
					_ex = _model.left;
//					if( _config.c.hasOppositeYAxis ){
//						_ex += _config.yArrowLength
//					}
				}else{						
					_ex = _model.left - _tf.width;
				}
				
				if( _config.animationEnabled ){
					_tf.visible = true;
					
					if( _model.isOpposite ){
						_tf.y = _item.start.y - _tf.height / 2;
						_tf.x = _ex + 200;
						
						TweenLite.delayedCall( 0, 
							function():void{
								TweenLite.to( _tf, _config.animationDuration
									, { 
										x: _ex
										, y: _item.start.y - _tf.height / 2
										, ease: Expo.easeOut } );
							});
					}else{		
						_tf.y = _item.start.y - _tf.height / 2;
						_tf.x = _ex - 200;
						
						TweenLite.delayedCall( 0, 
							function():void{
								TweenLite.to( _tf, _config.animationDuration
									, { 
										x: _ex
										, y: _item.start.y - _tf.height / 2
										, ease: Expo.easeOut } );
							});
					}

				}else{
					_tf.visible = true;
					_tf.x = _ex;
					//Log.log( _model.left );
					_tf.y = _item.start.y - _tf.height / 2;
				}
				
			});
		}


	}
}