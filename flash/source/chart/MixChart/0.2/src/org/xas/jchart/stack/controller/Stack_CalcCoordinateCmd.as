package org.xas.jchart.stack.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	
	public class Stack_CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _config:Config;
		private var _type:String;
		private var _seriesAr:Array;
		private var _gtype:Object;
		
		public function Stack_CalcCoordinateCmd()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			_type = notification.getType();
			_seriesAr = notification.getBody() as Array;
			if( !( _seriesAr && _seriesAr.length ) ) return;
			
			var _columns:Object = {};
			
			Common.each( _seriesAr, function( _k:int, _item:Object ):void{
				if( !( _item.modelIndex in _columns ) ){
					_columns[ _item.modelIndex ] = [];
				}
				_columns[ _item.modelIndex ].push( _item );
			});
			
			
//			Log.log( [ _type, new Date().getTime() ] );
			Log.printFormatJSON( _columns );
//			//Log.printFormatJSON( _seriesAr );
//			
//			_gtype = _config.c.mix[ _type ];
//			calc();
//			//Log.printJSON( _gtype );
//			//Log.log( Formatter.json( _gtype ) );
//			//Log.printFormatJSON( _gtype );
//			
//			facade.registerMediator( new HistogramGraphicMediator( _seriesAr, _gtype ) );
		}
		
		private function calc():void{	
			
		}
	}
}