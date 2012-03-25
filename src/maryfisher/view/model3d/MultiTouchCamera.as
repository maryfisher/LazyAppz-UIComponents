package maryfisher.view.model3d {
	import away3d.entities.Entity;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MultiTouchCamera extends TouchDragCamera {
		
		public function MultiTouchCamera(targetObject:Entity=null, panAngle:Number=0, tiltAngle:Number=90, distance:Number=1000) {
			super(targetObject, panAngle, tiltAngle, distance);
			
		}
		
	}

}