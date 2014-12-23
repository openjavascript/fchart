package org.xas.jchart.common.data.test
{
	public class MixChartData
	{
		private var _data:Vector.<Object>;
		public function get data():Vector.<Object>{ return _data;}
		
		private static var _ins:MixChartData;
		
		public static function get instance():MixChartData{
			if( !_ins ){
				_ins = new MixChartData();		
			}
			return _ins;
		}
		
		public function MixChartData()
		{
			init();
		}
		
		private function init():void{
			_data = new Vector.<Object>();
			//return;
			_data.push(
				{
					"chart": {
						"type": "bar"
					}
					, "mixChart": {
						"type": "line"
						, "series": [
							{
								"name": "北汽",
								"data": [
									81018,
									80207,
									84018,
									85313,
									84018,
									81892,
									82004,
									87625,
									85015,
									120000,
									86120,
									74182,
									71184,
									72038,
									72711,
									74956,
									81987,
									75229,
									86195,
									76900,
									78624,
									84466,
									84498,
									83873,
									83656,
									85722,
									77151,
									79772,
									107068,
									90566
								],
								"style": {
									"stroke": "#ff7100"
								},
								"pointStyle": {}
							}
						]
					}
					, "title": {
						"text": "日趋势"
					}
					, "xAxis": {
						"categories": [
							"2014-11-17",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20",
							"2014-11-21",
							"2014-11-22",
							"2014-11-23",
							"2014-11-24",
							"2014-11-25",
							"2014-11-26",
							"2014-11-27",
							"2014-11-28",
							"2014-11-29",
							"2014-11-30",
							"2014-12-01",
							"2014-12-02",
							"2014-12-03",
							"2014-12-04",
							"2014-12-05",
							"2014-12-06",
							"2014-12-07",
							"2014-12-08",
							"2014-12-09",
							"2014-12-10",
							"2014-12-11",
							"2014-12-12",
							"2014-12-13",
							"2014-12-14",
							"2014-12-15",
							"2014-12-16"
						]
						, "displayAll": {
							"enabled": false
						}
					},
					"yAxis": {
						"autoRate": {
							"enabled": true
							, "deep": 1
							, "rateUp": 2
							, "maxOffset": .1 /*最大值向上偏移 百分之多少*/
							, "minOffset": .1 /*最小值向下偏移 百分之多少*/
						}
					},
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"name": "MG名爵",
							"data": [
								84039,
								82828,
								81567,
								85531,
								83544,
								75332,
								74107,
								82759,
								83733,
								79110,
								80264,
								68606,
								61461,
								61599,
								70562,
								75320,
								79559,
								78800,
								84268,
								72327,
								73675,
								83763,
								81138,
								79073,
								79821,
								76209,
								69474,
								70292,
								82381,
								79333
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
					],
					"legend": {
						"enabled": false
					},
					"plotOptions": {
						"area": {
							"fillColor": {}
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
				
		}
	}
}
