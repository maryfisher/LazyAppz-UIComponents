package maryfisher.ui.button {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import maryfisher.ui.event.ButtonEvent;
	import maryfisher.ui.interfaces.IButton;
	import maryfisher.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseSpriteButton extends AbstractSpriteButton{
		
		protected var _tooltip:ITooltip;
		
		protected var _overState:DisplayObject;
		
		public function BaseSpriteButton(id:String) {
			super(id);
			buttonMode = true;
		}
		
		override protected function addListeners():void {
			if (_hitTest) {
				_hitTest.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
				_hitTest.addEventListener(MouseEvent.CLICK, onMouseUp, false, 0, true);
				_hitTest.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
				return;
			}
			
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
		}
		
		override protected function removeListeners():void {
			if(!_hitTest){
				removeEventListener(MouseEvent.ROLL_OVER, onMouseOver, false);
				removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false);
				removeEventListener(MouseEvent.MOUSE_UP, onMouseUp, false);
				removeEventListener(MouseEvent.ROLL_OUT, onMouseOut, false);
				return;
			}
		}
		
		private function showOverState():void {
			if(_upState) _upState.visible = false;
			if(_overState) _overState.visible = true;
		}
		
		protected function onMouseDown(e:MouseEvent):void {
			onDown();
		}
		
		protected function onMouseOver(e:MouseEvent):void {
			if (!_enabled || _selected) {
				return;
			}
				/* TODO
				 * Tween!
				 */	
			showOverState();
			
		}
		
		protected function onMouseOut(e:MouseEvent):void {
			if (!_enabled || _selected) {
				return;
			}
			showUpState();
			
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			super.onUp()
		}
		
		override protected function showUpState():void {
			super.showUpState();
			if(_overState) _overState.visible = false;
			//_tooltip && _tooltip.hide();
		}
		
		public function attachTooltip(tooltip:ITooltip):void {
			_tooltip = tooltip;
			
		}
		
		override public function set enabled(value:Boolean):void {
			
			if (_enabled == value) {
				return;
			}
			
			super.enabled = value;
			
			if (!value) {
				onMouseOut(null);
			}
			buttonMode = _enabled;
		}
		
		public function set overState(value:DisplayObject):void {
			_overState = value;
			_overState.visible = false;
			if (_downState) {
				addChildAt(_overState, numChildren - 2);
				return;
			}
			addChild(_overState);
		}
		
		//public function set defaultState(value:DisplayObject):void {
			//_defaultState = value;
		//}
	}
}