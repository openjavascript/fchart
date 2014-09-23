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
					, href: 'http://jchart.openjavascript.org/'
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
				//path data
				series:[{
					mapType: "China",
					highColor: 0x2f7ed8,
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
		}
	}
}