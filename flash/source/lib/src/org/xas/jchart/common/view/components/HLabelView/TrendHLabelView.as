package org.xas.jchart.common.view.components.HLabelView
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class TrendHLabelView extends BaseHLabelView
	{
		private var _config:Config;
		
		public function TrendHLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _titem:TextField;
			
			if( _config.dataFlow ){
				
				var _num:Number = 0;
				var _hlabelNum:Number = _config.hlabelNum;
				if( _config.categories.length < _hlabelNum ){
					_hlabelNum = _config.categories.length;
				}
				var _r:Number = Math.floor( _config.categories.length / ( _hlabelNum - 1 ) );
				
				for( var i:Number = 0; i < _hlabelNum; i++ ){
					_titem = new TextField();
					if( i == _hlabelNum - 1 ){
						_num = _config.categories.length - 1;
					}
					_titem.text = StringUtils.printf( _config.xAxisFormat, _config.categories[ _num ] );
					_titem.autoSize = TextFieldAutoSize.LEFT;
					var _align:String = 'center';
					if( _config.vlineEnabled ){
						if( _num === 0 ){
							_align = 'left';
						}else if( _num === _config.categories.length - 1 ){
							_align = 'right';
						}
					}
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': _align }
						, _config.labelsStyle
					] );
					
					if( _config.c.labelWidth && _config.xAxisWordwrap ){
						var _twidth:Number = _config.c.labelWidth;
						if( _twidth < 14 ) _twidth = 14;
						_titem.width = _twidth * 1.8;
						_titem.wordWrap = true;
					}
					
					if( !_config.displayAllLabel ){
						if( !( _num in _config.labelDisplayIndex ) ){
							_titem.visible = false;
						}
					}
					_labels.push( _titem );
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
					
					_num += _r;
				}
			}
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( _config.c && _config.c.hpoint ) ) return;
			var _hlabelNum:Number = _config.hlabelNum;
			if( _config.c.hpointReal.length < _hlabelNum ){
				_hlabelNum = _config.c.hpointReal.length;
			}
			var _r:Number = Math.floor( _config.c.hpointReal.length / ( _hlabelNum - 1 ) );
			//Log.printObject(_hlabelNum - 1);
			var _num:Number = 0;
			
			for( var i:Number = 0; i < _hlabelNum; i++ ){
				var _tf:TextField = _labels[ i ];
				if( i == _hlabelNum - 1 ){
					_num = _config.c.hpointReal.length - 1;
				}
				
				if( _config.vlineEnabled ){
					normalPosition( i, _config.c.hpointReal[ _num ] );
				}else{
					vlineDisabledPosition( i, _config.c.hpointReal[ _num ] );
				}
				
				_tf.y = _config.c.hpointReal[ _num ].end.y + _config.c.arrowLength;
				addChild(_tf);
				_num += _r;
			}
		}
		
		private function normalPosition( _index:int, _item:Object ):void{
			
			var _tf:TextField = _labels[ _index ]
				, _x:Number = _item.end.x - _tf.width / 2
				;
			
			if( _index === 0 ){
				_x < _config.c.chartX && ( _x = _config.c.chartX - 3 );
			}else if( _index === labels.length - 1 ){
				if( _x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
					_x = _config.c.chartX + _config.c.chartWidth - _tf.width + 3;
				}
			}
			
			_tf.x = _x;
		}
		
		private function vlineDisabledPosition( _index:int, _item:Object ):void{

			var _tf:TextField = _labels[ _index ]
				, _x:Number = _item.end.x - _tf.width / 2
				, _chartX:Number = _config.c.chartX + _config.c.linePadding / 2
				, _chartWidth:Number = _config.c.chartWidth - _config.c.linePadding
				;
			
			_tf.x = _x;
		}
	}
}