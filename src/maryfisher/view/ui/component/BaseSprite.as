package maryfisher.view.ui.component {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSprite extends Sprite implements IDisplayObjectContainer {
		
		public function BaseSprite() {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObject */
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			removeEventListener(type, listener, useCapture);
		}
		
		public function hasListener(type:String):Boolean {
			return hasEventListener(type);
		}
		
		public function dispatch(e:Event):void {
			dispatchEvent(e);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObjectContainer */
		
		public function addContent(child:IDisplayObject):void {
			addChild(child as DisplayObject);
		}
		
		public function addContentAt(child:IDisplayObject, index:int):void {
			addChildAt(child as DisplayObject, index);
		}
		
		public function removeContent(child:IDisplayObject):void {
			removeChild(child as DisplayObject);
		}
		
		public function removeAllContent():void {
			removeChildren();
		}
		
		public function containsContent(child:IDisplayObject):Boolean {
			return contains(child as DisplayObject)
		}
		
		public function getContentIndex(child:IDisplayObject):int {
			return getChildIndex(child as DisplayObject);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObjectContainer */
		
		public function get hasStage():Boolean {
			return stage != null;
		}
		
		public function hasStageListener(type:String):Boolean {
			return stage.hasEventListener(type);
		}
		
		public function addStageListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			stage.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeStageListener(type:String, listener:Function, useCapture:Boolean = false):void {
			stage.removeEventListener(type, listener, useCapture);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObjectContainer */
		
		public function get stageMouseX():Number {
			return stage.mouseX;
		}
		
		public function get stageMouseY():Number {
			return stage.mouseY;
		}
		
		public function set clipRect(value:Rectangle):void {
			mask = new Bitmap(new BitmapData(value.width, value.height, false, 0));
			mask.x = value.x;
			mask.y = value.y;
		}
		
	}

}