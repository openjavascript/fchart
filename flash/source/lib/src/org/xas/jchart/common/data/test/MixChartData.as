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
						"type": "mix"
					}
					, "title": {
						"text": "日趋势"
					}
					, "subtitle": {
						"text": "日趋势 subtitle"
					}
					, "xAxis": {
						"categories": [
							"2014-11-17",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20",
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
					},
					"yAxis": [
						{
							"autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							"title": {
								"text": "test vtitle 1"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "title": {
								"text": "test vtitle 2"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "title": {
								"text": "test vtitle 3"
								, "enabled": 1
							}
						}
					],
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"type": "bar",
							"name": "MG名爵",
							"yAxis": 0,
							"data": [
								4039,
								2828,
								1567,
								5531,
								3544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "bar",
							"name": "MG名爵1",
							"yAxis": 1,
							"data": [
								5039,
								3828,
								2567,
								6531,
								4544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "line",
							"name": "北汽",
							"yAxis": 2,
							"data": [
								81018,
								80207,
								84018,
								85313,
								84018
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}						, {
							"type": "line",
							"name": "北汽1",
							"yAxis": 3,
							"data": [
								34018,
								41018,
								40207,
								34018,
								25313
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
					],
					"legend": {
						"enabled": true
					},
					"plotOptions": {
						/*
						"area": {
						"fillColor": {}
						}
						*/
					},
					/*
					"colors": [
					"0xbb9b3e",
					"0x4673c0"
					],
					*/
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "mix"
					}
					, "title": {
						"text": "日趋势"
					}
					, "subtitle": {
						"text": "日趋势 subtitle"
					}
					, "xAxis": {
						"categories": [
							"2014-11-17",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20",
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
					},
					"yAxis": [
						{
							"autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "title": {
								"text": "test vtitle 1"
								, "enabled": 1
							}
						}
					],
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"type": "bar",
							"name": "MG名爵",
							"yAxis": 1,
							"data": [
								4039,
								2828,
								1567,
								5531,
								3544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "bar",
							"name": "MG名爵1",
							"yAxis": 1,
							"data": [
								5039,
								3828,
								2567,
								6531,
								4544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "line",
							"name": "北汽",
							"data": [
								81018,
								80207,
								84018,
								85313,
								84018
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
					],
					"legend": {
						"enabled": true
					},
					"plotOptions": {
						/*
						"area": {
						"fillColor": {}
						}
						*/
					},
					/*
					"colors": [
					"0xbb9b3e",
					"0x4673c0"
					],
					*/
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "mix"
					}
					, "title": {
						"text": "日趋势"
					}
					, "subtitle": {
						"text": "日趋势 subtitle"
					}
					, "xAxis": {
						"categories": [
							"2014-11-17",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20",
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
					},
					"yAxis": [
						{
							"autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
						}
						, {
							opposite: true
						}
					],
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"type": "bar",
							"name": "MG名爵",
							"yAxis": 1,
							"data": [
								4039,
								2828,
								1567,
								5531,
								3544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "bar",
							"name": "MG名爵1",
							"yAxis": 1,
							"data": [
								5039,
								3828,
								2567,
								6531,
								4544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "line",
							"name": "北汽",
							"data": [
								81018,
								80207,
								84018,
								85313,
								84018
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
					],
					"legend": {
						"enabled": true
					},
					"plotOptions": {
						/*
						"area": {
						"fillColor": {}
						}
						*/
					},
					/*
					"colors": [
					"0xbb9b3e",
					"0x4673c0"
					],
					*/
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "mix"
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
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
					},
					"yAxis": {
						
					},
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"type": "bar",
							"name": "MG名爵",
							"data": [
								4039,
								2828,
								1567,
								5531,
								3544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "bar",
							"name": "MG名爵1",
							"data": [
								5039,
								3828,
								2567,
								6531,
								4544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "line",
							"name": "北汽",
							"data": [
								11018,
								10207,
								14018,
								15313,
								14018
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
					],
					"legend": {
						"enabled": true
					},
					"plotOptions": {
						/*
						"area": {
						"fillColor": {}
						}
						*/
					},
					/*
					"colors": [
					"0xbb9b3e",
					"0x4673c0"
					],
					*/
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);

			_data.push(
				{
					"chart": {
						"type": "mix"
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
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
					},
					"yAxis": {
						
					},
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"type": "bar",
							"name": "MG名爵",
							"data": [
								4039,
								2828,
								1567,
								5531,
								3544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
					],
					"legend": {
						"enabled": true
					},
					"plotOptions": {
						/*
						"area": {
						"fillColor": {}
						}
						*/
					},
					/*
					"colors": [
					"0xbb9b3e",
					"0x4673c0"
					],
					*/
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);

			
			_data.push(
				{
					"chart": {
						"type": "mix"
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
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
					},
					"yAxis": [
						{
						}
						, {
							opposite: true
						}
					],
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"type": "bar",
							"name": "MG名爵",
							"data": [
								4039,
								2828,
								1567,
								5531,
								3544
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
						, {
							"type": "line",
							"name": "北汽",
							"yAxis": 1,
							"data": [
								81018,
								80207,
								84018,
								85313,
								84018
							],
							"style": {
								"stroke": "#ff7100"
							},
							"pointStyle": {}
						}
					],
					"legend": {
						"enabled": true
					},
					"plotOptions": {
						/*
						"area": {
							"fillColor": {}
						}
						*/
					},
					/*
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					*/
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
				
		}
	}
}
