package maryfisher.view.ui.interfaces {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDisplayObjectContainer extends IDisplayObject{
		function addDisplayChild(child:IDisplayObject):void;
		function removeDisplayChild(child:IDisplayObject):void;
		function removeChildren(beginIndex:int=0, endIndex:int=2147483647):void;
	}
	
}