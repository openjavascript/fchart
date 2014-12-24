package 
{
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.ChartType;
	import org.xas.jchart.common.data.mixchart.MixChartModel;
	import org.xas.jchart.common.data.mixchart.MixChartModelItem;

	public class Config extends BaseConfig
	{
		protected var _mixModel:MixChartModel;
		public function get mixModel():MixChartModel{ return _mixModel; }
		
		public function Config()
		{
			super();
		}	

		override public function setChartData( _d:Object ):Object {
			
			super.setChartData( _d );
			_mixModel = new MixChartModel( this );
			return _d;
		}
		
		public function getYAxisIndex( _seriesItem:Object ):int{
			var _r:int = 0;
			_r = _seriesItem.yAxis || _r;
			return _r;
		}		
		
		override public function get yAxisEnabled():Boolean{
			var _r:Boolean = true, _allFalse:Boolean = true;
			
			/*
			if( cd && cd.yAxis && ( 'enabled' in cd.yAxis ) ){
				_r = StringUtils.parseBool( cd.yAxis.enabled );
			}
			*/
			Common.each( _mixModel.items, function( _k:int, _item:MixChartModelItem ):Boolean{
				if( _item.enabeld ){
					return _allFalse = false;
				}
				return true;
			});
			
			if( cd && cd.rateLabel && ( 'enabled' in cd.rateLabel ) ){
				_r = StringUtils.parseBool( cd.rateLabel.enabled );
			}
			
			return _r;
		}
 
	}
}