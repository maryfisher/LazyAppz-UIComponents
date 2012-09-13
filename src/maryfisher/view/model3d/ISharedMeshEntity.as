package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ISharedMeshEntity {
		function set isWaiting(value:Boolean):void;
		function get meshSignal():Signal;
		function get meshId():String;
		function set meshId(value:String):void
		function set mesh(value:Mesh):void;
	}
	
}