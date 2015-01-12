package org.xas.jchart.common.data.test
{
	public class DefaultData
	{
		private var _data:Vector.<Object>;
		public function get data():Vector.<Object>{ return _data;}
		
		private static var _ins:DefaultData;
		
		public static function get instance():DefaultData{
			if( !_ins ){
				_ins = new DefaultData();		
			}
			return _ins;
		}
		
		public function DefaultData()
		{ 
			init();
		}
		
		private function init():void{
			_data = new Vector.<Object>();
//			return; 
			
			_data.push({
				"chart":
				{
					"type": "bar",
					"bgColor": 16777215, 
					"bgAlpha": 1
				}, 
				"colors":
				[
					44015, 
					10333619, 
					639232, 
					816836, 
					16713241
				], 
				"vline":
				{
//					"enabled": true
				}, 
				"xAxis":
				{
					"wordwrap": true, 
					"categories":
					[
						"pos.baidu.com", 
						"www.baidu.com", 
						"hao.360.cn", 
						"wd.360.cn", 
						"internal.host.com", 
						"eclick.baidu.com", 
						"googleads.g.doubleclick.net", 
						"user.qzone.qq.com", 
						"www.so.com", 
						"ptlogin2.qq.com"
					]
				}, 
				"yAxis":
				{
//					"enabled": false
				}, 
				"legend":
				{
//					"enabled": false
				}, 
				"displayAllLabel": true, 
				"maxItem":
				{
					"style":
					{
						"size": 18, 
						"color": 6146425
					}
				}, 
				"tooltip":
				{
//					"enabled": true
				}, 
				"hline":
				{
//					"enabled": false
				}, 
				"series":
				[
					{
						"name": "pv", 
						"data":
						[
							7026299386, 
							2243248546, 
							1918390720, 
							1887903406, 
							1517144906, 
							1463547200, 
							958396100, 
							951335880, 
							941430913, 
							914735040
						]
						, dataLabel: {
							"format": "{0}", 
							"enabled": true,
							"data": [
								"70.26亿", 
								"22.43亿", 
								"19.18亿", 
								"18.87亿", 
								"15.17亿", 
								"14.63亿", 
								"9.58亿", 
								"9.51亿", 
								"9.41亿", 
								"9.14亿"
							]
						}
					}
				],
				"animation": {
					"enabled": true
				}
			});
			     
			_data.push({
				"chart":
				{
					"type": "bar",
					"bgColor": 16777215, 
					"bgAlpha": 1
				}, 
				"colors":
				[
					44015, 
					10333619, 
					639232, 
					816836, 
					16713241
				], 
				"vline":
				{
					"enabled": true
				}, 
				"xAxis":
				{
					"wordwrap": true, 
					"categories":
					[
						"pos.baidu.com", 
						"www.baidu.com", 
						"hao.360.cn", 
						"wd.360.cn", 
						"internal.host.com", 
						"eclick.baidu.com", 
						"googleads.g.doubleclick.net", 
						"user.qzone.qq.com", 
						"www.so.com", 
						"ptlogin2.qq.com"
					]
				}, 
				"dataLabels":
				{
					"format": "{0}", 
					"enabled": true
				}, 
				"yAxis":
				{
					"enabled": false
				}, 
				"legend":
				{
					"enabled": false
				}, 
				"displayAllLabel": true, 
				"maxItem":
				{
					"style":
					{
						"size": 18, 
						"color": 6146425
					}
				}, 
				"tooltip":
				{
					"enabled": true
				}, 
				"hline":
				{
					"enabled": false
				}, 
				"series":
				[
					{
						"name": "pv", 
						"data":
						[
							7026299386, 
							2243248546, 
							1918390720, 
							1887903406, 
							1517144906, 
							1463547200, 
							958396100, 
							951335880, 
							941430913, 
							914735040
						]
						, "labelData": [
							"70.26亿", 
							"22.43亿", 
							"19.18亿", 
							"18.87亿", 
							"15.17亿", 
							"14.63亿", 
							"9.58亿", 
							"9.51亿", 
							"9.41亿", 
							"9.14亿"
						]
					}
				]
			});
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
							"2014-11-22--11111111111111111111111111111111123",
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18", 
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "labels": {
							"rotation": -45
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
							"2014-11-22",
							"2014-11-23",
							"2014-11-24",
							"2014-11-25--11111111111111111111111111111111123",
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18", 
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "labels": {
							"rotation": -45
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18", 
							"2014-12-19",
							"2014-12-20",
							"2014-12-21--11111111111111111111111111111111123"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "labels": {
							"rotation": 45
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			 
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18--11111111111111111111111111111111123", 
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "labels": {
							"rotation": 45
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18",
							"2014-12-19",
							"2014-12-20",
							"2014-12-21" 
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "rotation": {
							"enabled": true
							, "angle": 0
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18",
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "rotation": {
							"enabled": true
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18",
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "rotation": {
							"enabled": true
							, "angle": -90
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18",
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "rotation": { 
							"enabled": true
							, "angle": 90
						}
					},
					"animation": {
						"enabled": false,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);				
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18",
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"display": {
							"enabled": true,
							"startIndex": 0,
							"mod": 7
						}
						, "rotation": {
							"enabled": true
							, "angle": 45
						}
					},
					"animation": {
						"enabled": false,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dash',
							"data": [
								0,
								0,
								0,
								0,
								0,
								7976,
								7833,
								9080,
								9000,
								5447,
								5077,
								8291,
								7025,
								8832,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
						"area": {
							"fillColor": {}
						}
					},
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"xAxis": {
						"categories": [
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
							"2014-12-16",
							"2014-12-17",
							"2014-12-18",
							"2014-12-19",
							"2014-12-20",
							"2014-12-21"
						],
						"displayAll": {
							"enabled": true
						}
						, "rotation": {
							//"enabled": true
						}
					},
					"animation": {
						"enabled": true,
						"duration": 1
					},
					"yAxis": {
						"autoRate": {
							"rateUp": -1,
							"enabled": true,
							"deep": 1,
							"maxOffset": 0.1,
							"minOffset": 0.1
						}
					},
					"series": [
						{
							"name": "奥迪",
							"dashStyle": 'Dot',
							"data": [
								6394,
								6284,
								8345,
								8053,
								8524,
								7976,
								7833,
								9080,
								9000,
								5447,
								0,
								0,
								0,
								0,
								6277,
								6045,
								8713,
								8217,
								7738,
								7607,
								6978,
								6148,
								6434,
								8899,
								7972,
								8456,
								7750,
								7109,
								5923,
								5790
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
					"tooltip": {
						"valueStyle": {
							"font": "Calibri"
						}
					},
					"colors": [
						"0xbb9b3e",
						"0x4673c0"
					],
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
						, "autoRate": {
							enabled: true
							, deep: 2
						}
					},
					"animation": {
						"enabled": true
					},
					"hoverBg":
					{
						"style":
						{
							"borderColor": 11842740, 
							"bgColor": 15790320, 
							"borderWidth": 2
						}, 
						"enabled": true
					}, 
					"tooltip":
					{
						"headerYSpace": 6, 
						"headerStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 14, 
							"color": 7829367
						}, 
						"itemYSpace": 6, 
						"enabled": true, 
						"valueStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 6144104
						}, 
						"pointFormat": "{0} ", 
						"labelStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 11184810
						}, 
						'serialFormat': '{0}%',
						'afterSerialFormat': '{0}%',
						"serial":
						[
							{
								"name": "区分度", 
								"data":
								[
									"3.87", 
									"3.25", 
									"3.03", 
									"2.87", 
									"2.65", 
									"0", 
									"0", 
									"2.23", 
									"2.01", 
									"1.56"
								]
							}
						], 
						"headerFormat": "{0}", 
						"headerIcon":
						{
							"style":
							{
								"color": 6144104
							}, 
							"enabled": true
						}, 
						"valueLabelXSpace": 0
					}, 
					"xAxis":
					{
						"enabled": false,
						"categories":
						[
							"口腔护理", 
							"身体护理", 
							"洗护清洁", 
							"游戏点卡", 
							"彩妆", 
							"生鲜食品", 
							"童装", 
							"粮油米面", 
							"饮料", 
							"配饰"
						]
					},
					"lineBreak":{
						"enabled": true
					},
					"hline":
					{
						"enabled": false
					}, 
					"vline":
					{
						"enabled": false
					}, 
					"vsideLine":
					{
						"enabled": true
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"series":
					[
						{
							"name": "样本覆盖率", 
							"data":
							[
								"3.87", 
								"3.25", 
								"3.03", 
								"2.87", 
								"2.65", 
								"0", 
								"0", 
								"2.23", 
								"2.01", 
								"1.56"
							]
						}
					], 
					
					"colors":
					[
						44015, 
						10333619, 
						639232, 
						816836, 
						16713241, 
						16760576, 
						16740608, 
						16713395, 
						4317926, 
						12837540, 
						16757436, 
						14399741
					], 
					"displayAllLabel": true, 
					"dataLabels":
					{
						"format": "{0}", 
						"enabled": false
					},
					plotOptions: {
						area: {
							fillColor: { linearGradient: true }
						}
					}
				});
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"title": {
						"text": "日趋势"
					},
					"xAxis": {
						"categories": [
							"2014-11-17",
							"2014-11-18",
							"2014-11-19",
							"2014-11-2011111111111111111111111111111111111111111111111111", 
							"2014-11-21",
							"2014-11-22",
							"2014-11-2322222222222222222222222222222222222",
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
							"2014-12-14999999",
							"2014-12-15",
							"2014-12-16"
						]
						, "displayAll": {
							"enabled": false
							, "mod": 3
						}
						, "wordwrap": false
						, "rotation": {
							"enabled": true
							, "dir": "right"
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
							"name": "北汽",
							"data": [
								0,
								0,
								0,
								0,
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
						},
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
								0,
								0,
								0,
								0,
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
					"lineBreak":{
						"enabled": true
					},
					"callback": {
						"initedCallback": "initedCallback"
					}
				}
			);
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"title": {
						"text": "日趋势"
					},
					"xAxis": {
						"categories": [
							"2014-11-1700000000000000000000",
							"2014-11-18",
							"2014-11-19",
							"2014-11-20111111111111111111111111",
							"2014-11-21",
							"2014-11-22",
							"2014-11-2322222222222222222222222222222222222",
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
							"2014-12-14999999",
							"2014-12-15",
							"2014-12-16"
						]
						, "displayAll": {
							"enabled": false
							, "mod": 3
						}
						, "wordwrap": false
						, "rotation": {
							"enabled": true
							, "angle": 45
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
						},
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
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"title": {
						"text": "日趋势"
					},
					"xAxis": {
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
							, "startIndex": 0
							, "mod": 7
						}
					},
					"yAxis": {
						"autoRate": {
							"enabled": true
							, "deep": 1
							, "rateUp": 2
						}
					},
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"name": "北汽",
							"data": [
								81018,
								80207,
								81411,
								85313,
								84018,
								81892,
								82004,
								87625,
								85015,
								83327,
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
						},
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
			
			_data.push(
				{
					"chart": {
						"type": "line"
					},
					"title": {
						"text": "日趋势"
					},
					"xAxis": {
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
							, "startIndex": 1
							, "mod": 7
						}
					},
					"yAxis": {
						"autoRate": {
							"enabled": true
							, "deep": 1
							, "rateUp": 2
						}
					},
					"animation": {
						"enabled": true
					},
					"series": [
						{
							"name": "北汽",
							"data": [
								81018,
								80207,
								81411,
								85313,
								84018,
								81892,
								82004,
								87625,
								85015,
								83327,
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
						},
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
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
						, "autoRate": {
							enabled: true
							, deep: 2
						}
					},
					"animation": {
						"enabled": true
					},
					"hoverBg":
					{
						"style":
						{
							"borderColor": 11842740, 
							"bgColor": 15790320, 
							"borderWidth": 2
						}, 
						"enabled": true
					}, 
					"tooltip":
					{
						"headerYSpace": 6, 
						"headerStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 14, 
							"color": 7829367
						}, 
						"itemYSpace": 6, 
						"enabled": true, 
						"valueStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 6144104
						}, 
						"pointFormat": "{0} ", 
						"labelStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 11184810
						}, 
						'serialFormat': '{0}%',
						'afterSerialFormat': '{0}%',
						"serial":
						[
							{
								"name": "区分度", 
								"data":
								[
									"3.87", 
									"3.85", 
									"3.83", 
									"3.82", 
									"3.80", 
									"3.79", 
									"3.78", 
									"3.78", 
									"3.76", 
									"3.76"
								]
							}
						], 
						"headerFormat": "{0}", 
						"headerIcon":
						{
							"style":
							{
								"color": 6144104
							}, 
							"enabled": true
						}, 
						"valueLabelXSpace": 0
					}, 
					"xAxis":
					{
						"enabled": false,
						"categories":
						[
							"口腔护理", 
							"身体护理", 
							"洗护清洁", 
							"游戏点卡", 
							"彩妆", 
							"生鲜食品", 
							"童装", 
							"粮油米面", 
							"饮料", 
							"配饰"
						]
					},
					"lineBreak":{
						"enabled": true
					},
					"hline":
					{
						"enabled": false
					}, 
					"vline":
					{
						"enabled": false
					}, 
					"vsideLine":
					{
						"enabled": true
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"series":
					[
						{
							"name": "样本覆盖率", 
							"data":
							[
								"3.87", 
								"3.85", 
								"3.83", 
								"3.82", 
								"3.80", 
								"3.79", 
								"3.78", 
								"3.78", 
								"3.76", 
								"3.76"
							]
						}
					], 
					
					"colors":
					[
						44015, 
						10333619, 
						639232, 
						816836, 
						16713241, 
						16760576, 
						16740608, 
						16713395, 
						4317926, 
						12837540, 
						16757436, 
						14399741
					], 
					"displayAllLabel": true, 
					"dataLabels":
					{
						"format": "{0}", 
						"enabled": false
					},
					plotOptions: {
						area: {
							fillColor: { linearGradient: true }
						}
					}
				});
			
			_data.push( {
				"chart": {
					"type": "line"
				},
				"title": {
					"text": "月趋势"
				},
				"xAxis": {
					"categories": [
						"2013-12",
						"2014-01",
						"2014-02",
						"2014-03",
						"2014-04",
						"2014-05",
						"2014-06",
						"2014-07",
						"2014-08",
						"2014-09",
						"2014-10",
						"2014-11"
					]
				},
				"yAxis": {
					"title": {
						"text": "搜索指数"
					}
					, "autoRate": {
						enabled: true
						, deep: 2
					}
				},
				"series": [
					{
						"name": "宝马",
						"data": [
							205370,
							184888,
							205370,
							184888,
							205370,
							184888,
							205370,
							184888,
							205370,
							184888,
							205370,
							184888
						],
						"style": {
							"stroke": "#ff7100"
						},
						"pointStyle": {}
					},
					{
						"name": "别克",
						"data": [
							155729,
							142159,
							155729,
							142159,
							155729,
							142159,
							155729,
							142159,
							155729,
							142159,
							155729,
							142159
						],
						"style": {
							"stroke": "#ff7100"
						},
						"pointStyle": {}
					}
				],
				"displayAllLabel": false,
				"legend": {
					"enabled": true
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
				},
				"animation": {
					"enabled": true
				}
			});
			
			_data.push( {
				chart: {
					type: 'bar' 
				}
				, title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'subtitle' 
				},
				xAxis: {
					categories: [ 
						"01","02","03","04"
						,"01","02","03","04"
						,"01","02","03","04"
					]
				}, 
				yAxis: {
					"autoRate": {
						enabled: true
					}
				},
				series:[{
					name: '公司1',
					point: {  },
					data: [
						0.018773,0.021724,0.022130,0.021296
						,0.022255,0.022128,0.020949,0.023862
						,0.026974,0.028055,0.024992,0.024721
					],
					tipsData: [
						"1.8773%","2.1724%","2.2130%","2.1296%"
						,"2.2255%","2.2128%","2.0949%","2.3862%"
						,"2.6974%","2.8055%","2.4992%","2.4721%"
					]
				}, {
					name: '公司2',
					dashStyle: 'ShortDash',
					data: [
						0.018069,0.018495,0.018264,0.017527
						,0.016857,0.017398,0.016539,0.017144
						,0.018039,0.018798,0.018521,0.019580
					],
					tipsData: [
						"1.8069%","1.8495%","1.8264%","1.7527%"
						,"1.6857%","1.7398%","1.6539%","1.7144%"
						,"1.8039%","1.8798%","1.8521%","1.9580%"
					]
				}
				],
				tooltip: {
					header: [
						"2014Q1","2014Q2","2014Q3","2014Q4"
						,"2015Q1","2015Q2","2015Q3","2015Q4"
						,"2016Q1","2016Q2","2016Q3","2016Q4"
					]
				},
				group: {
					enabled: true,
					data: [
						"2014","2014","2014","2014"
						,"2015","2015","2015","2015"
						,"2016","2016","2016","2016"
					],
					background: {
						colors: [
							0xf2f2f2
						]
						, lastColor: 0xdbeccc
					},
					label: {
						style: {
							
						}
					}
				},
				credits: {
					enabled: true,
					text: 'fchart.openjavascript.org',
					href: 'http://fchart.openjavascript.org/'
				}
				, displayAllLabel: true
				, vline: {
				}
				, hline: {
				}
				, point: {
				}
			});
			
			_data.push( {
				chart: {
					type: 'bar' 
				}
				, title: {
					text:'Chart Title'
				},
				xAxis: {
					categories: [ 
						"01","02","03","04"
						,"01","02","03","04"
						,"01","02","03","04"
				]
				}, 
				yAxis: {
				},
				series:[{
					name: '公司1',
					point: {  },
					data: [
						0.018773,0.021724,0.022130,0.021296
						,0.022255,0.022128,0.020949,0.023862
						,0.026974,0.028055,0.024992,0.024721
					],
					tipsData: [
						"1.8773%","2.1724%","2.2130%","2.1296%"
						,"2.2255%","2.2128%","2.0949%","2.3862%"
						,"2.6974%","2.8055%","2.4992%","2.4721%"
					]
				}, {
					name: '公司2',
					dashStyle: 'Dot',
					data: [
						0.018069,0.018495,0.018264,0.017527
						,0.016857,0.017398,0.016539,0.017144
						,0.018039,0.018798,0.018521,0.019580
					],
					tipsData: [
						"1.8069%","1.8495%","1.8264%","1.7527%"
						,"1.6857%","1.7398%","1.6539%","1.7144%"
						,"1.8039%","1.8798%","1.8521%","1.9580%"
					]
				}
				],
				tooltip: {
					header: [
						"2014Q1","2014Q2","2014Q3","2014Q4"
						,"2015Q1","2015Q2","2015Q3","2015Q4"
						,"2016Q1","2016Q2","2016Q3","2016Q4"
					]
				},
				group: {
					enabled: true,
					data: [
						"2014","2014","2014","2014"
						,"2015","2015","2015","2015"
						,"2016","2016","2016","2016"
					],
					background: {
						colors: [
							0xf2f2f2
						]
						, lastColor: 0xdbeccc
					},
					label: {
						style: {
							
						}
					}
				},
				credits: {
					enabled: true,
					text: 'fchart.openjavascript.org',
					href: 'http://fchart.openjavascript.org/'
				}
				, displayAllLabel: true
				, vline: {
				}
				, hline: {
				}
				, point: {
				}
				, animation: {
					enabled: true
					, duration: 1
				}
			});
			
			_data.push( {
				chart: {
					type: 'bar' 
				}
				, title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ "2014-01-24","2014-01-25","2014-01-26","2014-01-27"
						,"2014-01-28","2014-01-29","2014-01-30","2014-01-31","2014-02-01"
						,"2014-02-02","2014-02-03","2014-02-04","2014-02-05","2014-02-06"
						,"2014-02-07","2014-02-08","2014-02-09","2014-02-10","2014-02-11"
						,"2014-02-12","2014-02-13","2014-02-14","2014-02-15","2014-02-16"
						,"2014-02-17","2014-02-18","2014-02-19","2014-02-20","2014-02-21"
						,"2014-02-22","2014-02-23","2014-02-24" ]
				}, 
				yAxis: {
				},
				series:[{
					name: '公司1',
					point: { enabled: false },
					data: [0.018773,0.021724,0.022130,0.021296,0.022255,0.022128,0.020949
						,0.023862,0.026974,0.028055,0.024992,0.024721,0.025100,0.021803
						,0.019327,0.020149,0.020714,0.017774,0.017844,0.018313,0.018225
						,0.017863,0.019568,0.019308,0.017606,0.017649,0.016645,0.016310
						,0.014451,0.017606,0.018455,0]
				}, {
					name: '公司2000000000000000000000000',
					data: [0.018069,0.018495,0.018264,0.017527,0.016857,0.017398,0.016539
						,0.017144,0.018039,0.018798,0.018521,0.019580,0.019071,0.019078
						,0.017415,0.018997,0.018585,0.018417,0.018958,0.019772,0.018243
						,0.018742,0.020183,0.022000,0.020125,0.020549,0.019577,0.017468
						,0.015819,0.017709,0.018943,0]
				}, {
					name: '公司3',
					data: [0.017261,0.018625,0.019226,0.018777,0.019406,0.019887,0.022632
						,0.020445,0.019140,0.020957,0.021089,0.020967,0.021576,0.021357
						,0.020665,0.019415,0.018805,0.016842,0.016483,0.016688,0.016102
						,0.015717,0.016570,0.017390,0.016249,0.016616,0.016699,0.016514
						,0.016597,0.016476,0.016742,0]
				}
				],
				credits: {
					enabled: true,
					text: 'fchart.openjavascript.org',
					href: 'http://fchart.openjavascript.org/'
				}
				, floatLen: 6
				, displayAllLabel: false
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, point: {
				}
				, animation: {
					enabled: true
				}
			});
			
			_data.push( {
				chart: {
					type: 'bar' 
				}
				, title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ "2014-01-24","2014-01-25","2014-01-26","2014-01-27"
						,"2014-01-28","2014-01-29","2014-01-30","2014-01-31","2014-02-01"
						,"2014-02-02","2014-02-03","2014-02-04","2014-02-05","2014-02-06"
						,"2014-02-07","2014-02-08","2014-02-09","2014-02-10","2014-02-11"
						,"2014-02-12","2014-02-13","2014-02-14","2014-02-15","2014-02-16"
						,"2014-02-17","2014-02-18","2014-02-19","2014-02-20","2014-02-21"
						,"2014-02-22","2014-02-23","2014-02-24" ]
				}, 
				yAxis: {
				},
				series:[{
					name: '公司1',
					point: { enabled: true },
					data: [0.018773,0.021724,0.022130,0.021296,0.022255,0.022128,0.020949
						,0.023862,0.026974,0.028055,0.024992,0.024721,0.025100,0.021803
						,0.019327,0.020149,0.020714,0.017774,0.017844,0.018313,0.018225
						,0.017863,0.019568,0.019308,0.017606,0.017649,0.016645,0.016310
						,0.014451,0.017606,0.018455,0]
				}, {
					name: '公司2',
					data: [0.018069,0.018495,0.018264,0.017527,0.016857,0.017398,0.016539
						,0.017144,0.018039,0.018798,0.018521,0.019580,0.019071,0.019078
						,0.017415,0.018997,0.018585,0.018417,0.018958,0.019772,0.018243
						,0.018742,0.020183,0.022000,0.020125,0.020549,0.019577,0.017468
						,0.015819,0.017709,0.018943,0]
				}, {
					name: '公司3',
					data: [0.017261,0.018625,0.019226,0.018777,0.019406,0.019887,0.022632
						,0.020445,0.019140,0.020957,0.021089,0.020967,0.021576,0.021357
						,0.020665,0.019415,0.018805,0.016842,0.016483,0.016688,0.016102
						,0.015717,0.016570,0.017390,0.016249,0.016616,0.016699,0.016514
						,0.016597,0.016476,0.016742,0]
				}
				],
				credits: {
					enabled: true,
					text: 'fchart.openjavascript.org',
					href: 'http://fchart.openjavascript.org/'
				}
				, floatLen: 6
				, displayAllLabel: false
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, point: {
					enabled: false
				}
			});
			
				_data.push( {
					chart: {
						type: 'bar' 
					}
					, title: {
						text:'Chart Title'
					},
					subtitle: {
						text: 'sub title'
					}, 
					xAxis: {
						categories: [ "2014-01-24","2014-01-25","2014-01-26","2014-01-27"
							,"2014-01-28","2014-01-29","2014-01-30","2014-01-31","2014-02-01"
							,"2014-02-02","2014-02-03","2014-02-04","2014-02-05","2014-02-06"
							,"2014-02-07","2014-02-08","2014-02-09","2014-02-10","2014-02-11"
							,"2014-02-12","2014-02-13","2014-02-14","2014-02-15","2014-02-16"
							,"2014-02-17","2014-02-18","2014-02-19","2014-02-20","2014-02-21"
							,"2014-02-22","2014-02-23","2014-02-24" ]
					}, 
					yAxis: {
					},
					series:[{
						name: '公司1',
						data: [0.018773,0.021724,0.022130,0.021296,0.022255,0.022128,0.020949
							,0.023862,0.026974,0.028055,0.024992,0.024721,0.025100,0.021803
							,0.019327,0.020149,0.020714,0.017774,0.017844,0.018313,0.018225
							,0.017863,0.019568,0.019308,0.017606,0.017649,0.016645,0.016310
							,0.014451,0.017606,0.018455,0]
					}, {
						name: '公司2',
						data: [0.018069,0.018495,0.018264,0.017527,0.016857,0.017398,0.016539
							,0.017144,0.018039,0.018798,0.018521,0.019580,0.019071,0.019078
							,0.017415,0.018997,0.018585,0.018417,0.018958,0.019772,0.018243
							,0.018742,0.020183,0.022000,0.020125,0.020549,0.019577,0.017468
							,0.015819,0.017709,0.018943,0]
					}, {
						name: '公司3',
						data: [0.017261,0.018625,0.019226,0.018777,0.019406,0.019887,0.022632
							,0.020445,0.019140,0.020957,0.021089,0.020967,0.021576,0.021357
							,0.020665,0.019415,0.018805,0.016842,0.016483,0.016688,0.016102
							,0.015717,0.016570,0.017390,0.016249,0.016616,0.016699,0.016514
							,0.016597,0.016476,0.016742,0]
					}
					],
					credits: {
						enabled: true,
						text: 'fchart.openjavascript.org',
						href: 'http://fchart.openjavascript.org/'
					}
					, floatLen: 6
					, displayAllLabel: false
					, vline: {
						enabled: false
					}
					, hline: {
						enabled: false
					}
					, point: {
						enabled: false
					}
				});
			
			_data.push( {
				chart: {
					type: 'zbar' 
					, bgColor: 0xffffff
				}, 
				subtitle: {
				}, 
				xAxis: {
					categories: [ "升级", "降级", "不变" ]
					, "autoRate": {
						enabled: true
					}
				}, 
				yAxis: {
					format: '{0}'
				},
				tooltip: {                  
					"pointFormat": "{0}",
					"headerFormat": "{0}"
				},
				series:[{
					name: '销售一部'
					, data: [ 9, 20, 30 ]
					, format: '{0}'
				}
					, {
						name: '销售二部'
						, data: [ 10, 10, 10 ]
						, format: '{0}'
					}
					, {
						name: '销售三部'
						, data: [ 5, 5, 30 ]
						, format: '{0}'
					}
					, {
						name: '销售四部'
						, data: [ 8, 12, 32 ]
						, format: '{0}'
					}
					, {
						name: '销售五部'
						, data: [ 7, 9, 12]
						, format: '{0}'
					}
				],
				credits: {
					enabled: false
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: true
					, interval: 20
					, direction: 'TOP_RIGHT'
				},
				animation: {
					enabled: true
					, duration: .75
				},
				vline: {
					enabled: false
				},         
				plotOptions: {
					line: {
						dashStyle: 'ShortDash'
					}
				},
				dataLabels: {
					enabled: true
				}
			});

		
			_data.push(             {
				chart: {
					type: 'zbar' 
					, bgColor: 0xffffff
				}, 
				subtitle: {
				}, 
				xAxis: {
					categories: [ "A级客户", "B级客户", "C级客户", "D级客户" ]
				}, 
				yAxis: {
					format: '{0}'
				},
				tooltip: {                  
					"pointFormat": "{0}",
					"headerFormat": "{0}"
				},
				series:[{
					name: '销售一部'
					, data: [ 20, 30, 40, 50 ]
					, format: '{0}'
				}
					, {
						name: '销售二部'
						, data: [ 10, 20, 35, 50 ]
						, format: '{0}'
					}
					, {
						name: '销售三部'
						, data: [ 5, 30, 20, 10 ]
						, format: '{0}'
					}
					, {
						name: '销售四部'
						, data: [ 12, 32, 13, 23 ]
						, format: '{0}'
					}
					, {
						name: '销售五部'
						, data: [ 9, 12, 31, 23]
						, format: '{0}'
					}
				],
				credits: {
					enabled: false
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: true
				},
				animation: {
					enabled: true
					, duration: .75
				}
			});
			
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
					, format: '{0}%'
				},
				tooltip: {					
					"pointFormat": "{0}%", 
					"headerFormat": "{0}月"
				},
				series:[{
					name: 'Temperature'
					, data: [-5000, 0, 300, -2000, -2000, 2700, 2800, 3200, 3000, 2500, 1500, -5800]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
					, fillColor: {}
					, fillOpacity: .35
				}, {
					name: 'Rainfall',
					data: [2000, 2100, 2000, 10000, 20000, 21000, 22000, 10000, 2000, 1000, 2000, 1000]
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: true
					, direction: 1
				},
				animation: {
					enabled: true
					, duration: .75
				}
			});

			
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
					, format: '{0}%'
				},
				tooltip: {					
					"pointFormat": "{0}%", 
					"headerFormat": "{0}月"
				},
				series:[{
					name: 'Temperature'
					, data: [-5000, 0, 300, -2000, -2000, 2700, 2800, 3200, 3000, 2500, 1500, -5800]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [2000, 2100, 2000, 10000, 20000, 21000, 22000, 10000, 2000, 1000, 2000, 1000]
					, fillColor: { linearGradient: true }
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: true
					, direction: 3
				},
				animation: {
					enabled: true
					, duration: .75
				},
				plotOptions: {
					area: {
						fillColor: {}
					}
				}
			});
			
			_data.push( 
				{
					"xAxis":
					{
						"categories":
						[
							"111111", 
							"2", 
							"3", 
							"4", 
							"5", 
							"6", 
							"7", 
							"8", 
							"9", 
							"10", 
							"11", 
							"122222"
						]
					}, 
					"displayAllLabel": true, 
					"series":
					[
						{
							"name": "Temperature", 
							"data":
							[
								10, 
								0, 
								3, 
								10, 
								20, 
								27, 
								28, 
								32, 
								30, 
								25, 
								15, 
								5
							]
							, dashStyle: 'Dash'
							, fillColor: {}
						}, 
						{
							"name": "Rainfall", 
							"data":
							[
								20, 
								21, 
								20, 
								100, 
								200, 
								210, 
								220, 
								100, 
								20, 
								10, 
								20, 
								10
							]
							, dashStyle: 'Dot'
							, fillColor: {}
						}
					], 
					"title":
					{
					}, 
					"credits":
					{
						"enabled": false, 
						"href": "http://fchart.openjavascript.org/", 
						"text": "fchart.openjavascript.org"
					}, 
					"subtitle":
					{
					}, 
					"yAxis":
					{
						"title":
						{
						}
					}
				}
			);
			
			_data.push( 
				{
					"hoverBg":
					{
						"style":
						{
							"borderColor": 11842740, 
							"bgColor": 15790320, 
							"borderWidth": 2
						}, 
						"enabled": true
					}, 
					"tooltip":
					{
						"headerYSpace": 6, 
						"headerStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 14, 
							"color": 7829367
						}, 
						"itemYSpace": 6, 
						"enabled": true, 
						"valueStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 6144104
						}, 
						"pointFormat": "{0} ", 
						"labelStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 11184810
						}, 
						"serial":
						[
							{
								"name": "区分度", 
								"data":
								[
									"3.87", 
									"3.85", 
									"3.83", 
									"3.82", 
									"3.80", 
									"3.79", 
									"3.78", 
									"3.78", 
									"3.76", 
									"3.76"
								]
							}
						], 
						"headerFormat": "{0}", 
						"headerIcon":
						{
							"style":
							{
								"color": 6144104
							}, 
							"enabled": true
						}, 
						"valueLabelXSpace": 0
					}, 
					"xAxis":
					{
						"enabled": false,
						"categories":
						[
							"口腔护理", 
							"身体护理", 
							"洗护清洁", 
							"游戏点卡", 
							"彩妆", 
							"生鲜食品", 
							"童装", 
							"粮油米面", 
							"饮料", 
							"配饰"
						]
					}, 
					"yAxis":
					{
						"enabled": true
					},
					"hline":
					{
						"enabled": true
					}, 
					"vline":
					{
						"enabled": false
					}, 
					"vsideLine":
					{
						"enabled": true
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"series":
					[
						{
							"name": "样本覆盖率", 
							"data":
							[
								"3.87", 
								"3.85", 
								"3.83", 
								"3.82", 
								"3.80", 
								"3.79", 
								"3.78", 
								"3.78", 
								"3.76", 
								"3.76"
							]
						}
					], 
					
					"colors":
					[
						44015, 
						10333619, 
						639232, 
						816836, 
						16713241, 
						16760576, 
						16740608, 
						16713395, 
						4317926, 
						12837540, 
						16757436, 
						14399741
					], 
					"displayAllLabel": true, 
					"dataLabels":
					{
						"format": "{0}", 
						"enabled": false
					},
					plotOptions: {
						line: {
							dashStyle: 'LongDash'
						}
					}
				});	
			
			
			
			_data.push( 
				{
					"hoverBg":
					{
						"style":
						{
							"borderColor": 11842740, 
							"bgColor": 15790320, 
							"borderWidth": 2
						}, 
						"enabled": true
					}, 
					"tooltip":
					{
						"headerYSpace": 6, 
						"headerStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 14, 
							"color": 7829367
						}, 
						"itemYSpace": 6, 
						"enabled": true, 
						"valueStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 6144104
						}, 
						"pointFormat": "{0} ", 
						"labelStyle":
						{
							"font": "Microsoft YaHei", 
							"size": 12, 
							"color": 11184810
						}, 
						"serial":
						[
							{
								"name": "区分度", 
								"data":
								[
									"3.87", 
									"3.85", 
									"3.83", 
									"3.82", 
									"3.80", 
									"3.79", 
									"3.78", 
									"3.78", 
									"3.76", 
									"3.76"
								]
							}
						], 
						"headerFormat": "{0}", 
						"headerIcon":
						{
							"style":
							{
								"color": 6144104
							}, 
							"enabled": true
						}, 
						"valueLabelXSpace": 0
					}, 
					"xAxis":
					{
						"enabled": false,
						"categories":
						[
							"口腔护理", 
							"身体护理", 
							"洗护清洁", 
							"游戏点卡", 
							"彩妆", 
							"生鲜食品", 
							"童装", 
							"粮油米面", 
							"饮料", 
							"配饰"
						]
					}, 
					"yAxis":
					{
						"enabled": true
					},
					"hline":
					{
						"enabled": true
					}, 
					"vline":
					{
						"enabled": false
					},  
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"series":
					[
						{
							"name": "样本覆盖率", 
							"data":
							[
								"3.87", 
								"3.85", 
								"3.83", 
								"3.82", 
								"3.80", 
								"3.79", 
								"3.78", 
								"3.78", 
								"3.76", 
								"3.76"
							]
						}
					], 
					
					"colors":
					[
						44015, 
						10333619, 
						639232, 
						816836, 
						16713241, 
						16760576, 
						16740608, 
						16713395, 
						4317926, 
						12837540, 
						16757436, 
						14399741
					], 
					"displayAllLabel": true, 
					"dataLabels":
					{
						"format": "{0}", 
						"enabled": false
					}
				});	
			
			_data.push({
				
				xAxis: {
					categories: [ '网页\n游戏\n3333', '游戏平台', '桌面游戏', '手机游戏', '个体经营', '小游戏', '网页游戏', '游戏平台', '桌面游戏', '手机游戏' ]
				}
				, yAxis: {
					enabled: false	
				}
				, series:[{
					name: '全体覆盖率'
					, data: [26, 36, 46, 56, 77, 76, 86, 72, 62, 52]
				}, {
					name: '样式覆盖率',
					data: [81, 71, 61, 51, 41, 31, 21, 11, 29, 39]
				}]
				, tooltip: {
					"headerFormat": "{0}"			
					, "pointFormat": "{0}%"
					//, enabled: false
					, afterSerial: [
						{
							name: '区分度',
							data: [81, 71, 61, 51, 41, 31, 21, 11, 29, 39]
						}
					]
					, "header": [ 
						'1', '2', '桌面游戏', '手机游戏', '个体经营', '小游戏', '网页游戏', '游戏平台', '桌面游戏', '手机游戏'
					]
					
					, headerYSpace: 6
					, itemYSpace: 6
					, valueLabelXSpace: 0
					
					, headerStyle: {
						font: "Microsoft YaHei"
						, size: 14
						, color: 0x777777
					}
					, labelStyle: {
						font: "Microsoft YaHei"
						, size: 12
						, color: 0xaaaaaa
					}
					, valueStyle: {
						font: "Microsoft YaHei"
						, size: 12
						, color: 0x5dc068
					}
					
					, headerIcon: {
						enabled: true
						, style: {
							color: 0x5DC068
						}
					}
					
				}
				, displayAllLabel: true
				, legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: false
					, format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]       
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, hoverBg: {
					enabled: true		
					, style: {
						borderColor: 0xB4B4B4
						, borderWidth: 2
						, bgColor: 0xF0F0F0
					}										
				}
			});
			
			_data.push(
				{					
					"chart":
					{
						"bgColor": 16777215, 
						"bgAlpha": 1
					}, 
					"colors":
					[
						44015, 
						10333619, 
						639232, 
						816836, 
						16713241
					], 
					"vline":
					{
						"enabled": false
					}, 
					"xAxis":
					{
						"wordwrap": true, 
						"categories":
						[
							"pos.baidu.com", 
							"www.baidu.com", 
							"hao.360.cn", 
							"wd.360.cn", 
							"internal.host.com", 
							"eclick.baidu.com", 
							"googleads.g.doubleclick.net", 
							"user.qzone.qq.com", 
							"www.so.com", 
							"ptlogin2.qq.com"
						]
					}, 
					"dataLabels":
					{
						"format": "{0}", 
						"enabled": true
					}, 
					"yAxis":
					{
						"enabled": false
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"displayAllLabel": true, 
					"maxItem":
					{
						"style":
						{
							"size": 18, 
							"color": 6146425
						}
					}, 
					"tooltip":
					{
						"enabled": true
					}, 
					"hline":
					{
						"enabled": false
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								"7026299386", 
								"2243248546", 
								"1918390720", 
								"1887903406", 
								"1517144906", 
								"1463547200", 
								"958396100", 
								"951335880", 
								"941430913", 
								"914735040"
							]
							, "labelData": [
								"70.26亿", 
								"22.43亿", 
								"19.18亿", 
								"18.87亿", 
								"15.17亿", 
								"14.63亿", 
								"9.58亿", 
								"9.51亿", 
								"9.41亿", 
								"9.14亿"
							]
						}
					]
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049
							]
							, "labelData": [
								"1.72k"
								, "1.69k"
								, "2.04k"
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								6, 
								7
							]
							, "labelData": [
								"0.005k"
								, "0.006k"
								, "0.007k"
							]
						}
					], 
					"dataLabels":
					{
						"format": "{0}", 
						"enabled": true
					}, 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": true
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138, 
								1557
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138, 
								1557, 
								1561
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138, 
								1557, 
								1561, 
								1400
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138, 
								1557, 
								1561, 
								1400, 
								1400
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910", 
							"20140910"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910", 
							"20140910"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138, 
								1557, 
								1561, 
								1400, 
								1400, 
								1400
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138, 
								1557, 
								1561, 
								1400, 
								1400, 
								1400, 
								1400
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							
							"20140913", 
							"20140912", 
							"20140911", 
							
							"20140910", 
							"20140910", 
							"20140910", 
							
							"20140910",
							"20140910"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							
							"20140913", 
							"20140912", 
							"20140911",
							
							"20140910", 
							"20140910", 
							"20140910", 
							
							"20140910", 
							"20140910"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								
								2138, 
								1557, 
								1561, 
								
								1400, 
								1400, 
								1400, 
								
								1400, 
								1400
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								
								5, 
								5, 
								5, 
								
								5, 
								5, 
								5, 
								
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			
			_data.push( 
				{
					"yAxis":
					{
						"enabled": true
					}, 
					"tooltip":
					{
						"pointFormat": "{0}", 
						"headerFormat": "{0}", 
						"enabled": true
					}, 
					"displayAllLabel": false, 
					"vline":
					{
					}, 
					"xAxis":
					{
						"categories":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910"
						], 
						"wordwrap": false, 
						"tipsHeader":
						[
							"20140916", 
							"20140915", 
							"20140914", 
							"20140913", 
							"20140912", 
							"20140911", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910", 
							"20140910"
						]
					}, 
					"series":
					[
						{
							"name": "pv", 
							"data":
							[
								1722, 
								1694, 
								2049, 
								2138, 
								1557, 
								1561, 
								1400, 
								1400, 
								1400, 
								1400, 
								1400, 
								1400
							]
						}, 
						{
							"name": "uv", 
							"data":
							[
								5, 
								5, 
								5, 
								
								5, 
								5, 
								5, 
								
								5, 
								5, 
								5, 
								
								5, 
								5, 
								5
							]
						}
					], 
					"hline":
					{
					}, 
					"toggleBg":
					{
						"enabled": true
					}, 
					"legend":
					{
						"enabled": false
					}, 
					"chart":
					{
						"bgAlpha": 1, 
						"bgColor": 16777215
					} 
				}
			);
			
			_data.push({ 
				
				xAxis: {
					categories: [ 
						'网页游戏1\n游戏', '网页游戏2\n游戏', '网页游戏3\n游戏', '网页游戏4\n游戏', '网页游戏5\n游戏'
						, '网页游戏6\n游戏', '网页游戏7\n游戏', '网页游戏8\n游戏', '网页游戏9\n游戏', '网页游戏9\n游戏'
					]
					, format: '{0}'
				}
				, yAxis: {
					format: '{0}'
					, enabled: false
				}
				, series:[{
					name: '最大区分度 - 兴趣'
					, data: [
						0.98, 1.99, 1.01, 1.02, 1.05
						, 1.98, 2.99, 0.001, 3.02, 3.05
					]
				}] 
				, tooltip: {		
					enabled: true
					, "headerFormat": "{0}"			
					, "pointFormat": "{0}"
					
				}
				//isPercent: true,
				, displayAllLabel: true
				, legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true
					, format: '{0}'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, colors: [
					0x03ACEF
					, 0x5DC979
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]    				
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
					//, graphicHeight: 220
				}
				, itemBg: {
					enabled: true		
					, style: {
						borderColor: 0xB4B4B4
						, borderWidth: 0
						, bgColor: 0xF0F0F0
					}										
				}
			});
			
			
			_data.push({
				
				xAxis: {
					categories: [ '02/24', '02/25', '02/26', '02/27', '02/28', '02/29', '03/01' ]
				}
				, yAxis: {
					format: '{0}%'
					, maxvalue: 100
				}
				, series:[{
					name: '目标PV'
					, data: [ 70, 49, 76, 30, 55, 26, 78 ]
				}, {
					name: '目标UV',
					data: [ 48, 62, 50, 50, 30, 40, 35 ]
				}]
				, tooltip: {		
					enabled: true
					, "headerFormat": "{0}"			
					, "pointFormat": "{0} %"
					
				}
				//isPercent: true,
				, displayAllLabel: true
				, legend: {
					//enabled: false
				}
				, dataLabels: {
					enabled: true
					, format: '{0}%'
				}
				, vline: {
					//enabled: false
				}
				, hline: {
					//enabled: true
				}
				, colors: [
					0x03ACEF
					, 0x5DC979
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]    				
				, credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				}
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
					//, graphicHeight: 220
				}
				, hoverBg: {
					enabled: true		
					, style: {
						borderColor: 0xB4B4B4
						, borderWidth: 2
						, bgColor: 0xF0F0F0
					}										
				}
			});
			
			
			_data.push({
				
				xAxis: {
					categories: [ 
						'04/01', '04/05', '04/10', '04/15', '04/20', '04/25'
						, '05/01', '05/05', '05/10', '05/15', '05/20', '05/25'
						, '05/31', '06/04', '06/09', '06/14', '06/19', '06/24'
						, '06/29'
					]
					, wordwrap: false
				}
				, yAxis: {
					format: '{0}'
					, rate: [ 1, .8, .6, .4, .2, .0 ]
				}
				, series:[{
					name: '词1'
					, data: [ 10, 0, 38, 53, 51, 38, 39, 38, 34, 59, 37, 34, 51, 58, 57, 39, 58, 44, 31 ]
				}, {
					name: '词2',
					data: [ 20, 0, 18, 25, 59, 19, 26, 18, 40, 21, 42, 22, 30, 42, 30, 39, 59, 30, 50 ]
				}, {
					name: '词3',
					data: [ 30, 0, 55, 41, 54, 53, 55, 54, 57, 55, 54, 59, 55, 39, 47, 43, 46, 42, 45 ]
				}, {
					name: '词4',
					data: [ 35, 0, 65, 51, 64, 63, 65, 64, 67, 65, 64, 69, 65, 59, 57, 53, 56, 52, 45 ]
				}, {
					name: '词5',
					data: [ 5, 0, 45, 31, 44, 43, 45, 44, 47, 45, 44, 49, 45, 29, 37, 33, 36, 32, 35 ]
				}
				]
				, tooltip: {		
					enabled: true
					, "headerFormat": "{0}             PV"			
					, "pointFormat": "{0}"
					, "header": [ 
						'2014-04-01', '2014-04-05', '2014-04-10', '2014-04-15', '2014-04-20', '2014-04-25'
						, '2014-05-01', '2014-05-05', '2014-05-10', '2014-05-15', '2014-05-20', '2014-05-25'
						, '2014-05-31', '2014-06-04', '2014-06-09', '2014-06-14', '2014-06-19', '2014-06-24'
						, '2014-06-29'
					]
					, "serial": [
						{
							"name": "总体"
							, "data": [ 
								1000, 2000, 3000, 4000, 5000, 6000
								, 1000, 2000, 3000, 4000, 5000, 6000 
								, 1000, 2000, 3000, 4000, 5000, 6000 
								, 7000
							]
						}
					]
					, "afterSerial": [
						{
							"name": "区分度"
							, "data": [ 
								1.04, 1.05, 1.06, 1.07, 1.08, 1.09
								, 2.01, 2.02, 2.03, 2.04, 2.05, 2.06
								, 3.09, 3.08, 3.07, 3.06, 3.05, 3.04
								, 4.11
							]
						}
					]
				}
				, displayAllLabel: false
				, legend: {
					enabled: false
				}
				, vline: {
					//enabled: false
				}
				, hline: {
					//enabled: true
				}
				, colors: [		
					0x61CA7D
					, 0x00ABEF
					, 0xFCBC2B
					, 0xF47672
					, 0xBDA5E6
					, 0xFF7C27
					
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]    	
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, toggleBg: {
					enabled: true
				}
			});
			
			
			_data.push({
				
				xAxis: {
					categories: [ 
						'04/01', '04/05', '04/10', '04/15', '04/20', '04/25'
						, '05/01', '05/05', '05/10', '05/15', '05/20', '05/25'
						, '05/31', '06/04', '06/09', '06/14', '06/19', '06/24'
						, '06/29'
					]
					, wordwrap: false
				}
				, yAxis: {
					format: '{0}%'
					, enabled: true
					, maxvalue: 100
					, rate: [ 1, .8, .6, .4, .2, .0 ]
				}
				, series:[{
					name: '词1'
					, data: [ 10, 0, 38, 53, 51, 38, 39, 38, 34, 59, 37, 34, 51, 58, 57, 39, 58, 44, 31 ]
				}, {
					name: '词2',
					data: [ 20, 0, 18, 25, 59, 19, 26, 18, 40, 21, 42, 22, 30, 42, 30, 39, 59, 30, 50 ]
				}, {
					name: '词3',
					data: [ 30, 0, 55, 41, 54, 53, 55, 54, 57, 55, 54, 59, 55, 39, 47, 43, 46, 42, 45 ]
				}, {
					name: '词4',
					data: [ 35, 0, 65, 51, 64, 63, 65, 64, 67, 65, 64, 69, 65, 59, 57, 53, 56, 52, 45 ]
				}, {
					name: '词5',
					data: [ 5, 0, 45, 31, 44, 43, 45, 44, 47, 45, 44, 49, 45, 29, 37, 33, 36, 32, 35 ]
				}
				]
				, tooltip: {		
					enabled: true
					, "headerFormat": "{0}             UV"			
					, "pointFormat": "{0}%"
					, "header": [ 
						'2014-04-01', '2014-04-05', '2014-04-10', '2014-04-15', '2014-04-20', '2014-04-25'
						, '2014-05-01', '2014-05-05', '2014-05-10', '2014-05-15', '2014-05-20', '2014-05-25'
						, '2014-05-31', '2014-06-04', '2014-06-09', '2014-06-14', '2014-06-19', '2014-06-24'
						, '2014-06-29'
					]
				}
				, displayAllLabel: false
				, legend: {
					enabled: false
				}
				, vline: {
					//enabled: false
				}
				, hline: {
					//enabled: true
				}
				, colors: [		
					0x61CA7D
					, 0x00ABEF
					, 0xFCBC2B
					, 0xF47672
					, 0xBDA5E6
					, 0xFF7C27
					
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]    	
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, toggleBg: {
					enabled: true
				}
			});
			
			
			_data.push({
				xAxis: {
					categories: [ '初中\n以下', '高中\n中专\n技校', '大专', '本科', '研究生\n及以上' ]
					, wordwrap: true
				}, 
				yAxis: {
					enabled: false
				},
				series:[{
					name: '学历'
					, data: [ 12, 19, 21, 46, 10 ]
				}],
				//isPercent: true,
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}				
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
					, graphicHeight: 220
				}
			});
			
			_data.push({
				
				xAxis: {
					categories: [ '网页游戏', '游戏平台', '桌面游戏', '手机游戏', '个体经营', '小游戏', '网页游戏', '游戏平台', '桌面游戏', '手机游戏' ]
				}
				, yAxis: {					
					enabled: false	
				}
				, series:[{
					name: '全体覆盖率'
					, data: [26, 36, 46, 56, 77, 76, 86, 72, 62, 52]
				}, {
					name: '样式覆盖率',
					data: [81, 71, 61, 51, 41, 31, 21, 11, 29, 39]
				}]
				, tooltip: {		
					"headerFormat": "{0}"			
					, "pointFormat": "{0} %"
					//, enabled: false
					
				}
				//isPercent: true,
				, displayAllLabel: true
				, legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true
					, format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]       
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, hoverBg: {
					enabled: true		
					, style: {
						borderColor: 0xB4B4B4
						, borderWidth: 2
						, bgColor: 0xF0F0F0
					}										
				}
			});
			
			
			_data.push({
				xAxis: {
					categories: [ 
						'兴趣点1', '兴趣点2', '兴趣点3', '兴趣点4', '兴趣点5'
					]
					, wordwrap: true
				}, 
				yAxis: {
					format: '{0}%'
					, maxvalue: 100
					, enabled: false
				},
				series:[{
					name: '时段分布'
					, data: [
						80.12, 70.12, 50.12, 30.12, 10.12
					]
				}],
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, vline: {
					enabled: true
				}
				, hline: {
					enabled: true
				}
				, tooltip: {		
//					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}                
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
				, hoverBg: {
					enabled: true												
				}
				
			});
			
			_data.push({
				xAxis: {
					categories: [ 
						'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
						, '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'
						, '20', '21', '22', '23', '0'
					]
					, wordwrap: false
				}, 
				yAxis: {
					format: '{0}%'
					, maxvalue: 100
				},
				series:[{
					name: '时段分布'
					, data: [
						0, 1, 2, 3, 4, 5, 6, 7, 8, 9
						, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
						, 20, 21, 22, 23, 0
					]
				}]
				, tooltip: {		
					"headerFormat": "{0}"			
					, "pointFormat": "{0} %"
					//, enabled: false
					, header: [
						'0 时~', '1 时~', '2 时~', '3 时~', '4 时~', '5 时~', '6 时~', '7 时~', '8 时~', '9  时~'
						, '10 时~', '11 时~', '12 时~', '13 时~', '14 时~', '15 时~', '16 时~', '17 时~', '18 时~', '19 时~'
						, '20 时~', '21 时~', '22 时~', '23 时~', '0 时~'
					]
				}
				, displayAllLabel: true
				, legend: {
					enabled: false
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: true
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			_data.push({
				
				xAxis: {
					categories: [ '1', '2', '3', '4', '5' ]
				}, 
				yAxis: {
					enabled: false
				},
				series:[{
					name: 'Temperature'
					, data: [50, 60, 3, 20, 20]
					, style: { 'stroke': 0xff7100 } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [20, 21, 20, -100, 200]
				}],
				//isPercent: true,
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true
				}
				, vline: {
					enabled: true
				}
				, hline: {
					enabled: true
				}
				, tooltip: {
//					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
					, 0xFFBF00			
					, 0xff7100	
					, 0xff06b3
					
					, 0x41e2e6			
					, 0xc3e2a4	
					, 0xffb2bc
					
					, 0xdbb8fd
				]       
				, chart: {
					bgColor: 0xffffff
					, bgAlpha: 1
				}
			});
			
			
			_data.push({
				xAxis: {
					categories: [ 
						'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
						, '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'
						, '20', '21', '22', '23', '0'
					]
					, wordwrap: false
				}, 
				yAxis: {
					format: '{0}%'
				},
				series:[{
					name: '时段分布'
					, data: [
						0, 1, 2, 3, 4, 5, 6, 7, 8, 9
						, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
						, 20, 21, 22, 23, 0
					]
				}],
				isPercent: true,
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: true
				}
				, tooltip: {
					"headerFormat": "{0} 日"			
					, "pointFormat": "{0}%"		
					, enabled: true
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			_data.push({
				xAxis: {
					categories: [ '学生', '公司职员', '公司管理者', '公务员', '事业单位', '个体经营', '自由职业', '产业\n服务员\n工人', '农业\n劳动者', '其他' ]
					, wordwrap: true
				}, 
				yAxis: {
					enabled: false
				},
				series:[{
					name: '职业'
					, data: [ 11, 14, 43, 12, 21, 8, 4, 6, 8, 5 ]
				}],
				//isPercent: true,
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			
			
			_data.push({
				xAxis: {
					categories: [ '<18', '19-24', '23-34', '35-49', '>49' ]
					, wordwrap: true
				}, 
				yAxis: {
					enabled: false
				},
				series:[{
					name: '年龄'
					, data: [ 69, 19, 21, 18, 10 ]
				}],
				//isPercent: true,
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			_data.push({
				xAxis: {
					categories: [ '低', '偏低', '中等', '偏高', '高' ]
					, wordwrap: true
				}, 
				yAxis: {
					enabled: false
				},
				series:[{
					name: '购买力'
					, data: [ 43, 19, 21, 18, 0 ]
				}],
				//isPercent: true,
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, dataLabels: {
					enabled: true,
					format: '{0}%'
				}
				, vline: {
					enabled: false
				}
				, hline: {
					enabled: false
				}
				, tooltip: {
					enabled: false
				}
				, colors: [
					0x00ABEF
					, 0x9DADB3
					, 0x09c100
					, 0x0c76c4 				
					, 0xff0619
					
				]
				, maxItem: {
					style: { color: 0x5DC979, size: 18 }
				}
			});
			
			
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
				},
				series:[{
					name: 'Temperature'
					, data: [-50, 0, 3, -20, -20, 27, 28, 32, 30, 25, 15, -58]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [20, 21, 20.8, 100, 200, 210, 220, 100, 20, 10, 20, 10]
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
			});
			
			_data.push( {
				title: { text: 'test title 中文' }
				, subtitle: { text: 'test subtitle 中文' }
				, yAxis: { title: { text: 'vtitle 中文' } }
				, credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				xAxis: {
					categories: [2111111111111, 2, 3, 4, 5, 6, 7, 8, 999999999999]
					, tipTitlePostfix: '{0}月'
				}, 
				xAxis: {
					"autoRate": {
						enabled: true
					}
				},
				series:[{
					name: 'Temperature',
					data: [-50, -1, -3, 10.01, -20, -27, -28, -32, -30]
				}, {
					name: 'Rainfall1',
					data: [-20.10, -21, 50, 100, -10, -210, -220, -100, -20]
				}, {
					name: 'Rainfall2',
					data: [-30, -21, -20, -100, -10, -210, -20, -100, -20]
				}, {
					name: 'Rainfall999',
					data: [-40, -21, -20, -100, -10, -210, -120, -100, -20]
				}
					
				],
				legend: {
					enabled: true
				}
				, displayAllLabel: false
			});
			
			_data.push( {
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
					, tipTitlePostfix: '{0}月'
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
				},
				series:[{
					name: 'Temperature'
					, data: [-50, 0, 3, -20, -20, 27, 28, 32, 30, 25, 15, -58]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [20, 21, 20, 100, 200, 210, 220, 100, 20, 10, 20, 10]
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: true
				}
			});
			
			_data.push( {
				title: {
					text:'北京每月平均温度和降水'
				},
				subtitle: {
					text: '北京气象局'
				}, 
				xAxis: {
					categories: [1, 2, 3, 4, 5, 6, 7, 8, 9]
					, tipTitlePostfix: '{0}月'
				}, 
				yAxis: {
					title: {
						text: '平均温度'
					}
				},
				series:[{
					name: 'Temperature',
					data: [-50, -1, -3, -10, -20, -27, -28, -32, -30]
				}, {
					name: 'Rainfall',
					data: [-120, -211, 0, -100, -10, -210, -220, -80, -20]
				}, {
					name: 'Rainfall',
					data: [-220, -121, -20, -110, -10, -200, -230, -90, -30]
				}, {
					name: 'Rainfall',
					data: [-20, -21, 20, -120, -10, -205, -240, -100, -40]
				}
				],
				legend: {
					enabled: true
				}
			});
			
			
			_data.push( {
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
				},
				series:[{
					name: 'Temperature'
					, data: [-50, 0, 3, -20, -20, 27, 28, 32, 30, 25, 15, -58]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [20, 21, 20, 100, 200, 210, 220, 100, 20, 10, 20, 10]
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
			});
			
			_data.push(                     {
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ "2014-01-24","2014-01-25","2014-01-26","2014-01-27"
						,"2014-01-28","2014-01-29","2014-01-30","2014-01-31","2014-02-01"
						,"2014-02-02","2014-02-03","2014-02-04","2014-02-05","2014-02-06"
						,"2014-02-07","2014-02-08","2014-02-09","2014-02-10","2014-02-11"
						,"2014-02-12","2014-02-13","2014-02-14","2014-02-15","2014-02-16"
						,"2014-02-17","2014-02-18","2014-02-19","2014-02-20","2014-02-21"
						,"2014-02-22","2014-02-23","2014-02-24" ]
					, wordwrap: false
				}, 
				yAxis: {
				},
				series:[{
					name: '公司1',
					data: [0.018773,0.021724,0.022130,0.021296,0.022255,0.022128,0.020949
						,0.023862,0.026974,0.028055,0.024992,0.024721,0.025100,0.021803
						,0.019327,0.020149,0.020714,0.017774,0.017844,0.018313,0.018225
						,0.017863,0.019568,0.019308,0.017606,0.017649,0.016645,0.016310
						,0.014451,0.017606,0.018455,0]
				}, {
					name: '公司2',
					data: [0.018069,0.018495,0.018264,0.017527,0.016857,0.017398,0.016539
						,0.017144,0.018039,0.018798,0.018521,0.019580,0.019071,0.019078
						,0.017415,0.018997,0.018585,0.018417,0.018958,0.019772,0.018243
						,0.018742,0.020183,0.022000,0.020125,0.020549,0.019577,0.017468
						,0.015819,0.017709,0.018943,0]
				}, {
					name: '公司3',
					data: [0.017261,0.018625,0.019226,0.018777,0.019406,0.019887,0.022632
						,0.020445,0.019140,0.020957,0.021089,0.020967,0.021576,0.021357
						,0.020665,0.019415,0.018805,0.016842,0.016483,0.016688,0.016102
						,0.015717,0.016570,0.017390,0.016249,0.016616,0.016699,0.016514
						,0.016597,0.016476,0.016742,0]
				}
				],
				credits: {
					enabled: true,
					text: 'fchart.openjavascript.org',
					href: 'http://fchart.openjavascript.org/'
				}
				, displayAllLabel: false
				, legend: {
					direction: 'RIGHT_MIDDLE'
				}
			} );
						
			
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
					, format: '{0}%'
				},
				tooltip: {					
					"pointFormat": "{0}", 
					"headerFormat": "{0}月"
				},
				series:[{
					name: 'Temperature'
					, data: [1, 2, 4, 8, 8, 33, 60, 0, 50.33, 66, 77, 88]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [1.01, 44, 3, 55, 3, 5, 83, 1, 33, 55, 44, 33]
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, isPercent: true
			});
			
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3' ]
					, enabled: false
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
					, format: '{0}%'
				},
				tooltip: {
					"pointFormat": "{0}", 
					"headerFormat": "{0}月"
				},
				series:[{
					name: 'Temperature'
					, data: [1, 2, 4]
					, style: { 'stroke': '#ff7100' } 
					, pointStyle: {}
				}, {
					name: 'Rainfall',
					data: [1.01, 44, 3]
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: false
				}
				, isPercent: true
			});
			
			_data.push({
				title: {
					text:'Chart Title'
				},
				subtitle: {
					text: 'sub title'
				}, 
				xAxis: {
					categories: [ '1', '2', '3', '4', '5' ]
				}, 
				yAxis: {
					title: {
						text: '(Vertical Title - 中文)'
					}
					, format: '{0}'
				},
				tooltip: {					
					"pointFormat": "{0}",
					"headerFormat": "{0}"
				},
				series:[{
					name: 'Phone'
					, data: [ 27000, 23600, 16200, 14100, 8400 ]
					//, label: [ "iphone", "samsung", "huawei", "mi", "meizu" ]
					, format: '{0}台 占{1}%'
				}, {
					name: 'Computer',
					data: [19170, 32060, 13600, 7000, 14800, ]
					//, label: [ "Dell", "Asus", "Sony", "Lenovo", "iMac", ]
					, format: '{0}台 约占{1}%'
					, dataLabel: { enabled: true }
				}],
				credits: {
					enabled: true
					, text: 'fchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				displayAllLabel: true,
				legend: {
					enabled: true
				},
				animation: {
					enabled: false
					, duration: .75
				}
			});
			
		}
	}
}
