package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.event.ButtonEvent;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseSpriteButton extends AbstractSpriteButton{
		//private var _isTouch:Boolean;
		private var _isDown:Boolean;
		
		protected var _tooltip:ITooltip;
		
		protected var _overState:DisplayObject;
		
		public function BaseSpriteButton(id:String) {
			//_isTouch = isTouch;
			super(id);
			//if(_isTouch) buttonMode = true;
			CONFIG::mouse {
				buttonMode = true;
			}
		}
		
		override protected function addListeners():void {
			CONFIG::mouse {
				addMouseListeners();
			}
			CONFIG::touch{
				addTouchListeners();
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
				_hitTest.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
				_hitTest.addEventListener(MouseEvent.CLICK, onMouseUp, false, 0, true);
				_hitTest.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
				return;
			}
			
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
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
		
		protected function onOver():void {
			if(_upState) _upState.visible = false;
			if(_overState) _overState.visible = true;
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
		protected function onMouseDown(e:MouseEvent):void {
			onDown();
		}
		CONFIG::mouse
		protected function onMouseOver(e:MouseEvent):void {
			if (!_enabled || _selected) {
				return;
			}
				/* TODO
				 * Tween!
				 */
			onOver();
			
		}
		CONFIG::mouse
		protected function onMouseOut(e:MouseEvent):void {
			if (!_enabled || _selected) {
				return;
			}
			showUpState();
			
		}
		CONFIG::mouse
		protected function onMouseUp(e:MouseEvent):void {
			super.onUp();
		}
		
		override protected function showUpState():void {
			super.showUpState();
			if(_overState) _overState.visible = false;
			//_tooltip && _tooltip.hide();
		}
		
		public function attachTooltip(tooltip:ITooltip):void {
			_tooltip = tooltip;
			
		}
		
		override public function set enabled(value:Boolean):void {
			
			if (_enabled == value) {
				return;
			}
			
			super.enabled = value;
			
			if (!value) {
				onMouseOut(null);
			}
			buttonMode = _enabled;
		}
		
		public function set overState(value:DisplayObject):void {
			_overState = value;
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