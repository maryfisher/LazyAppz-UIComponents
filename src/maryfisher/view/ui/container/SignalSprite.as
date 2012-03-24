package maryfisher.view.ui.container {
	import flash.display.Sprite;
	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SignalSprite extends Sprite implements IBubbleEventHandler{
		
		private var _updateSignal:Signal;
		
		public function SignalSprite() {
			
		}
		
		/* INTERFACE org.osflash.signals.events.IBubbleEventHandler */
		
		public function onEventBubbled(event:IEvent):Boolean {
			
		}
		
		public function get updateSignal():Signal {
			return _updateSignal;
		}
		
	}

}