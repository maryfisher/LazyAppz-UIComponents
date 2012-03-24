package maryfisher.view.model3d {
	import away3d.containers.ObjectContainer3D;
	import away3d.controllers.LookAtController;
	import away3d.core.math.MathConsts;
	import away3d.entities.Entity;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Vector3D;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseCameraControllerOLD extends LookAtController implements ICameraController {
		static private const MOVE:Number = 25;
		
		private var _currentPositionX:Number;
		private var _currentPositionZ:Number;
		
		private var _currentPanAngle:Number = 0;
		private var _currentTiltAngle:Number = 90;
		
		private var _panAngle:Number = 0;
		private var _tiltAngle:Number = 90;
		
		private var _distance:Number = 1000;
		
		private var _minPanAngle:Number = -Infinity;
		private var _maxPanAngle:Number = Infinity;
		private var _minTiltAngle:Number = -80;
		private var _maxTiltAngle:Number = 90;
		
		private var _steps:Number = 8;
		private var _yFactor:Number = 2;
		private var _wrapPanAngle:Boolean = false;
		
		private var _moveUpdate:Boolean = false;
		
		private var _tiltSignal:Signal;
		private var _panSignal:Signal;
		protected var _stage:Stage;
		
		public function BaseCameraController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000, minTiltAngle:Number = -90, maxTiltAngle:Number = 40, minPanAngle:Number = NaN, maxPanAngle:Number = NaN, steps:Number = 8, yFactor:Number = 2, wrapPanAngle:Boolean = false){
			super(targetObject, lookAtObject);
			
			this.distance = distance;
			this.panAngle = panAngle;
			this.tiltAngle = tiltAngle;
			this.minPanAngle = minPanAngle || -Infinity;
			this.maxPanAngle = maxPanAngle || Infinity;
			this.minTiltAngle = minTiltAngle;
			this.maxTiltAngle = maxTiltAngle;
			_steps = steps;
			_yFactor = yFactor;
			_wrapPanAngle = wrapPanAngle;
			
			//values passed in contrustor are applied immediately
			_currentPanAngle = _panAngle;
			_currentTiltAngle = _tiltAngle;
			_currentPositionX = lookAtObject.position.x;
			_currentPositionZ = lookAtObject.position.z;
			
			_tiltSignal = new Signal(int);
			_panSignal = new Signal(int);
		}
		
		/* INTERFACE maryfisher.austengames.view.model3d.core.ICameraController */
		
		public function addTiltListener(listener:Function):void {
			_tiltSignal.add(listener);
		}
		
		public function addPanListener(listener:Function):void {
			_panSignal.add(listener);
		}
		
		public function destroy():void {
			_tiltSignal.removeAll();
			_panSignal.removeAll();
		}
		
		override public function update():void {
			
			if (_moveUpdate){
				//&& (_currentPositionX != lookAtObject.position.x ||
					//_currentPositionZ != lookAtObject.position.z)) {
				
				notifyUpdate();
				
				//_currentPositionX += (_tiltAngle - _currentTiltAngle)/(_steps + 1);
				//_currentPositionZ += (_panAngle - _currentPanAngle)/(_steps + 1);
				
				_moveUpdate = false;
				targetObject.x = lookAtObject.x + _distance;
				//targetObject.x = _currentPosition.x + _distance;
				targetObject.z = lookAtObject.z + _distance;
				//targetObject.z = _currentPosition.z + _distance;
			}
			
			if (_tiltAngle != _currentTiltAngle || _panAngle != _currentPanAngle) {
				
				
				notifyUpdate();
				
				if (_wrapPanAngle) {
					if (_panAngle < 0)
						panAngle = (_panAngle % 360) + 360;
					else
						panAngle = _panAngle % 360;
					
					if (panAngle - _currentPanAngle < -180)
						panAngle += 360;
					else if (panAngle - _currentPanAngle > 180)
						panAngle -= 360;
				}
				
				_currentTiltAngle += (_tiltAngle - _currentTiltAngle)/(_steps + 1);
				_currentPanAngle += (_panAngle - _currentPanAngle)/(_steps + 1);
				
				
				//snap coords if angle differences are close
				if ((Math.abs(_tiltAngle - _currentTiltAngle) < 0.01) && (Math.abs(_panAngle - _currentPanAngle) < 0.01)) {
					_currentTiltAngle = _tiltAngle;
					_currentPanAngle = _panAngle;
				}
			}
			
			targetObject.x = lookAtObject.x + _distance * Math.sin(_currentPanAngle * MathConsts.DEGREES_TO_RADIANS) * Math.cos(_currentTiltAngle * MathConsts.DEGREES_TO_RADIANS);
			targetObject.z = lookAtObject.z + _distance * Math.cos(_currentPanAngle * MathConsts.DEGREES_TO_RADIANS) * Math.cos(_currentTiltAngle * MathConsts.DEGREES_TO_RADIANS);
			targetObject.y = lookAtObject.y + _distance * Math.sin(_currentTiltAngle * MathConsts.DEGREES_TO_RADIANS) * _yFactor;
			
			super.update();
		}
		
		public function start(stage:Stage = null):void {
			_stage = stage;
			
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(e:Event):void {
			//if (_move) {
				//panAngle = 0.3 * (_stage.mouseX - _lastMouseX) + _lastPanAngle;
			//}
		}
		
		public function stop():void {
			_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function notifyMoveUpdate():void {
			notifyUpdate();
			_moveUpdate = true;
		}
		
		public function set panAngle(val:Number):void {
			val = Math.max(_minPanAngle, Math.min(_maxPanAngle, val));
			
			if (_panAngle == val)
				return;
			
			_panAngle = val;
			
			notifyUpdate();
		}
		
		public function set tiltAngle(val:Number):void {
			val = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, val));
			
			if (_tiltAngle == val)
				return;
			
			/* TODO
			 * smooth out
			 */
			//distance -= (_tiltAngle - val) * 4;
		
			_tiltAngle = val;
			
			notifyUpdate();
		}
		
		public function set distance(val:Number):void {
			if (_distance == val)
				return;
			
			_distance = val;
			
			notifyUpdate();
		}
		
		public function set minPanAngle(val:Number):void {
			if (_minPanAngle == val)
				return;
			
			_minPanAngle = val;
			
			panAngle = Math.max(_minPanAngle, Math.min(_maxPanAngle, _panAngle));
		}
		
		public function set maxPanAngle(val:Number):void {
			if (_maxPanAngle == val)
				return;
			
			_maxPanAngle = val;
			
			panAngle = Math.max(_minPanAngle, Math.min(_maxPanAngle, _panAngle));
		}
		
		public function set minTiltAngle(val:Number):void {
			if (_minTiltAngle == val)
				return;
			
			_minTiltAngle = val;
			
			tiltAngle = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, _tiltAngle));
		}
		
		public function set maxTiltAngle(val:Number):void {
			if (_maxTiltAngle == val)
				return;
			
			_maxTiltAngle = val;
			
			tiltAngle = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, _tiltAngle));
		}
		
		public function get panAngle():Number {
			return _panAngle;
		
		}
	}

}