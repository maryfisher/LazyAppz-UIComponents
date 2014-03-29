package maryfisher.view.event {
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextInputSignalEvent extends GenericEvent {
		
		static public const ON_ACTIVATED:String = "onActivated";
		static public const ON_CHANGE_FINISHED:String = "onChangeFinished";
		static public const ON_SELECTION_CHANGED:String = "onSelectionChanged";
		static public const ON_DEACTIVATED:String = "onDeactivated";
		
		public var type:String;
		
		public function TextInputSignalEvent(type:String) {
			super(true);
			this.type = type;
			
		}
		
	}

}