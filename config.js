;(function(){
window.JC = window.JC|| {log:function(){}};
JC.PATH = JC.PATH || scriptPath();
/**
 * requirejs config.js for JC Chart Project
 */
window.requirejs && 
requirejs.config( {
    baseUrl: JC.PATH
    , urlArgs: 'v=20150127'
    , paths: {
        'JC.common': 'modules/JC.common/0.3/common'
        , 'JC.BaseMVC': 'modules/JC.BaseMVC/0.1/BaseMVC'

        , 'JC.FChart': 'modules/JC.FChart/0.1/FChart'

        , 'JC.FChartNormalData': 'modules/JC.FChartNormalData/0.1/FChart.NormalData'
        , 'JC.FChartCircleData': 'modules/JC.FChartCircleData/0.1/FChart.FChartCircleData'

        , 'jquery.mousewheel': 'modules/jquery.mousewheel/3.1.12/jquery.mousewheel'

        , 'plugins.json2': 'modules/JSON/2/JSON'
        , 'swfobject': 'modules/swfobject/2.3/swfobject'
        , 'SWFObject': 'modules/swfobject/2.3/swfobject'
    }
});
/**
 * 取当前脚本标签的 src路径 
 * @static
 * @return  {string} 脚本所在目录的完整路径
 */
function scriptPath(){
    var _sc = document.getElementsByTagName('script'), _sc = _sc[ _sc.length - 1 ], _path = _sc.getAttribute('src');
    if( /\//.test( _path ) ){ _path = _path.split('/'); _path.pop(); _path = _path.join('/') + '/'; }
    else if( /\\/.test( _path ) ){ _path = _path.split('\\'); _path.pop(); _path = _path.join('\\') + '/'; }
    return _path;
}
}());
