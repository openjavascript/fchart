package org.xas.jchart.curvegram.view.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.CurveGramUI;
	import org.xas.jchart.common.ui.widget.JFillLine;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<CurveGramUI>;
		private var _preIndex:int = -1;
		private var _nowIndex:int;
		
		private var _config:Config;
		
		public function GraphicView()
		{
			super(); 
			
			_config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			addEventListener( JChartEvent.UPDATE, update );
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		private function addToStage( _evt:Event ):void{
		}

		private function update( _evt:JChartEvent ):void{
			
			if( !( _config.c && _config.c.paths && _config.c.paths.length ) ) return;
			
			graphics.clear();
			_boxs = new Vector.<CurveGramUI>;
			
			var _delay:Number = 0;
			BaseConfig.ins.xAxisEnabled && ( _delay = BaseConfig.ins.animationDuration / 2 );
			
			Common.each( _config.c.paths, function( _k:int, _item:Object ):void{
				
				var _cmd:Vector.<int> = _item.cmd as Vector.<int>
				, _path:Vector.<Number> = _item.path as Vector.<Number>
				, _gitem:CurveGramUI
				, _vectorPath:Vector.<Point> = _config.c.vectorPaths[ _k ] as Vector.<Point>
				;
				
				if( _config.isFillLine( _item.data ) ){
					addChild( 
						new JFillLine( 
							_vectorPath
							, { 
								thickness: 2
								, lineColor: _config.itemColor( _k )
								, fillOpacity: _config.lineFillOpacity( _item.data ) 
								, delayShow: _delay + BaseConfig.ins.animationEnabled
								, animationEnabled: BaseConfig.ins.animationEnabled
								, duration: BaseConfig.ins.animationDuration
								, delay: _delay
							}
							, _config.isLineGradient( _item.data )
						) 
					);
				}

			});
			
			Common.each( _config.c.paths, function( _k:int, _item:Object ):void{
				
				var _cmd:Vector.<int> = _item.cmd as Vector.<int>
					, _path:Vector.<Number> = _item.path as Vector.<Number>
					, _gitem:CurveGramUI
					, _vectorPath:Vector.<Point> = _config.c.vectorPaths[ _k ] as Vector.<Point>
					;
					
				addChild(
					_gitem = new CurveGramUI(
						_cmd
						, _path
						, _config.itemColor( _k )
						, _vectorPath 
						, _config.lineDashStyle( _item.data )
						, {
							animationEnabled: BaseConfig.ins.animationEnabled
							, duration: BaseConfig.ins.animationDuration
							, delay: _delay
							, pointEnabled: BaseConfig.ins.pointEnabled( _item.data )
							, index: _k
						}
					)
				);
				
				_gitem.addEventListener( MouseEvent.CLICK, onMouseClick );
				_boxs.push( _gitem );
			});
			
			dispatchEvent( new JChartEvent( JChartEvent.INITED, {} ) );
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{	
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
					( _k  < _boxs.length ) && _boxs[ _k ] && _boxs[ _k ].items 
						&& ( _preIndex  < _boxs[ _k ].items.length ) && _boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			_preIndex = -1;
			
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;
			
			_nowIndex = _ix;
			
			if( !_boxs || _boxs.length == 0 ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
					
					( _k  < _boxs.length ) && _boxs[ _k ].items  
						&& ( _preIndex < _boxs[ _k ].items.length ) && _boxs[ _k ].items[ _preIndex ].unhover();
						
				});
			}
			Common.each( _boxs, function( _k:int, _item:CurveGramUI ):void{
				
				( _k  < _boxs.length ) && _boxs[ _k ].items
					&& ( _ix < _boxs[ _k ].items.length ) && _boxs[ _k ].items[ _ix ].hover();
				
			});
			
			_preIndex = _ix;
		}
		
		private function onMouseClick( _evt:MouseEvent ):void {
			
			var _target:CurveGramUI = _evt.currentTarget as CurveGramUI;
			var _ix:int = _target.data.index;
			var _groupData:Vector.<Object> = new Vector.<Object>;
			var _itemData:Object = new Object();
			var _tpmObject:Object = new Object();
			var _orgIndex:Number;
			
			Common.each( _config.displaySeries, function( _six:Number, _dataObj:Object ):void{
				
				_orgIndex = _config.displaySeriesIndexMap[ _six ];
				_tpmObject = {
					'name' : _dataObj.name
					, 'data' : _dataObj.data[ _nowIndex ]
					, 'categories' : _config.categories[ _nowIndex ]
					, 'lineIndex' : _six
					, 'orglineIndex' : _orgIndex
					, 'pointIndex' : _nowIndex
				};
				
				_groupData.push( _tpmObject );
				
				( _ix == _six ) && ( _itemData = _tpmObject );
			} );
			
			dispatchEvent( new JChartEvent( JChartEvent.ITEM_CLICK, _itemData ) );
			dispatchEvent( new JChartEvent( JChartEvent.GROUP_CLICK, _groupData ) );
		}
		
	}
}