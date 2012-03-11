package maryfisher.ui.button {
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import maryfisher.ui.interfaces.IButton;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseAppButton extends AbstractSpriteButton implements IButton {
		
		public function BaseAppButton(id:String) {
			super(id);
		}
		
		override protected function addListeners():void {
			if (_hitTest) {
				_hitTest.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, false);
				_hitTest.addEventListener(TouchEvent.TOUCH_END, onTouchEnd, false);
				return;
			}
			
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		
		private function onTouchEnd(e:TouchEvent):void {
			onUp()
		}
		
		private function onTouchBegin(e:TouchEvent):void {
			onDown();
		}
		
		override protected function removeListeners():void {
			if (!_hitTest) {
				removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
	}

}