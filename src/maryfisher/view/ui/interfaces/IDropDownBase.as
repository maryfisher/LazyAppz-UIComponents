package maryfisher.view.ui.interfaces {
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDropDownBase extends IDisplayObjectContainer {
		function set maxHeight(value:int):void;
		function set actHeight(value:int):void;
		function get actHeight():int;
		function removeBaseContent():void;
		
		//function updateHeight():void;
	}
	
}