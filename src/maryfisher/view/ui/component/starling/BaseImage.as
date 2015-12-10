package maryfisher.view.ui.component.starling {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import maryfisher.framework.view.IDisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseImage extends Image implements IDisplayObject {
		
		public function BaseImage(texture:Texture) {
			super(texture);
			
		}
		
		public function hasListener(type:String):Boolean {
			return false;
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			
		}
		
		public function dispatch(e:Event):void {
			
		}
		
		public function set clipRect(value:Rectangle):void {
			
		}
		
	}

}