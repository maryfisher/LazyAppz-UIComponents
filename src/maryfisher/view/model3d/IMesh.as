package maryfisher.view.model3d {
	import away3d.entities.Mesh;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IMesh {
		
		function set isWaiting(value:Boolean):void;
		function set mesh(value:Mesh):void;
	}
	
}