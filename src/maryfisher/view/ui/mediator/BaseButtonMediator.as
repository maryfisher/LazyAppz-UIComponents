package maryfisher.view.ui.mediator {
	import flash.ui.MouseCursor;
	import maryfisher.framework.sound.ISoundPlayer;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	import maryfisher.view.ui.interfaces.ITooltip;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseButtonMediator implements IButton {
		
		private var _clickedSignal:Signal;
		private var _rightClickSignal:Signal;
		private var _downSignal:Signal;
		private var _bubblingSignal:DeluxeSignal;
		private var _overSignal:Signal;
		private var _outSignal:Signal;
		
		protected var _doBubble:Boolean = true;
		private var _onStayDown:Boolean;
		private var _isDown:Boolean;
		
		protected var _sound:ISoundPlayer;
		protected var _tooltip:ITooltip;
		
		protected var _enabled:Boolean;
		protected var _selected:Boolean;
		
		protected var _upState:IDisplayObject;
		protected var _downState:IDisplayObject;
		protected var _disabledState:IDisplayObject;
		protected var _selectedState:IDisplayObject;
		protected var _defaultState:IDisplayObject;
		protected var _overState:IDisplayObject;
		//protected var _hitTest:DisplayObject;
		
		protected var _id:String;
		
		protected var _overCursor:String = MouseCursor.BUTTON;
		protected var _outCursor:String = MouseCursor.ARROW;
		
		public function BaseButtonMediator(container:IDisplayObjectContainer, id:String) {
			_enabled = true;
			_selected = false;
			_id = id;
			
			_bubblingSignal = new DeluxeSignal(this);
			
			addListeners();
			
			CONFIG::mouse {
				buttonMode = true;
			}
		}
		
		protected function addListeners():void { }
		
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
			
			changeSelected(value);
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled == value) {
				return;
			}
			
			if (!value) {
				_selected = false;
			}
			
			_enabled = value;
			
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
			var index:int = 0;
			if (_upState) {
				if (contains(_upState)) {
					index = getChildIndex(_upState);
					removeChild(_upState);
				}
			}
			_upState = value;
			_upState && addChildAt(_upState, index);
		}
		
		public function set downState(value:DisplayObject):void {
			var index:int = 0;
			if (_downState) {
				if (contains(_downState)) {
					index = getChildIndex(_downState);
					removeChild(_downState);
				}
			}
			_downState = value;
			if (!_downState) return;
			_downState.visible = false;
			addChildAt(_downState, index);
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
			//if (_selectedState) {
				//removeChild(_selectedState);
			//}
			_selectedState = value;
			//_selectedState.visible = false;
			//addChild(_selectedState);
		}
		
		public function set doBubble(value:Boolean):void {
			_doBubble = value;
		}
		
		public function set disabledState(value:DisplayObject):void {
			_disabledState = value;
		}
		
		public function set defaultState(value:DisplayObject):void {
			_defaultState = value;
		}
		
		public function get defaultState():DisplayObject {
			return _defaultState;
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
		
		protected function onRight():void {
			_rightClickSignal && _rightClickSignal.dispatch(this);
		}
		
		protected function onUp():void {
			if (!_enabled) {
				return;
			}
			if (_downState) _downState.visible = false;
			
			//dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_CLICKED, _id));
			//_clickedSignal && _clickedSignal.dispatch(this);
			//_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent(ButtonSignalEvent.ON_CLICKED)));
			trigger();
			
			if (_downSignal && _onStayDown) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		public function trigger():void {
			_clickedSignal && _clickedSignal.dispatch(this);
			_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent(ButtonSignalEvent.ON_CLICKED)));
		}
		
		protected function onDown():void {
			if (!_enabled) {
				return;
			}
			_sound && _sound.play();
			if (_selected) {
				return;
			}
			if (_downState) _downState.visible = true;
			
			//_doBubble && (_bubblingSignal.dispatch(new ButtonSignalEvent(ButtonSignalEvent.ON_DOWN)));
			
			if (_downSignal) {
				_downSignal.dispatch(this);
				if(_onStayDown){
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
		}
		
		private function onEnterFrame(e:Event):void {
			_downSignal.dispatch(this);
		}
		
		protected function changeSelected(value:Boolean):void {
			_selected = value;
			if (_selected) {
				upState = _selectedState;
			}else {
				upState = _defaultState;
			}
			showUpState();
		}
	}

}