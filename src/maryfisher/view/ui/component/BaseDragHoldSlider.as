package maryfisher.view.ui.component {
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.interfaces.ISlider;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseDragHoldSlider extends AbstractSlider {
		
		private var _direction:int;
		private var _startPos:int;
		
		public function BaseDragHoldSlider() {
			super();
		}
		
		override public function assignThumb(thumb:DisplayObject, minPos:int, maxPos:int, isVertical:Boolean = true):void {
			super.assignThumb(thumb, minPos, maxPos, isVertical);
			_startPos = _isVertical ? _thumb.y : _thumb.x;
		}
		
		private function onEnterFrame(e:Event):void {
			calculatePosition();
			_direction = (_currenPos - _startPos) * 0.3;
			_updateSignal.dispatch(_direction);
		}
		
		private function snapBack():void {
			stage && stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			/* TODO
			 * tween?
			 */
			Tweener.removeTweens(_thumb);
			if (_isVertical) {
				_thumb.y = _startPos;
			}else {
				_thumb.x = _startPos;
			}
		}
		
		CONFIG::touch
		override protected function onTouchBegin(e:TouchEvent):void {
			//_beginPoint = _isVertical ? stage.mouseY : stage.mouseX;
			stage && stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			super.onTouchBegin(e);
		}
		CONFIG::touch
		override protected function onTouchEnd(e:TouchEvent):void {
			snapBack();
		}
		CONFIG::mouse
		override protected function onMouseDown(ev:MouseEvent):void {
			//_beginPoint = _isVertical ? stage.mouseY : stage.mouseX;
			stage && stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			super.onMouseDown(ev);
		}
		CONFIG::mouse
		override protected function onMouseUp(ev:MouseEvent):void {
			snapBack();
		}
	}

}