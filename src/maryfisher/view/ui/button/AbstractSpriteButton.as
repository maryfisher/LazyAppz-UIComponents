package maryfisher.view.ui.button {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import maryfisher.view.ui.event.ButtonEvent;
	import maryfisher.view.ui.event.ButtonSignalEvent;
	import maryfisher.view.ui.interfaces.IButton;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractSpriteButton extends Sprite implements IButton{
		
		private var _clickedSignal:Signal;
		private var _bubblingSignal:DeluxeSignal;
		
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
			mouseChildren = false;
			
			_bubblingSignal = new DeluxeSignal(this);
			
			addListeners();
		}
		
		protected function addListeners():void { }
		
		public function destroy():void {
			removeListeners();
			_clickedSignal && _clickedSignal.removeAll();
		}
		
		public function addClickedListener(listener:Function):void {
			if (!_clickedSignal) {
				_clickedSignal = new Signal(IButton);
			}
			_clickedSignal.add(listener);
		}
		
		public function addOnFinished(listener:Function):void {
			
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
			mouseEnabled = _enabled;
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
			addChildAt(_upState, 0);
		}
		
		public function set downState(value:DisplayObject):void {
			_downState = value;
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
		
		protected function onUp():void {
			if (!_enabled) {
				return;
			}
			if (_downState) _downState.visible = false;
			
			/* TODO
			 *nicht auf alle Arten dispatchen
			 */
			dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_CLICKED, _id));
			_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent()));
			_clickedSignal && _clickedSignal.dispatch(this);
		}
		
		protected function onDown():void {
			if (!_enabled || _selected) {
				return;
			}
			if(_downState) _downState.visible = false;
		}
	}

}