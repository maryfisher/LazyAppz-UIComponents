package maryfisher.view.ui.interfaces {
	import flash.display.DisplayObject;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ISlider {
		function get updateSignal():Signal;
		function assignThumb(thumb:DisplayObject, minPos:int, maxPos:int, isVertical:Boolean = true):void
		function destroy():void;
	}
	
}