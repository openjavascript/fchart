
;(function(define, _win) { 'use strict'; define( 'demoData', [  ], function(){

/*
* 
* 数据字典说明：
* 
* datatype - 数据标识 与fchart数据设置项名称对应
* title - 数据展示说明 展示使用
* view - 数据html展示方式： input | radio 等
* name - 为view展示方式是radio的数据项提供name属性
* attr - 属性列表
* childrenList - 子数据项List
* valueList - 数据项可选项ist
* inputType - 数据项接受输入的数据类型 boolean | int | float 默认是string 转换为JSON时需要指明
* 
*/

var _demoData = {
    "chartList":[
        {
            "show": false
            , "name": "base"
            , "attr": [
                {
                    "datatype": "chart"
                    , "title": "图表类别 & 背景："
                    , "noIgnor": true
                    , "tips": "-说明-：控制图表类型和图表背景表现</br>" 
                            + "-注意-：该属性不能被禁用（缺省），但背景属性可以无值</br>" 
                            + "-对应属性-：<em class='green'>chart</em>"
                    , "childrenList": [
                        null
                        , {
                            "datatype": "bgAlpha"
                            , "title": "背景透明："
                            , "view": "input"
                        }
                        , {
                            "datatype": "bgColor"
                            , "title": "背景颜色："
                            , "view": "input"
                        }
                    ]
                }
                , {
                    "datatype": "series"
                    , "noIgnor": true
                    , "tips": "-说明-：图表展示的主要数据，可以点击按钮进行新增组，但是每组数据的“数据内容”个数应该跟“横坐标标签数据”个数对应。</br>" 
                            + "-注意-：该属性不能被禁用（缺省）</br>" 
                            + "-对应属性-：<em class='green'>series</em>"
                    , "title": "图表数据："
                    , "childrenList": [
                        {
                            "dataarray": true
                            , "remoteAdd": true
                            , "title": "数据组："
                            , "childrenList": [
                                {
                                    "datatype": "name"
                                    , "title": "数据名称："
                                    , "view": "input"
                                }
                                , {
                                    "datatype": "data"
                                    , "title": "数据内容："
                                    , "inputtype": "float"
                                    , "view": "textarea"
                                    , "defaultFill":"BAR_SERIES"
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "yAxis"
                    , "tips": "-说明-：图表展示的主要数据，每组数据内容个数应该跟“横坐标标签数据”个数对应。</br>" 
                            + "-注意-：该属性如果被禁用（缺省），则会使用默认属性</br>" 
                            + "-对应属性-：<em class='green'>yAxis</em>"
                    , "title": "纵坐标："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "yAxis"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                        , {
                            "datatype": "title"
                            , "title": "纵坐标标题："
                            , "childrenList": [
                                {
                                    "datatype": "enabled"
                                    , "title": "显示开关："
                                    , "view": "radio"
                                    , "name": "yAxistitle"
                                    , "inputtype": "boolean"
                                    , "valueList": [
                                        {
                                            "value": "true"
                                            , "title": "开"
                                            , "default": true
                                        }
                                        , {
                                            "value": "false"
                                            , "title": "关"
                                        }
                                    ]
                                }
                                , {
                                    "datatype": "text"
                                    , "title": "纵坐标副标题文字："
                                    , "view": "input"
                                }
                            ]
                        }
                        , {
                            "datatype": "autoRate"
                            , "title": "刻度浮动："
                            , "childrenList": [
                                {
                                    "datatype": "enabled"
                                    , "title": "显示开关："
                                    , "name": "autoRate"
                                    , "view": "radio"
                                    , "inputtype": "boolean"
                                    , "valueList": [
                                        {
                                            "value": "true"
                                            , "title": "开"
                                        }
                                        , {
                                            "value": "false"
                                            , "title": "关"
                                            , "default": true
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "xAxis"
                    , "title": "横坐标："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "xAxis"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                        , {
                            "datatype": "wordwrap"
                            , "title": "横坐标标签自动换行："
                            , "view": "radio"
                            , "name": "wordwrap"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "不换行"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "自动"
                                }
                            ]
                        }
                        , {
                            "datatype": "categories"
                            , "title": "横坐标标签数据(数组)："
                            , "view": "textarea"
                            , "defaultFill":"BAR_CATEGORIES"
                        }
                        , {
                            "datatype": "display"
                            , "title": "横坐标显示规则："
                            , "childrenList": [
                                {
                                    "datatype": "enabled"
                                    , "title": "横坐标全部显示："
                                    , "view": "radio"
                                    , "name": "display"
                                    , "inputtype": "boolean"
                                    , "valueList": [
                                        {
                                            "value": "true"
                                            , "title": "开"
                                            , "default": true
                                        }
                                        , {
                                            "value": "false"
                                            , "title": "关"
                                        }
                                    ]
                                }
                                , {
                                    "datatype": "mod"
                                    , "title": "横坐标显示规则："
                                    , "view": "input"
                                }
                                , {
                                    "datatype": "startIndex"
                                    , "title": "规则生效的坐标："
                                    , "view": "input"
                                }
                            ]
                        }
                        , {
                            "datatype": "rotation"
                            , "title": "标签倾斜："
                            , "childrenList": [
                                {
                                    "datatype": "enabled"
                                    , "title": "横坐标全部显示："
                                    , "view": "radio"
                                    , "name": "rotation"
                                    , "inputtype": "boolean"
                                    , "valueList": [
                                        {
                                            "value": "true"
                                            , "title": "开"
                                            , "default": true
                                        }
                                        , {
                                            "value": "false"
                                            , "title": "关"
                                        }
                                    ]
                                }
                                , {
                                    "datatype": "angle"
                                    , "title": "横坐标旋转角度："
                                    , "inputtype": "float"
                                    , "view": "input"
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "title"
                    , "title": "图表主标题："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "title"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                        , {
                            "datatype": "text"
                            , "title": "标题文字："
                            , "view": "input"
                        }
                    ]
                }
                , {
                    "datatype": "subtitle"
                    , "title": "副标题："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "subtitle"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                        , {
                            "datatype": "text"
                            , "title": "标题文字："
                            , "view": "input"
                        }
                    ]
                }
                , {
                    "datatype": "tooltip"
                    , "title": "气泡标签："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "legend"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                        , {
                            "datatype": "headerFormat"
                            , "title": "标题格式化："
                            , "view": "input"
                            , "default": "{0}"
                        }
                        , {
                            "datatype": "pointFormat"
                            , "title": "数据格式化："
                            , "view": "input"
                            , "default": "{0}"
                        }
                        , {
                            "datatype": "afterSerial"
                            , "title": "补充数据："
                            , "childrenList": [
                                {
                                    "dataarray": true
                                    , "remoteAdd": true
                                    , "title": "数据组："
                                    , "childrenList": [
                                        {
                                            "datatype": "name"
                                            , "title": "补充数据名称："
                                            , "view": "input"
                                        }
                                        , {
                                            "datatype": "data"
                                            , "title": "补充数据项："
                                            , "view": "textarea"
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "legend"
                    , "title": "图例："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "legend"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                        , {
                            "datatype": "direction"
                            , "title": "图例位置："
                            , "view": "radio"
                            , "name": "direction"
                            , "valueList": [
                                {
                                    "value": "1"
                                    , "title": "上"
                                    , "default": true
                                }
                                , {
                                    "value": "2"
                                    , "title": "上右（横向）"
                                }
                                , {
                                    "value": "3"
                                    , "title": "右上（竖向）"
                                }
                                , {
                                    "value": "4"
                                    , "title": "右"
                                }
                                , {
                                    "value": "5"
                                    , "title": "右下（竖向）"
                                }
                                , {
                                    "value": "8"
                                    , "title": "下右（横向）"
                                }
                                , {
                                    "value": "7"
                                    , "title": "下（横向）"
                                }
                                , {
                                    "value": "6"
                                    , "title": "下左（横向）"
                                }
                                , {
                                    "value": "11"
                                    , "title": "左下（竖向）"
                                }
                                , {
                                    "value": "10"
                                    , "title": "左（竖向）"
                                }
                                , {
                                    "value": "9"
                                    , "title": "左上（竖向）"
                                }
                                , {
                                    "value": "0"
                                    , "title": "上左（横向）"
                                }
                            ]
                        }
                        , {
                            "datatype": "interval"
                            , "title": "图例间隔："
                            , "view": "input"
                        }
                    ]
                }
                , {
                    "datatype": "dataLabels"
                    , "title": "图表数据显示："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "dataLabels"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                    , "default": true
                                }
                            ]
                        }
                        , {
                            "datatype": "format"
                            , "title": "格式化："
                            , "view": "input"
                            , "default": "{0}"
                        }
                    ]
                }
                , {
                    "datatype": "hline"
                    , "title": "图表背景竖线："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "hline"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "vline"
                    , "title": "图表背景竖线："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "vline"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "animation"
                    , "title": "动画效果："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "animation"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                        , {
                            "datatype": "duration"
                            , "title": "动画时间(秒)："
                            , "view": "input"
                            , "inputtype": "float"
                            , "default": 1
                        }
                    ]
                }
                , {
                    "datatype": "credits"
                    , "title": "角标链接："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "credits"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                    , "default": true
                                }
                            ]
                        }
                        , {
                            "datatype": "text"
                            , "title": "显示文字："
                            , "view": "input"
                            , "default": "fchart.openjavascript.org"
                        }
                        , {
                            "datatype": "duration"
                            , "title": "点击跳转(URL)："
                            , "view": "input"
                            , "default": "http://fchart.openjavascript.org/"
                        }
                    ]
                }
            ]
        }
        , {
            "name": "柱状图"
            , "default": true
            , "extend": "base"
            , "defaultData": "BAR_DATA"
            , "attr": [
                {
                    "childrenList": [
                        {
                            "datatype": "type"
                            , "title": "展现类型："
                            , "view": "radio"
                            , "name": "chart"
                            , "valueList": [
                                {
                                    "value": "bar"
                                    , "title": "竖向"
                                    , "default": true
                                }
                                , {
                                    "value": "vbar"
                                    , "title": "横向"
                                }
                                , {
                                    "value": "zbar"
                                    , "title": "竖向重叠"
                                }
                                , {
                                    "value": "stack"
                                    , "title": "横向重叠"
                                }
                            ]
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "hoverBg"
                    , "title": "数据选中效果："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "animation"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                    , "default": true
                                }
                            ]
                        }
                        , {
                            "datatype": "style"
                            , "title": "选中效果："
                            , "childrenList": [
                                {
                                    "datatype": "borderColor"
                                    , "title": "边框颜色："
                                    , "view": "input"
                                    , "default": "0xB4B4B4"
                                }
                                , {
                                    "datatype": "borderWidth"
                                    , "title": "边框宽度："
                                    , "inputtype": "float"
                                    , "view": "input"
                                    , "default": "2"
                                }
                                , {
                                    "datatype": "bgColor"
                                    , "title": "背景颜色："
                                    , "view": "input"
                                    , "default": "0xF0F0F0"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        , {
            "name": "折线图"
            , "extend": "base"
            , "defaultData": "LINE_DATA"
            , "attr": [
                {
                    "childrenList": [
                        {
                            "datatype": "type"
                            , "title": "展现类型："
                            , "view": "radio"
                            , "name": "chart"
                            , "valueList": [
                                {
                                    "value": "line"
                                    , "title": "竖向"
                                    , "default": true
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "series"
                    , "title": "图表数据："
                    , "childrenList": [
                        {
                            "dataarray": true
                            , "remoteAdd": true
                            , "title": "数据组："
                            , "childrenList": [
                                {
                                    "datatype": "name"
                                    , "title": "数据名称："
                                    , "view": "input"
                                }
                                , {
                                    "datatype": "data"
                                    , "title": "数据内容："
                                    , "inputtype": "float"
                                    , "view": "textarea"
                                    , "defaultFill":"BAR_SERIES"
                                }
                                , {
                                    "datatype": "dashStyle"
                                    , "title": "线段样式："
                                    , "view": "radio"
                                    , "name": "dashStyle"
                                    , "valueList": [
                                        {
                                            "value": "Solid"
                                            , "title": "直线"
                                            , "default": true
                                        }
                                        , {
                                            "value": "ShortDash"
                                            , "title": "短虚线"
                                        }
                                        , {
                                            "value": "Dash"
                                            , "title": "虚线"
                                        }
                                        , {
                                            "value": "LongDash"
                                            , "title": "长虚线"
                                        }
                                        , {
                                            "value": "ShortDot"
                                            , "title": "短点线"
                                        }
                                        , {
                                            "value": "Dot"
                                            , "title": "点线"
                                        }
                                    ]
                                }
                                , {
                                    "datatype": "point"
                                    , "title": "圆点样式："
                                    , "childrenList": [
                                        {
                                            "datatype": "enabled"
                                            , "title": "显示开关："
                                            , "view": "radio"
                                            , "name": "credits"
                                            , "inputtype": "boolean"
                                            , "valueList": [
                                                {
                                                    "value": "true"
                                                    , "title": "开"
                                                    , "default": true
                                                }
                                                , {
                                                    "value": "false"
                                                    , "title": "关"
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "group"
                    , "": ""
                    , "title": "区域分组："
                    ,"childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "credits"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                    , "default": true
                                }
                            ]
                        }
                        , {
                            "datatype": "data"
                            , "title": "分组内容："
                            , "view": "textarea"
                        }
                        , {
                            "datatype": "background"
                            , "title": "背景颜色："
                            , "childrenList": [
                                {
                                    "datatype": "colors"
                                    , "title": "颜色值组："
                                    , "view": "textarea"
                                }
                            ]
                        }
                        , {
                            "datatype": "label"
                            , "title": "文字样式："
                            , "view": "input"
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "plotOptions"
                    , "title": "颜色填充："
                    , "childrenList": [
                        {
                            "datatype": "area"
                            , "title": "区域设置："
                            , "childrenList": [
                                {
                                    "datatype": "fillColor"
                                    , "title": "颜色填充："
                                    , "childrenList": [
                                        {
                                            "datatype": "enabled"
                                            , "title": "显示开关："
                                            , "view": "radio"
                                            , "name": "credits"
                                            , "inputtype": "boolean"
                                            , "valueList": [
                                                {
                                                    "value": "true"
                                                    , "title": "开"
                                                }
                                                , {
                                                    "value": "false"
                                                    , "title": "关"
                                                    , "default": true
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "point"
                    , "title": "圆点样式："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "credits"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                    , "default": true
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                }
                            ]
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "lineBreak"
                    , "title": "断点处理："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "credits"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                    , "default": true
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        , {
            "name": "扇形图"
            , "extend": "base"
            , "defaultData": "PIE_DATA"
            , "attr": [
                {
                    "childrenList": [
                        {
                            "datatype": "type"
                            , "title": "展现类型："
                            , "view": "radio"
                            , "name": "chart"
                            , "valueList": [
                                {
                                    "value": "pie"
                                    , "title": "饼状图"
                                    , "default": true
                                }
                                , {
                                    "value": "dount"
                                    , "title": "管状图"
                                }
                            ]
                        }
                        , {
                            "datatype": "bgAlpha"
                            , "title": "背景透明："
                            , "view": "input"
                        }
                        , {
                            "datatype": "bgColor"
                            , "title": "背景颜色："
                            , "view": "input"
                        }
                    ]
                }
                , {
                    "datatype": "series"
                    , "title": "图表数据："
                    , "childrenList": [
                        {
                            "dataarray": true
                            , "remoteAdd": false
                            , "title": "数据组："
                            , "childrenList": [
                                {
                                    "datatype": "name"
                                    , "title": "数据名称："
                                    , "view": "input"
                                }
                                , {
                                    "datatype": "data"
                                    , "title": "数据内容："
                                    , "childrenList": [
                                        {
                                            "dataarray": true
                                            , "remoteAdd": true
                                            , "title": "数据组："
                                            , "childrenList": [
                                                {
                                                    "datatype": "name"
                                                    , "title": "数据名称："
                                                    , "view": "input"
                                                }
                                                , {
                                                    "datatype": "y"
                                                    , "inputtype": "float"
                                                    , "title": "数据内容："
                                                    , "view": "input"
                                                }
                                                , {
                                                    "datatype": "selected"
                                                    , "title": "默认选中："
                                                    , "onlyname": true
                                                    , "name": "selected"
                                                    , "view": "radio"
                                                    , "valueList": [
                                                        {
                                                            "value": "true"
                                                            , "title": "选中"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "angle"
                    , "title": "角度设置："
                    , "childrenList": [
                        {
                            "datatype": "offset"
                            , "title": "开始角度："
                            , "view": "input"
                            , "default": 270
                            , "inputtype": "float"
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "radius"
                    , "title": "管状图设置："
                    , "childrenList": [
                        {
                            "datatype": "width"
                            , "title": "管状图形宽度："
                            , "view": "input"
                            , "default": 20
                            , "inputtype": "float"
                        }
                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "innerRadius"
                    , "title": "内置圆形设置："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "innerRadius"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                    , "default": true
                                }
                            ]
                        }
                        , {
                            "datatype": "thickness"
                            , "title": "内置圆形宽度："
                            , "view": "input"
                            , "inputtype": "float"
                        }

                    ]
                }
                , {
                    "dataPrivate": true
                    , "datatype": "totalLabel"
                    , "title": "总数值标签："
                    , "childrenList": [
                        {
                            "datatype": "enabled"
                            , "title": "显示开关："
                            , "view": "radio"
                            , "name": "innerRadius"
                            , "inputtype": "boolean"
                            , "valueList": [
                                {
                                    "value": "true"
                                    , "title": "开"
                                }
                                , {
                                    "value": "false"
                                    , "title": "关"
                                    , "default": true
                                }
                            ]
                        }
                        , {
                            "datatype": "bgStyle"
                            , "title": "标签背景样式："
                            , "childrenList": [
                                {
                                    "datatype": "color"
                                    , "title": "背景颜色："
                                    , "view": "input"
                                    , "default": "0xff0000"
                                }
                                , {
                                    "datatype": "alpha"
                                    , "title": "透明程度："
                                    , "view": "input"
                                    , "default": "0.1"
                                }
                            ]
                        }
                        , {
                            "datatype": "labelStyle"
                            , "title": "标签文字样式："
                            , "view": "input"
                        }

                    ]
                }
            ]
        }
        , {
            "name": "混合图表"
            , "extend": "base"
            , "defaultData": "MIX_DATA"
            , "attr": [
                {
                    "childrenList": [
                        {
                            "datatype": "type"
                            , "title": "展现类型："
                            , "view": "radio"
                            , "name": "chart"
                            , "valueList": [
                                {
                                    "value": "mix"
                                    , "title": "混合图表"
                                    , "default": true
                                }
                            ]
                        }
                    ]
                }
                , {
                    "datatype": "series"
                    , "title": "图表数据："
                    , "childrenList": [
                        {
                            "dataarray": true
                            , "remoteAdd": true
                            , "title": "数据组："
                            , "childrenList": [
                                {
                                    "datatype": "type"
                                    , "title": "数据模型："
                                    , "view": "radio"
                                    , "valueList": [
                                        {
                                            "value": "bar"
                                            , "title": "柱状图"
                                            , "default": true
                                        }
                                        , {
                                            "value": "stack"
                                            , "title": "重叠柱状图"
                                        }
                                        , {
                                            "value": "line"
                                            , "title": "折线图"
                                        }
                                    ]
                                }
                                , {
                                    "datatype": "name"
                                    , "title": "数据名称："
                                    , "view": "input"
                                }
                                , {
                                    "datatype": "yAxis"
                                    , "title": "纵轴索引："
                                    , "view": "input"
                                }
                                , {
                                    "datatype": "data"
                                    , "title": "数据内容："
                                    , "inputtype": "float"
                                    , "view": "textarea"
                                }

                            ]
                        }
                    ]
                }
                , {
                    "datatype": "yAxis"
                    , "title": "纵坐标："
                    , "childrenList": [
                        {
                            "dataarray": true
                            , "remoteAdd": true
                            , "title": "数据组："
                            , "childrenList": [
                                {
                                    "datatype": "opposite"
                                    , "title": "显示位置："
                                    , "view": "radio"
                                    , "name": "opposite"
                                    , "inputtype": "boolean"
                                    , "valueList": [
                                        {
                                            "value": "true"
                                            , "title": "右侧显示"
                                        }
                                        , {
                                            "value": "false"
                                            , "title": "左侧显示"
                                            , "default": true
                                        }
                                    ]
                                }
                                , {
                                    "datatype": "title"
                                    , "title": "纵坐标标题："
                                    , "childrenList": [
                                        {
                                            "datatype": "text"
                                            , "title": "纵坐标标题文字："
                                            , "view": "input"
                                        }
                                        , {
                                            "datatype": "autoRate"
                                            , "title": "纵坐标取值规则："
                                            , "childrenList": [
                                                {
                                                    "datatype": "enabled"
                                                    , "title": "显示开关："
                                                    , "view": "radio"
                                                    , "name": "enabled"
                                                    , "inputtype": "boolean"
                                                    , "valueList": [
                                                        {
                                                            "value": "true"
                                                            , "title": "开"
                                                        }
                                                        , {
                                                            "value": "false"
                                                            , "title": "关"
                                                            , "default": true
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }, null, null
                    ]
                }
            ]
        }
    ]
    , "defaultFill": {
        "BAR_DATA" : {
            "chart": {
                "type": "bar", 
                "bgAlpha": "0", 
                "bgColor": "0xff0000"
            }, 
            "title": {
                "text": "Chart Title"
            }, 
            "subtitle": {
                "text": "Chart Subtitle"
            }, 
            "xAxis": {
                "categories": [ "111111", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "122222" ]
            }, 
            "yAxis": {
                "title": {
                    "enabled": true, 
                    "text": "(Vertical Title - 中文)"
                }
            }, 
            "series": [
                {
                    "name": "Temperature", 
                    "data": [ 10, 0, 3, 10, 20, 27, 28, 32, 30, 25, 15, 5 ]
                }, 
                {
                    "name": "Rainfall", 
                    "data": [ 20, 21, 20, 100, 200, 210, 220, 100, 20, 10, 20, 10 ]
                }
            ], 
            "credits": {
                "enabled": true, 
                "text": "fchart.openjavascript.org", 
                "href": "http://fchart.openjavascript.org/"
            }, 
            "dataLabels": {
                "enabled": true
            }, 
            "animation": {
                "enabled": true, 
                "duration": 0.75
            }, 
            "legend": {
                "enabled": true, 
                "direction": "7", 
                "interval": 10
            }
        }
        , "LINE_DATA" : {
            "chart": {
                "type": "line", 
                "bgAlpha": "0", 
                "bgColor": "0xff0000"
            }, 
            "title": {
                "text": "Chart Title"
            }, 
            "subtitle": {
                "text": "Chart Subtitle"
            }, 
            "xAxis": {
                "categories": [ "111111", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "122222" ]
            }, 
            "yAxis": {
                "title": {
                    "enabled": true, 
                    "text": "(Vertical Title - 中文)"
                }
            }, 
            "series": [
                {
                    "name": "Temperature", 
                    "data": [ 10, 0, 3, 10, 20, 27, 28, 32, 30, 25, 15, 5 ]
                }, 
                {
                    "name": "Rainfall", 
                    "data": [ 20, 21, 20, 100, 200, 210, 220, 100, 20, 10, 20, 10 ]
                }
            ], 
            "credits": {
                "enabled": true, 
                "text": "fchart.openjavascript.org", 
                "href": "http://fchart.openjavascript.org/"
            }, 
            "dataLabels": {
                "enabled": true
            }, 
            "animation": {
                "enabled": true, 
                "duration": 0.75
            }, 
            "legend": {
                "enabled": true, 
                "direction": "7", 
                "interval": 10
            }
        }
        , "PIE_DATA" : {
            "chart": {
                "type": "pie"
            }, 
            "title": {
                "text": "浏览器使用份额"
            }, 
            "subtitle": {
                "text": "for PC"
            }, 
            "series": [
                {
                    "name": "Browser share", 
                    "data": [
                        { "name": "Firefox", "y": 45 }, 
                        { "name": "IE", "y": 26.8 }, 
                        { "name": "Chrome", "y": 12.8, "selected": true }, 
                        { "name": "Safari", "y": 8.5 }, 
                        { "name": "Opera", "y": 6.2 }, 
                        { "name": "Others", "y": 0.7 }
                    ]
                }
            ] 
            , "angle": {
                "offset": 270
            }
            , "animation": {
                "enabled": true
            }
        }
        , "MIX_DATA" : {
            "chart": {
                "type": "mix"
            }, 
            "title": {
                "text": "日趋势"
            }, 
            "subtitle": {
                "text": "日趋势 subtitle"
            }, 
            "xAxis": {
                "categories": [ "2014-11-17", "2014-11-18", "2014-11-19", "2014-11-20", "2014-11-21" ], 
                "displayAll": {
                    "enabled": true
                }
            }, 
            "yAxis": [
                {
                    "title": {
                        "text": "test vtitle", 
                        "enabled": 1
                    }
                }, 
                {
                    "autoRate": {
                        "enabled": true
                    }, 
                    "title": {
                        "text": "test vtitle 1", 
                        "enabled": 1
                    }
                }, 
                {
                    "opposite": true, 
                    "title": {
                        "text": "test vtitle 2", 
                        "enabled": 1
                    }
                }, 
                {
                    "opposite": true, 
                    "autoRate": {
                        "enabled": true, 
                        "rateUp": 0, 
                        "maxOffset": 0.1, 
                        "minOffset": 0.1
                    }, 
                    "title": {
                        "text": "test vtitle 3", 
                        "enabled": 1
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
                    "data": [ 4039, 2828, 1567, 5531, 3544 ], 
                    "style": {
                        "stroke": "#ff7100"
                    }
                }, 
                {
                    "type": "bar", 
                    "name": "MG名爵1", 
                    "yAxis": 1, 
                    "data": [ 5039, 3828, 2567, 6531, 4544 ], 
                    "style": {
                        "stroke": "#ff7100"
                    }
                }, 
                {
                    "type": "line", 
                    "name": "北汽", 
                    "yAxis": 2, 
                    "data": [ 81018, 80207, 84018, 85313, 84018 ], 
                    "style": {
                        "stroke": "#ff7100"
                    }, 
                    "pointStyle": { }
                }, 
                {
                    "type": "line", 
                    "name": "北汽1", 
                    "yAxis": 3, 
                    "data": [ 34018, 41018, 40207, 34018, 25313 ], 
                    "style": {
                        "stroke": "#ff7100"
                    }, 
                    "pointStyle": { }
                }
            ], 
            "legend": {
                "enabled": true, 
                "direction": "TOP_RIGHT", 
                "margin": {
                    "bottom": 0, 
                    "y": -5
                }
            }
        }
    }
}
    return _demoData;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
