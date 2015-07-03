package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import maryfisher.framework.core.ViewController;
	import maryfisher.view.event.ButtonEvent;
	import maryfisher.view.event.ButtonSignalEvent;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ITooltip;
	import maryfisher.view.ui.interfaces.ITooltipButton;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseSpriteButton extends AbstractSpriteButton implements ITooltipButton {
		//private var _isTouch:Boolean;
		private var _isDown:Boolean;
		
		protected var _tooltip:ITooltip;
		CONFIG::mouse
		protected var _overState:DisplayObject;
		
		private var _overSignal:Signal;
		private var _outSignal:Signal;
		protected var _overCursor:String = MouseCursor.BUTTON;
		protected var _outCursor:String = MouseCursor.ARROW;
		
		public function BaseSpriteButton(id:String) {
			//_isTouch = isTouch;
			super(id);
			//if(_isTouch) buttonMode = true;
			CONFIG::mouse {
				buttonMode = true;
			}
		}
		
		public function addOverListener(listener:Function):void {
			if (!_overSignal) {
				_overSignal = new Signal(IButton);
			}
			_overSignal.add(listener);
		}
		
		public function addOutListener(listener:Function):void {
			if (!_outSignal) {
				_outSignal = new Signal(IButton);
			}
			_outSignal.add(listener);
		}
		
		override protected function addListeners():void {
			CONFIG::mouse {
				addMouseListeners();
			}
			CONFIG::touch{
				addTouchListeners();
			}
		}
		
		override protected function addRightClick():void {
			CONFIG::mouse{
				addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			}
			
			CONFIG::touch {
				/** TODO
				 * 
				 */
			}
		}
		
		CONFIG::touch
		private function addTouchListeners():void {
			if (_hitTest) {
				_hitTest.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, false);
				_hitTest.addEventListener(TouchEvent.TOUCH_END, onTouchEnd, false);
				return;
			}
			
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		CONFIG::touch
		protected function onTouchEnd(e:TouchEvent):void {
			if (!_isDown) {
				return;
			}
			onUp();
			_isDown = false;
		}
		CONFIG::touch
		protected function onTouchBegin(e:TouchEvent):void {
			if (_isDown) {
				return;
			}
			_isDown = true;
			onDown();
		}
		CONFIG::mouse
		private function addMouseListeners():void {
			if (_hitTest) {
				_hitTest.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false);
				_hitTest.addEventListener(MouseEvent.CLICK, onMouseUp, false);
				_hitTest.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false);
				return;
			}
			
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false);
		}
		
		CONFIG::mouse
		private function onRightClick(e:MouseEvent):void {
			onRight();
		}
		
		override protected function removeListeners():void {
			CONFIG::touch {
				removeTouchListeners();
			}
			CONFIG::mouse{
				removeMouseListeners();
			}
		}
		
		CONFIG::touch
		private function removeTouchListeners():void {
			if (!_hitTest) {
				removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		CONFIG::mouse
		protected function onOver():void {
			showOverState();
			
			_overSignal && _overSignal.dispatch(this);
			Mouse.cursor = _overCursor;
			//trace("[BaseSpriteButton] onOver cursor:", _overCursor);
			//_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent(ButtonSignalEvent.ON_OVER)));
			/** TODO
			 * 
			 */
			//dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_OVER, _id));
		}
		
		CONFIG::mouse
		private function removeMouseListeners():void {
			if(!_hitTest){
				removeEventListener(MouseEvent.ROLL_OVER, onMouseOver, false);
				removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false);
				removeEventListener(MouseEvent.MOUSE_UP, onMouseUp, false);
				removeEventListener(MouseEvent.ROLL_OUT, onMouseOut, false);
				return;
			}
		}
		
		CONFIG::mouse
		public function showOverState():void {
			if (_overState) {
				_upState && (_upState.visible = false);
				_overState.visible = true;
			}
		}
		
		CONFIG::mouse
		protected function onMouseDown(e:MouseEvent):void {
			if (!enabled) {
				return;
			}
			onDown();
		}
		CONFIG::mouse
		protected function onMouseOver(e:MouseEvent):void {
			_tooltip && _tooltip.show();
			if (!enabled) {
				return;
			}
			if (_selected) {
				return;
			}
			/* TODO
			 * Tween!
			 */
			onOver();
			
		}
		CONFIG::mouse
		protected function onMouseOut(e:MouseEvent):void {
			_tooltip && _tooltip.hide();
			if (!_enabled || _selected) {
				return;
			}
			/** TODO
			 * 
			 */
			//dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_OUT, _id));
			Mouse.cursor = _outCursor;
			_outSignal && _outSignal.dispatch(this);
			showUpState();
			
		}
		CONFIG::mouse
		protected function onMouseUp(e:MouseEvent):void {
			onUp();
		}
		
		override protected function onUp():void {
			if (!_enabled) {
				return;
			}
			if(!_selected) showOverState();
			//if (_overState) _overState.visible = true;
			super.onUp();
		}
		
		override public function showUpState():void {
			super.showUpState();
			CONFIG::mouse{
				if (_overState) _overState.visible = false;
			}
		}
		
		public function attachTooltip(tooltip:ITooltip):void {
			_tooltip = tooltip;
			
		}
		
		override public function set enabled(value:Boolean):void {
			
			if (_enabled == value) {
				return;
			}
			CONFIG::mouse{
				if (!value) {
					onMouseOut(null);
				}
			}
			super.enabled = value;
			buttonMode = _enabled;
		}
		
		CONFIG::mouse
		public function set overState(value:DisplayObject):void {
			//var index:int = numChildren - 2;
			if (_overState) {
				if (contains(_overState)) {
					//var index:int = getChildIndex(_overState);
					removeChild(_overState);
				}
			}
			_overState = value;
			if (!_overState) return;
			
			_overState.visible = false;
			if (_downState && contains(_downState)) {
				addChildAt(_overState, getChildIndex(_downState));
				return;
			}
			addChildAt(_overState, getChildIndex(_upState));
		}
		
		public function set overCursor(value:String):void {
			_overCursor = value;
		}
		
		public function set outCursor(value:String):void {
			_outCursor = value;
		}
		
		public function get tooltip():ITooltip {
			return _tooltip;
		}
		
		public function get overState():DisplayObject {
			return _overState;
		}
		
		//public function set defaultState(value:DisplayObject):void {
			//_defaultState = value;
		//}
	}
}