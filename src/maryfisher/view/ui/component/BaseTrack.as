package maryfisher.view.ui.component {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import maryfisher.ui.interfaces.IScrollTrack;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseTrack extends Sprite implements IScrollTrack {
		
		private var _yOffset:Number;
		private var _yMin:Number;
		private var _yMax:Number;
		private var _thumb:Sprite;
		private var _direction:int;
		private var _updateSignal:Signal;
		
		public function BaseTrack() {
			_yMin = 0;
			_updateSignal = new Signal(int);
		}
		
		public function assignListeners():void {
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp, false, 0, true);
		}
		
		private function thumbDown(ev:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove, false, 0, true);
			_yOffset = mouseY - _thumb.y;
		}
		
		private function thumbUp(ev:MouseEvent):void {
			stage && stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove, false);
		}
		
		public function mouseWheel(delta:Number):void {
			if (_thumb != null) {
				var pos:Number = _thumb.y - delta * 10;
				assignDiff(pos);
			}
		}
		
		private function thumbMove(ev:MouseEvent):void {
			var pos:Number = mouseY - _yOffset;
			assignDiff(pos);
		}
		
		private function assignDiff(pos:Number):void {
			if (pos <= _yMin) {
				_thumb.y = _yMin;
			}else if (pos >= _yMax) {
				_thumb.y = _yMax;
			}else {
				_thumb.y = pos;
			}
			
			var sp:Number = _thumb.y / _yMax;
			_updateSignal.dispatch(sp);
			//dispatchEvent(new ScrollbarEvent(sp));
		}
		
		public function removeListeners():void {
			if (_thumb != null) {
				_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown, false);
			}
			
			if (stage != null) {
				stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp, false);
			}
			_thumb = null;
		}
		
		/* INTERFACE maryfisher.ui.interfaces.IScrollTrack */
		
		public function get updateSignal():Signal {
			return _updateSignal;
		}
		
	}

}