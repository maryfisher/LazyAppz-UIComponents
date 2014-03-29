package maryfisher.view.ui.button {
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import maryfisher.view.ui.component.FormatText;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextSpriteButton extends BaseSpriteButton {
		
		protected var _colorScheme:ButtonColorScheme;
		
		protected var _textField:FormatText;
		
		//private var _hasOver:Boolean = false;
		//private var _hasDown:Boolean = false;
		
		public function TextSpriteButton(id:String, colorScheme:ButtonColorScheme, textfield:FormatText = null, centerButton:Boolean = true, overwrite:Boolean = true) {
			super(id);
			_colorScheme = colorScheme;
			_textField = textfield || new FormatText();
			
			//_label.mouseEnabled = false;
			if (overwrite && centerButton) {
				_textField.wordWrap = false;
				//trace(_textField.x);
				_textField.autoSize = TextFieldAutoSize.CENTER;
				//trace(_textField.x);
				_textField.align = "center";
			}else if (overwrite && !centerButton) {
				_textField.align = "left";
				_textField.autoSize = TextFieldAutoSize.LEFT;
			}
			//_textField.x = 0;
			_textField.textColor = _colorScheme.upColor;
			addChild(_textField);
		}
		
		public function set textColor(color:uint):void {
			_textField.textColor = color;
		}
		
		CONFIG::mouse
		override public function showOverState():void {
			super.showOverState();
			_textField.textColor = _colorScheme.overColor;
			//trace(_label.textColor.toString(16));
		}
		
		override protected function onDown():void {
			super.onDown();
			_textField.textColor = _colorScheme.downColor;
		}
		
		override public function showUpState():void {
			super.showUpState();
			_textField.textColor = _colorScheme.upColor;
		}
		
		//override protected function onUp():void {
			//super.onUp();
			//_textField.textColor = _colorScheme.overColor;
		//}
		
		public function set label(value:String):void {
			_textField.text = value;
			_textField.y = int((height - _textField.height) / 2);
			//trace(_textField.y, height, _textField.height);
		}
		
		public function get label():String {
			return _textField.text;
		}
		
		public function set textFormat(value:TextFormat):void {
			_textField.format = value;
			//_textFormat = value;
			//_label.defaultTextFormat = _textFormat;
			//_label.setTextFormat(_textFormat);
		}
		
		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			if (_enabled) {
				textColor = _colorScheme.upColor;
			}else {
				textColor = _colorScheme.disabledColor;
			}
		}
		
		public function set colorScheme(value:ButtonColorScheme):void {
			_colorScheme = value;
		}
		
		public function get textField():FormatText {
			return _textField;
		}
	}

}