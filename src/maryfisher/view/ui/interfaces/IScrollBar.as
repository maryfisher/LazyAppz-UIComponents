package maryfisher.view.ui.interfaces {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IScrollBar {
		function setScrollDims(scrollMax:int, scrollHeight:int):void;
		function startScrolling(scrollEnd:int):void;
		function finishedScrolling():void;
	}
	
}