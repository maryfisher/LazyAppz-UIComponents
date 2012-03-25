package maryfisher.view.model3d {
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import flash.display.Stage;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ICameraController {
		function addTiltListener(listener:Function):void;
		function addPanListener(listener:Function):void;
		//function tiltSignal():Signal;
		//function panSignal():Signal;
		function destroy():void;
		function start(stage:Stage = null):void;
		function stop():void;
		function assignBounds(minX:int, maxX:int, minY:int, maxY:int):void
	}
	
}