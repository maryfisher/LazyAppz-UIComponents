package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SimpleTouchButton extends BaseSpriteButton {
		
		public function SimpleTouchButton(id:String, upState:DisplayObject, downState:DisplayObject, disabledState:DisplayObject = null) {
			super(id, true);
			
			_defaultState = upState;
			if (disabledState) {
				_disabledState = disabledState;
			}else {
				drawDisabledState(false, true);
			}
			this.upState = upState;
			this.downState = downState;
		}
		
	}

}