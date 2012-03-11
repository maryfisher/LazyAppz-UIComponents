package maryfisher.ui.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Model3DEvent extends Event {
		
		public static const CLICKED:String = "clicked";
		
		public function Model3DEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new Model3DEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("Model3DEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}