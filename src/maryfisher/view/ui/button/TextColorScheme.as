package maryfisher.view.ui.button {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextColorScheme {
		public var upColor:uint;
		public var downColor:uint;
		public var overColor:uint;
		public var disabledColor:uint;
		public var selectedColor:uint;
		
		public function TextColorScheme(upColor:uint, downColor:uint, overColor:uint = NaN, disabledColor:uint = NaN, selectedColor:uint = NaN) {
			this.upColor = upColor;
			this.downColor = downColor;
			this.overColor = overColor;
			this.disabledColor = disabledColor;
			this.selectedColor = selectedColor;
		}
		
	}

}