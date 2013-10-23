package maryfisher.view.ui.button {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import maryfisher.framework.sound.ISound;
	import maryfisher.view.event.ButtonEvent;
	import maryfisher.view.event.ButtonSignalEvent;
	import maryfisher.view.ui.component.BaseSprite;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.util.ColorUtil;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractSpriteButton extends BaseSprite implements IButton {
		
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
		protected var _hitTest:DisplayObject;
		
		protected var _id:String;
		
		protected var _doBubble:Boolean = true;
		
		public function AbstractSpriteButton(id:String) {
			_enabled = true;
			_selected = false;
			_id = id;
			//mouseChildren = false;
			
			_bubblingSignal = new DeluxeSignal(this);
			
			addListeners();
		}
		
		protected function addListeners():void { }
		
		public function destroy():void {
			removeListeners();
			_clickedSignal && _clickedSignal.removeAll();
			_downSignal && _downSignal.removeAll();
		}
		
		public function addClickedListener(listener:Function):void {
			if (!_clickedSignal) {
				_clickedSignal = new Signal(IButton);
			}
			if(listener != null)
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
		
		public function showUpState():void {
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
				//removeListeners();
				_selected = false;
			}else {
				//addListeners();
			}
			
			_enabled = value;
			//mouseEnabled = _enabled;
			//buttonMode = _enabled;
			
			if (!value) {
				if(_disabledState) upState = _disabledState;
			}else {
				if(_defaultState) upState = _defaultState;
			}
			
		}
		public function get enabled():Boolean {	return _enabled; }
		
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		
		public function set upState(value:DisplayObject):void {
			if (_upState) {
				if (contains(_upState)) removeChild(_upState);
			}
			_upState = value;
			_upState && addChildAt(_upState, 0);
		}
		
		public function set downState(value:DisplayObject):void {
			if (_downState) {
				if (contains(_downState)) removeChild(_downState);
			}
			_downState = value;
			if (!_downState) return;
			_downState.visible = false;
			addChild(_downState);
		}
		
		public function set hitTest(value:DisplayObject):void {
			_hitTest = value;
			mouseChildren = true;
			mouseEnabled = false;
			_hitTest.alpha = 0;
			addChild(_hitTest);
			/* TODO
			 * es müssen die anderen states disabled werden
			 */
		}
		
		public function set selectedState(value:DisplayObject):void {
			_selectedState = value;
			_selectedState.visible = false;
			addChild(_selectedState);
		}
		
		public function set doBubble(value:Boolean):void {
			_doBubble = value;
		}
		
		protected function drawDisabledState(desaturate:Boolean = true, transparent:Boolean = false):void {
			
			if (_defaultState is Bitmap) {
				var bd:BitmapData
				if (desaturate) {
					bd = ColorUtil.desaturateBitmapData((_defaultState as Bitmap).bitmapData, transparent ? 0.5 : 1);
				}else {
					bd = (_defaultState as Bitmap).bitmapData.clone();
					//if (transparent) {
						//bd = ColorUtil.setTransparency((_defaultState as Bitmap).bitmapData, 0.5);
					//}
				}
				_disabledState = new Bitmap(bd);
				if (transparent) {
					_disabledState.alpha = 0.5;
				}
				
			}else {
				//_disabledState = new Bitmap()
				//_defaultState;
				//ColorUtil.desaturate(_disabledState);
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
			_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent(ButtonSignalEvent.ON_CLICKED)));
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
			
			//_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent(ButtonSignalEvent.ON_DOWN)));
			
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
		
		private function onEnterFrame(e:Event):void {
			_downSignal.dispatch(this);
		}
	}

}