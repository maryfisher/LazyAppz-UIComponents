package maryfisher.view.ui.interfaces {
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDisplayObject{
		function get width():Number;
		function get height():Number;
		function get x():Number;
		function get y():Number;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set visible(value:Boolean):void;
		function get visible():Boolean;
		function set alpha(value:Number):void;
		function set clipRect(value:Rectangle):void;
		
		function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
		function removeListener(type:String, listener:Function, useCapture:Boolean=false) : void
		function hasListener(type:String):Boolean;
		
		function get stage():Stage;
		
	}
	
}