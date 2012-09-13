package maryfisher.view.ui.interfaces {
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDropDownList {
		function expand():void;
		function collapse():void;
		function set selectedListElement(value:IDisplayObject):void;
		function addListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void;
		function addListChild(obj:IDisplayObject):void;
	}
	
}