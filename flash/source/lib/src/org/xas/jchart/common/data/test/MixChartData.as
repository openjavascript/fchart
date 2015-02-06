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
			 
			return;  
			
			
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
						, 
						"displayAll": {
							"enabled": true
						}
					},
					"yAxis": [
						{
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
							, format: '¥{0}'
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle 2"
								, "enabled": 1
							}
						}
						, {
							"title": {
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
							"type": "line",
							"name": "北汽1",
							"yAxis": 2,
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
							, "dataLabels": {
								"enabled": true
							}
						}
						, {
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
							"name": "MG名爵1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle 3"
								, "enabled": 1
							}
						}
					],
					"animation": {
						"enabled": false
					},
					"series": [
						{
							"type": "stack",
							"name": "北汽",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
							"type": "stack",
							"name": "北汽1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
						, {
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle 3"
								, "enabled": 1
							}
						}
					],
					"animation": {
						"enabled": false
					},
					"series": [
						{
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
							"name": "MG名爵1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle 3"
								, "enabled": 1
							}
						}
					],
					"animation": {
						"enabled": false
					},
					"series": [
						{
							"type": "line",
							"name": "北汽",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
							"type": "line",
							"name": "北汽1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
						, {
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle 3"
								, "enabled": 1
							}
						}
					],
					"animation": {
						"enabled": false
					},
					"series": [
						{
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
							"name": "MG名爵1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
						, {
							"type": "bar",
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
							"type": "bar",
							"name": "北汽1",
							"yAxis": 1,
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
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
							"type": "line",
							"name": "北汽",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
							"type": "line",
							"name": "北汽1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
						, {
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
							, "title": {
								"text": "test vtitle 2"
								, "enabled": 1
							}
						}
						, {
							"title": {
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
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
							"name": "MG名爵1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
						, {
							"type": "bar",
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
							"type": "line",
							"name": "北汽1",
							"yAxis": 2,
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
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
							"type": "stack",
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
							, "dataLabels": {
								"enabled": false
							}
						}
						, {
							"type": "stack",
							"name": "MG名爵1",
							"yAxis": 0,
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
							, "dataLabels": {
								"enabled": true
							}
						}
						, {
							"type": "bar",
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
							"type": "bar",
							"name": "北汽1",
							"yAxis": 1,
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
							, "dataLabels": {
								"enabled": true
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
					}
				}
			);
			 
			_data.push( 				{
				"chart": {
					"type": "mix"
				}
				, "title": {
					"text": "全站统计"
				}
				, "subtitle": {
					"text": "for CRM"
				}
				, "xAxis": {
					"categories": [
						"20141213"
						,"20141215"
						,"20141216"
						,"20141217"
						,"20141218"
						,"20141219"
						,"20141220"
						,"20141221"
						,"20141222"
						,"20141223"
						,"20141224"
						,"20141225"
						,"20141226"
						,"20141227"
						,"20141228"
						,"20141229"
						,"20141230"
						,"20141231"
						,"20150101"
						,"20150102"
						,"20150103"
						,"20150104"
						,"20150105"
						,"20150106"
						,"20150107"
						,"20150108"
						,"20150109"
						,"20150110"
						,"20150111"
						,"20150112"
						,"20150113"
					]
					, "displayAll": {
						"enabled": true
					}
					, "rotation": {
						"enabled": true
					}
				},
				"yAxis": [
					{
						"title": {
							"text": "PV"
							, "enabled": 1
						}
					}
					, {
						"autoRate": {
							"enabled": true
						}
						, opposite: true
						, "title": {
							"text": "UV"
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
						"name": "PV",
						"yAxis": 0,
						"data": [
							34
							,3112
							,2610
							,2979
							,4631
							,3467
							,790
							,1586
							,5411
							,6115
							,3668
							,2356
							,1910
							,293
							,799
							,135929
							,497866
							,458720
							,44840
							,45804
							,46943
							,495849
							,467362
							,458704
							,498137
							,456188
							,436244
							,135031
							,45329
							,469859
							,457164
						],
						"style": {
							"stroke": "#ff7100"
						},
						"pointStyle": {}			
						, "dataLabel": {
							"enabled": false
						}
					}
					, {
						"type": "line",
						"name": "UV",
						"yAxis": 1,
						"data": [
							1
							,161
							,48
							,62
							,71
							,69
							,12
							,16
							,127
							,158
							,76
							,65
							,49
							,18
							,21
							,4002
							,6069
							,5775
							,982
							,751
							,938
							,5722
							,5773
							,5846
							,5896
							,5861
							,5858
							,2546
							,11033
							,5977
							,5835							
						],
						"style": {
							"stroke": "#ff7100"
						},
						"pointStyle": {}	
					}
				],
				"legend": {
					"enabled": true
					, "direction": "TOP_RIGHT"
					, "margin": { "bottom": 0, "y": -5 }
				},
				"callback": {
					"initedCallback": "initedCallback"
				}
				, "abbrNumber": {
					"enabled": true
				}

			});
			
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							"autoRate": {
								"enabled": true
							}
							, "title": {
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
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
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
							, "dataLabels": {
								"enabled": false
							}
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
							, "dataLabels": {
								"enabled": true
							}
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
							, "dataLabels": {
								"enabled": true
							}
						}						
						, {
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
							, "dataLabels": {
								"enabled": false
							}
						}
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					"dataLabels": {
						"enabled": false
					}
				}
			);
			
//			return;
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
							"2014-11-20--日趋势日趋势日趋势日趋势日趋势日趋势日趋势日趋势123",
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
						, "rotation": {
							"enabled": true
							, "angle": 140
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
						, "rotation": {
							"enabled": true
							, "angle": 45
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
					, "subtitle": {
						"text": "日趋势 subtitle"
					}
					, "xAxis": {
						"categories": [
							"2014-11-17",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20",
							"2014-11-21--日趋势日趋势日趋势日趋势日趋势日趋势日趋势日趋势123"
						]
						, "displayAll": {
							"enabled": true
						}
						, "rotation": {
							"enabled": true
							, "angle": 45
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
					, "subtitle": {
						"text": "日趋势 subtitle"
					}
					, "xAxis": {
						"categories": [
							"2014-11-17~~",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20--日趋势日趋势日趋势日趋势日趋势日趋势日趋势日趋势123",
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
						, "rotation": {
							"enabled": true
							, "angle": 45
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
						, "rotation": {
							"enabled": true
						}
					},
					"yAxis": [
						{
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
							}
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
							"type": "line",
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
							"type": "line",
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
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
							"2014-11-17--日趋势日趋势日趋势日趋势日趋势日趋势日趋势日趋势123",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20",
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
						, "rotation": {
							"enabled": true
						}
					},
					"yAxis": [
						{
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
							}
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
							"type": "line",
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
							"type": "line",
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
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
							"2014-11-18--日趋势日趋势日趋势日趋势日趋势日趋势日趋势日趋势123",
							"2014-11-19",
							"2014-11-20",
							"2014-11-21"
						]
						, "displayAll": {
							"enabled": true
						}
						, "rotation": {
							"enabled": true
						}
					},
					"yAxis": [
						{
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
							}
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
							"type": "line",
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
							"type": "line",
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
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
						, "rotation": {
							"enabled": true
							, "angle": 0
						}
					},
					"yAxis": [
						{
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
							}
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
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
						, "rotation": {
							"enabled": true
							, "angle": -90
						}
					},
					"yAxis": [
						{
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							"autoRate": {
								"enabled": true
							}
							, "title": {
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
							, "autoRate": {
								"enabled": true
								, "rateUp": 0
								, "maxOffset": .1
								, "minOffset": .1
							}
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
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
						, "rotation": { 
							"enabled": true
							, "angle": 90
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
							}
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
							"type": "line",
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
							"type": "line",
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
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
							"title": {
								"text": "test vtitle"
								, "enabled": 1
							}
						}
						, {
							opposite: true
							, "autoRate": {
								"enabled": true
							}
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
					],
					"legend": {
						"enabled": true
						, "direction": "TOP_RIGHT"
						, "margin": { "bottom": 0, "y": -10 }
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
					},
					dataLabels: {
						enabled: true
					}
					, "tooltip": {
						"type": "simple"					
					}
				}
			);
			
			
			_data.push( {
				"chart": {
					"type": "mix"
					, bgColor: 0xffffff
					, bgAlpha: 1
				}
				, "xAxis": {
//					"categories": [
//						"20141213"
//						,"20141215"
//						,"20141216"
//						,"20141217"
//						,"20141218"
//						,"20141219"
//						,"20141220"
//						,"20141221"
//						,"20141222"
//						,"20141223"
//						,"20141224"
//						,"20141225"
//						,"20141226"
//						,"20141227"
//						,"20141228"
//						,"20141229"
//						,"20141230"
//						,"20141231"
//						,"20150101"
//						,"20150102"
//						,"20150103"
//						,"20150104"
//						,"20150105"
//						,"20150106"
//						,"20150107"
//						,"20150108"
//						,"20150109"
//						,"20150110"
//						,"20150111"
//						,"20150112"
//						,"20150113"
//					]
//					, 
					rotation: {
						//						"enabled": true
					}
					, display: {
						"enabled": true
						,"mod": 30
					}
					, "enabled": true
				}
				, "yAxis": [
					{
						opposite: true
						, "autoRate": {
							"enabled": true
							, "rateUp": 0
							, "maxOffset": .1
							, "minOffset": .1
						}
						, rate: [ 1, .5, 0 ]
					}
				]
				, rateLabel: { data: [ 1, .5, 0 ] }
				, hline: {
					enabled: false
				}
				, vline: {
					enabled: false
				}
				,"animation": {
					"enabled": true
				},
				"series": [
					{
						"type": "line",
						"name": "价格走势",
						"yAxis": 0,
						"data": [
							11000
							,11610
							,4800
							,6200
							,7100
							,6900
							,11200
							,11600
							,11270
							,11580
							,7600
							,6500
							,14900
							,11800
							,12100
							,4002
							,6069
							,5775
							,9820
							,7510
							,9380
							,5722
							,5773
							,5846
							,5896
							,5861
							,5858
							,12546
							,11033
							,5977
							,5835							
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
				"colors": [
					0xE5633F
				],
				"point": {
					hoverShow: true
				}
				, "tooltip": {
					"type": "simple"					
				}
			});
				
		}
	}
}
