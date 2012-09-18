package maryfisher.view.ui.component {
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSlider extends AbstractSlider {
		
		
		public function BaseSlider() {
			super()
		}
		
		CONFIG::touch
		override protected function onTouchEnd(e:TouchEvent):void {
			stage && stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		}
		CONFIG::touch
		override protected function onTouchBegin(e:TouchEvent):void {
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			super.onMouseDown(e);
		}
		
		CONFIG::mouse
		override protected function onMouseUp(ev:MouseEvent):void {
			stage && stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		CONFIG::mouse
		override protected function onMouseDown(ev:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			super.onMouseDown(ev);
			//calculateOffset()
		}
		
		CONFIG::mouse
		public function mouseWheel(delta:Number):void {
			var pos:Number = (_isVertical ? _thumb.y : _thumb.x) - delta * 10;
			assignDiff(pos);
		}
		
		public function getPercent():Number {
			return _currenPos / (_maxPos - _minPos);
		}
		
		CONFIG::touch
		private function onTouchMove(e:TouchEvent):void {
			calculatePosition();
		}
		CONFIG::mouse
		private function onMouseMove(ev:MouseEvent):void {
			calculatePosition();
		}
		
		override protected function tweenThumb():void {
			super.tweenThumb();
			var sp:Number = _currenPos / _maxPos;
			_updateSignal.dispatch(sp);
			
		}
	}
}