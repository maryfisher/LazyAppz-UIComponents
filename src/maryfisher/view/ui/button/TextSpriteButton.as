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
		
		protected var _label:FormatText;
		
		//private var _hasOver:Boolean = false;
		//private var _hasDown:Boolean = false;
		
		public function TextSpriteButton(id:String, colorScheme:ButtonColorScheme, textfield:FormatText = null, centerButton:Boolean = true, overwrite:Boolean = true) {
			super(id);
			_colorScheme = colorScheme;
			_label = textfield || new FormatText();
			//_label.mouseEnabled = false;
			if(overwrite && centerButton){
				_label.wordWrap = false;
				_label.autoSize = TextFieldAutoSize.CENTER;
				_label.align = "center";
			}else if (overwrite && !centerButton) {
				_label.align = "left";
				_label.autoSize = TextFieldAutoSize.LEFT;
			}
			_label.textColor = _colorScheme.upColor;
			addChild(_label);
		}
		
		public function set textColor(color:uint):void {
			_label.textColor = color;
		}
		
		CONFIG::mouse
		override public function showOverState():void {
			super.showOverState();
			_label.textColor = _colorScheme.overColor;
			//trace(_label.textColor.toString(16));
		}
		
		override protected function onDown():void {
			super.onDown();
			_label.textColor = _colorScheme.downColor;
		}
		
		override public function showUpState():void {
			super.showUpState();
			_label.textColor = _colorScheme.upColor;
		}
		
		override protected function onUp():void {
			super.onUp();
			_label.textColor = _colorScheme.overColor;
		}
		
		public function set label(value:String):void {
			_label.text = value;
		}
		
		public function get label():String {
			return _label.text;
		}
		
		public function set textFormat(value:TextFormat):void {
			_label.format = value;
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
	}

}