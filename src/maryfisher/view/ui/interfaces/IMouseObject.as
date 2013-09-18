package maryfisher.view.ui.interfaces {
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IMouseObject extends IDisplayObject{
		function addMouseOver():void;
		function addMouseOut():void;
		function removeMouseOver():void;
		function removeMouseOut():void;
		function get mouseOutCallback():Signal
		function get mouseOverCallback():Signal
	}
	
}