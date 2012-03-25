package maryfisher.view.model3d {
	import away3d.entities.Entity;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IScrollTrack;
	import maryfisher.view.ui.interfaces.ISlider;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class UITouchCamera extends TouchDragCamera {
		
		private var _zoomInButton:IButton;
		private var _zoomOutButton:IButton;
		private var _dragTrack:ISlider;
		//private var _startY:int;
		//private var _maxY:int;
		
		public function UITouchCamera(targetObject:Entity=null, panAngle:Number=0, tiltAngle:Number=90, distance:Number=1000) {
			super(targetObject, panAngle, tiltAngle, distance);
		}
		
		public function set zoomInButton(value:IButton):void {
			_zoomInButton = value;
		}
		
		public function set zoomOutButton(value:IButton):void {
			_zoomOutButton = value;
		}
		
	}

}