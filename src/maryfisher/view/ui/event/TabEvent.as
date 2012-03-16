package maryfisher.view.ui.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TabEvent extends Event {
		static public const CHANGE_TAB:String = "changeTab";
		static public const TAB_CLICKED:String = "tabClicked";
		
		private var _id:String;
		private var _param:Object;
		
		public function TabEvent(type:String, id:String = '', param:Object = null) {
			super(type, true, cancelable);
			_param = param;
			_id = id;
			
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get param():Object {
			return _param;
		}
		
	}

}