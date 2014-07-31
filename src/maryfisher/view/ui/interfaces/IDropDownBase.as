package maryfisher.view.ui.interfaces {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDropDownBase extends IDisplayObjectContainer{
		function set maxHeight(value:int):void;
		function set actHeight(value:int):void;
		function get actHeight():int;
		function removeContent():void;
		
		//function updateHeight():void;
	}
	
}