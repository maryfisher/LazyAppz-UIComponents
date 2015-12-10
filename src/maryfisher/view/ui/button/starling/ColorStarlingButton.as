package maryfisher.view.ui.button.starling {
	import flash.display.BitmapData;
	import maryfisher.view.ui.button.ButtonColorScheme;
	import maryfisher.view.ui.component.FormatText;
	import maryfisher.view.ui.component.starling.BaseImage;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ColorStarlingButton extends TextStarlingButton {
		
		protected var _bgScheme:ButtonColorScheme;
		
		public function ColorStarlingButton(id:String, w:int, h:int, colorScheme:ButtonColorScheme, textColorScheme:ButtonColorScheme, textfield:FormatText=null) {
			_bgScheme = colorScheme;
			
			super(id, textColorScheme, textfield);
			_label.width = w;
			_label.height = h;
			_height = h;
			_width = w;
		}
		
		override protected function setStates():void {
			_button.defaultState = getState(_colorScheme.upColor, _bgScheme.upColor);
			_button.disabledState = getState(_colorScheme.disabledColor, _bgScheme.disabledColor);
			_button.overState = getState(_colorScheme.overColor, _bgScheme.overColor);
			_button.downState = getState(_colorScheme.downColor, _bgScheme.downColor);
			_button.selectedState = getState(_colorScheme.selectedColor, _bgScheme.selectedColor);
			
		}
		
		private function getState(textColor:uint, color:uint):BaseImage {
			return new BaseImage(Texture.fromBitmapData(drawTextData(new BitmapData(_width, _height, false, color), textColor)));
		}
	}

}