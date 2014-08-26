package maryfisher.view.ui.interfaces {
	import flash.display.DisplayObject;
	import maryfisher.framework.view.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ITabSelectedEffect {
		function onAddContent(content:IDisplayObject):void;
		function startTransition(oldContent:IDisplayObject, newContent:IDisplayObject):void;
	}
	
}