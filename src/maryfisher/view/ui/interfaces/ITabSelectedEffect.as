package maryfisher.view.ui.interfaces {
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ITabSelectedEffect {
		function onAddContent(content:DisplayObject):void;
		function onTabSelected(oldContent:DisplayObject, newContent:DisplayObject):void;
	}
	
}