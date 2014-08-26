package maryfisher.view.ui.component {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import maryfisher.framework.view.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseShape extends Shape implements IDisplayObject {
		
		public function BaseShape() {
			
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			
		}
		
		public function dispatch(e:Event):void {
			
		}
		
		public function hasListener(type:String):Boolean {
			return false;
		}
		
		public function set clipRect(value:Rectangle):void {
			
		}
		
	}

}