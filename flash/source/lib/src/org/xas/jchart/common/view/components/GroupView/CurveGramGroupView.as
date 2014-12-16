package org.xas.jchart.common.view.components.GroupView
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.JSprite;
	import org.xas.jchart.common.ui.widget.JTextField;

	public class CurveGramGroupView extends BaseGroupView
	{
		private var _labelData:Array = [];
		private var _labelMap:Object = {};
		private var _labels:Vector.<JTextField>;
		private var _rects:Vector.<JSprite>;
		
		public function CurveGramGroupView( _startY:Number = 0 )
		{
			super( _startY );
		}
		
		
		override protected function addToStage( _evt:Event ):void{
			//Log.log( '_startY:' + _startY );
			
			init();
			
			_maxHeight = 0;
			if( _labels.length ){
				_maxHeight = _labels[0].height;
			}
		}
		
		private function init():void{
			
			_labels = new Vector.<JTextField>();
			
			Common.each( BaseConfig.ins.group.data, function( _k:int, _item:String ):void {
				if( _item in _labelMap ){
					_labelMap[ _item ].end = _k;
				}else{
					_labelMap[ _item ] = {};
					_labelMap[ _item ].begin = _k;
					_labelMap[ _item ].end = _k;
					_labelData.push( _labelMap[ _item ] );
					var _label:JTextField = new JTextField( _labelMap[ _item ] );
					_label.text = _item;
					_label.y = _startY;
					
					Common.implementStyle( _label, [
						DefaultOptions.subtitle.style
						, BaseConfig.ins.groupLabelStyle
					] )
										
					addChild( _label );
					_labels.push( _label );
				}
			});
			
			//Log.printJSON( _labelMap );
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			//Log.log( 'show chart' );
			
			Common.each( _labels, function( _k:int, _item:JTextField ):void{
				var _data:Object = _item.data
					, _spoint:Point = BaseConfig.ins.c.hpointReal[ _data.begin ].start as Point
					, _epoint:Point = BaseConfig.ins.c.hpointReal[ _data.end ].end as Point
					, _width:Number = _epoint.x - _spoint.x
					, _height:Number = _epoint.y - _spoint.y
					;					
				_item.x = _spoint.x + _width / 2 - _item.width / 2;
				
				var _rect:JSprite = new JSprite()
					, _ix:int = _k % BaseConfig.ins.groupBgColors.length
					, _color:uint =  BaseConfig.ins.groupBgColors[ _ix ]
					;
			
				if( _k === _labels.length - 1 ){
					_color = BaseConfig.ins.groupLastBgColors( _color );
				}
					
				_rect.graphics.beginFill( _color );
				_rect.graphics.lineStyle( 0, 0, 0 );
				_rect.graphics.drawRect( _spoint.x, _spoint.y, _width, _height );
				addChild( _rect );				
			});
		}
		
	}
}