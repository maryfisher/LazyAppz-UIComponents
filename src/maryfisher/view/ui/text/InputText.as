package maryfisher.view.ui.text {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import maryfisher.view.ui.component.BaseSprite;
	import maryfisher.view.ui.component.FormatText;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class InputText extends BaseSprite {
		
		private var _bubbleSignal:DeluxeSignal;
		protected var _inputLabel:FormatText;
		private var _activated:Boolean;
		private var _enterKey:Boolean;
		private var _maxLines:int;
		private var _prevText:String;
		private var _id:String;
		
		public function InputText(id:String, inputLabel:FormatText) {
			_inputLabel = inputLabel;
			_id = id;
			_bubbleSignal = new DeluxeSignal(this);
			_inputLabel.addEventListener(Event.CHANGE, onTextChange);
			_inputLabel.type = TextFieldType.INPUT;
			_inputLabel.maxChars = 15;
			_inputLabel.mouseEnabled = true;
			_inputLabel.selectable = true;
			addChild(_inputLabel);
			addEventListener(MouseEvent.CLICK, onMouseClicked);
			//addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
		}
		
		//private function onMouseOutsideClicked(e:MouseEvent):void {
			//changeFinished();
		//}
		
		private function onTextChange(e:Event):void {
			//nix??
			trace("input text changed??");
		}
		
		public function setFormatting(font:String, color:int, size:int, bold:Boolean = false, align:String = "left", italic:Boolean = false):void {
			_inputLabel.setFormatting(font, color, size, bold, align, italic);
		}
		
		public function set maxLines(value:int):void {
			_maxLines = value;
		}

		public function set enterKey(value:Boolean):void {
			_enterKey = value;
		}
		
		public function set maxChars(chars: int): void {
			_inputLabel.maxChars = chars;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get label():String {
			return _inputLabel.text;
		}
		
		public function set label(value:String):void {
			_inputLabel.text = value;
		}
		
		public function restrictLabel(value:String):void {
			_inputLabel.restrict = value;
		}
		
		public function activate():void {
			_activated = true;
			_inputLabel.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			removeEventListener(MouseEvent.CLICK, onMouseClicked);
			_inputLabel.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onFocusOut);
			
			_inputLabel.selectable = true;
			stage.focus = _inputLabel;
			_inputLabel.setSelection(0, _inputLabel.length);
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.ENTER) {
				_enterKey && changeFinished();
			}
			//if (_inputLabel.numLines == _maxLines) {
				//_inputLabel.text = _prevText || '';
			//}
			else {
				_prevText = _inputLabel.text;
			}
		}
		
		private function changeFinished():void {
			_activated = false;
			
			_inputLabel.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(MouseEvent.CLICK, onMouseClicked);
			_inputLabel.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			_inputLabel.selectable = false;
			if(stage.focus == _inputLabel){
				stage.focus = null;
			}
			
			//dispatch
			_bubbleSignal.dispatch(new GenericEvent(true));
		}
		
		protected function onMouseClicked(event:MouseEvent): void {
			if (!_activated) {
				activate();
			}
		}
		
		//protected function onFocusIn(event:FocusEvent): void {
			//trace("focus in");
			//onMouseClicked(null);
		//}
		
		private function onFocusOut(e:FocusEvent):void {
			changeFinished();
		}
	}

}