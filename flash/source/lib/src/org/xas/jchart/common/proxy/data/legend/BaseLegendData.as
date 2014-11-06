package org.xas.jchart.common.proxy.data.legend
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.view.components.LegendView.BaseLegendView;
	
	public class BaseLegendData
	{
		public function BaseLegendData() {
		}
		
		public function calLegendPosition( view:BaseLegendView ):void{
			
			var _config:Config = BaseConfig.ins as Config;
			var legend_x:Number, legend_y:Number;
			var _dir:Number = _config.legendDir;
			var _align:Number = _dir % 3;
			
			switch( Math.floor( _dir / 3 ) ) {
				case 0 : {/* legend在顶部 */
					legend_y = _config.c.minY - 2;
					_config.c.minY += view.height;
					break;
				}
				case 1 : {/* legend在右部 */
					legend_x = _config.c.maxX - view.width;
					_config.c.maxX -= view.width;
					break;
				}
				case 2 : {/* legend在下部 */
					legend_y = _config.c.maxY - view.height + 2;
					_config.c.maxY -= view.height - 2;
					break;
				}
				case 3 : {/* legend在左部 */
					legend_x = _config.c.minX;
					_config.c.minX += view.width;
					break;
				}
			}
			
			if( !legend_x ){
				switch( _align ){
					case 0 : {/* legend左对齐 */
						legend_x = _config.c.minX;
						break;
					}
					case 1 : {/* legend水平居中*/
						legend_x = _config.width / 2 - view.width / 2;
						break;
					}
					case 2 : {/* legend右对齐 */
						legend_x = _config.c.maxX - view.width;
						break;
					}
				}
			} else {
				switch( _align ){
					case 0 : {/* legend上对齐 */
						legend_y = _config.c.minY;
						break;
					}
					case 1 : {/* legend垂直居中*/
						legend_y = _config.c.maxY / 2 - view.height / 2;
						break;
					}
					case 2 : {/* legend下对齐 */
						legend_y = _config.c.maxY - view.height;
						break;
					}
				}
			}
			
			_config.c.legend = {
				x: legend_x
				, y: legend_y
			};
		}
	}
}