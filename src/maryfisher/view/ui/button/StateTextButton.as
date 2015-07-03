package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StateTextButton extends TextSpriteButton {
		
		public function StateTextButton(id:String, upState:DisplayObject, overState:DisplayObject, downState:DisplayObject, colorScheme:ButtonColorScheme) {
			_defaultState = upState;
			if (disabledState) {
				_disabledState = disabledState;
			}else {
				drawDisabledState(false, true);
			}
			this.upState = upState;
			this.overState = overState;
			this.downState = downState;
			
			super(id, colorScheme, textfield, centerButton, overwrite);
			
		}
		
	}

}