package maryfisher.view.ui.mediator.button {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Mouse;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.interfaces.IButtonContainer;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	import maryfisher.view.ui.mediator.button.BaseButtonMediator;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SpriteButtonMediator extends BaseButtonMediator {
		
		private var _spriteC:DisplayObjectContainer;
		
		public function SpriteButtonMediator(container:IButtonContainer, id:String) {
			_spriteC = container as DisplayObjectContainer;
			super(container, id);
		}
		
		override protected function addListeners():void {
			CONFIG::mouse {
				addMouseListeners();
			}
			CONFIG::touch{
				addTouchListeners();
			}
		}
		
		override protected function addRightClick():void {
			CONFIG::mouse{
				_spriteC.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			}
			
			CONFIG::touch {
				/** TODO
				 * 
				 */
			}
		}
		
		CONFIG::touch
		private function addTouchListeners():void {
			//if (_hitTest) {
				//_hitTest.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, false);
				//_hitTest.addEventListener(TouchEvent.TOUCH_END, onTouchEnd, false);
				//return;
			//}
			
			_spriteC.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			_spriteC.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		CONFIG::touch
		protected function onTouchEnd(e:TouchEvent):void {
			onUp();
		}
		CONFIG::touch
		protected function onTouchBegin(e:TouchEvent):void {
			
			onDown();
		}
		CONFIG::mouse
		private function addMouseListeners():void {
			//if (_hitTest) {
				//_hitTest.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false);
				//_hitTest.addEventListener(MouseEvent.CLICK, onMouseUp, false);
				//_hitTest.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false);
				//return;
			//}
			
			_spriteC.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false);
			_spriteC.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false);
			_spriteC.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false);
			_spriteC.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false);
		}
		
		CONFIG::mouse
		private function onRightClick(e:MouseEvent):void {
			onRight();
		}
		
		override protected function removeListeners():void {
			CONFIG::touch {
				removeTouchListeners();
			}
			CONFIG::mouse{
				removeMouseListeners();
			}
		}
		
		CONFIG::touch
		private function removeTouchListeners():void {
			if (!_hitTest) {
				_spriteC.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				_spriteC.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
		
		CONFIG::mouse
		private function removeMouseListeners():void {
			if(!_hitTest){
				_spriteC.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver, false);
				_spriteC.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false);
				_spriteC.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp, false);
				_spriteC.removeEventListener(MouseEvent.ROLL_OUT, onMouseOut, false);
				return;
			}
		}
		
		CONFIG::mouse
		protected function onMouseDown(e:MouseEvent):void {
			onDown();
		}
		CONFIG::mouse
		protected function onMouseOver(e:MouseEvent):void {
			onOver();
		}
		CONFIG::mouse
		protected function onMouseOut(e:MouseEvent):void {
			onOut();
			
		}
		CONFIG::mouse
		protected function onMouseUp(e:MouseEvent):void {
			onUp();
		}
		
		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			CONFIG::mouse {
				(_container as Sprite).buttonMode = _enabled;
			}
		}
		
		override public function set hitTest(value:IDisplayObject):void {
			super.hitTest = value
			_spriteC.mouseChildren = true;
			_spriteC.mouseEnabled = false;;
		}
	}

}