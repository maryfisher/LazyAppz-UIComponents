package maryfisher.view.ui.component.starling {
	import flash.events.Event;
	import flash.geom.Rectangle;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarling extends Sprite implements IDisplayObjectContainer {
		
		public function BaseStarling() {
			super();
			
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
			return contains(child as DisplayObject);
		}
		
		public function getContentIndex(child:IDisplayObject):int {
			return getChildIndex(child as DisplayObject);
		}
		
		//public function set filters(value:Array):void {
			///** TODO
			 //* 
			 //*/
		//}
		
		public function hasListener(type:String):Boolean {
			return hasEventListener(type);
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			
		}
		
		public function dispatch(e:Event):void {
			
		}
		
		
		/* INTERFACE maryfisher.framework.view.IViewListener */
		
		public function get stageMouseX():Number {
			return -1;
		}
		
		public function get stageMouseY():Number {
			return -1;
		}
		
		public function get hasStage():Boolean {
			return stage != null;
		}
		
		public function hasStageListener(type:String):Boolean {
			return stage.hasEventListener(type);
		}
		
		public function addStageListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			stage.addEventListener(type, listener);
		}
		
		public function removeStageListener(type:String, listener:Function, useCapture:Boolean = false):void {
			stage.removeEventListener(type, listener);
		}
		
		
		/* INTERFACE maryfisher.view.ui.interfaces.IDisplayObjectContainer */
		
		public function set clipRect(value:Rectangle):void 
		{
			
		}
		
	}

}