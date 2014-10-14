package org.xas.jchart.common.data.test
{
	public class TrendData
	{
		private var _data:Vector.<Object>;
		public function get data():Vector.<Object>{ return _data;}
		
		private static var _ins:TrendData;
		
		public static function get instance():TrendData{
			if( !_ins ){
				_ins = new TrendData();		
			}
			return _ins;
		}
		
		public function TrendData()
		{
			init();
		}
		
		private function init():void{
			_data = new Vector.<Object>();
						
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				},
				xAxis: {
					num: 5
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
					, format: '{0}'
				},
				tooltip: {
					enabled: true,
					fixed: false,
					dynLoading: true,
					"headerFormat": "{0}",
					afterSerial: [ {
							name: '当前价',
							format: '{0}元',
							data: 'c'
						}, {
							name: '涨跌幅',
							format: '{0}%',
							data: 'p'
						}, {
							name: '成交量',
							data: 'v'
						} ]
				},
				vline: {
					enabled: true
				},
				series:[{
					dataName: "sina2",
					startDate: "09:30:00",
					endDate: "16:00:00",
					baseDate: "73.00",
					data: []
				}],
				credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://jchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, isPercent: false
			});
		}
	}
}
