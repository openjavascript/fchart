package org.xas.jchart.common.controller
{
	import fl.motion.MatrixTransformer;
	
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.HLabelMediator;
	import org.xas.jchart.common.view.mediator.MainMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator;
	
	public class GlobalRotationLabelsCmd extends SimpleCommand implements ICommand
	{
		private var _type:String = '', _body:Object;
		private var _config:Config;
		private var _itemWidth:Number;
		private var _labels:Vector.<TextField>;
		private var _isReset:Boolean;
		
		public function GlobalRotationLabelsCmd()
		{
			super();
			_config = BaseConfig.ins as Config;
		}
		
		override public function execute( notification:INotification ):void{
			_body = notification.getBody();
			_type = notification.getType();
			
			//Log.log( _config.labelRotationEnable, _config.displayAllLabel );
			if( !_config.xAxisEnabled ) return;
			if( !_config.labelRotationEnable ) return;
			
			_labels = hlabelMediator.labels;
			
			_itemWidth = _config.c.chartWidth / ( _config.categories.length );
							
			switch( _type ){
				case 'line': {
					if( !( _config.categories && _config.categories.length ) ) return;
					lineAction();
					break;
				}
				default: {
					if( !( _config.categories && _config.categories.length ) ) return;
					normalAction();
					break;
				}
			}
			//Log.log( '_isReset' );
			_isReset && sendNotification( JChartEvent.RESET_HLABELS );
		}
		
		protected function lineAction():void{
			//Log.log( 'GlobalRotationLablesCmd normalAction', _itemWidth );
			if( !( _labels && _labels.length) ) return;
			
			//			testPoint();
			//			test( -1 );
			//			test( -10 );
			//			test( -20 );
			//			test( -30 );
			//			test( -40 );
			//			test( -50 );
			//			test( -60 );
			//			test( -70 );
			//			test( -80 );
			//			test( -90 );
			//			test( -100 );
			//			test( -110 );
			//			test( -120 );
			//			test( -130 );
			//			test( -140 );
			//			test( -150 );
			//			test( -160 );
			//			test( -170 );
			//			test( -180 );
			//			
			//			test( 0 );
			//			test( 1 );
			//			test( 10 );
			//			test( 20 );
			//			test( 30 );
			//			test( 40 );
			//			test( 50 );
			//			test( 60 );
			//			test( 70 );
			//			test( 80 );
			//			test( 90 );
			//			test( 100 );
			//			test( 110 );
			//			test( 120 );
			//			test( 130 );
			//			test( 140 );
			//			test( 150 );
			//			test( 160 );
			//			test( 170 );
			//			test( 180 );
			
			_config.c.rotationCoor = [];
			var _maxWidth:Number = 0, _maxHeight:Number = 0, _labelMaxWidth:Number = 0, _offsetY:int = 1;
			
			Common.each( _labels, function( _k:int, _item:TextField ):void{
				//Log.log( _item.x, _item.y, _config.labelRotationAngle );
				var _default:Point = new Point( _item.x, _item.y )
				, _rect:Rectangle = Common.calcRotationLabelPoint( _item, _config.labelRotationAngle )
				, _new:Point = _default.subtract( new Point( _rect.x, _rect.y + _offsetY ) )
				, _plus:Number = 0;
				;
								
				_config.c.rotationCoor.push( 
					{
						old: _default
						, rect: _rect
						, offset: _new
					}
				);
				_item.width > _maxWidth && ( _maxWidth = _item.width );
				_rect.height > _maxHeight && ( _maxHeight = _rect.height );
				
				if( _config.labelRotationAngle < 0 ){
					_plus = _k * _itemWidth - _itemWidth / 2;		
				}else if( _config.labelRotationAngle > 0 ){
					_plus = ( _labels.length - _k - 1 ) * _itemWidth - _itemWidth / 2;		
				}
				( _item.width - _plus ) > _labelMaxWidth && ( _labelMaxWidth = _item.width - _plus );
			});
			//Log.printJSON( _config.c.rotationCoor );
			_maxHeight += _offsetY;
			hlabelMediator.maxHeight = _maxHeight;
			
			if( _config.labelRotationAngle > 0 ){
				_labelMaxWidth -= _itemWidth / 2;
				_labelMaxWidth -= 10;
				
				if( _labelMaxWidth > 0 ){
					hlabelMediator.maxWidth = _labelMaxWidth;
				}				
			}else if( _config.labelRotationAngle < 0 ){
				
				_labelMaxWidth -= _itemWidth / 2
				_labelMaxWidth -= 10;
				if( _config.yAxisEnabled ){
					_labelMaxWidth -= _config.c.minX;
				}
				if( _labelMaxWidth > 0 ){
					_config.c.minX += _labelMaxWidth;	
				}
			}			
		}
		
		protected function normalAction():void{
			//Log.log( 'GlobalRotationLablesCmd normalAction', _itemWidth );
			if( !( _labels && _labels.length) ) return;
			
//			testPoint();
//			test( -1 );
//			test( -10 );
//			test( -20 );
//			test( -30 );
//			test( -40 );
//			test( -50 );
//			test( -60 );
//			test( -70 );
//			test( -80 );
//			test( -90 );
//			test( -100 );
//			test( -110 );
//			test( -120 );
//			test( -130 );
//			test( -140 );
//			test( -150 );
//			test( -160 );
//			test( -170 );
//			test( -180 );
//			
//			test( 0 );
//			test( 1 );
//			test( 10 );
//			test( 20 );
//			test( 30 );
//			test( 40 );
//			test( 50 );
//			test( 60 );
//			test( 70 );
//			test( 80 );
//			test( 90 );
//			test( 100 );
//			test( 110 );
//			test( 120 );
//			test( 130 );
//			test( 140 );
//			test( 150 );
//			test( 160 );
//			test( 170 );
//			test( 180 );

			_config.c.rotationCoor = [];
			var _maxWidth:Number = 0, _maxHeight:Number = 0, _labelMaxWidth:Number = 0;
			
			Common.each( _labels, function( _k:int, _item:TextField ):void{
				//Log.log( _item.x, _item.y, _config.labelRotationAngle );
				var _default:Point = new Point( _item.x, _item.y )
					, _rect:Rectangle = Common.calcRotationLabelPoint( _item, _config.labelRotationAngle )
					, _new:Point = _default.subtract( new Point( _rect.x, _rect.y ) )
					, _plus:Number = 0;
					;
					
					
				_config.c.rotationCoor.push( 
					{
						old: _default
						, rect: _rect
						, offset: _new
					}
				);
				_item.width > _maxWidth && ( _maxWidth = _item.width );
				_rect.height > _maxHeight && ( _maxHeight = _rect.height );
				
				if( _config.labelRotationAngle < 0 ){
					_plus = _k * _itemWidth;				
				}else if( _config.labelRotationAngle > 0 ){
					_plus = ( _labels.length - _k - 1 ) * _itemWidth;		
				}
				( _item.width - _plus ) > _labelMaxWidth && ( _labelMaxWidth = _item.width - _plus );
			});
			//Log.printJSON( _config.c.rotationCoor );
			hlabelMediator.maxHeight = _maxHeight;
			
			if( _config.labelRotationAngle > 0 ){
				_labelMaxWidth -= _itemWidth / 2;
				_labelMaxWidth -= 10;
				
				if( _labelMaxWidth > 0 ){
					hlabelMediator.maxWidth = _labelMaxWidth;
				}				
			}else if( _config.labelRotationAngle < 0 ){
				
				_labelMaxWidth -= _itemWidth / 2
				_labelMaxWidth -= 10;
				if( _config.yAxisEnabled ){
					_labelMaxWidth -= _config.c.minX;
				}
				if( _labelMaxWidth > 0 ){
					_config.c.minX += _labelMaxWidth;	
				}
			}			
		}
		
		private function testPoint():void{
			var _sp:Sprite = new Sprite();
				_sp.graphics.beginFill( 0xff0000 ); 
				_sp.graphics.drawRect( _config.stageWidth / 2, _config.stageHeight / 2, 10, 10 );
				
				mainMediator.view.index12.addChild( _sp );
		}
		
		private function test( _angle:Number ):void{
			
			var _tf:TextField = new TextField()
				, _new:Rectangle
				, _matrix:Matrix
				, _rect:Rectangle
				;
			_tf.text = '123456789123456789123456789';

			_tf.autoSize = TextFieldAutoSize.LEFT;
			_rect = _tf.getRect( _tf );
			
			mainMediator.view.index12.addChild( _tf );
			//Log.log( _tf.getBounds( _tf ) );
			//Common.rotateAroundCenter( _tf, 0 );
			_tf.x = _config.stageWidth / 2 ;
			_tf.y = _config.stageHeight / 2;
			
			_new = Common.calcRotationLabelPoint( _tf, _angle );
			_tf.x = _new.x;
			_tf.y = _new.y;
		}
		
		protected function get vlabelMediator():VLabelMediator{
			return facade.retrieveMediator( VLabelMediator.name ) as VLabelMediator;
		}
		protected function get hlabelMediator():HLabelMediator{
			return facade.retrieveMediator( HLabelMediator.name ) as HLabelMediator;
		}
		protected function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
	}
}