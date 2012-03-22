package maryfisher.view.ui.interfaces {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IScrollEffect {
		/* TODO
		 * lousy
		 */
		function addContent(content:int, maskWidth:int):void;
		function onStartScroll():void;
		function onScrollUpdate():void;
		function onScrolledContent():void
	}
	
}