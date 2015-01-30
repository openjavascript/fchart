package org.xas.jchart.stack.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.stack.view.components.GraphicView;
	
	public class StackGraphicMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PCharStackMediator';
		private var _view:GraphicView;
		public function get view():GraphicView{ return _view; }
		
		private var _config:Config;
		private var _seriesAr:Array;
		private var _coordinate:Object;
		
		public function StackGraphicMediator( _seriesAr:Array, _coordinate:Object )
		{
			super( name );
			
			_config = BaseConfig.ins as Config;
			this._seriesAr = _seriesAr;
			this._coordinate = _coordinate;
			
		}
	}
}