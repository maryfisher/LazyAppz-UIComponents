package maryfisher.view.model3d.camera {
	import away3d.entities.Entity;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MultiTouchCamera extends DragCamera {
		
		public function MultiTouchCamera(targetObject:Entity=null, panAngle:Number=0, tiltAngle:Number=90, distance:Number=1000) {
			super(targetObject, panAngle, tiltAngle, distance);
			
		}
		
	}

}