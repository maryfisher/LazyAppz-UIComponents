package maryfisher.view.ui.button {
	import flash.display.BitmapData;
	import maryfisher.view.ui.component.BaseBitmap;
	import maryfisher.view.ui.component.FormatText;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextImageButton extends TextSpriteButton {
		private var _defaultS:BitmapData;
		private var _overS:BitmapData;
		private var _downS:BitmapData;
		private var _disabledS:BitmapData;
		private var _selectedS:BitmapData;
		
		public function TextImageButton(id:String, colorScheme:ButtonColorScheme, textfield:FormatText=null, centerButton:Boolean=true, overwrite:Boolean=false) {
			super(id, colorScheme, textfield, centerButton, overwrite);
			
		}
		
		override protected function setStates():void {
			setButtonStates(
				new BaseBitmap(drawTextData(_defaultS.clone(), _textScheme.upColor)),
				new BaseBitmap(drawTextData(_overS.clone(), _textScheme.overColor)),
				new BaseBitmap(drawTextData(_downS.clone(), _textScheme.downColor)),
				_disabledS ? new BaseBitmap(drawTextData(_disabledS.clone(), _textScheme.disabledColor)) : null,
				_selectedS ? new BaseBitmap(drawTextData(_selectedS.clone(), _textScheme.selectedColor)) : null
			)
			
		}
		
		public function setImageStates(defaultS:BitmapData, overS:BitmapData, downS:BitmapData, disabledS:BitmapData = null, selectedS:BitmapData = null):void {
			_selectedS = selectedS;
			_disabledS = disabledS;
			_downS = downS;
			_overS = overS;
			_defaultS = defaultS;
			_width = _defaultS.width;
			_height = _defaultS.height;
			_textField.x = 0;
			_textField.y = 0;
			_textField.width = _width;
			_textField.height = _height;
			//setStates();
		}
		
	}

}