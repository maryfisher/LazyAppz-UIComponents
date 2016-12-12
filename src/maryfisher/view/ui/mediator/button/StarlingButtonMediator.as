package maryfisher.view.ui.mediator.button {
	import maryfisher.view.ui.interfaces.IButtonContainer;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	import maryfisher.view.ui.mediator.button.BaseButtonMediator;
	import starling.display.DisplayObjectContainer;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class StarlingButtonMediator extends BaseButtonMediator {
		
		private var _isOver:Boolean;
		private var _starlingC:DisplayObjectContainer;
		
		public function StarlingButtonMediator(container:IButtonContainer, id:String) {
			_starlingC = container as DisplayObjectContainer;
			super(container, id);
		}
		
		override protected function addListeners():void {
			_starlingC.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override protected function removeListeners():void {
			_starlingC.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override protected function addRightClick():void {
			CONFIG::mouse{
				//addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			}
		}
		
		//CONFIG::mouse
		//private function onRightClick(e:MouseEvent):void {
			//onRight();
		//}
		
		private function onTouch(e:TouchEvent):void {
			
            var touch:Touch = e.getTouch(_starlingC);
			
            if (!_enabled) return;
            
            if (touch == null) {
				//trace("onOut");
				if (_isOver) {
					onOut();
					_isOver = false;
				}
            } else if (touch.phase == TouchPhase.BEGAN) {
				//trace("onDown");
                onDown();
            } else if (touch.phase == TouchPhase.MOVED) {
				//trace("TouchPhase.MOVED");
				var isWithinBounds:Boolean = _starlingC.getBounds(_starlingC.stage).contains(touch.globalX, touch.globalY);

                //if (!isWithinBounds) {
					
                //}
			} else if (touch.phase == TouchPhase.HOVER) {
				if (_isOver) return;
				_isOver = true;
				//trace("onOver");
				CONFIG::mouse {
					onOver();
				}
			} else if (touch.phase == TouchPhase.ENDED) {
				//trace("onUp");
				onUp();
			}
		}
		
		override public function set enabled(value:Boolean):void {
			super.enabled = value;
			/** TODO
			 * 
			 */
			//CONFIG::mouse {
				//(_container as Sprite).buttonMode = _enabled;
			//}
		}
		
	}

}