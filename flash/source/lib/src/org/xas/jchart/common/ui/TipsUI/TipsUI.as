package org.xas.jchart.common.ui.TipsUI
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class TipsUI extends Sprite
	{
		/*
		{
			"items":[
				{"name":"Temperature","value":-30}
				,{"name":"Rainfall1","value":-20}
				,{"name":"Rainfall2","value":-20}
				,{"name":"Rainfall3","value":-20}
			]
			,"name":"9月"
		}
		*/
		protected var _data:Object;
		protected var _layout:BaseTipsUILayout;
		
		
		protected var _config:Config;
				
		public function TipsUI( _type:String = 'normal' )
		{
			super();
			_config = BaseConfig.ins as Config;
			
			visible = false;
			switch( _type ){
				case 'simple': {
					addChild( _layout = new SimpleTipsUILayout() );
					break;
				}
				default: {
					addChild( _layout = new BaseTipsUILayout() );
					break;
				}
			}
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );	
		}
		
		public function update( _data:Object, _position:Object = null, _colors:Array = null, _rect:Object = null ):TipsUI{
			_position && dispatchEvent( 
				new JChartEvent( JChartEvent.UPDATE_TIPS, { data: _data, point: _position, colors: _colors, rect: _rect } ) 
			);
			return this;
		}
		
		public function show( _position:Point = null ):TipsUI{
			_position && dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { point: _position } ) );
			visible = true;
			return this;
		}
		
		public function hide():TipsUI{
			visible = false;
			return this;
		}
		
		public function buildLayout( _data:Object ):TipsUI{
			_layout.buildLayout( _data );
			return this;
		}
		
		
		public function updateLayout( _data:Object = null, _colors:Array = null ):TipsUI{
			_layout.updateLayout( _data, _colors );
			return this;
		}

		
		private function updateTips( _evt:JChartEvent ):void{
			var _point:Object = _evt.data.point as Object
				, _data:Object = _evt.data.data as Object
				, _colors:Array = _evt.data.colors as Array
				, _rect:Object = _evt.data.rect as Object
				;
			if( !_point ) return;
			
			updateLayout( _data, _colors );
			
			if( _rect ){
				//Log.log(_rect.initType);
				if(_rect.initType && _rect.initType == 'VHistogram') {
					rectPositionForVHis( _point, _rect );
				} else {
					rectPosition( _point, _rect );
				}
			}else{
				normalPosition( _point, _rect );
			}
		}
		
		private function normalPosition( _point:Object, _rect:Object ):void{
			
			var _x:Number = _point.x + 15
				, _y:Number = _point.y + 18
				, _x2:Number = _x + this.width
				, _y2:Number = _y + this.height
				;
			
			if( _x2 >= root.stage.x + root.stage.stageWidth ){
				_x = _point.x - this.width;
			}
			
			if( _y2 >= root.stage.y + root.stage.stageHeight ){
				_y = _point.y - this.height;
			}
			
			_x < 0 && ( _x = 0 );
			_y < 0 && ( _y = 0 );
			
			this.x = _x;
			this.y = _y;
		}
		
		private function rectPosition( _point:Object, _rect:Object ):void{
			
			var _x:Number = _rect.x + _rect.width
				, _y:Number = _point.y 
				, _x2:Number = _x + this.width
				, _y2:Number = _y + this.height
				;
			
			if( _x2 >= root.stage.x + root.stage.width ){
				_x = _rect.x - this.width;
			}
			
			if( _y2 >= root.stage.y + root.stage.height ){
				_y = _point.y - this.height;
			}
			
			_x < 0 && ( _x = 0 );
			_y < 0 && ( _y = 0 );
			
			//Log.log( _x2, root.stage.x + root.stage.width );
			
			this.x = _x;
			this.y = _y;
			//Log.log( 'TipsUI updateTips', _point.x, _point.y );
		}
		
		private function rectPositionForVHis( _point:Object, _rect:Object ):void{
			
			var _x:Number = _point.x
				, _y:Number = _rect.x + _rect.height
				, _x2:Number = _x + this.width
				, _y2:Number = _y + this.height
				;
			
			if( _x2 >= root.stage.x + root.stage.width ){
				_x -= this.width;
			}
			
			if( _y2 >= root.stage.y + root.stage.height ){
				_y = _y - this.height - _rect.height;
			}
			
			_x < 0 && ( _x = 0 );
			_y < 0 && ( _y = 0 );
			
			this.x = _x;
			this.y = _y;
		}
	}
}