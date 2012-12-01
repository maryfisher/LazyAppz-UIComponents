package maryfisher.view.model3d.move {
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ITurnableObject extends IMovableObject{
		function lookTo(position:Vector3D):void;
		function face(rot:Number):void;
		function turn(value:int):void;
	}
	
}