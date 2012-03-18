package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SimpleTouchButton extends BaseSpriteButton {
		
		public function SimpleTouchButton(id:String, upState:DisplayObject, downState:DisplayObject, disabledState:DisplayObject = null) {
			super(id, true);
			
			if (disabledState) {
				_defaultState = upState;
				_disabledState = disabledState;
			}
			this.upState = upState;
			this.downState = downState;
		}
		
	}

}