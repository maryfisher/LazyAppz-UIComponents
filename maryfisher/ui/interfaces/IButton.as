package maryfisher.ui.interfaces {
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IButton extends IViewComponent{
		function get id():String;
		function set selected(value:Boolean):void;
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
	}
	
}