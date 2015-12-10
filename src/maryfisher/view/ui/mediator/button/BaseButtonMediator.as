package maryfisher.view.ui.mediator.button {
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import maryfisher.framework.command.view.StageCommand;
	import maryfisher.framework.sound.ISoundPlayer;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.ITickedObject;
	import maryfisher.view.event.ButtonSignalEvent;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IButtonContainer;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	import maryfisher.view.ui.interfaces.ITooltip;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseButtonMediator implements IButton, ITickedObject {
		
		private var _clickedSignal:Signal;
		private var _downSignal:Signal;
		private var _bubblingSignal:DeluxeSignal;
		//for desktop only
		private var _rightClickSignal:Signal;
		private var _overSignal:Signal;
		private var _outSignal:Signal;
		
		protected var _doBubble:Boolean = true;
		private var _onStayDown:Boolean;
		protected var _isDown:Boolean;
		
		protected var _container:IButtonContainer;
		protected var _sound:ISoundPlayer;
		protected var _tooltip:ITooltip;
		
		protected var _enabled:Boolean;
		protected var _selected:Boolean;
		
		protected var _upState:IDisplayObject;
		protected var _downState:IDisplayObject;
		protected var _disabledState:IDisplayObject;
		protected var _selectedState:IDisplayObject;
		protected var _defaultState:IDisplayObject;
		protected var _hitTest:IDisplayObject;
		
		//for desktop only
		protected var _overState:IDisplayObject;
		
		protected var _id:String;
		
		//for desktop only
		protected var _overCursor:String = MouseCursor.BUTTON;
		protected var _outCursor:String = MouseCursor.ARROW;
		
		public function BaseButtonMediator(container:IButtonContainer, id:String) {
			_container = container;
			_enabled = true;
			_selected = false;
			_id = id;
			
			_bubblingSignal = new DeluxeSignal(container);
			
			addListeners();
		}
		
		protected function addListeners():void { }
		
		protected function removeListeners():void {	}
		
		public function destroy():void {
			removeListeners();
			_clickedSignal && _clickedSignal.removeAll();
			_downSignal && _downSignal.removeAll();
			_rightClickSignal && _rightClickSignal.removeAll();
			_bubblingSignal = null;
		}
		
		/**
		 * 
		 * @param	listener Function.<IButton>
		 */
		public function addClickedListener(listener:Function):void {
			if (!_clickedSignal) {
				_clickedSignal = new Signal(IButton);
			}
			if(listener != null)
				_clickedSignal.add(listener);
		}
		
		/**
		 * 
		 * @param	listener Function.<IButton>
		 */
		public function addRightClickListener(listener:Function):void {
			if (!_rightClickSignal) {
				addRightClick();
				_rightClickSignal = new Signal(IButton);
			}
			if(listener != null)
				_rightClickSignal.add(listener);
		}
		
		public function addOverListener(listener:Function):void {
			if (!_overSignal) {
				_overSignal = new Signal(IButton);
			}
			_overSignal.add(listener);
		}
		
		public function addOutListener(listener:Function):void {
			if (!_outSignal) {
				_outSignal = new Signal(IButton);
			}
			_outSignal.add(listener);
		}
		
		protected function addRightClick():void {
			
		}
		
		/**
		 * 
		 * @param	listener Function.<IButton>
		 * @param	onStayDown if true dispatches per frame that button is down
		 */
		public function addDownListener(listener:Function, onStayDown:Boolean):void {
			_onStayDown = onStayDown;
			if (!_downSignal) {
				_downSignal = new Signal(IButton);
			}
			_downSignal.add(listener);
		}
		
		//public function addUpListener(onMonocleDown:Function):void {
			//if (!_upSignal) {
				//_upSignal = new Signal(IButton);
			//}
			//_upSignal.add(listener);
		//}
		
		public function addOnFinished(listener:Function):void {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IButton */
		
		public function set sound(value:ISoundPlayer):void {
			_sound = value;
		}
		
		public function get selected():Boolean { return _selected;	}
		public function set selected(value:Boolean):void {
			if (_selected == value) {
				return;
			}
			
			changeSelected(value);
		}
		
		protected function changeSelected(value:Boolean):void {
			_selected = value;
			_container.selected = value;
			if (_selected) {
				upState = _selectedState;
			}else {
				upState = _defaultState;
			}
			showUpState();
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled == value) {
				return;
			}
			CONFIG::mouse{
				if (!value) {
					onOut();
				}
			}
			
			if (!value) {
				_selected = false;
			}
			
			_enabled = value;
			_container.enabled = value;
			
			if (!value) {
				if(_disabledState) upState = _disabledState;
			}else {
				if(_defaultState) upState = _defaultState;
			}
			
		}
		public function get enabled():Boolean {	return _enabled; }
		
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		
		public function set upState(value:IDisplayObject):void {
			var index:int = 0;
			if (_upState) {
				if (_container.containsContent(_upState)) {
					index = _container.getContentIndex(_upState);
					_container.removeContent(_upState);
				}
			}
			_upState = value;
			_upState && _container.addContentAt(_upState, index);
		}
		
		public function set downState(value:IDisplayObject):void {
			var index:int = 0;
			if (_downState) {
				if (_container.containsContent(_downState)) {
					index = _container.getContentIndex(_downState);
					_container.removeContent(_downState);
				}
			}
			_downState = value;
			if (!_downState) return;
			_downState.visible = false;
			_container.addContentAt(_downState, index);
		}
		
		CONFIG::mouse
		public function set overState(value:IDisplayObject):void {
			//var index:int = numChildren - 2;
			if (_overState) {
				if (_container.containsContent(_overState)) {
					//var index:int = getChildIndex(_overState);
					_container.removeContent(_overState);
				}
			}
			_overState = value;
			if (!_overState) return;
			
			_overState.visible = false;
			if (_downState && _container.containsContent(_downState)) {
				_container.addContentAt(_overState, _container.getContentIndex(_downState));
				return;
			}
			_container.addContentAt(_overState, _container.getContentIndex(_upState));
		}
		
		public function set hitTest(value:IDisplayObject):void {
			_hitTest = value;
			/** TODO
			 * 
			 */
			//_hitTest.alpha = 0;
			_container.addContent(_hitTest);
		}
		
		public function set selectedState(value:IDisplayObject):void {
			if (_upState && _upState == _selectedState) {
				upState = value;
			}
			_selectedState = value;
		}
		
		public function set defaultState(value:IDisplayObject):void {
			if (_upState == _defaultState || !_upState) {
				upState = value;
			}
			_defaultState = value;
		}
		
		public function set doBubble(value:Boolean):void {
			_doBubble = value;
		}
		
		public function set disabledState(value:IDisplayObject):void {
			_disabledState = value;
		}
		
		protected function onRight():void {
			_rightClickSignal && _rightClickSignal.dispatch(this);
		}
		
		public function set overCursor(value:String):void {
			_overCursor = value;
		}
		
		public function set outCursor(value:String):void {
			_outCursor = value;
		}
		
		public function get tooltip():ITooltip {
			return _tooltip;
		}
		
		public function get container():IDisplayObjectContainer {
			return _container;
		}
		
		public function attachTooltip(tooltip:ITooltip):void {
			_tooltip = tooltip;
		}
		
		protected function onUp():void {
			if (!_isDown) {
				return;
			}
			if (!_enabled) {
				return;
			}
			if (_downState) _downState.visible = false;
			
			if(!_selected) showOverState();
			
			trigger();
			
			if (_downSignal && _onStayDown) {
				new StageCommand(StageCommand.UNREGISTER_TICK, this);
			}
			_isDown = false;
		}
		
		public function showUpState():void {
			if(_upState) _upState.visible = true;
			
			if (_downState) _downState.visible = false;
			CONFIG::mouse{
				if (_overState) _overState.visible = false;
			}
		}
		
		CONFIG::mouse
		protected function onOver():void {
			_tooltip && _tooltip.show();
			if (!enabled) {
				return;
			}
			if (_selected) {
				return;
			}
			showOverState();
			
			_overSignal && _overSignal.dispatch(this);
			Mouse.cursor = _overCursor;
		}
		
		CONFIG::mouse
		public function showOverState():void {
			if (_overState) {
				_upState && (_upState.visible = false);
				_overState.visible = true;
			}
		}
		
		protected function onDown():void {
			if (_isDown) {
				return;
			}
			_isDown = true;
			if (!_enabled) {
				return;
			}
			_sound && _sound.play();
			if (_selected) {
				return;
			}
			if (_downState) _downState.visible = true;
			
			if (_downSignal) {
				_downSignal.dispatch(this);
				if (_onStayDown) {
					new StageCommand(StageCommand.REGISTER_TICK, this);
				}
			}
		}
		
		protected function onOut():void {
			_tooltip && _tooltip.hide();
			if (!_enabled || _selected) {
				return;
			}
			Mouse.cursor = _outCursor;
			_outSignal && _outSignal.dispatch(this);
			showUpState();
		}
		
		public function trigger():void {
			_clickedSignal && _clickedSignal.dispatch(this);
			_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent(ButtonSignalEvent.ON_CLICKED)));
		}
		
		/* INTERFACE maryfisher.framework.view.ITickedObject */
		
		public function nextTick(interval:int):void {
			if(_isDown)
				_downSignal.dispatch(this);
		}
	}
}