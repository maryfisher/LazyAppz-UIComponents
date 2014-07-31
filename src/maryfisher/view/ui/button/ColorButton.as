package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ColorButton extends TextSpriteButton {
		protected var _bgScheme:ButtonColorScheme;
		
		public function ColorButton(id:String, w:int, h:int, colorScheme:ButtonColorScheme, textColorScheme:ButtonColorScheme, textfield:FormatText = null) {
			_bgScheme = colorScheme;
			//var bd:BitmapData = new BitmapData(w, h, false, colorScheme.upColor);
			//var bd2:BitmapData = new BitmapData(w, h, false, colorScheme.overColor);
			//var bd3:BitmapData = new BitmapData(w, h, false, colorScheme.downColor);
			
			//_defaultState = new Bitmap(bd);
			_defaultState = getState(w, h, colorScheme.upColor);
			if (colorScheme.disabledColor) {
				//_disabledState = new Bitmap(new BitmapData(w, h, false, colorScheme.disabledColor));
				_disabledState = getState(w, h, colorScheme.disabledColor);
			} else {
				//drawDisabledState(false, true);
			}
			this.upState = _defaultState;
			//this.overState = new Bitmap(bd2);
			this.overState = getState(w, h, colorScheme.overColor);
			//this.downState = new Bitmap(bd3);
			this.downState = getState(w, h, colorScheme.downColor);
			
			super(id, textColorScheme, textfield);
			
			_textField.x = 0;
			_textField.width = w;
			//_textField.y = int((h - _textField.height) / 2);
			//trace(_textField.y);
		}
		
		public function getState(w:int, h:int, color:uint):Bitmap {
			return new Bitmap(new BitmapData(w, h, false, color));
		}
		
		public function set bgScheme(value:ButtonColorScheme):void {
			_bgScheme = value;
		}
	}

}