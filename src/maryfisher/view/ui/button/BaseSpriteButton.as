package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.event.ButtonEvent;
	import maryfisher.view.event.ButtonSignalEvent;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ITooltip;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseSpriteButton extends AbstractSpriteButton{
		//private var _isTouch:Boolean;
		private var _isDown:Boolean;
		
		protected var _tooltip:ITooltip;
		CONFIG::mouse
		protected var _overState:DisplayObject;
		
		private var _overSignal:Signal;
		
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
			if (!enabled) {
				return;
			}
			_tooltip && _tooltip.show();
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
			showOverState();
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
			if (_overState) {
				if (contains(_overState)) removeChild(_overState);
			}
			_overState = value;
			if (!_overState) return;
			
			_overState.visible = false;
			if (_downState) {
				addChildAt(_overState, numChildren - 2);
				return;
			}
			addChild(_overState);
		}
		
		//public function set defaultState(value:DisplayObject):void {
			//_defaultState = value;
		//}
	}
}