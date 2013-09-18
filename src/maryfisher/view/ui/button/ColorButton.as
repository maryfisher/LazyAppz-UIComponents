package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ColorButton extends BaseSpriteButton {
		
		public function ColorButton(id:String, w:int, h:int, colorScheme:ButtonColorScheme) {
			super(id);
			
			var bd:BitmapData = new BitmapData(w, h, false, colorScheme.upColor);
			var bd2:BitmapData = new BitmapData(w, h, false, colorScheme.overColor);
			var bd3:BitmapData = new BitmapData(w, h, false, colorScheme.downColor);
			
			_defaultState = new Bitmap(bd);
			if (colorScheme.disabledColor) {
				_disabledState = new Bitmap(new BitmapData(w,h,false,colorScheme.disabledColor));
			}else {
				//drawDisabledState(false, true);
			}
			this.upState = _defaultState;
			this.overState = new Bitmap(bd2);
			this.downState = new Bitmap(bd3);
		}
		
	}

}