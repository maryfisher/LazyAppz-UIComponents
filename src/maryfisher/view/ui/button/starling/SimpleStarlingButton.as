package maryfisher.view.ui.button.starling {
	import maryfisher.view.ui.component.starling.BaseImage;
	import starling.display.DisplayObject;
	import starling.display.Image;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SimpleStarlingButton extends BaseStarlingButton {
		
		public function SimpleStarlingButton(id:String, upState:BaseImage, overState:BaseImage, downState:BaseImage, disabledState:BaseImage = null) {
			super(id);
			_button.defaultState = upState;
			_button.overState = overState;
			_button.downState = downState;
			_button.disabledState = disabledState;
			//_button.selectedState = selectedState;
		}
		
	}

}