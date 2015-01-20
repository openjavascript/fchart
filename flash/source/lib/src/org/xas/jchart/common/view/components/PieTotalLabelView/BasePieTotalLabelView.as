package org.xas.jchart.common.view.components.PieTotalLabelView
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BasePieTotalLabelView extends Sprite
	{
		protected var _maxHeight:Number = 0;
		public function get maxHeight():Number{ return _maxHeight; }
		public function set maxHeight( _setter:Number ):void{ _maxHeight = _setter; }
		
		protected var _maxWidth:Number = 0;
		public function get maxWidth():Number{ return _maxWidth; }
		public function set maxWidth( _setter:Number ):void{ _maxWidth = _setter; }
		
		protected var _label:TextField;
		protected var _bg:Sprite;
		
		protected var _debugLabel:Boolean = false;
		
		protected var _config:Config;
		
		
		public function BasePieTotalLabelView()
		{
			super();
			
			_config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}		
		protected function onReady( _evt:JChartEvent ):void{
			this.alpha = 0;
			this.visible = true;
			
			TweenLite.to( this, _config.animationDuration
				, { 
					alpha: 1, ease: Expo.easeOut
				} );
		}
		
		protected function addToStage( _evt:Event ):void{
			if( !_config.dataLabelEnabled ) return;
			
			if( _config.animationEnabled ){
				this.visible = false;
			}
			this.x  = -1000;
			
			_bg = new Sprite();		
			_bg.graphics.beginFill( _config.totalLabelBgColor, _config.totalLabelBgAlpha );
			_bg.graphics.drawCircle( 0, 0, _config.totalLabelRadius );
			addChild( _bg );
			
			_label = new TextField();
			_label.text =
				StringUtils.printf( _config.totalLabelFormat, 
					Common.moneyFormat( _config.totalNum, 3, Common.floatLen( _config.totalNum ) )
				);	
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.selectable = false;
			_label.mouseEnabled = false;
//			EffectUtility.textShadow( _label, _config.totalLabelLabelStyle, 0xffffff );
			Common.implementStyle( _label, [ _config.totalLabelLabelStyle ] ); 
			
			
			ElementUtility.center( _label, new Point( 0, 0 ) );
			addChild( _label );
			
			addEventListener( JChartEvent.SHOW_CHART, onShowChart );
			addEventListener( JChartEvent.READY, onReady );
		}
		
		protected function onShowChart( _evt:JChartEvent ):void{
			if( !_config.dataLabelEnabled ) return;
			if( !_config.c ) return;
			
			ElementUtility.center( this, new Point( _config.c.cx, _config.c.cy ), false );
		}
	}
}