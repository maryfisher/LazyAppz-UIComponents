package maryfisher.view.ui.component {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.component.AbstractSlider;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ToggleSlider extends AbstractSlider{
		
		private var _isOn:Boolean;
		private var _snapLine:int;
		
		public function ToggleSlider(isOn:Boolean = true) {
			super();
			_isOn = isOn;
		}
		
		//override protected function init():void {
			//_updateSignal = new Signal(ToggleSlider);
		//}
		
		override public function assignThumb(thumb:DisplayObject, minPos:int, maxPos:int, isVertical:Boolean = true):void {
			super.assignThumb(thumb, minPos, maxPos, isVertical);
			_snapLine = (_maxPos - _minPos) * 0.5;
		}
		
		CONFIG::mouse
		override protected function onMouseDown(ev:MouseEvent):void {
			super.onMouseDown(ev);
			stage && stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		CONFIG::mouse
		private function onMouseMove(e:MouseEvent):void {
			calculatePosition();
		}
		CONFIG::mouse
		override protected function onMouseUp(ev:MouseEvent):void {
			stage && stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			snap();
		}
		
		CONFIG::touch
		override protected function onTouchBegin(e:TouchEvent):void {
			super.onTouchBegin(e);
			stage && stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		}
		CONFIG::touch
		private function onTouchMove(e:TouchEvent):void {
			calculatePosition();
		}
		CONFIG::touch
		override protected function onTouchEnd(e:TouchEvent):void {
			stage && stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			snap();
		}
		
		private function snap():void {
			var assign:int;
			if (_snapLine < _currenPos) {
				_isOn = false;
				assign = _minPos;
			}else {
				_isOn = true;
				assign = _maxPos;
			}
			_isVertical ? _thumb.y = assign : _thumb.x = assign;
			_updateSignal.dispatch(0);
		}
		
		public function get isOn():Boolean {
			return _isOn;
		}
		
		public function set isOn(value:Boolean):void {
			if (_isOn == value) {
				return;
			}
			_isOn = value;
			
			var assign:int = _isOn ? _maxPos : _minPos ;
			_isVertical ? _thumb.y = assign : _thumb.x = assign;
		}
		
	}

}