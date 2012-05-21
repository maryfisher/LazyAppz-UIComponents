package maryfisher.view.ui.button {
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import maryfisher.austengames.view.components.TextColorScheme;
	import maryfisher.view.ui.component.FormatText;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextSpriteButton extends BaseSpriteButton {
		
		private var _colorScheme:TextColorScheme;
		
		protected var _label:FormatText;
		
		//private var _hasOver:Boolean = false;
		//private var _hasDown:Boolean = false;
		
		public function TextSpriteButton(id:String, colorScheme:TextColorScheme, textfield:FormatText = null) {
			super(id);
			_colorScheme = colorScheme;
			_label = textfield || new FormatText();
			//_label.mouseEnabled = false;
			_label.wordWrap = false;
			_label.autoSize = TextFieldAutoSize.CENTER;
			_label.align = "center";
			_label.textColor = _colorScheme.upColor;
			addChild(_label);
		}
		
		protected function set textColor(color:uint):void {
			_label.textColor = color;
		}
		
		CONFIG::mouse
		override protected function onOver():void {
			super.onOver();
			_label.textColor = _colorScheme.overColor;
			
		}
		
		override protected function onDown():void {
			super.onDown();
			_label.textColor = _colorScheme.downColor;
		}
		
		override protected function showUpState():void {
			_label.textColor = _colorScheme.upColor;
		}
		
		override protected function onUp():void {
			super.onUp();
			_label.textColor = _colorScheme.upColor;
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
				textColor = _colorScheme.downColor;
			}
		}
	}

}