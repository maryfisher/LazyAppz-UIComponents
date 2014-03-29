package maryfisher.view.ui.interfaces {
	import maryfisher.view.ui.mediator.PageMediator;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IPageBar {
		function set pageMediator(value:PageMediator):void;
		function addPage(id:String):IButton;
		function destroy():void;
		
		function reset():void;
		
		function setPage(currentPageNum:int):void;
		
		function setMaxPages(max:int):void;
	}
	
}