package maryfisher.view.ui.button {
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import maryfisher.austengames.view.components.TextColorScheme;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TextSpriteButton extends BaseSpriteButton {
		
		private var _colorScheme:TextColorScheme;
		
		protected var _label:TextField;
		
		//protected var _overColor:uint;
		//protected var _upColor:uint;
		//protected var _downColor:uint;
		
		protected var _textFormat:TextFormat;
		
		private var _hasOver:Boolean = false;
		private var _hasDown:Boolean = false;
		
		public function TextSpriteButton(id:String, colorScheme:TextColorScheme, isTouch:Boolean = false) {
			super(id, isTouch);
			_colorScheme = colorScheme;
			_label = new TextField();
			_label.wordWrap = false;
			_label.autoSize = TextFieldAutoSize.CENTER;
			addChild(_label);
		}
		
		protected function set textColor(color:uint):void {
			_label.textColor = color;
		}
		
		override protected function onOver():void {
			super.onOver();
			if(_hasOver) _label.textColor = _colorScheme.overColor;
			
		}
		
		override protected function onDown():void {
			super.onDown();
			if(_hasDown) _label.textColor = _colorScheme.downColor;
		}
		
		override protected function onUp():void {
			super.onUp();
			_label.textColor = _colorScheme.upColor;
		}
		
		protected function set hasOver(value:Boolean):void {
			_hasOver = value;
		}
		
		protected function set hasDown(value:Boolean):void {
			_hasDown = value;
		}
		
		public function set label(value:String):void {
			_label.text = value;
		}
		
		public function get label():String {
			return _label.text;
		}
		
		public function set textFormat(value:TextFormat):void {
			_textFormat = value;
			_label.defaultTextFormat = _textFormat;
			_label.setTextFormat(_textFormat);
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