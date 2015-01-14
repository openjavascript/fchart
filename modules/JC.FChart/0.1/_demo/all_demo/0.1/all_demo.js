;(function(define, _win) { 'use strict'; define( 'JC.FchartDemo', [ 'JC.BaseMVC' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.BaseMVC.html'>JC.BaseMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.FchartDemo.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JC.FchartDemo/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *  <h2>页面只要引用本脚本, 默认会处理 div class="js_compFchartDemo"</h2>
 *
 *  <h2>可用的 HTML attribute</h2>
 *
 *  <dl>
 *      <dt></dt>
 *      <dd><dd>
 *  </dl> 
 *
 * @namespace   JC
 * @class       FchartDemo
 * @extends     JC.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.FchartDemo 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JC.FchartDemo = FchartDemo;

    var globel = {};
    globel.chartType = 'column';

    function chartType( _selector ) {
        return this.attrProp( 'charttype' ) || 'column';
    }

    function FchartDemo( _selector ) {
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, FchartDemo ) ) 
            return JC.BaseMVC.getInstance( _selector, FchartDemo );

        JC.BaseMVC.getInstance( _selector, FchartDemo, this );

        this._model = new FchartDemo.Model( _selector );

        this._view = new FchartDemo.View( this._model );

        this._init();
    }

    /**
     * 初始化可识别的 FchartDemo 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of FchartDemoInstance}
     */
    FchartDemo.init = function( _selector ) {
        var _r = [];
        _selector = $( _selector || document );

        if( _selector.length ){
            if( _selector.hasClass( 'js_compFchartDemo' )  ) {
                _r.push( new FchartDemo( _selector ) );
            } else {
                _selector.find( 'div.js_compFchartDemo' ).each( function(){
                    _r.push( new FchartDemo( this ) );
                } );
            }
        }
        return _r;
    };

    JC.BaseMVC.build( FchartDemo );

    JC.f.extendObject( FchartDemo.prototype, {
        _beforeInit: function(){
            JC.log( 'FchartDemo _beforeInit', new Date().getTime() );
        }

        , _initHanlderEvent: function() {
            var _p = this;

            _p.on( 'inited', function() {
                
            } );
        }

        , _inited: function() {
            JC.log( 'FchartDemo _inited', new Date().getTime() );
            this.trigger( 'inited' );
        }

    } );

    FchartDemo.Model._instanceName = 'JCFchartDemo';
    JC.f.extendObject( FchartDemo.Model.prototype, {
        init: function(){
            JC.log( 'FchartDemo.Model.init:', new Date().getTime() );
        }

        , chartTypeDom: function() {

        }

        , chartView: function(){
            return this.selectorProp( 'chartview' );
        }
    } );

    JC.f.extendObject( FchartDemo.View.prototype, {
        init: function(){
            JC.log( 'FchartDemo.View.init:', new Date().getTime() );
        }

        , updateChart: function(){


        }
    } );

    _jdoc.ready( function(){
        var _insAr = 0;
        FchartDemo.autoInit
            && ( _insAr = FchartDemo.init() );
    } );

    return JC.FchartDemo;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
