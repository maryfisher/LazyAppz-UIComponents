package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SimpleButton extends BaseSpriteButton {
		
		public function SimpleButton(id:String, upState:DisplayObject, overState:DisplayObject, downState:DisplayObject, disabledState:DisplayObject = null) {
			super(id);
			_defaultState = upState;
			if (disabledState) {
				_disabledState = disabledState;
			}else {
				drawDisabledState(false, true);
			}
			this.upState = upState;
			this.overState = overState;
			this.downState = downState;
		}
		
	}

}