package maryfisher.view.ui.button.starling {
	import flash.display.BitmapData;
	import flash.text.TextFieldAutoSize;
	import maryfisher.view.ui.button.ButtonColorScheme;
	import maryfisher.view.ui.component.FormatText;
	import maryfisher.view.ui.component.starling.BaseImage;
	import maryfisher.view.ui.component.starling.BaseStarling;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextStarlingButton extends BaseStarlingButton {
		
		protected var _colorScheme:ButtonColorScheme;
		protected var _label:FormatText;
		protected var _height:int;
		protected var _width:int;
		
		public function TextStarlingButton(id:String, colorScheme:ButtonColorScheme, textfield:FormatText = null, centerButton:Boolean = true) {
			super(id);
			_colorScheme = colorScheme;
			
			_label = textfield || new FormatText();
			
			if (centerButton) {
				_label.wordWrap = false;
				_label.autoSize = TextFieldAutoSize.CENTER;
				_label.align = "center";
			}else {
				_label.align = "left";
				_label.autoSize = TextFieldAutoSize.LEFT;
			}
			
			_label.align = "center"
		}
		
		public function set label(value:String):void {
			_label.text = value;
			if(_height == 0){
				_height = _label.textHeight;
			}
			if(_width == 0){
				_width = _label.textWidth;
			}
			_label.y = (_height - _label.textHeight) >> 1;
			setStates();
		}
		
		public function get label():String {
			return _label.text;
		}
		
		protected function setStates():void {
			_button.defaultState = getState(_colorScheme.upColor);
			_button.disabledState = getState(_colorScheme.disabledColor);
			_button.overState = getState(_colorScheme.overColor);
			_button.downState = getState(_colorScheme.downColor);
			_button.selectedState = getState(_colorScheme.selectedColor);
			
		}
		
		protected function drawTextData(st:BitmapData, textColor:uint):BitmapData {
			_label.textColor = textColor;
			st.draw(_label);
			return st;
		}
		
		private function getState(textColor:uint):BaseImage {
			return new BaseImage(Texture.fromBitmapData(drawTextData(new BitmapData(_width, _height, true, 0), textColor)));
		}
	}

}