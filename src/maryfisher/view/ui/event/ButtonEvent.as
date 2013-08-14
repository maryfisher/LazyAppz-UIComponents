package maryfisher.view.ui.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ButtonEvent extends Event {
		
		static public const BUTTON_CLICKED:String = "buttonClicked";
		static public const BUTTON_OVER:String = "buttonOver";
		static public const BUTTON_OUT:String = "buttonOut";
		static public const CHANGE_TAB:String = "changeTab";
		static public const TAB_CLICKED:String = "tabClicked";
		
		private var _buttonId:String;
		
		public function ButtonEvent(type:String, buttonId:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_buttonId = buttonId;
			
		}
		
		public function get buttonId():String {
			return _buttonId;
		}
		
	}

}