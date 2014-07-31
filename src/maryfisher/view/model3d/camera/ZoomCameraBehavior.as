package maryfisher.view.model3d.camera {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ZoomCameraBehavior extends AbstractCameraBehavior {
		
		private var _zoomDistance:int;
		private var _minDistance:int;
		private var _maxDistance:int;
		
		public function ZoomCameraBehavior(cameraController:BaseCameraController, zoomDistance:int = 100, minDistance:int = 3000, maxDistance:int = 10000) {
			super(cameraController);
			_maxDistance = maxDistance;
			_minDistance = minDistance;
			_zoomDistance = zoomDistance;
			
		}
		
		override public function start(stage:Stage):void {
			super.start(stage);
			
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		override public function stop():void {
			super.stop();
			_stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			/** TODO
			 * distance check
			 */
			//trace(_cameraController.distance);
			if (e.delta > 0 && _cameraController.distance <= _minDistance) return;
			if (e.delta < 0 && _cameraController.distance >= _maxDistance) return;
			//e.delta > 0 ist zoom rein
			_cameraController.distance -= e.delta * _zoomDistance;
		}
		
		public function set zoomDistance(value:int):void {
			_zoomDistance = value;
		}
		
		public function set minDistance(value:int):void {
			_minDistance = value;
		}
	}

}