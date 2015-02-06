;(function(define, _win) { 'use strict'; define( 'JC.FchartDemo', [ 'demoData', 'JC.BaseMVC', 'JC.FChart', 'JC.Tips' ], function( _demoData ){
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
        }

        , _initHanlderEvent: function() {
            var _p = this
                , _model = _p._model
                , _Model = FchartDemo.Model
                , _selector = _model.selector();

            _p.on( 'inited', function() {

                _selector.on( 
                    'click'
                    , '.' + _Model.FCHART_DATAARRAY_ADDBTN
                    , function( e ) {
                        e.preventDefault();

                        _p._view.addDataArrayTpl( 1, $( this ).closest( 'div[' + _Model.DATA_FLAG + ']' )
                            .find( '.' + _Model.FCHART_DATAARRAY_CLASSNAME ).eq( 0 ) );
                    }
                );
                
                _selector.on( 'change', 'input,textarea', function( e ) {
                    if ( _model.updateLock() ){
                        return;
                    }

                    var _target = $( this )
                        , _parent = _target.closest( '[class^="' + _Model.FCHART_CHANGEVIEW_CLASSNAME + '"]' );

                    if( _parent.is( '[class$="' + _Model.FCHART_CHANGEVIEW_FORM_TYPE + '"]' ) ){
                        _p._view.updateChart( _model.getChartData() );
                    } else {
                        _p._view.initAndFillData( _model.getCodeViewData() );
                    }
                } );

                _selector.on( 'hover', 'a.' + _Model.FCHART_ATTRFLOOR_HELP, function( e ) {
                    e.preventDefault();

                    
                } );

                $( 'a.' + _Model.FCHART_ATTRFLOOR_FORBIDE + ', a.' + _Model.FCHART_ATTRFLOOR_USE ).hover( function( e ) {
                    e.preventDefault();

                    $( this ).stop().animate( { 'width': '160px' } );
                }, function( e ){
                    e.preventDefault();

                    $( this ).stop().animate( { 'width': '90px' } );
                } );

                _selector.on( 'click', '.fchart-fl2 h2 span, .' + _Model.FCHART_ATTRFLOOR_HELP, function( e ) {
                    e.preventDefault();

                    $( this ).parent().prev().click();
                } );

                _selector.on( 'click', 'a.' + _Model.FCHART_ATTRFLOOR_FORBIDE, function( e ) {
                    e.preventDefault();

                    $( this ).closest( '.fchart-fl2' ).addClass( _Model.FCHART_ATTRFLOOR_IGNOR );
                    _selector.find( 'textarea' ).eq( 0 ).change();
                } );

                _selector.on( 'click', 'a.' + _Model.FCHART_ATTRFLOOR_USE, function( e ) {
                    e.preventDefault();

                    $( this ).closest( '.fchart-fl2' ).removeClass( _Model.FCHART_ATTRFLOOR_IGNOR );
                    _selector.find( 'textarea' ).eq( 0 ).change();
                } );

                _selector.on( 'click', 'a.' + _Model.FCHART_ATTRFLOOR_CTRL, function( e ) {
                    e.preventDefault();

                    _p._view.displayAttrCtr( $( this ) );
                } );

                _selector.on( 'click', 'a.' + _Model.FCHART_ATTRFLOOR_BTN, function( e ) {
                    e.preventDefault();

                    _p._view.displayAttr( $( this ) );
                } );

                _selector.on( 'click', 'a[' + _Model.FCHART_TABBAR_CHANGEBTN_FLAG + ']', function( e ) {
                    e.preventDefault();

                    var _target = $( this )
                        , _class = _Model.FCHART_TABBAR_CHANGEBTN_SELECTED;
                    _target.removeClass( _class ).siblings().addClass( _class );

                    _p._view.changeView( _target );
                } );

                _selector.on( 'click', 'a[' + _Model.FCHART_TABBAR_TARGETBTN_FLAG + ']', function( e ) {
                    e.preventDefault();


                    var _target = $( this );
                    _target.addClass( _Model.FCHART_TABBAR_TARGETBTN_SELECTED )
                        .siblings( '.' + _Model.FCHART_TABBAR_TARGETBTN_SELECTED )
                        .removeClass( _Model.FCHART_TABBAR_TARGETBTN_SELECTED );
                    _p._view.changeChartForm( 
                        _target.attr( _Model.FCHART_TABBAR_TARGETBTN_FLAG )
                        , _p._model.getDefaultData( _target.attr( _Model.FCHART_TABBAR_DEFAULT_DATA_FLAG ) )
                    );
                    console.log( _target.attr( _Model.FCHART_TABBAR_DEFAULT_DATA_FLAG ) );
                } );
            } );
        }

        , _inited: function() {
            this.trigger( 'inited' );
        }

    } );

    var _tmlModel = FchartDemo.Model;

    _tmlModel._instanceName = 'JCFchartDemo';
    _tmlModel.UPDATE_LOCK = false;
    _tmlModel.DATA_FLAG = 'datatype';
    _tmlModel.DATAARRAY_FLAG = 'dataarray';

    _tmlModel.FCHART_TABBAR_CLASSNAME = 'fchart-tabBar';
    _tmlModel.FCHART_TABBAR_CHANGE_CLASSNAME = 'fchart-tabBar-changeBtn';
    _tmlModel.FCHART_TABBAR_CHANGEBTN_FLAG = 'targetchange';
    _tmlModel.FCHART_TABBAR_CHANGEBTN_SELECTED = 'fchart-changeBtn-selected';
    _tmlModel.FCHART_TABBAR_TARGETBTN_FLAG = 'targetindex';
    _tmlModel.FCHART_TABBAR_DEFAULT_DATA_FLAG = 'defaultdata';
    _tmlModel.FCHART_TABBAR_TARGETBTN_SELECTED = 'fchart-targetBtn-selected';
    _tmlModel.FCHART_TABBAR_CHANGECODE_TITLE = '代码模式';
    _tmlModel.FCHART_TABBAR_CHANGEFORM_TITLE = '表单模式';

    _tmlModel.FCHART_ATTRFLOOR_IGNOR = 'fchart-attrfloor-ignor';
    _tmlModel.FCHART_ATTRFLOOR_CTRL = 'fchart-attrfloor-ctrl';
    _tmlModel.FCHART_ATTRFLOOR_HELP = 'fchart-attrfloor-help';
    _tmlModel.FCHART_ATTRFLOOR_FORBIDE = 'fchart-attrfloor-forbide';
    _tmlModel.FCHART_ATTRFLOOR_USE = 'fchart-attrfloor-use';
    _tmlModel.FCHART_ATTRFLOOR_BTN = 'fchart-attrfloor-btn';
    _tmlModel.FCHART_ATTRFLOOR_CLOSE = 'fchart-attrfloor-close';
    _tmlModel.FCHART_ATTRFLOOR_OPEN = 'fchart-attrfloor-open';

    _tmlModel.FCHART_CHARTVIEW_CLASSNAME = 'fchart-chartview';
    _tmlModel.FCHART_CHANGEVIEW_CLASSNAME = 'fchart-changeview';
    _tmlModel.FCHART_CHANGEVIEW_FORM_TYPE = 'form';
    _tmlModel.FCHART_CHANGEVIEW_CODE_TYPE = 'code';
    _tmlModel.NOW_SELECTED_CLASSNAME = 'fchart-nowSelect';
    _tmlModel.FCHART_DATAARRAY_CLASSNAME = 'fchart-dataarray';
    _tmlModel.FCHART_DATAARRAY_CONTROL = 'fchart-dataarray-control';
    _tmlModel.FCHART_DATAARRAY_ADDBTN = 'fchart-dataarray-addbtn';

    _tmlModel.FCHART_FLOOR_NUM = 'fchart-fl';

    _tmlModel.FCHART_TIPS_CLASSNAME = 'tips_bd';

    JC.f.extendObject( FchartDemo.Model.prototype, {
        init: function(){ }

        , updateLock: function( flag ) {
            if( typeof flag == 'undefined' ){
                return FchartDemo.Model.UPDATE_LOCK;
            } else {
                FchartDemo.Model.UPDATE_LOCK = flag;
            }
        }

        , getChartData: function() {
            var _data = {}
                , _dataDl = this.selector().find( '.' + FchartDemo.Model.NOW_SELECTED_CLASSNAME ).eq( 0 );
            return this.getDataFromJQDom( _dataDl.children( 'dd' ) );
        }

        , getDataFromJQDom: function( _jqDom ) {
            var _p = this
                , _childDom
                , _dataChildren = _jqDom.children( '[' + FchartDemo.Model.DATA_FLAG + ']' )
                , _dataArray = _jqDom.children( '[' + FchartDemo.Model.DATAARRAY_FLAG + ']' )
                , _res;

            if( _dataArray.length > 0 ) {
                _res = [];
                $.each( _dataArray, function( _ix, _dom ){
                    _res[ _ix ] = _p.getDataFromJQDom( $( _dom ) );
                } );
            } else {
                if( _dataChildren.length > 0 ) {
                    _res = {};
                    $.each( _dataChildren, function( _ix, _dom ){
                        _childDom = $( _dom );
                        if( !_childDom.hasClass( FchartDemo.Model.FCHART_ATTRFLOOR_IGNOR ) ){
                            _res[ _childDom.attr( FchartDemo.Model.DATA_FLAG ) ] = _p.getDataFromJQDom( _childDom );
                        }
                    } );
                } else {
                    var _content = _jqDom.find( 'input' );
                    var _inputtype = _jqDom.attr( 'inputtype' );
                    if( _content.length > 0 ){
                        _res = _content.is( ':radio' ) ? _jqDom.find( 'input[type="radio"]:checked' ).val() : _content.val();
                        if( _inputtype != '' ) {
                            switch( _inputtype ){
                                case 'int' : 
                                case 'float' : {
                                    _res = +_res;
                                    break;
                                }
                                case 'boolean' : {
                                    _res = _res == 'true' ? true : false;
                                    break;
                                }
                            }
                        }
                    } else {
                        _content = _jqDom.find( 'textarea' ).val();
                        _res = _content.replace(/(\s+)|\"|\'|\[|\]/g, '').split(',')
                        if( _inputtype == 'float' ){
                            $.each( _res, function( _i, _item ){
                                _res[ _i ] = +_item;
                            } );
                        }
                    }

                }
            }
            return _res;
        }

        ,getFillDataByType: function( _type ){
            var _data = _demoData.defaultFill;
            return _data[ _type ] || '';
        }

        , getChartView: function() {
            return this.attrProp( 'chartview' );
        }

        , getCodeViewTextArea: function() {
            return this.selector().find( '[class="' + FchartDemo.Model.FCHART_CHANGEVIEW_CLASSNAME 
                + '-' + FchartDemo.Model.FCHART_CHANGEVIEW_CODE_TYPE + '"]' ).children( 'textarea' );
        }

        , getJCFlash: function() {
            return JC.BaseMVC.getInstance( this.getChartView(), JC.FChart );
        }

        , getChartDefaultData: function() {
            return this.selectorProp( 'chartDefaultData' );
        }

        , getChartDataFromScript: function() {
            return this.changeStringToJson( this.getChartDefaultData().html() );
        }

        , changeStringToJson: function( _string ){
            return eval( '(' + _string + ')' );
        }

        , getCodeViewData: function(){
            return  this.changeStringToJson( this.getCodeViewTextArea().val() );
        }

        , getDefaultData: function( _dataName ){
            return _demoData.defaultFill[ _dataName ];
        }

    } );

    JC.f.extendObject( FchartDemo.View.prototype, {
        init: function() { 
            this.initForm();
        }

        , initForm: function() {
            var _p = this
                , _model = _p._model
                , _commonUtil = JC.common
                , _Model = FchartDemo.Model
                , _formDom = _model.selector()
                , _data = _demoData
                , _extendName
                , _extendObj

                , _tabBarWrapperTpl = '<div class="{0}">{1}{2}</div>'
                , _tabItemTpl = '<a href="#" targetindex="{0}" class="{2}" defaultdata="{3}" >{1}</a>'
                , _tabChangeBtnTpl = '<p class="' + _Model.FCHART_TABBAR_CHANGE_CLASSNAME + '"><a href="#" ' 
                    + _Model.FCHART_TABBAR_CHANGEBTN_FLAG + '="' + _Model.FCHART_CHANGEVIEW_FORM_TYPE + '" class="' 
                    + _Model.FCHART_TABBAR_CHANGEBTN_SELECTED + '">' + _Model.FCHART_TABBAR_CHANGEFORM_TITLE 
                    + '</a><a href="#" ' + _Model.FCHART_TABBAR_CHANGEBTN_FLAG + '="' + _Model.FCHART_CHANGEVIEW_CODE_TYPE 
                    + '">' + _Model.FCHART_TABBAR_CHANGECODE_TITLE + '</a></p>'
                , _chartViewWrapperTpl = '<div class="{0}"><div class={1}>{2}</div><div class="{3}"><textarea></textarea></div></div>'
                , _chartDlTpl = '<dl class="{0}"><dt><h{1}>{2}{4}</h{1}></dt><dd>{3}</dd></dl>'
                , _attrBtn = '<a href="#" class="' + _Model.FCHART_ATTRFLOOR_CTRL + '">展开全部属性节点</a>'

                , _tabBarContentList = []
                , _chartDlContentList = []
                , _chartDDContent
                , _floorNum
                , _relNum = -1;

            $.each( _data.chartList, function( _idx, _chartData ) {
                if( _chartData.show == false ){
                    return;
                }
                _relNum++;

                _extendName = _chartData['extend'];
                $.each( _data.chartList, function( _i, _c ) {
                    if( _c.name == _extendName ){
                        _extendObj = _c;
                    }
                } );

                var _publicList = [], _privateList = [];
                $.each( _chartData.attr, function( _i, _c ){
                    if( _c['dataPrivate'] ) {
                        _privateList.push( _c );
                    } else {
                        _publicList.push( _c );
                    }
                } );

                // _chartData.attr = $.merge( _chartData.attr || [], _extendObj.attr );
                _chartData.attr = $.merge( $.extend( true, [], _extendObj.attr, _publicList || {} ), _privateList );

                _chartDDContent = '';
                _floorNum = 1;
                /* 组装tab */
                _tabBarContentList[ _relNum ] = 
                    _commonUtil.printf( 
                        _tabItemTpl
                        , _relNum
                        , _chartData.name
                        , _chartData.default ?  _Model.FCHART_TABBAR_TARGETBTN_SELECTED : ''
                        , _chartData.defaultData
                    );

                /* 组装dl */
                _chartData.attr && $.each( _chartData.attr, function( _cidx, _item ){
                    _chartDDContent += _p.spellDom( _item, _floorNum + 1 );
                } );

                _chartDlContentList[ _relNum ] = _commonUtil.printf( 
                    _chartDlTpl
                    , _chartData.default ? _Model.NOW_SELECTED_CLASSNAME : ''
                    , _floorNum
                    , _chartData.name
                    , _chartDDContent
                    , _attrBtn
                );
            } );

            _formDom.append(
                /* add tabBar */
                _commonUtil.printf( 
                    _tabBarWrapperTpl
                    , FchartDemo.Model.FCHART_TABBAR_CLASSNAME
                    , _tabBarContentList.join('') 
                    , _tabChangeBtnTpl
                )

                /* add chartView */
                + _commonUtil.printf( 
                    _chartViewWrapperTpl
                    , _Model.FCHART_CHARTVIEW_CLASSNAME + ' '
                        + _Model.FCHART_TIPS_CLASSNAME
                    , _Model.FCHART_CHANGEVIEW_CLASSNAME + '-' 
                        + _Model.FCHART_CHANGEVIEW_FORM_TYPE
                    , _chartDlContentList.join('')
                    , _Model.FCHART_CHANGEVIEW_CLASSNAME + '-' 
                        + _Model.FCHART_CHANGEVIEW_CODE_TYPE
                )
            );

            this.initAndFillData( _model.getChartDataFromScript() );

            this.fillChartDataToView( _model.getChartDefaultData().html() );
        }

        , spellDom: function( _data, _floorNum ) {

            if( !_data ){
                return '';
            }

            var _p = this
                , _model = _p._model
                , _commonUtil = JC.common
                , _Model = FchartDemo.Model

                , _titleTmp
                , _contentTmp = ''
                , _contentTpl = '';

            if( _data.childrenList ) {

                var _dataarrayTmp;
                var _isFloor2 = _floorNum == 2;

                _titleTmp = _commonUtil.printf(
                    '{2}<h{0} class="clearfix"><span>{1}</span>{3}{4}</h{0}>'
                    , _floorNum
                    , _data.title 
                    , _isFloor2 ? '<a href="#" class="' + _Model.FCHART_ATTRFLOOR_BTN + ' ' 
                        + _Model.FCHART_ATTRFLOOR_CLOSE + '"></a>' : ''
                    , _data.tips ? '<a href="#" class="' + _Model.FCHART_ATTRFLOOR_HELP + '" title="' 
                        + ( 
                            _data.tips.replace( /(“[\/w\u4e00-\u9fa5]+”)/g, '<em class=\'yellow\'>$1</em>' )
                                      .replace( /(\-[\/w\u4e00-\u9fa5]+\-\：)/g, '<em class=\'blue\'>$1</em>' )
                        ) + '" ></a>' : ''
                    , !_data.noIgnor && _isFloor2 ? ( '<a href="#" class="' + _Model.FCHART_ATTRFLOOR_FORBIDE + '">属性已启用，点击禁用</a>'
                        + '<a href="#" class="' + _Model.FCHART_ATTRFLOOR_USE + '">属性已禁用，点击启用</a>' ) : ''
                );

                $.each( _data.childrenList, function( _idx, _item ){
                    _contentTmp += _p.spellDom( _item, _floorNum + 1 );
                } );

                if( _data[ _Model.DATAARRAY_FLAG ] ){
                    _contentTpl = ( _data[ 'remoteAdd' ] ? '<p class="' + _Model.FCHART_DATAARRAY_CONTROL + '"><a class="' 
                        + _Model.FCHART_DATAARRAY_ADDBTN + '" href="#">点击新增数据组</a></p>' : '' ) 
                        + '<div class="{0} ' + _Model.FCHART_DATAARRAY_CLASSNAME + ' ' + ( _data[ 'remoteAdd' ] ? 'fchart-remotedata' : '' ) 
                        + '" ' + _Model.DATA_FLAG + '="{1}" ' + _Model.DATAARRAY_FLAG + '="true" ' + ( _data.noIgnor ? 'noIgnor' : '' ) + ' >{2}{3}</div>'
                } else {
                    _contentTpl = '<div class="{0} " ' + _Model.DATA_FLAG + '="{1}" ' + ( _data.noIgnor ? 'noIgnor' : '' ) + ' >{2}{3}</div>'
                }
            } else {
                _titleTmp = _commonUtil.printf ( '<label>{0}</label>', _data.title );
                switch( _data.view ) {
                    case 'radio': {
                        var _name = _data.name + new Date().getTime() + Math.random();
                        _data.valueList && $.each( _data.valueList, function( _idx, _item ) {
                            _contentTmp += _commonUtil.printf( 
                                '<label><input type="radio" name="{0}" value="{1}" {2} />{3}</label>'
                                , _name
                                , _item.value
                                , _item.default ? 'checked="checked" defaultData="true"' : ''
                                , _item.title 
                            );
                        } );
                        break;
                    }
                    case 'input': {
                        _contentTmp = '<input type="text" value="' + ( _data.default || "" ) + '" />';
                        break;
                    }
                    case 'textarea': {
                        _contentTmp = '<textarea ></textarea>';
                        break;
                    }
                }
                _contentTpl = '<div class="{0}" ' + _Model.DATA_FLAG + '="{1}" inputtype="{4}" {5} >{2}{3}</div>';
            }

            return _commonUtil.printf( 
                _contentTpl
                , _Model.FCHART_FLOOR_NUM + _floorNum
                , _data[ _Model.DATA_FLAG ]
                , _titleTmp
                , _contentTmp
                , _data.inputtype ? _data.inputtype : ''
                , _data.onlyname ? 'onlyname="true"' : ''
            );
        }

        , initAndFillData:function( _data, _targetDom ) {
            var _p = this
                , _model = this._model
                , _Model = FchartDemo.Model
                , _selector = _model.selector();

            _selector.find( 'div.fchart-fl2:not([noIgnor])' ).addClass( _Model.FCHART_ATTRFLOOR_IGNOR );

            this.fillChartDataToForm( _data, _targetDom );
        }

        , fillChartDataToForm: function( _data, _targetDom ) {

            var _p = this
                , _model = this._model
                , _Model = FchartDemo.Model
                , _dataType
                , tmpDom;

            _targetDom = _targetDom || _model.selector();

            _targetDom.hasClass( _Model.FCHART_ATTRFLOOR_IGNOR ) 
                && _targetDom.removeClass( _Model.FCHART_ATTRFLOOR_IGNOR );

            _dataType = Object.prototype.toString.apply( _data );

            if( _dataType.indexOf( 'Object' ) > 0 ){/* 类型是object 则还有下级 递归 */
                for( var _attr in _data ) {
                    _p.fillChartDataToForm( 
                        _data[ _attr ]
                        , _targetDom.find( '[ datatype="' + _attr + '" ]' ) 
                    );
                }
            } else if( _dataType.indexOf( 'Array' ) > 0 ) {
                tmpDom = _targetDom.find( '.' + _Model.FCHART_DATAARRAY_CLASSNAME );
                if( tmpDom.length > 0 ) {
                    _p.addDataArrayTpl( _data.length, tmpDom.eq( 0 ), true );
                    $.each( _data, function( _idx, _item ) {
                        _p.fillChartDataToForm( 
                            _item
                            , _targetDom.find( '.' + _Model.FCHART_DATAARRAY_CLASSNAME ).eq( _idx )
                        );
                    } );
                } else {
                    _targetDom.find( 'textarea' ).text( _data );
                }
            } else if( _dataType.indexOf( 'Boolean' ) > 0 || _data == 'true' || _data == 'false' ) {
                _targetDom.find( 'input[type="radio"][value="' + _data + '"]' )
                    .prop( 'checked', 'checked' );
            } else if( _dataType.indexOf( 'String' ) > 0 || _dataType.indexOf( 'Number' ) ) {
                tmpDom = _targetDom.find( 'input[type="text"]' );

                if( tmpDom.length > 0 ){
                    tmpDom.val( _data )
                } else {
                    _targetDom.find( 'input[type="radio"][value="' + _data + '"]' )
                        .prop( 'checked', 'checked' );
                }
            }
        }

        /* 将数据复制到textarea */
        , fillChartDataToView: function( _data ) {
            // console.dir( _data );
            var _p = this
                , _model = this._model;

            _model.getCodeViewTextArea().val( _data );
        }

        /* 添加数据组的tpl */
        , addDataArrayTpl: function( _num, _modelTpl, _isInit ) {
            var _parent = _modelTpl.parent()
                , _tpl = _modelTpl.clone();

                _tpl.find( 'input[type="text"]' ).val( '' ).end()
                    .find( 'textarea' ).text( '' ).end()
                    .filter( '[defaultData]' ).prop( 'checked', 'checked' );

            if( _isInit ){
                _parent.find( '.fchart-dataarray' ).remove();
            }

            for( var _count = 0; _count < _num; _count++ ) {
                var _radios = _tpl.find( 'input[type="radio"]' );
                if( _radios.length > 0 ) {
                    var _tmp;

                    if( !( _radios.closest( 'div' ).attr( 'onlyname' ) == 'true' ) ) {
                        _radios.attr( 'name', _radios.attr( 'name' ).split( '0.' )[0] + Math.random() );
                    }

                    $.each( _radios, function( _i, _item ){
                        _tmp = $( _item );
                        _tmp.prop( 'checked', _tmp.attr( 'defaultdata' ) == 'true' );
                        _tmp.attr( 'name', _tmp.attr( 'name' ).replace( /[A-Za-z]+/g, _tmp.closest( 'div' ).attr( 'datatype' ) ) )
                    } );
                }
                _isInit ? _parent.append( _tpl.clone() ) : _modelTpl.before( _tpl.clone() )
            }
        }

        /* 更新fchart */
        , updateChart: function( _data ) {
            console.log( _data );
            this._model.getJCFlash().update( _data );
            var _dataStr = JSON.stringify( _data );
            _dataStr = _dataStr.replace( /(,|})/g, '\n $1' ).replace( /({)/g, '$1\n' );
            
            console.log( _dataStr );
            this.fillChartDataToView( _dataStr );
        }

        /* 切换textarea 和 form 的展现 */
        , changeView: function( _target ) {
            var _Model = FchartDemo.Model
                , _model = this._model
                , _selector = _model.selector()
                , _targetType = _target.attr( _Model.FCHART_TABBAR_CHANGEBTN_FLAG )
                , _hideView = _selector.find( '.' + _Model.FCHART_CHANGEVIEW_CLASSNAME + '-' + _targetType )
                , _showView = _hideView.siblings( 'div[class^="' + _Model.FCHART_CHANGEVIEW_CLASSNAME + '"]' );

            _hideView.stop().fadeOut( function(){
                _showView.fadeIn();
            } );
        }

        /* 切换不同图表的form */
        , changeChartForm: function( _targetindex, _data ) {
            var _model = this._model
                , _Model = FchartDemo.Model
                , _selector = _model.selector()
                // , _data = _model.getChartData()
                , _chartForms = _selector.find( '.' + _Model.FCHART_CHANGEVIEW_CLASSNAME + '-' + _Model.FCHART_CHANGEVIEW_FORM_TYPE + ' dl' )
                , _nowForm = _chartForms.eq( parseInt( _targetindex ) );

            _chartForms.filter( '.' + _Model.NOW_SELECTED_CLASSNAME ).removeClass( _Model.NOW_SELECTED_CLASSNAME );
            _nowForm.addClass( _Model.NOW_SELECTED_CLASSNAME );

            /* 同步数据 */
            console.log( _data );
            if( _data ){
                this.initAndFillData( _data, _nowForm );
                this.updateChart( _data );
            } else {
                this.updateChart( _model.getChartData() );
            }
        }

        , displayAttr: function( _target ) {
            var _model = this._model
                , _Model = FchartDemo.Model
                , _selector = _model.selector()
                , _parent = _target.closest( 'div' );
            if( _target.hasClass( _Model.FCHART_ATTRFLOOR_CLOSE ) ){
                _target.removeClass( _Model.FCHART_ATTRFLOOR_CLOSE ).addClass( _Model.FCHART_ATTRFLOOR_OPEN );
                _parent.children( 'div, p' ).stop().slideDown();
            } else {
                _target.removeClass( _Model.FCHART_ATTRFLOOR_OPEN ).addClass( _Model.FCHART_ATTRFLOOR_CLOSE );
                _parent.children( 'div, p' ).stop().slideUp();
            }
        }

        , displayAttrCtr: function( _target ) {
            var _model = this._model
                , _Model = FchartDemo.Model;

            if( _target.text().indexOf( '关闭' ) >= 0 ) {
                _target.text( '展开全部属性节点' );
                _target.closest( '.fchart-nowSelect' ).find( 'a.' + _Model.FCHART_ATTRFLOOR_OPEN ).click();
            } else {
                _target.text( '关闭全部属性节点' );
                _target.closest( '.fchart-nowSelect' ).find( 'a.' + _Model.FCHART_ATTRFLOOR_CLOSE ).click();
            }
        }
    } );

    _jdoc.ready( function() {
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
