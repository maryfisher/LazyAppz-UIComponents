package maryfisher.view.ui.interfaces {
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ITabSelectedEffect {
		function onAddContent(content:IDisplayObject):void;
		function startTransition(oldContent:IDisplayObject, newContent:IDisplayObject):void;
	}
	
}