package maryfisher.view.ui.button.starling {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import maryfisher.view.ui.event.ButtonSignalEvent;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ISound;
	import maryfisher.view.ui.interfaces.ITooltip;
	import maryfisher.view.util.ColorUtil;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingButton extends DisplayObjectContainer implements IButton{
		
		private var _clickedSignal:Signal;
		private var _downSignal:Signal;
		private var _bubblingSignal:DeluxeSignal;
		protected var _sound:ISound;
		
		protected var _enabled:Boolean;
		protected var _selected:Boolean;
		
		protected var _upState:DisplayObject;
		protected var _downState:DisplayObject;
		protected var _disabledState:DisplayObject;
		protected var _selectedState:DisplayObject;
		protected var _defaultState:DisplayObject;
		//protected var _hitTest:DisplayObject;
		private var _isDown:Boolean;
		private var _isOver:Boolean;
		
		protected var _tooltip:ITooltip;
		CONFIG::mouse
		protected var _overState:DisplayObject;
		
		protected var _id:String;
		
		protected var _doBubble:Boolean = true;
		
		public function BaseStarlingButton(id:String) {
			_enabled = true;
			_selected = false;
			_id = id;
			//mouseChildren = false;
			
			_bubblingSignal = new DeluxeSignal(this);
			
			addListeners();
			
			CONFIG::mouse {
				//buttonMode = true;
				useHandCursor = true;
			}
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			_upState && addChild(_upState);
			_overState && addChild(_overState);
			_downState && addChild(_downState);
			_disabledState && addChild(_disabledState);
			_selectedState && addChild(_selectedState);
		}
		
		protected function addListeners():void {
			//if (_hitTest) {
				//_hitTest.addEventListener(TouchEvent.TOUCH, onTouch);
				//return;
			//}
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void {
			
            var touch:Touch = e.getTouch(this);
            if (!_enabled || touch == null) return;
            
            if (touch.phase == TouchPhase.BEGAN) {
                if (_isDown) {
					return;
				}
				_isDown = true;
				onDown();
            } else if (touch.phase == TouchPhase.MOVED) {
				
			} else if (touch.phase == TouchPhase.HOVER) {
				
				if (!_enabled || _selected || _isOver) {
					return;
				}
					/* TODO
					 * Tween!
					 */
				_isOver = true;
				onOver();
			} else if (touch.phase == TouchPhase.ENDED) {
				if (!_isDown) {
					return;
				}
				onUp();
				_isDown = false;
				_isOver = false;
			}else if(!e.interactsWith(e.target as DisplayObject)){
				if (!_enabled || _selected) {
					return;
				}
				showUpState();
			}
		}
		
		public function destroy():void {
			removeListeners();
			_clickedSignal && _clickedSignal.removeAll();
			_downSignal && _downSignal.removeAll();
		}
		
		public function addClickedListener(listener:Function):void {
			if (!_clickedSignal) {
				_clickedSignal = new Signal(IButton);
			}
			_clickedSignal.add(listener);
		}
		
		public function addDownListener(listener:Function):void {
			if (!_downSignal) {
				_downSignal = new Signal(IButton);
			}
			_downSignal.add(listener);
		}
		
		public function addOnFinished(listener:Function):void {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IButton */
		
		public function set sound(value:ISound):void {
			_sound = value;
		}
		
		public function get componentType():String {
			return "";
		}
		
		protected function removeListeners():void {	}
		
		protected function showUpState():void {
			if(_upState) _upState.visible = true;
			
			if (_downState) _downState.visible = false;
			//_tooltip && _tooltip.hide();
		}
		
		public function get selected():Boolean { return _selected;	}
		public function set selected(value:Boolean):void {
			if (_selected == value) {
				return;
			}
			
			_selected = value;
			if (_selected) {
				upState = _selectedState;
			}else {
				upState = _defaultState;
			}
			//handleMouseOut(null);
			showUpState();
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled == value) {
				return;
			}
			
			if (!value) {
				//onMouseOut(null);
				removeListeners();
				_selected = false;
			}else {
				addListeners();
			}
			
			_enabled = value;
			touchable = _enabled;
			//buttonMode = _enabled;
			
			if (!value) {
				if(_disabledState) upState = _disabledState;
			}else {
				if(_defaultState) upState = _defaultState;
			}
			
		}
		public function get enabled():Boolean {	return _enabled; }
		
		public function get id():String { return _id; }
		
		public function set upState(value:DisplayObject):void {
			if (_upState) {
				if (contains(_upState)) removeChild(_upState);
			}
			_upState = value;
			if (!_upState || !stage) return;
			
			if (numChildren > 0) {
				addChildAt(_upState, 0);				
			}else{
				addChild(_upState);
			}
		}
		
		public function set downState(value:DisplayObject):void {
			_downState = value;
			_downState.visible = false;
			//addChild(_downState);
		}
		
		//public function set hitTest(value:DisplayObject):void {
			//_hitTest = value;
			//mouseChildren = true;
			//touchable = false;
			//_hitTest.alpha = 0;
			//addChild(_hitTest);
			///* TODO
			 //* es müssen die anderen states disabled werden
			 //*/
		//}
		
		public function set selectedState(value:DisplayObject):void {
			_selectedState = value;
			_selectedState.visible = false;
			//addChild(_selectedState);
		}
		
		public function set overState(value:DisplayObject):void {
			_overState = value;
			_overState.visible = false;
			//if (_downState) {
				//addChildAt(_overState, numChildren - 2);
				//return;
			//}
			//addChild(_overState);
		}
		
		public function set doBubble(value:Boolean):void {
			_doBubble = value;
		}
		
		protected function drawDisabledState(desaturate:Boolean = true, transparent:Boolean = false):void {
			
			if (_defaultState is Image) {
				var bd:BitmapData;
				if (desaturate) {
					//bd = ColorUtil.desaturateBitmapData((_defaultState as Image).texture.bitmapData, transparent ? 0.5 : 1);
				}else {
					//bd = (_defaultState as Bitmap).bitmapData.clone();
				}
				//_disabledState = new Bitmap(bd);
				//if (transparent) {
					//_disabledState.alpha = 0.5;
				//}
				
			}else {
				
			}
		}
		
		protected function onUp():void {
			if (!_enabled) {
				return;
			}
			if (_downState) _downState.visible = false;
			
			/* TODO
			 *nicht auf alle Arten dispatchen
			 */
			//dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_CLICKED, _id));
			_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent()));
			_clickedSignal && _clickedSignal.dispatch(this);
			//_sound && _sound.play();
			
			if (_downSignal) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		protected function onDown():void {
			if (!_enabled || _selected) {
				return;
			}
			if (_downState) _downState.visible = true;
			_sound && _sound.play();
			if (_downSignal) {
				_downSignal.dispatch(this);
				/* TODO
				 * optional
				 */
				if(!_clickedSignal){
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
		}
		
		protected function onOver():void {
			if (_overState) {
				_upState.visible = false;
				_overState.visible = true;
			}
		}
		
		private function onEnterFrame(e:Event):void {
			_downSignal.dispatch(this);
		}
		
		protected function createTexture(bm:Bitmap):Image {
			return new Image(Texture.fromBitmap(bm));
		}
	}

}