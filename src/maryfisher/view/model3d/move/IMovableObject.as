package maryfisher.view.model3d.move {
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IMovableObject {
		function pathTo(path:Vector.<Vector3D>):void;
		function moveToPosition(move:Vector3D):void;
	}
	
}