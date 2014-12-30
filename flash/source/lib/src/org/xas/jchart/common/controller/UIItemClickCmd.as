package org.xas.jchart.common.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class UIItemClickCmd extends SimpleCommand implements ICommand
	{
		private var _config:Config;
		private var _data:Object, _type:String;
		
		public function UIItemClickCmd()
		{
			super();
			_config = BaseConfig.ins as Config;
		}	
		
		override public function execute( notification:INotification ):void{	
			
			_data = notification.getBody();
			_type = notification.getType() || '';
			
			if( !_data ) return; 
			
			switch( _type ){
				default: {
					defaultAction();
					break;
				}
			}
		}
		
		private function defaultAction():void{
			var _itemData:Object = {}, _groupData:Array = [];
			
			
			Common.each( _config.displaySeries, function( _six:Number, _dataObj:Object ):void{
				var _tmpObject:Object = {
					seriesIndex: _six
					, dataIndex: _data.dataIndex
					, originSeriesIndex: ( _six in _config.displaySeriesIndexMap ) ? _config.displaySeriesIndexMap[ _six ] : _six
					, name: _dataObj.name
					, categorie : _config.categories[ _data.dataIndex ] || ''
					, data: _dataObj.data[ _data.dataIndex ]
					, type: _type
				};
			
				if( _type == 'line' ){
					_tmpObject = Common.extendObject( _tmpObject, {
						categories : _config.categories[ _data.dataIndex ]
						, lineIndex : _six
						, orglineIndex : _tmpObject.originSeriesIndex
						, pointIndex : _data.dataIndex
					});
				}

				_groupData.push( _tmpObject );
				( _data.seriesIndex == _six ) && ( _itemData = _tmpObject );
			} );
			
//			Log.printFormatJSON( _itemData );
//			Log.printFormatJSON( _groupData );
			
			sendNotification( JChartEvent.ITEM_CLICK, _itemData );
			sendNotification( JChartEvent.GROUP_CLICK, _groupData );
		}
	}
}