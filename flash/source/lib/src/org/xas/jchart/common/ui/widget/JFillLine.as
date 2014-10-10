package org.xas.jchart.common.ui.widget
{
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;

	public class JFillLine extends JSprite
	{
		private var _path:Vector.<Point>;
		private var _type:String;
		
		public static const SOLID:String = 'Solid';
		
		public static const SHORT_DASH:String = 'ShortDash';
		public static const SHORT_DASH_LEN:Number = 8;
		public static const SHORT_DASH_SPACE:Number = 5;
		
		public static const DASH:String = 'Dash';
		public static const DASH_LEN:Number = 8;
		public static const DASH_SPACE:Number = 10;
		
		public static const LONG_DASH:String = 'LongDash';
		public static const LONG_DASH_LEN:Number = 20;
		public static const LONG_DASH_SPACE:Number = 10;
		
		public static const SHORT_DOT:String = 'ShortDot';
		public static const SHORT_DOT_RADIUS:Number = .5;
		public static const SHORT_DOT_SPACE:Number = 5;
		
		public static const DOT:String = 'Dot';
		public static const DOT_RADIUS:Number = .5;
		public static const DOT_SPACE:Number = 10;
		
		private var _ins:JFillLine;
		private var _thickness:int = 2;
		private var _lineColor:uint = 0x00ff00;
		
		public function JFillLine( _path:Vector.<Point>, _data:Object=null)
		{
			_ins = this;
			_data = _data || {};
			super(_data);
			
			this._path = _path;
			
			_data.thickness && ( _thickness = _data.thickness );
			_data.lineColor && ( _lineColor = _data.lineColor );
			
			init();
		}
		
		private function init():void{
			if( !( _path && _path.length > 1 ) ) return;
			
			this.graphics.lineStyle( 0, _lineColor );
			this.graphics.beginFill( _lineColor, .2 );
			
			solidLine(); 
		}

		
		private function solidLine():void{
			
			Common.each( _path, function( _k:int, _item:Point ):void{
				if( _k === 0 ){
					_ins.graphics.moveTo( _item.x, _item.y );
					return;
				}
				
				var _prePoint:Point = _path[ _k - 1 ];
				_ins.graphics.lineTo( _item.x, _item.y );
			});
			
			var _first:Point = _path[0]
				, _last:Point = _path[ _path.length - 1 ]
				;
						
			_ins.graphics.lineTo( _last.x, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight );
			_ins.graphics.lineTo( _first.x, BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight );
			_ins.graphics.lineTo( _first.x, _first.y );
		}
	}
}