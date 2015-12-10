package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	import maryfisher.framework.view.IDisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SimpleButton extends BaseSpriteButton {
		
		public function SimpleButton(id:String, upState:IDisplayObject, overState:IDisplayObject, downState:IDisplayObject, disabledState:IDisplayObject = null, selectedState:IDisplayObject = null) {
			super(id);
			setButtonStates(upState, overState, downState, disabledState, selectedState);
			//_defaultState = upState;
			//if (disabledState) {
				//_disabledState = disabledState;
			//}else {
				//drawDisabledState(false, true);
			//}
			//this.upState = upState;
			//this.overState = overState;
			//this.downState = downState;
		}
	}

}