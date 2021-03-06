package maryfisher.view.ui.button {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ButtonColorScheme {
		public var upColor:uint;
		public var downColor:uint;
		public var overColor:uint;
		public var disabledColor:uint;
		public var selectedColor:uint;
		
		public function ButtonColorScheme(upColor:uint, overColor:uint, downColor:uint = 0, disabledColor:uint = 0, selectedColor:uint = 0) {
			this.upColor = upColor;
			this.downColor = downColor;
			this.overColor = overColor;
			this.disabledColor = disabledColor;
			this.selectedColor = selectedColor;
		}
		
		public function clone():ButtonColorScheme {
			return new ButtonColorScheme(upColor, overColor, downColor, disabledColor, selectedColor);
		}
	}

}