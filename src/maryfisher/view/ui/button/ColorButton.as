package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import maryfisher.view.ui.component.BaseBitmap;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ColorButton extends TextSpriteButton {
		
		protected var _bgScheme:ButtonColorScheme;
		
		public function ColorButton(id:String, w:int, h:int, colorScheme:ButtonColorScheme, textColorScheme:ButtonColorScheme, textfield:FormatText = null, hasSelectedState:Boolean = true) {
			_bgScheme = colorScheme;
			super(id, textColorScheme, textfield, true, false);
			_textField.width = w;
			_textField.height = h;
			_height = h;
			_width = w;
		}
		
		override protected function setStates():void {
			_button.defaultState = getState(_textScheme.upColor, _bgScheme.upColor);
			_button.disabledState = getState(_textScheme.disabledColor, _bgScheme.disabledColor);
			_button.overState = getState(_textScheme.overColor, _bgScheme.overColor);
			_button.downState = getState(_textScheme.downColor, _bgScheme.downColor);
			_button.selectedState = getState(_textScheme.selectedColor, _bgScheme.selectedColor);
			
		}
		
		private function getState(textColor:uint, color:uint):BaseBitmap {
			return new BaseBitmap(drawTextData(new BitmapData(_width, _height, false, color), textColor));
		}
	}

}