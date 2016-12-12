package maryfisher.view.ui.interfaces {
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IButtonContainer extends IDisplayObjectContainer, IViewListener{
		function set selected(value:Boolean):void;
		function set enabled(value:Boolean):void;
		function get button():IButton;
		function get numChildren():int;
		function fadeState(state:IDisplayObject):void
	}
	
}