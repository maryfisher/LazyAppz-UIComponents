package maryfisher.view.ui.interfaces {
	import flash.display.DisplayObject;
	import maryfisher.framework.view.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IProgressBar extends IDisplayObject {
		function setProgress(percent:Number):void
		//function get width():Number;
		//function get height():Number;
		//function setBar(bar:DisplayObject, mask:DisplayObject):void
		//function set maskWidth(value:Number):void;
		//function get totalWidth():Number;
	}
	
}