package maryfisher.view.ui.interfaces {
	import maryfisher.view.ui.mediator.BarScroller;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IScrollBar {
		function setScrollDims(scrollMax:int, scrollHeight:int):void;
		function startScrolling(scrollEnd:int):void;
		function finishedScrolling():void;
		function set scroller(value:BarScroller):void;
	}
	
}