package org.xas.jchart.common.view.components.PieLabelView
{
	import com.adobe.utils.StringUtil;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.JSprite;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class BasePieLabelView extends Sprite
	{
		protected var _labels:Vector.<JTextField>;
		public function get labels():Vector.<JTextField>{ return _labels; }
		
		protected var _lines:Vector.<JSprite>;
		public function get lines():Vector.<JSprite>{ return _lines; }
		
		protected var _leftTopLabel:Vector.<JTextField>;
		protected var _leftTopLine:Vector.<JSprite>;
		
		protected var _rightTopLabel:Vector.<JTextField>;
		protected var _rightTopLine:Vector.<JSprite>;
		
		protected var _leftBottomLabel:Vector.<JTextField>;
		protected var _leftBottomLine:Vector.<JSprite>;
		
		protected var _rightBottomLabel:Vector.<JTextField>;
		protected var _rightBottomLine:Vector.<JSprite>;
		
		protected var _isIntersect:Boolean = false;
		
		protected var _maxWidth:Number;
		protected var _maxHeight:Number;
		
		protected var _debugLabel:Boolean = false;
		
		protected var _config:Config;
		
		public function BasePieLabelView()
		{
			super();
			_config = BaseConfig.ins as Config;
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		protected function addToStage( _evt:Event ):void{
			_debugLabel = false;
			
			if( _config.animationEnabled ){
				this.visible = false;
			}
			
			addEventListener( JChartEvent.SHOW_CHART, onShowChart );
			addEventListener( JChartEvent.READY, onReady );
		}
		
		private function onReady( _evt:JChartEvent ):void{
			this.alpha = 0;
			this.visible = true;
			
			TweenLite.to( this, _config.animationDuration
				, { 
					alpha: 1, ease: Expo.easeOut
				} );
		}
		
		protected function onShowChart( _evt:JChartEvent ):void{
			ElementUtility.removeAllChild( this );
			graphics.clear();
			
			_labels = new Vector.<JTextField>();
			_lines = new Vector.<JSprite>();
			
			_leftTopLabel = new Vector.<JTextField>();
			_leftTopLine = new Vector.<JSprite>();
			
			_rightTopLabel = new Vector.<JTextField>();
			_rightTopLine = new Vector.<JSprite>();
			
			_leftBottomLabel = new Vector.<JTextField>();
			_leftBottomLine = new Vector.<JSprite>();
			
			_rightBottomLabel = new Vector.<JTextField>();
			_rightBottomLine = new Vector.<JSprite>();
			
			_isIntersect = false;
			_maxWidth = 0;
			_maxHeight = 15;
			
			
			if( !_config.dataLabelEnabled ) return;
			
			if( !( _config.c && _config.c.piePart && _config.c.piePart.length ) ) return;
			
			var _topLabel:JTextField, _topLine:JSprite
				, _rightLabel:JTextField, _rightLine:JSprite
				, _bottomLabel:JTextField, _bottomLine:JSprite
				, _leftLabel:JTextField, _leftLine:Sprite
				;
			
			Common.each( _config.c.pieLine, function( _k:int, _lineData:Object ):void{
				
				var _data:Object = { index: _k, data: _lineData, color: _config.itemColor( _k ) }
					, _line:JSprite = new JSprite( _data )
					, _label:JTextField = new JTextField( _data )
					;
					_data.line = _line;
				
				_line.graphics.lineStyle( 1, _config.itemColor( _k ) );
				_line.graphics.moveTo( _lineData.start.x, _lineData.start.y );
				_line.graphics.curveTo( _lineData.control.x, _lineData.control.y, _lineData.end.x, _lineData.end.y );												
				addChild( _line );
				
				_label.text = _config.displaySeries[ _k ].name;
				_label.mouseEnabled = false;
				_label.autoSize = TextFieldAutoSize.LEFT;
				
				
				switch( _lineData.direction ){
					case 'top':
					{
						_label.x = _lineData.end.x - _label.width / 2;
						_label.y = _lineData.end.y - 5 - _label.height;
						//_leftTopLabel.push( _label );
						//_leftTopLine.push( _line );
						
						_topLabel = _label;
						_topLine = _line;
						break;
					}
					case 'right':
					{
						//_label.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						//_rightBottomLabel.push( _label );
						//_rightBottomLine.push( _line );
						_rightLabel = _label;
						_rightLine = _line;
						break;
					}
					case 'bottom':
					{
						//_label.attr( { x: _item.end.x, y: _item.end.y + 5 } );
						_label.x = _lineData.end.x - _label.width / 2;
						_label.y = _lineData.end.y;
						//_leftBottomLabel.push( _label );
						//_leftBottomLine.push( _line );
						_bottomLabel  = _label;
						_bottomLine  = _line;
						break;
					}
					case 'left':
					{
						//_label.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
						//_leftBottomLabel.push( _label );
						//_leftBottomLine.push( _line );
						_leftLabel  = _label;
						_leftLine  = _line;
						break;
					}
					case 'left_top':
					{
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
						_leftTopLabel.push( _label );
						_leftTopLine.push( _line );
						break;
					}
					case 'right_top':
					{
						//_label.attr( { x: , y: , 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						_rightTopLabel.push( _label );
						_rightTopLine.push( _line );
						break;
					}
					case 'left_bottom':
					{
						//_label.attr( { x: 5, y: , 'text-anchor': 'end' } );
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
						_leftBottomLabel.push( _label );
						_leftBottomLine.push( _line );
						break;
					}
					case 'right_bottom':
					{
						//_label.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						_rightBottomLabel.push( _label );
						_rightBottomLine.push( _line );
						break;
					}
				}		
				
//				if( _label.x < 1 ){
//					_label.x = 1;
//				}
//				
//				if( _label.x + _label.width >= _config.stageWidth ){
//					_label.x = _config.stageWidth - _label.x - _label.width - 1;
//				}
				
				_label.textColor = _config.itemColor( _k );
				addChild( _label );
				
				_label.width > _maxWidth && ( _maxWidth = _label.width );
				_label.height > _maxHeight && ( _maxHeight = _label.height );				
				
				_labels.push( _label );
				_lines.push( _line );
			});
			
			if( _topLabel ){
				_leftTopLabel.push( _topLabel );
				_leftTopLine.push( _topLine );
			}
			
			if( _rightLabel ){
				_rightTopLabel.push( _rightLabel );
				_rightTopLine.push( _rightLine );
			}
			
			if( _bottomLabel ){
				_rightBottomLabel.push( _bottomLabel );
				_rightBottomLine.push( _bottomLine );
			}
			
			if( _leftLabel ){
				_leftBottomLabel.push( _leftLabel );
				_leftBottomLine.push( _leftLine );
			}
			_isIntersect = checkIntersect( _labels );
			
			//Log.log( _isIntersect );
			if( _isIntersect ){
				
				fixRightTopLabel( _rightTopLabel );
				
				_rightBottomLabel.reverse();
				fixRightBottomLabel( _rightBottomLabel );
				
				_leftTopLabel.reverse();
				fixLeftTopLabel( _leftTopLabel );
				
				fixLeftBottomLabel( _leftBottomLabel );
			}			
			
			Common.each( _labels, function( _k:int, _label:JTextField ):void{
				if( _label.x < 0 ){
					_lines[ _k ].x += Math.abs( _label.x );
					_label.x = 0;	
				}
				if( _label.x + _label.width > _config.stageWidth ){
//					_lines[_k].x -= _config.stageWidth - _label.width - _label.x;
					_lines[ _k ].x -= Math.abs( _label.width + _label.x - _config.stageWidth );
					_label.x = _config.stageWidth - _label.width;	
				}
				
				if( _label.y < 0 ){
					_label.y = 0;	
					_lines[ _k ].y += Math.abs( _label.y );
				}
				if( _label.y + _label.height > _config.stageHeight ){
					_lines[ _k ].y -= Math.abs( _label.height + _label.y - _config.stageHeight );
					_label.y = _config.stageHeight - _label.height;	
				}
			});
		}
		
		protected function fixRightTopLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = _config.c.cx + 5
				, _y:Number = _config.c.chartY + 5
				, _endX:Number = _config.c.chartX + _config.c.chartWidth - 5 - _maxWidth
				, _endY:Number = _config.c.cy - _maxHeight - 5
				;	
			
			if( _labels.length < 5 ){
				_x = _config.c.chartX + _config.c.chartWidth - ( _config.c.cx - _config.c.chartX ) / 5;
			}
						
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
				, _controlX:Number = -8
				, _controlY:Number = -8
				, _anchorX:Number = _item.x - 2
				, _anchorY:Number = _item.y + _item.height / 2
				;			
				
				if( _item.data.data.start.x > _anchorX && _item.data.data.start.y > _anchorY ){
					_controlX = 8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2;
					_anchorY = _item.y + _item.height + 2;
				}
				
				if( _line ){
					
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}
		
		protected function fixRightBottomLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = _config.c.cx + 5
				, _endX:Number = _config.c.chartX + _config.c.chartWidth - 5 - _maxWidth
				
				, _y:Number = _config.c.chartY + _config.c.chartHeight - 5 - _maxHeight
				, _endY:Number = _config.c.cy + _maxHeight - 5
				;	
			
			if( _labels.length < 5 ){
				_x = _config.c.chartX + _config.c.chartWidth - ( _config.c.cx - _config.c.chartX ) / 5;
			}
			
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
				, _controlX:Number = -8
				, _controlY:Number = 8
				, _anchorX:Number = _item.x - 2
				, _anchorY:Number = _item.y + _item.height / 2
				;			
				
				
				if( _item.data.data.start.x > _anchorX && _item.data.data.start.y < _anchorY ){
					_controlX = -8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2  + 2;
					_anchorY = _item.y ;
				}
				
				
				if( _line ){
					
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}
		
		protected function fixLeftTopLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = _config.c.cx - _maxWidth - 5
				, _y:Number = _config.c.chartY + 5
				, _endX:Number = _config.c.chartX + 10
				, _endY:Number = _config.c.cy - _maxHeight / 2 - 10
				;
			
			if( _labels.length < 5 ){
				_x = _config.c.chartX + ( _config.c.cx - _config.c.chartX ) / 5;
			}
			
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
					, _controlX:Number = 8
					, _controlY:Number = -8
					, _anchorX:Number = _item.x + _item.width + 2
					, _anchorY:Number = _item.y + _item.height / 2
					;		
					
				
				if( _item.x + _item.width + 25 >= _item.data.data.start.x && _item.data.data.start.y > _anchorY ){
					_controlX = -8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2;
					_anchorY = _item.y + _item.height + 2;
				}
				
				
				if( _line ){
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}		
		
		protected function fixLeftBottomLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = _config.c.cx - _maxWidth - 5
				, _endX:Number = _config.c.chartX + 5
				, _y:Number = _config.c.chartY + _config.c.chartHeight - 5 - _maxHeight
				, _endY:Number = _config.c.cy + _maxHeight / 2 - 5
				;
			
			if( _labels.length < 5 ){
				_x = _config.c.chartX + ( _config.c.cx - _config.c.chartX ) / 5;
			}
			
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
				, _controlX:Number = -8
				, _controlY:Number = 8
				, _anchorX:Number = _item.x + _item.width + 2
				, _anchorY:Number = _item.y + _item.height / 2
				;			
								
				
				if( ( _anchorX + 25 >= _item.data.data.start.x ) && _item.data.data.start.y < _anchorY ){
					_controlX = 8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2;
					_anchorY = _item.y - 2;
				}
				
								
				if( _line ){
					
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}	
		
		protected function positionItems( _labels:Vector.<JTextField>
										, _x:Number, _y:Number
										  , _endX:Number, _endY:Number
											, _cb:Function = null
		):void
		{
			var _xWidth:Number = Math.abs( _x - _endX )
				, _xIsMax:Boolean = _x > _endX
				
				,  _yHeight:Number = Math.abs( _y - _endY )
				, _yIsMax:Boolean = _y > _endY
				
				, _maxLen:int = _labels.length - 1
				, _yStep:Number = Math.abs( _y - _endY ) / _maxLen
				;
			if( _labels.length ){
				var _tmpX:Number, _tmpY:Number = _y, _tmpWidth:Number = _xWidth;
				Common.each( _labels, function( _k:int, _item:JTextField ):void{
					var _percent:Number = .65
					, _maxX:Number = Math.max( _x, _endX )
					, _minX:Number = Math.min( _x, _endX )
					;
					if( _xIsMax ){
						if( _k == 0 ){
							_percent = .99;
						}else if( _k == _maxLen ){
						}else{				
						}
					}else{
						if( _k == 0 ){
							_percent = .99;
						}else if( _k == _maxLen ){
						}else{				
						}
					}
					_tmpWidth *= _percent;
					if( _xIsMax ){
						_item.x = _maxX - ( _xWidth - _tmpWidth );
					}else{						
						_item.x = _minX + ( _xWidth - _tmpWidth );
					}
					_item.y = _tmpY;
					
					if( _yIsMax ){
						_tmpY -= _yStep;
					}else{
						_tmpY += _yStep;
					}
					
					//_item.text = _item.text + '_' + _k;
					_cb && _cb( _item );				
				});
			}else{
				
			}
		}
		
		protected function checkIntersect( _labes:Vector.<JTextField> ):Boolean{
			var _r:Boolean = false
				, _len:int
				, i:int, j:int
				, _ta:JTextField, _tb:JTextField
				;
			
			_len = _labels.length;
			
			for(  i = 0; i < _len; i++ ){
				_ta = _labels[ i ];
				for( j = i + 1; j < _len; j++ ){
					_tb = _labels[ j ];
					
					if( _ta.hitTestObject( _tb ) ){
                        return true;
					}
				}
			} 
			
			return _r;
		}

	}
}
