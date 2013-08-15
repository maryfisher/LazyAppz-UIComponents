package maryfisher.view.event {
	import maryfisher.view.ui.button.AbstractSpriteButton;
	import maryfisher.view.ui.interfaces.IButton;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ButtonSignalEvent extends GenericEvent {
		
		public function ButtonSignalEvent() {
			super(true);
			
		}
		
		public function get button():IButton {
			return target as IButton;
		}
	}

}