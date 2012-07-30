package maryfisher.view.ui.button {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.component.BaseSpriteTooltip;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class HoverSpriteButton extends Sprite implements IDisplayObject{
		
		protected var _tooltip:BaseSpriteTooltip;
		
		public function HoverSpriteButton(tooltip:BaseSpriteTooltip = null) {
			_tooltip = tooltip;
			
			_tooltip && _tooltip.hide();
			
			if (!_tooltip) return;
			
			addListeners();
		}
		
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			positionTooltip();
			stage.addChild(_tooltip);
		}
		
		CONFIG::touch
		private function onTap(e:TouchEvent):void {
			_tooltip && _tooltip.switchVisibility();
		}
		
		CONFIG::mouse
		private function onMouseOut(e:MouseEvent):void {
			_tooltip && _tooltip.hide();
		}
		
		CONFIG::mouse
		private function onMouseOver(e:MouseEvent):void {
			_tooltip && _tooltip.show();
		}
		
		protected function positionTooltip():void {
			_tooltip.y = getRect(stage).top - _tooltip.height;
		}
		
		private function addListeners():void {
			CONFIG::mouse {
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			CONFIG::touch {
				addEventListener(TouchEvent.TOUCH_TAP, onTap);
			}
			if (stage) {
				onAdded(null);
			}else{
				addEventListener(Event.ADDED_TO_STAGE, onAdded);
			}
		}
		
		public function destroy():void {
			CONFIG::mouse {
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			CONFIG::touch {
				removeEventListener(TouchEvent.TOUCH_TAP, onTap);
			}
			
			stage && stage.removeChild(_tooltip);
			_tooltip.destroy();
		}
		
		public function set tooltip(value:BaseSpriteTooltip):void {
			_tooltip = value;
			addListeners();
		}
		
	}

}