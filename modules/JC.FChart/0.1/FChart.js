;(function(define, _win) { 'use strict'; define( [ 'JC.BaseMVC' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.BaseMVC.html'>JC.BaseMVC</a>
 *      , <a href='window.swfobject.html'>SWFObject</a>
 *      , <a href='window.json2'>JSON2</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.FChart.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JC.FChart/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *  <h2>页面只要引用本脚本, 默认会处理 div class="js_compFChart"</h2>
 *
 *  <h2>可用的 HTML attribute</h2>
 *
 *  <dl>
 *      <dt></dt>
 *      <dd><dd>
 *  </dl> 
 *
 * @namespace   JC
 * @class       FChart
 * @extends     JC.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.FChart 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JC.FChart = FChart;

    function FChart( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, FChart ) ) 
            return JC.BaseMVC.getInstance( _selector, FChart );

        JC.BaseMVC.getInstance( _selector, FChart, this );

        this._model = new FChart.Model( _selector );
        this._view = new FChart.View( this._model );

        this._init();

        JC.log( FChart.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 FChart 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of FChartInstance}
     */
    FChart.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'js_compFChart' )  ){
                    _r.push( new FChart( _selector ) );
                }else{
                    _selector.find( 'div.js_compFChart' ).each( function(){
                        _r.push( new FChart( this ) );
                    });
                }
            }
            return _r;
        };

    JC.BaseMVC.build( FChart );

    JC.f.extendObject( FChart.prototype, {
        _beforeInit:
            function(){
                JC.log( 'FChart _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                   var _data;
                    if( this.selector().attr( 'chartScriptData' ) ){
                        _data = JC.f.scriptContent( this._model.selectorProp( 'chartScriptData' ) );
                        _data = _data.replace( /\}[\s]*?,[\s]*?\}$/g, '}}');
                        alert( _data );
                        _data = eval( '(' + _data + ')' );
                        this.trigger( FChart.Model.UPDATE_CHART_DATA, [ _data ] );
                    }
                    _p._model.height() && _p.selector().css( { 'height': _p._model.height() } );

                    alert( 1 );
                });

                _p.on( FChart.Model.UPDATE_CHART_DATA, function( _evt, _data ){
                    _p.trigger( FChart.Model.CLEAR );
                    _p._view.update( _data );
                    _p._model.chartSize( { width: _p._model.width(), height: _p._model.height() } );
                });

                _p.on( FChart.Model.CLEAR, function( _evt ){
                    _p.trigger( FChart.Model.CLEAR_STATUS );
                    _p._view && _p._view.clear();
                    //_p._model.clear && _p._model.clear();
                });


                _p._model.chartSize( { width: _p._model.width(), height: _p._model.height() } );

            }

        , _inited:
            function(){
                JC.log( 'FChart _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }
        /**
         * 更新数据
         * @method update
         * @param   object  _data
         */
        , update:
            function( _data ){
                this.trigger( FChart.Model.UPDATE_CHART_DATA, _data );
                return this;
            }

    });

    FChart.Model._instanceName = 'JCFChart';

    FChart.Model.INS_COUNT = 1;
    FChart.Model.CLEAR = 'clear';
    FChart.Model.CLEAR_STATUS = 'clear_status';
    FChart.Model.UPDATE_CHART_DATA = 'update_data';

    JC.f.extendObject( FChart.Model.prototype, {
        init:
            function(){
                //JC.log( 'FChart.Model.init:', new Date().getTime() );
                this._gid = 'jchart_gid_' + ( FChart.Model.INS_COUNT++ );
                this.afterInit && this.afterInit();
            }
        /**
         * 保存图表数据
         */
        , data:
            function( _data ){
                typeof _data != 'undefined' && ( this._data = _data );
                return this._data;
            }

        , gid: function(){ return this._gid; }

        , chartType:
            function(){
            }
        /**
         * 图表宽度
         */
        , width:
            function(){
                if( typeof this._width == 'undefined' ){
                    this._width = this.selector().prop( 'offsetWidth' );
                    this.is( '[chartWidth]' ) && ( this._width = this.intProp( 'chartWidth' ) || this._width );
                }
                return this._width
            }
        /**
         * 图表高度
         */
        , height:
            function(){
                if( typeof this._height == 'undefined' ){
                    this._height = this.selector().prop( 'offsetHeight' ) || 400;
                    this.is( '[chartHeight]' ) && ( this._height = this.intProp( 'chartHeight' ) || this._height );
                }
                return this._height;
            }
        /**
         * 设置或保存图表的宽高
         */
        , chartSize:
            function( _setter ){
                typeof _setter != 'undefined' && ( this._chartSize = _setter );
                return this._chartSize;
            }
        /**
         * 图表画布
         */
        , stage:
            function(){
            }
        /**
         * 画布圆角弧度 
         */
        , stageCorner: function(){ return 18; }
        /**
         * 清除图表数据
         */
        , clear: 
            function(){
                var _p = this, _k;
                for( _k in _p ){
                    //JC.log( _k, JC.f.ts() );
                    if( /^\_/.test( _k ) ){
                        if( _k == '_selector' ) continue;
                        if( _k == '_gid' ) continue;
                        _p[ _k ] = undefined;
                    }
                }
                //JC.log( 'JChart.Base clear', JC.f.ts() );
                _p.afterClear && _p.afterClear();
            }
        /**
         * 清除图表状态
         */
        , clearStatus:
            function(){
            }
    });

    JC.f.extendObject( FChart.View.prototype, {
        init:
            function(){
                //JC.log( 'FChart.View.init:', new Date().getTime() );
            }
        /**
         * 图表高度
         */
        , width: function(){ return this._model.width(); }
        /**
         * 图表高度
         */
        , height: function(){ return this._model.height(); }
        /**
         * 图表画布
         */
        , stage: function(){ return this._model.stage(); }
        /**
         * 初始化的选择器
         */
        , selector:
            function(){
                return this._model.selector();
            }
        /**
         * 清除图表数据
         */
        , clear: 
            function(){
                var _p = this;
                if( !_p._model._stage ) return;
                $( _p._model._stage.canvas ).remove();
                _p._model._stage = undefined;
            }
        /**
         * 清除图表状态
         */
        , clearStatus:
            function(){
            }
        /**
         * 更新图表数据
         */
        , update: 
            function( _data ){
                var _p = this;
                _p.clear();
                _p._model.clear();
                _p._model.data( _data );
                _p.draw( _data );
            }
        /**
         * 渲染图表外观
         */
        , draw: 
            function( _data ){
                var _p = this
                    , _fpath =  JC.f.printf( _path, JChart.PATH ).replace( /[\/]+/g, '/' )
                    , _element = $( '#' + _p._model.gid() )
                    , _dataStr = JSON.stringify( _data ) 
                    ; 
                if( !$( '#' +  _p._model.gid() ).length ){
                    _element = $( JC.f.printf( '<span id="{0}"></span>', _p._model.gid() ) );
                    _element.appendTo( _p.selector() );
                }
                //JC.log( 'drawFlash', _fpath, _p._model.gid(), _p._model.width(), _p._model.height(), _element[0] );
                //JC.log( _dataStr );
                swfobject.embedSWF( 
                    _fpath
                    , _p._model.gid()
                    , _p._model.sourceWidth()
                    , _p._model.height()
                    , '10' 
                    , ''
                    , { 'testparams': 2, 'chart': _dataStr }
                    , { 'wmode': 'transparent' }
                );

            }
    });

    _jdoc.ready( function(){
        var _insAr = 0;
        FChart.autoInit
            && ( _insAr = FChart.init() )
            && $( '<h2>FChart total ins: ' 
                + _insAr.length + '<br/>' + new Date().getTime() + '</h2>' ).appendTo( document.body )
            ;
    });

    return JC.FChart;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
