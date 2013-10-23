package maryfisher.view.event {
	import maryfisher.view.ui.button.AbstractSpriteButton;
	import maryfisher.view.ui.interfaces.IButton;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ButtonSignalEvent extends GenericEvent {
		public var type:String;
		
		static public const ON_CLICKED:String = "ButtonSignalEvent/onClicked";
		static public const ON_OVER:String = "ButtonSignalEvent/onOver";
		static public const ON_DOWN:String = "ButtonSignalEvent/onDown";
		
		public function ButtonSignalEvent(type:String) {
			super(true);
			this.type = type;
			
		}
		
		public function get button():IButton {
			return target as IButton;
		}
	}

}