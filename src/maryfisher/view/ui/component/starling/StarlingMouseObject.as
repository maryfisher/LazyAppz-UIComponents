package maryfisher.view.ui.component.starling {
	
	import maryfisher.view.ui.interfaces.IMouseObject;
	import org.osflash.signals.Signal;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingMouseObject extends Sprite implements IMouseObject{
		
		private var _mouseOutCallback:Signal;
		private var _mouseOverCallback:Signal;
		
		private var _hasMouseOver:Boolean;
		private var _hasMouseOut:Boolean;
		
		public function StarlingMouseObject() {
			mouseOutCallback = new Signal();
			mouseOverCallback = new Signal();
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IMouseObject */
		
		public function addMouseOver(callback:Function):void {
			_hasMouseOver = true;
			addTouchListener();
		}
		
		public function addMouseOut(callback:Function):void {
			_hasMouseOut = true;
			addTouchListener();
		}
		
		public function removeMouseOver(callback:Function):void {
			_hasMouseOver = false;
			removeTouchListener();
		}
		
		public function removeMouseOut(callback:Function):void {
			_hasMouseOut = false;
			removeTouchListener();
		}
		
		private function removeTouchListener():void {
			if (_hasMouseOut || _hasMouseOver) return;
			removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function addTouchListener():void {
			if (hasEventListener(TouchEvent.TOUCH)) return;
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void {
			if (e.getTouch(this, TouchPhase.HOVER)) {
				// rollover code goes here
				_mouseOverCallback.dispatch();
			} else {
				// rollout code goes here
				_mouseOutCallback.dispatch();
			}
		 
			if (e.getTouch(this, TouchPhase.ENDED)) {
				// click code goes here
			}
		}
		
		public function get mouseOutCallback():Signal {
			return _mouseOutCallback;
		}
		
		public function get mouseOverCallback():Signal {
			return _mouseOverCallback;
		}
	}
}