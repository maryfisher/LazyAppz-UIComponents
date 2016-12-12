package maryfisher.view.ui.button {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import maryfisher.view.ui.component.BaseBitmap;
	import maryfisher.view.ui.component.FormatText;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextSpriteButton extends BaseSpriteButton {
		
		protected var _centerButton:Boolean;
		protected var _textScheme:ButtonColorScheme;
		protected var _textField:FormatText;
		protected var _height:Number = 0;
		protected var _width:Number = 0;
		
		public function TextSpriteButton(id:String, colorScheme:ButtonColorScheme, textfield:FormatText = null, centerButton:Boolean = true, overwrite:Boolean = false) {
			super(id);
			_centerButton = centerButton;
			_textScheme = colorScheme;
			_textField = textfield || new FormatText();
			
			if(centerButton){
				_textField.align = "center";
				if(overwrite){
					_textField.autoSize = TextFieldAutoSize.CENTER;
				}
			}else {
				_textField.align = "left";
				if(overwrite)
					_textField.autoSize = TextFieldAutoSize.LEFT;
			}
		}
		
		public function get label():String {
			return _textField.text;
		}
		
		public function set label(value:String):void {
			_textField.text = value;
			setTextDims();
			setStates();
		}
		
		protected function setTextDims():void {
			if(_height == 0){
				_height = _textField.textHeight;
			}
			if(_width == 0){
				_width = _textField.textWidth;
			}
		}
		
		public function set textScheme(value:ButtonColorScheme):void {
			_textScheme = value;
		}
		
		public function get textField():FormatText {
			return _textField;
		}
		
		public function set textFormat(value:TextFormat):void {
			_textField.format = value;
			/** TODO
			 * 
			 */
			//_textFormat = value;
			//_label.defaultTextFormat = _textFormat;
			//_label.setTextFormat(_textFormat);
		}
		
		protected function setStates():void {
			setButtonStates(
				getTextState(_textScheme.upColor),
				getTextState(_textScheme.overColor), 
				getTextState(_textScheme.downColor),
				getTextState(_textScheme.disabledColor),
				getTextState(_textScheme.selectedColor));
			
		}
		
		protected function drawTextData(st:BitmapData, textColor:uint):BitmapData {
			var m:Matrix = new Matrix();
			m.translate(_textField.x, (_height - _textField.textHeight) >> 1);
			_textField.textColor = textColor;
			st.draw(_textField, m);
			return st;
		}
		
		private function getTextState(textColor:uint):BaseBitmap {
			return new BaseBitmap(drawTextData(new BitmapData(_width, _height, true, 0), textColor));
		}
	}

}