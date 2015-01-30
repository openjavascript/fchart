package org.xas.jchart.common.data
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;

	public class ChartType
	{
		
		public static const BAR:String = 'bar';
		public static const LINE:String = 'line';
		public static const PIE:String = 'pie';
		public static const COLUMN:String = 'column';
		public static const STACK:String = 'stack';
		
		
		public function ChartType()
		{
		}
		
		public static function fixChartType( _type:String ):String{
			switch( BaseConfig.ins.version ){
				case '0.2': {
					_type = fixChartType02( _type );
					break;
				}
				default: {
					_type = fixChartTypeNormal( _type );
					break;
				}
			}
			
			return _type;
		}
		protected static function fixChartTypeNormal( _type:String ):String{
			_type = ( _type || '' ).toString();
			
			if( _type != BAR
				&& _type != LINE
				&& _type != PIE
				&& _type != COLUMN
			){
				_type = BAR;
			}
			
			return _type;
		}
		
		protected static function fixChartType02( _type:String ):String{
			_type = ( _type || '' ).toString();
			
			if( _type != BAR
				&& _type != LINE
				&& _type != PIE
				&& _type != COLUMN
				&& _type != STACK
			){
				_type = BAR;
			}
			
			return _type;
		}
	}
}