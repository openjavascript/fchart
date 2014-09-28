package org.xas.jchart.common.data.test
{
	public class MapData
	{
		private var _data:Vector.<Object>;
		public function get data():Vector.<Object>{ return _data;}
		
		private static var _ins:MapData;
		
		public static function get instance():MapData{
			if( !_ins ){
				_ins = new MapData();		
			}
			return _ins;
		}
		
		public function MapData()
		{
			init();
		}
		
		private function init():void{
			_data = new Vector.<Object>();
			
			_data.push({
				
				title: {
					text:'China Map'
				},
				subtitle: {
					text: 'sub title'
				}, 
				credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				tooltip: {
					"headerFormat": "~{0}~"
					, "pointFormat": "{0} 元（每平）"
					, "labelStyle": {
						color: 0xaaaaaa
					},
					header:[
						{
							"name": "tip header 辽宁"
						}, {
							"name": "tip header 河北"
						}, {
							"name": "tip header 北京"
						}, {
							"name": "tip header 上海"
						}, {
							"name": "tip header 江苏"
						}, {
							"name": "tip header 吉林"
						}, {
							"name": "tip header 黑龙江"
						}, {
							"name": "tip header 内蒙古"
						}, {
							"name": "tip header 青海"
						}, {
							"name": "tip header 山东"
						}, {
							"name": "tip header 天津"
						}, {
							"name": "tip header 宁夏"
						}, {
							"name": "tip header 陕西"
						}, {
							"name": "tip header 台湾"
						}, {
							"name": "tip header 海南"
						}, {
							"name": "tip header 河南"
						}, {
							"name": "tip header 新疆"
						}, {
							"name": "tip header 甘肃"
						}, {
							"name": "tip header 香港"
						}, {
							"name": "tip header 西藏"
						}, {
							"name": "tip header 四川"
						}, {
							"name": "tip header 云南"
						}, {
							"name": "tip header 贵州"
						}, {
							"name": "tip header 澳门"
						}, {
							"name": "tip header 广西"
						}, {
							"name": "tip header 广东"
						}, {
							"name": "tip header 重庆"
						}, {
							"name": "tip header 湖北"
						}, {
							"name": "tip header 湖南"
						}, {
							"name": "tip header 江西"
						}, {
							"name": "tip header 安徽"
						}, {
							"name": "tip header 福建"
						}, {
							"name": "tip header 浙江"
						}, {
							"name": "tip header 山西"
						} 
					],
					series:[
						{
							"name": "tip serial 辽宁",
							"value": 1260122
						}, {
							"name": "tip serial 河北",
							"value": 18697
						}, {
							"name": "tip serial 北京",
							"value": 33288
						}, {
							"name": "tip serial 上海",
							"value": 30825
						}, {
							"name": "tip serial 江苏",
							"value": 18242
						}, {
							"name": "tip serial 吉林",
							"value": 16863
						}, {
							"name": "tip serial 黑龙江",
							"value": 10365
						}, {
							"name": "tip serial 内蒙古",
							"value": 6325
						}, {
							"name": "tip serial 青海",
							"value": 11952
						}, {
							"name": "tip serial 山东",
							"value": 15650
						}, {
							"name": "tip serial 天津",
							"value": 24829
						}, {
							"name": "tip serial 宁夏",
							"value": 18865
						}, {
							"name": "tip serial 陕西",
							"value": 15954
						}, {
							"name": "tip serial 台湾",
							"value": 26559
						}, {
							"name": "tip serial 海南",
							"value": 21820
						}, {
							"name": "tip serial 河南",
							"value": 17850
						}, {
							"name": "tip serial 新疆",
							"value": 6825
						}, {
							"name": "tip serial 甘肃",
							"value": 8843
						}, {
							"name": "tip serial 香港",
							"value": 27825
						}, {
							"name": "tip serial 西藏",
							"value": 7429
						}, {
							"name": "tip serial 四川",
							"value": 15281
						}, {
							"name": "tip serial 云南",
							"value": 8875
						}, {
							"name": "tip serial 贵州",
							"value": 7825
						}, {
							"name": "tip serial 澳门",
							"value": 28565
						}, {
							"name": "tip serial 广西",
							"value": 23845
						}, {
							"name": "tip serial 广东",
							"value": 25025
						}, {
							"name": "tip serial 重庆",
							"value": 22825
						}, {
							"name": "tip serial 湖北",
							"value": 18225
						}, {
							"name": "tip serial 湖南",
							"value": 21325
						}, {
							"name": "tip serial 江西",
							"value": 19620
						}, {
							"name": "tip serial 安徽",
							"value": 17826
						}, {
							"name": "tip serial 福建",
							"value": 20833
						}, {
							"name": "tip serial 浙江",
							"value": 22807
						}, {
							"name": "tip serial 山西",
							"value": 9638
						} 
					],
					afterSeries:[
						{
							"name": "tip after serial 辽宁",
							"value": 126011
						}, {
							"name": "tip after serial 河北",
							"value": 18697
						}, {
							"name": "tip after serial 北京",
							"value": 33288
						}, {
							"name": "tip after serial 上海",
							"value": 30825
						}, {
							"name": "tip after serial 江苏",
							"value": 18242
						}, {
							"name": "tip after serial 吉林",
							"value": 16863
						}, {
							"name": "tip after serial 黑龙江",
							"value": 10365
						}, {
							"name": "tip after serial 内蒙古",
							"value": 6325
						}, {
							"name": "tip after serial 青海",
							"value": 11952
						}, {
							"name": "tip after serial 山东",
							"value": 15650
						}, {
							"name": "tip after serial 天津",
							"value": 24829
						}, {
							"name": "tip after serial 宁夏",
							"value": 18865
						}, {
							"name": "tip after serial 陕西",
							"value": 15954
						}, {
							"name": "tip after serial 台湾",
							"value": 26559
						}, {
							"name": "tip after serial 海南",
							"value": 21820
						}, {
							"name": "tip after serial 河南",
							"value": 17850
						}, {
							"name": "tip after serial 新疆",
							"value": 6825
						}, {
							"name": "tip after serial 甘肃",
							"value": 8843
						}, {
							"name": "tip after serial 香港",
							"value": 27825
						}, {
							"name": "tip after serial 西藏",
							"value": 7429
						}, {
							"name": "tip after serial 四川",
							"value": 15281
						}, {
							"name": "tip after serial 云南",
							"value": 8875
						}, {
							"name": "tip after serial 贵州",
							"value": 7825
						}, {
							"name": "tip after serial 澳门",
							"value": 28565
						}, {
							"name": "tip after serial 广西",
							"value": 23845
						}, {
							"name": "tip after serial 广东",
							"value": 25025
						}, {
							"name": "tip after serial 重庆",
							"value": 22825
						}, {
							"name": "tip after serial 湖北",
							"value": 18225
						}, {
							"name": "tip after serial 湖南",
							"value": 21325
						}, {
							"name": "tip after serial 江西",
							"value": 19620
						}, {
							"name": "tip after serial 安徽",
							"value": 17826
						}, {
							"name": "tip after serial 福建",
							"value": 20833
						}, {
							"name": "tip after serial 浙江",
							"value": 22807
						}, {
							"name": "tip after serial 山西",
							"value": 9638
						} 
					]
				},
				yAxis: {
					enabled: true,
					format: '{0}',
					ratenum: 5
				},
				legend: {
					//enabled: false
				},
				zoom: {
					enable: true,
					zoomRate: .5,
					zoomSpeed: .5
				},
				callBack:{
					initedCallback: "inited",
					hoverCallback: "hovered",
					clickCallback: "clicked"
				},
				series:[{
					name: "平均房价",
					mapType: "China",
					highColor: 0x2f7ed8,
					lowColor: 0xffffff,
					hoverColor: 0xbada55,
					data: [{
						"id": 1,
						"name": "辽宁",
						"value": 12601
					}, {
						"id": 2,
						"name": "河北",
						"value": 18697
					}, {
						"id": 3,
						"name": "北京",
						"value": 33288
					}, {
						"id": 4,
						"name": "上海",
						"value": 30825
					}, {
						"id": 5,
						"name": "江苏",
						"value": 18242
					}, {
						"id": 6,
						"name": "吉林",
						"value": 16863
					}, {
						"id": 7,
						"name": "黑龙江",
						"value": 10365
					}, {
						"id": 8,
						"name": "内蒙古",
						"value": 6325
					}, {
						"id": 9,
						"name": "青海",
						"value": 11952
					}, {
						"id": 10,
						"name": "山东",
						"value": 15650
					}, {
						"id": 11,
						"name": "天津",
						"value": 24829
					}, {
						"id": 12,
						"name": "宁夏",
						"value": 18865
					}, {
						"id": 13,
						"name": "陕西",
						"value": 15954
					}, {
						"id": 14,
						"name": "台湾",
						"value": 26559
					}, {
						"id":15 ,
						"name": "海南",
						"value": 21820
					}, {
						"id": 16,
						"name": "河南",
						"value": 17850
					}, {
						"id": 17,
						"name": "新疆",
						"value": 6825
					}, {
						"id": 18,
						"name": "甘肃",
						"value": 8843
					}, {
						"id": 19,
						"name": "香港",
						"value": 27825
					}, {
						"id": 20,
						"name": "西藏",
						"value": 7429
					}, {
						"id": 21,
						"name": "四川",
						"value": 15281
					}, {
						"id": 22,
						"name": "云南",
						"value": 8875
					}, {
						"id": 23,
						"name": "贵州",
						"value": 7825
					}, {
						"id": 24,
						"name": "澳门",
						"value": 28565
					}, {
						"id": 25,
						"name": "广西",
						"value": 23845
					}, {
						"id": 26,
						"name": "广东",
						"value": 25025
					}, {
						"id": 27,
						"name": "重庆",
						"value": 22825
					}, {
						"id": 28,
						"name": "湖北",
						"value": 18225
					}, {
						"id": 29,
						"name": "湖南",
						"value": 21325
					}, {
						"id": 30,
						"name": "江西",
						"value": 19620
					}, {
						"id": 31,
						"name": "安徽",
						"value": 17826
					}, {
						"id": 32,
						"name": "福建",
						"value": 20833
					}, {
						"id": 33,
						"name": "浙江",
						"value": 22807
					}, {
						"id": 34,
						"name": "山西",
						"value": 9638
					} 
					]
				}]
			});
						
			_data.push({
				
				title: {
					text:'China Map'
				},
				subtitle: {
					text: 'sub title'
				}, 
				credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				tooltip: {
					"headerFormat": "{0}"
					, "pointFormat": "{0}"
					, "labelStyle": {
						color: 0xaaaaaa
					}
				},
				yAxis: {
					enabled: true,
					format: '{0}',
					ratenum: 5
				},
				legend: {
					//enabled: false
				},
				zoom: {
					enable: true,
					zoomRate: .5,
					zoomSpeed: .5
				},
				callBack:{
					initedCallback: "inited",
					hoverCallback: "hovered",
					clickCallback: "clicked"
				},
				series:[{
					name: "平均房价",
					mapType: "China",
					highColor: 0x2f7ed8,
					lowColor: 0xffffff,
					hoverColor: 0xbada55,
					data: [{
							"id": 1,
							"name": "辽宁",
							"value": 12601
						}, {
							"id": 2,
							"name": "河北",
							"value": 18697
						}, {
							"id": 3,
							"name": "北京",
							"value": 33288
						}, {
							"id": 4,
							"name": "上海",
							"value": 30825
						}, {
							"id": 5,
							"name": "江苏",
							"value": 18242
						}, {
							"id": 6,
							"name": "吉林",
							"value": 16863
						}, {
							"id": 7,
							"name": "黑龙江",
							"value": 10365
						}, {
							"id": 8,
							"name": "内蒙古",
							"value": 6325
						}, {
							"id": 9,
							"name": "青海",
							"value": 11952
						}, {
							"id": 10,
							"name": "山东",
							"value": 15650
						}, {
							"id": 11,
							"name": "天津",
							"value": 24829
						}, {
							"id": 12,
							"name": "宁夏",
							"value": 18865
						}, {
							"id": 13,
							"name": "陕西",
							"value": 15954
						}, {
							"id": 14,
							"name": "台湾",
							"value": 26559
						}, {
							"id":15 ,
							"name": "海南",
							"value": 21820
						}, {
							"id": 16,
							"name": "河南",
							"value": 17850
						}, {
							"id": 17,
							"name": "新疆",
							"value": 6825
						}, {
							"id": 18,
							"name": "甘肃",
							"value": 8843
						}, {
							"id": 19,
							"name": "香港",
							"value": 27825
						}, {
							"id": 20,
							"name": "西藏",
							"value": 7429
						}, {
							"id": 21,
							"name": "四川",
							"value": 15281
						}, {
							"id": 22,
							"name": "云南",
							"value": 8875
						}, {
							"id": 23,
							"name": "贵州",
							"value": 7825
						}, {
							"id": 24,
							"name": "澳门",
							"value": 28565
						}, {
							"id": 25,
							"name": "广西",
							"value": 23845
						}, {
							"id": 26,
							"name": "广东",
							"value": 25025
						}, {
							"id": 27,
							"name": "重庆",
							"value": 22825
						}, {
							"id": 28,
							"name": "湖北",
							"value": 18225
						}, {
							"id": 29,
							"name": "湖南",
							"value": 21325
						}, {
							"id": 30,
							"name": "江西",
							"value": 19620
						}, {
							"id": 31,
							"name": "安徽",
							"value": 17826
						}, {
							"id": 32,
							"name": "福建",
							"value": 20833
						}, {
							"id": 33,
							"name": "浙江",
							"value": 22807
						}, {
							"id": 34,
							"name": "山西",
							"value": 9638
						} 
					]
				}]
			});
			
			_data.push({
				title: {
					text:'World Map'
				},
				subtitle: {
					text: 'sub title'
				}, 
				credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				tooltip: {		
					"headerFormat": "{0}"
					, "pointFormat": "{0}"
				},
				yAxis: {
					enabled: true,
					format: '{0}',
					ratenum: 5
				},
				legend: {
					enabled: false
				},
				zoom: {
					enable: true,
					zoomRate: .5,
					zoomSpeed: .5
				},
				series:[{
					name: "defaultData",
					mapType: "World",
					highColor: 0x8ec72f,
					hoverColor: 0xaf72c8,
					defaultData: 10,
					data: [ ]
				}]
			});
			
			_data.push({
				
				title: {
				},
				subtitle: {
				}, 
				credits: {
					enabled: false
					, text: 'jchart.openjavascript.org'
					, href: 'http://fchart.openjavascript.org/'
				},
				tooltip: {
					"headerFormat": "{0}"
					, "pointFormat": "{0}"
				},
				yAxis: {
					enabled: true,
					format: '{0}',
					ratenum: 5
				},
				legend: {
					//enabled: false
				},
				zoom: {
					enable: true,
					zoomRate: .5,
					zoomSpeed: .5
				},
				callBack:{
					initedCallback: "inited",
					hoverCallback: "hovered",
					clickCallback: "clicked"
				},
				series:[{
					name: "平均房价",
					mapType: "China",
					highColor: 0xdc3500,
					lowColor: 0x24ec00,
					hoverColor: 0x2f7ed8,
					data: [{
						"id": 1,
						"name": "辽宁",
						"value": 12601
					}, {
						"id": 2,
						"name": "河北",
						"value": 18697
					}, {
						"id": 3,
						"name": "北京",
						"value": 33288
					}, {
						"id": 4,
						"name": "上海",
						"value": 30825
					}, {
						"id": 5,
						"name": "江苏",
						"value": 18242
					}, {
						"id": 6,
						"name": "吉林",
						"value": 16863
					}, {
						"id": 7,
						"name": "黑龙江",
						"value": 10365
					}, {
						"id": 8,
						"name": "内蒙古",
						"value": 6325
					}, {
						"id": 9,
						"name": "青海",
						"value": 11952
					}, {
						"id": 10,
						"name": "山东",
						"value": 15650
					}, {
						"id": 11,
						"name": "天津",
						"value": 24829
					}, {
						"id": 12,
						"name": "宁夏",
						"value": 18865
					}, {
						"id": 13,
						"name": "陕西",
						"value": 15954
					}, {
						"id": 14,
						"name": "台湾",
						"value": 26559
					}, {
						"id":15 ,
						"name": "海南",
						"value": 21820
					}, {
						"id": 16,
						"name": "河南",
						"value": 17850
					}, {
						"id": 17,
						"name": "新疆",
						"value": 6825
					}, {
						"id": 18,
						"name": "甘肃",
						"value": 8843
					}, {
						"id": 19,
						"name": "香港",
						"value": 27825
					}, {
						"id": 20,
						"name": "西藏",
						"value": 7429
					}, {
						"id": 21,
						"name": "四川",
						"value": 15281
					}, {
						"id": 22,
						"name": "云南",
						"value": 8875
					}, {
						"id": 23,
						"name": "贵州",
						"value": 7825
					}, {
						"id": 24,
						"name": "澳门",
						"value": 28565
					}, {
						"id": 25,
						"name": "广西",
						"value": 23845
					}, {
						"id": 26,
						"name": "广东",
						"value": 25025
					}, {
						"id": 27,
						"name": "重庆",
						"value": 22825
					}, {
						"id": 28,
						"name": "湖北",
						"value": 18225
					}, {
						"id": 29,
						"name": "湖南",
						"value": 21325
					}, {
						"id": 30,
						"name": "江西",
						"value": 19620
					}, {
						"id": 31,
						"name": "安徽",
						"value": 17826
					}, {
						"id": 32,
						"name": "福建",
						"value": 20833
					}, {
						"id": 33,
						"name": "浙江",
						"value": 22807
					}, {
						"id": 34,
						"name": "山西",
						"value": 9638
					} 
					]
				}]
			});
		}
	}
}
