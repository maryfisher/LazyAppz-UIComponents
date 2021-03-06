package maryfisher.view.model3d.ui {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SimplePlane3DButton extends Plane3DButton {
		
		public function SimplePlane3DButton(id:String, color:uint, up:Class, over:Class, down:Class = null) {
			
			_upData = new up().bitmapData;
			_overData = new over().bitmapData;
			
			down && (_downData = new down().bitmapData);
			
			super(id, color);
			
		}
		
	}

}