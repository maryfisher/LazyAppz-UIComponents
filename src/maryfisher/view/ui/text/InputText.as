package maryfisher.view.ui.text {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import maryfisher.view.event.TextInputSignalEvent;
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
		protected var _activated:Boolean;
		//private var _enterKey:Boolean;
		private var _maxLines:int;
		private var _prevText:String;
		private var _id:String;
		private var _autoDeactivate:Boolean;
		
		public function InputText(id:String, inputLabel:FormatText, autoDeactivate:Boolean = true) {
			_autoDeactivate = autoDeactivate;
			_inputLabel = inputLabel;
			_id = id;
			_bubbleSignal = new DeluxeSignal(this);
			_inputLabel.addEventListener(Event.CHANGE, onTextChange);
			_inputLabel.type = TextFieldType.INPUT;
			_inputLabel.maxChars = 0;
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

		//public function set enterKey(value:Boolean):void {
			//_enterKey = value;
		//}
		
		public function set maxChars(chars: int): void {
			_inputLabel.maxChars = chars;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get label():String {
			
			//var escaped:String = _inputLabel.text;
			//escaped = escaped.split("'").join("\\\"");
			//trace(escaped);
			//trace(escape(_inputLabel.text));
			//return escaped;
			return _inputLabel.text;
		}
		
		public function set label(value:String):void {
			//value = value.split("\\\"").join("'");
			_inputLabel.text = value;
		}
		
		public function get activated():Boolean {
			return _activated;
		}
		
		public function set autoDeactivate(value:Boolean):void {
			_autoDeactivate = value;
		}
		
		public function restrictLabel(value:String):void {
			_inputLabel.restrict = value;
		}
		
		public function activate():void {
			_activated = true;
			_inputLabel.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//removeEventListener(MouseEvent.CLICK, onMouseClicked);
			if(_autoDeactivate){
				_inputLabel.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onFocusOut);
			//}else {
				//_inputLabel.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, 
			}
			
			_inputLabel.selectable = true;
			stage.focus = _inputLabel;
			_inputLabel.setSelection(0, _inputLabel.length);
			
			_bubbleSignal.dispatch(new TextInputSignalEvent(TextInputSignalEvent.ON_ACTIVATED));
		}
		
		public function getSelectionLength():int {
			return -_inputLabel.selectionBeginIndex + _inputLabel.selectionEndIndex;
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.ENTER && _autoDeactivate) {
				changeFinished();
			}
			//if (_inputLabel.numLines == _maxLines) {
				//_inputLabel.text = _prevText || '';
			//}
			else {
				_prevText = _inputLabel.text;
			}
		}
		
		public function deactivate():void {
			if (!_activated) return;
			_activated = false;
			
			_inputLabel.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//addEventListener(MouseEvent.CLICK, onMouseClicked);
			if (_autoDeactivate) {
				_inputLabel.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			}else {
				_bubbleSignal.dispatch(new TextInputSignalEvent(TextInputSignalEvent.ON_DEACTIVATED));
			}
			
			//_inputLabel.setSelection(_inputLabel.length, _inputLabel.length);
			//_inputLabel.selectable = false;
			if(stage.focus == _inputLabel){
				stage.focus = null;
			}
		}
		
		private function changeFinished():void {
			deactivate();
			//_bubbleSignal.dispatch(new GenericEvent(true));
			_bubbleSignal.dispatch(new TextInputSignalEvent(TextInputSignalEvent.ON_CHANGE_FINISHED));
		}
		
		protected function onMouseClicked(event:MouseEvent): void {
			if (!_activated) {
				activate();
			}else {
				/** TODO
				 * is this going to be a problem with clicking elsewhere especially considering autoDeactivation??
				 */
				if (stage.focus != _inputLabel) {
					_inputLabel.setSelection(_inputLabel.length, _inputLabel.length);
				}
				_bubbleSignal.dispatch(new TextInputSignalEvent(TextInputSignalEvent.ON_SELECTION_CHANGED));
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