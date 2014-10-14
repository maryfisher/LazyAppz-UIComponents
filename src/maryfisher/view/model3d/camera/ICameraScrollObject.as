package maryfisher.view.model3d.camera {
	import maryfisher.framework.view.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ICameraScrollObject extends IDisplayObject {
		function get panelId():String;
		//function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
		//function removeListener(type:String, listener:Function, useCapture:Boolean=false) : void
	}
	
}