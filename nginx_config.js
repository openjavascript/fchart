;(function(){
window.JC = window.JC || {log:function(){}};
JC.PATH = JC.PATH || scriptPath();
//JC.PATH  = 'http://crm.360.cn/static/jc2/';           //test for crm online
//JC.PATH  = '/jc2_requirejs_master/';                  //test for jc2 master
//JC.PATH  = '/jc2_requirejs_master/deploy/normal/';    //test for jc2 deploy
/**
 * requirejs config.js for JC Project
 */

var _configMap = {
    'Base': [
        , '??'
        ,  'modules/JC.common/0.3/common.js'
        , ',modules/JC.BaseMVC/0.1/BaseMVC.js'
        , '?'
    ].join('')


    , 'JCChart': [
        , '??'
        , 'modules/JC.FChart/0.1/FChart.js'
        , ',modules/jquery.mousewheel/3.1.12/jquery.mousewheel.js'
        , '?'
    ].join('')

    , 'tpl': [
        , '??'
        , '?'
    ].join('')

};

window.requirejs && 
requirejs.config( {
    baseUrl: JC.PATH
    , urlArgs: 'v=' + new Date().getTime()
    , paths: {
        'JC.common': _configMap[ 'Base' ]
        , 'JC.BaseMVC': _configMap[ 'Base' ]

       
        , 'JC.FChart': _configMap[ 'JCChart' ]

        , 'jquery.mousewheel': _configMap[ 'JCChart' ]
        , 'jquery.cookie': 'modules/jquery.cookie/1.4.1/jquery.cookie'

        , 'json2': 'modules/JSON/2/JSON'
        , 'plugins.JSON2': 'modules/JSON/2/JSON'
        , 'plugins.json2': 'modules/JSON/2/JSON'

        , 'plugins.Aes': 'plugins/Aes/0.1/Aes'
        , 'plugins.Base64': 'plugins/Base64/0.1/Base64'
        , 'plugins.md5': 'plugins/md5/0.1/md5'

        , 'plugins.requirejs.domReady': 'plugins/requirejs.domReady/2.0.1/domReady'

        , 'plugins.swfobject': 'plugins/SWFObject/2.2/SWFObject'
        , 'swfobject': 'modules/swfobject/2.3/swfobject'
        , 'SWFObject': 'modules/swfobject/2.3/swfobject'

        , 'SWFUpload': 'modules/SWFUpload/2.5.0/SWFUpload'
        , 'swfupload': 'modules/SWFUpload/2.5.0/SWFUpload'
        , 'Raphael': 'modules/Raphael/latest/raphael'

        , 'artTemplate':  "modules/artTemplate/3.0/artTemplate"
        , 'store':  "modules/store/1.3.14/store"
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
