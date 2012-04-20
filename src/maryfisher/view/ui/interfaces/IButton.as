package maryfisher.view.ui.interfaces {
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	/* TODO
	 * wieso extended das viewcomponent???
	 */
	public interface IButton extends IViewComponent{
		function get id():String;
		function set selected(value:Boolean):void;
		function get selected():Boolean;
		function set enabled(value:Boolean):void;
		function get enabled():Boolean;
		function addClickedListener(listener:Function):void;
		function addDownListener(listener:Function):void;
		function set sound(value:ISound):void;
	}
	
}