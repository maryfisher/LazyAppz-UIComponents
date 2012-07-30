package maryfisher.view.ui.interfaces {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IDisplayObject {
		function get width():Number;
		function get height():Number;
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set visible(value:Boolean):void;
		function set alpha(value:Number):void;
	}
	
}