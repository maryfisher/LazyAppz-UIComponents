package maryfisher.ui.interfaces {
	import flash.events.IEventDispatcher;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IScrollTrack extends IEventDispatcher{
		function get updateSignal():Signal;
	}
	
}