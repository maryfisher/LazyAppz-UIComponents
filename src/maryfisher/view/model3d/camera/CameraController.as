﻿package maryfisher.view.model3d.camera {
	//import away3d.arcane;
	import away3d.containers.*;
	import away3d.controllers.LookAtController;
	import away3d.entities.*;
	import away3d.core.math.*;
	import flash.ui.Keyboard;
	import maryfisher.framework.core.IKeyListener;
	import maryfisher.framework.core.KeyController;
	
	import flash.geom.Matrix3D;
	
	//use namespace arcane;
	
	/**
	 * Extended camera used to hover round a specified target object.
	 *
	 * @see	away3d.containers.View3D
	 */
	public class CameraController extends LookAtController implements IKeyListener {
		static private const MOVE:Number = 25;
		
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
		private var _panUpdate:Boolean = false;
		
		/**
		 * Fractional step taken each time the <code>hover()</code> method is called. Defaults to 8.
		 *
		 * Affects the speed at which the <code>tiltAngle</code> and <code>panAngle</code> resolve to their targets.
		 *
		 * @see	#tiltAngle
		 * @see	#panAngle
		 */
		public var steps:Number = 8;
		public var panSteps:Number = 8;
		
		/**
		 * Rotation of the camera in degrees around the y axis. Defaults to 0.
		 */
		public function get panAngle():Number
		{
			return _panAngle;
		}
		
		public function set panAngle(val:Number):void
		{
			val = Math.max(_minPanAngle, Math.min(_maxPanAngle, val));
			
			if (_panAngle == val)
				return;
			
			_panAngle = val;
			
			notifyUpdate();
		}
		
		/**
		 * Elevation angle of the camera in degrees. Defaults to 90.
		 */
		public function get tiltAngle():Number
		{
			return _tiltAngle;
		}
		
		public function set tiltAngle(val:Number):void
		{
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
		
		/**
		 * Distance between the camera and the specified target. Defaults to 1000.
		 */
		public function get distance():Number
		{
			return _distance;
		}
		
		public function set distance(val:Number):void
		{
			if (_distance == val)
				return;
			
			_distance = val;
			
			notifyUpdate();
		}
		
		/**
		 * Minimum bounds for the <code>panAngle</code>. Defaults to -Infinity.
		 *
		 * @see	#panAngle
		 */
		public function get minPanAngle():Number { return _minPanAngle; }
		public function set minPanAngle(val:Number):void {
			if (_minPanAngle == val)
				return;
			
			_minPanAngle = val;
			
			panAngle = Math.max(_minPanAngle, Math.min(_maxPanAngle, _panAngle));
		}
		
		/**
		 * Maximum bounds for the <code>panAngle</code>. Defaults to Infinity.
		 *
		 * @see	#panAngle
		 */
		public function get maxPanAngle():Number { return _maxPanAngle;	}
		public function set maxPanAngle(val:Number):void {
			if (_maxPanAngle == val)
				return;
			
			_maxPanAngle = val;
			
			panAngle = Math.max(_minPanAngle, Math.min(_maxPanAngle, _panAngle));
		}
		
		/**
		 * Minimum bounds for the <code>tiltAngle</code>. Defaults to -90.
		 *
		 * @see	#tiltAngle
		 */
		public function get minTiltAngle():Number { return _minTiltAngle; }
		public function set minTiltAngle(val:Number):void {
			if (_minTiltAngle == val)
				return;
			
			_minTiltAngle = val;
			
			tiltAngle = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, _tiltAngle));
		}
		
		/**
		 * Maximum bounds for the <code>tiltAngle</code>. Defaults to 90.
		 *
		 * @see	#tiltAngle
		 */
		public function get maxTiltAngle():Number { return _maxTiltAngle; }
		public function set maxTiltAngle(val:Number):void {
			if (_maxTiltAngle == val)
				return;
			
			_maxTiltAngle = val;
			
			tiltAngle = Math.max(_minTiltAngle, Math.min(_maxTiltAngle, _tiltAngle));
		}
		
		/**
		 * Fractional difference in distance between the horizontal camera orientation and vertical camera orientation. Defaults to 2.
		 *
		 * @see	#distance
		 */
		public function get yFactor():Number { return _yFactor; }
		public function set yFactor(val:Number):void {
			if (_yFactor == val)
				return;
			
			_yFactor = val;
			
			notifyUpdate();
		}
		
		/**
		 * Defines whether the value of the pan angle wraps when over 360 degrees or under 0 degrees. Defaults to false.
		 */
		public function get wrapPanAngle():Boolean { return _wrapPanAngle; }
		public function set wrapPanAngle(val:Boolean):void {
			if (_wrapPanAngle == val)
				return;
			
			_wrapPanAngle = val;
			
			notifyUpdate();
		}
		
		public function get currentPanAngle():Number {
			return _currentPanAngle;
		}
		
		public function get currentTiltAngle():Number {
			return _currentTiltAngle;
		}
		
		/**
		 * Creates a new <code>HoverController</code> object.
		 */
		public function CameraController(targetObject:Entity = null, lookAtObject:ObjectContainer3D = null, panAngle:Number = 0, tiltAngle:Number = 90, distance:Number = 1000, minTiltAngle:Number = -90, maxTiltAngle:Number = 40, minPanAngle:Number = NaN, maxPanAngle:Number = NaN, steps:Number = 8, yFactor:Number = 2, wrapPanAngle:Boolean = false){
			super(targetObject, lookAtObject);
			
			this.distance = distance;
			this.panAngle = panAngle;
			this.tiltAngle = tiltAngle;
			this.minPanAngle = minPanAngle || -Infinity;
			this.maxPanAngle = maxPanAngle || Infinity;
			this.minTiltAngle = minTiltAngle;
			this.maxTiltAngle = maxTiltAngle;
			this.steps = steps;
			this.yFactor = yFactor;
			this.wrapPanAngle = wrapPanAngle;
			
			//values passed in contrustor are applied immediately
			_currentPanAngle = _panAngle;
			_currentTiltAngle = _tiltAngle;
			
			registerKeyListener();
			
			
		}
		
		/* INTERFACE maryfisher.framework.core.IKeyListener */
		
		public function handleKeyDownOnce(key:int):void {
			
		}
		
		public function handleKeyDown(key:int):void {
			
			lookAtObject.rotationY = targetObject.rotationY;
			switch(key) {
				case Keyboard.LEFT:
					lookAtObject.moveLeft(MOVE);
					notifyPanUpdate();
					break;
				case Keyboard.RIGHT:
					lookAtObject.moveRight(MOVE);
					notifyPanUpdate();
					break;
				case Keyboard.DOWN:
					lookAtObject.moveBackward(MOVE);
					notifyPanUpdate();
					break;
				case Keyboard.UP:
					lookAtObject.moveForward(MOVE);
					notifyPanUpdate();
					break;
				case Keyboard.PAGE_UP:
					break;
				case Keyboard.PAGE_DOWN:
					break;
				default:
					break;
			}
		}
		
		public function handleKeyUp(key:int):void {
			
		}
		
		public function handleKeyCombo():void {
			
		}
		
		/**
		 * Updates the current tilt angle and pan angle values.
		 *
		 * Values are calculated using the defined <code>tiltAngle</code>, <code>panAngle</code> and <code>steps</code> variables.
		 *
		 * @see	#tiltAngle
		 * @see	#panAngle
		 * @see	#steps
		 */
		public override function update():void {
			
			if (_panUpdate) {
				
				notifyUpdate();
				
				_panUpdate = false;
				targetObject.x = lookAtObject.x + distance;
				targetObject.y = lookAtObject.y + distance;
				targetObject.z = lookAtObject.z + distance;
			}
			
			if (_tiltAngle != _currentTiltAngle || _panAngle != _currentPanAngle) {
				
				
				notifyUpdate();
				
				if (wrapPanAngle) {
					if (_panAngle < 0)
						panAngle = (_panAngle % 360) + 360;
					else
						panAngle = _panAngle % 360;
					
					if (panAngle - _currentPanAngle < -180)
						panAngle += 360;
					else if (panAngle - _currentPanAngle > 180)
						panAngle -= 360;
				}
				
				_currentTiltAngle += (_tiltAngle - _currentTiltAngle)/(steps + 1);
				_currentPanAngle += (_panAngle - _currentPanAngle)/(steps + 1);
				
				
				//snap coords if angle differences are close
				if ((Math.abs(tiltAngle - _currentTiltAngle) < 0.01) && (Math.abs(_panAngle - _currentPanAngle) < 0.01)) {
					_currentTiltAngle = _tiltAngle;
					_currentPanAngle = _panAngle;
				}
			}
			
			targetObject.x = lookAtObject.x + distance*Math.sin(_currentPanAngle*MathConsts.DEGREES_TO_RADIANS)*Math.cos(_currentTiltAngle*MathConsts.DEGREES_TO_RADIANS);
			targetObject.z = lookAtObject.z + distance*Math.cos(_currentPanAngle*MathConsts.DEGREES_TO_RADIANS)*Math.cos(_currentTiltAngle*MathConsts.DEGREES_TO_RADIANS);
			targetObject.y = lookAtObject.y + distance*Math.sin(_currentTiltAngle*MathConsts.DEGREES_TO_RADIANS)*yFactor;
			
			super.update();
		}
		
		public function registerKeyListener():void {
			var keycontroller:KeyController = KeyController.getInstance();
			keycontroller.registerForKeyDown(this,
				Vector.<int>([Keyboard.DOWN, Keyboard.UP, Keyboard.LEFT, Keyboard.RIGHT,
				Keyboard.PAGE_DOWN, Keyboard.PAGE_UP]));
		}
		
		private function notifyPanUpdate():void {
			notifyUpdate();
			_panUpdate = true;
		}
	}
}