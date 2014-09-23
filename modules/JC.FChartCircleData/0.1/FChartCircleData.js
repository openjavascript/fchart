;(function(define, _win) { 'use strict'; define( [ 'JC.FChartNormalData' ], function(){
/**
 * JChart 图表数据( 曲线图、环状图、管状图 )
 *
 * <p><a href='https://github.com/openjavascript/fchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://fchart.openjavascript.org/docs_api/classes/JC.FChartCircleData.html' target='_blank'>API docs</a>
 *  </p>
 * <h2></h2>
 * <dl>
 *    <dt></dt>
 *    <dd><dd>
 * </dl> 
 *
 * @namespace   JC
 * @class       FChartCircleData
 * @extends     JC.FChartNormalData
 * @constructor
 * @static
 * @version dev 0.1 2014-08-28
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
<h2>显示 两块数据[ 曲线图、环状图、管状图 ]的图表数据</h2>
<pre>{
    chart: {
        type: 'pie' 
    } 

    , series:[{
        data: [
            ['全体覆盖率',   60],
            ['样本覆盖率',   20]
        ]
    }]
    
    , colors: [ 
        0x00ABEF
        , 0xFF6297
        
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
}</pre>
 */

    JChart.FChartCircleData = JC.f.cloneObject( JC.FChartNormalData, {
        /**
         * 展现的数据
         * <br />series 数组只有索引0数据
         * <br />series 索引0 里的 data 应该是个两维数组, 或者 数组里的数据为 object: { name: String, y: Number }
         * @property    series
         * @type        {Array of Object}
         * @default     null
         * @example
         * 
<pre>series:[{
    data: [
        ['全体覆盖率',   60],
        ['样本覆盖率',   20]
    ]
}]</pre>
<pre>series:[{
    data: [
        { name:'全体覆盖率',   y:60],
        [ name:'样本覆盖率',   y:20]
    ]
}]</pre>

         */
        series: null
        /**
         * 图表数值是否按总数值=100划分百分比
         * @property    isPercent
         * @type        {Boolean}
         * @default     false
         * @example 
         *  isPercent: false
         */
        , isPercent: false
        /**
         * 设置圆环的环宽
         * <br /> 仅对 NDount 生效
         * @property radiusStep
         * @default 10
         * @type int
         */
        , radiusStep: 10
        /**
         * 不同 圆环图的设置数据
         * @property plotOptions
         * @type {Object}
         */
        , plotOptions: {
            /**
             * NDount 的设置数据
             * @property plotOptions.ndount
             * @type {Object}
             */
            ndount: {
                /**
                 * NDount的圆环中的文本显示设置
                 * @property plotOptions.ndount.cdataLabels
                 * @type {Object}
                 */
                cdataLabels: {
                    /**
                     * 是否显示 NDount的圆环中的文本
                     * @property plotOptions.ndount.cdataLabels.enabled
                     * @type Boolean
                     * @default false
                     */
                    enabled: false
                }
            }
        }

    });

    return FChartCircleData;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
