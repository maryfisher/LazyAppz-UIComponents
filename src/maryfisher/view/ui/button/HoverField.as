package maryfisher.view.ui.button {
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.component.BaseSprite;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class HoverField extends BaseSprite {
		private var _tooltip:ITooltip;
		private var _hasListener:Boolean;
		
		public function HoverField() {
			//mouseChildren = false;
			
		}
		
		CONFIG::touch
		private function onTap(e:TouchEvent):void {
			_tooltip && _tooltip.switchVisibility();
		}
		
		private function removeListeners():void {
			if (!_hasListener) return;
			_hasListener = false;
			CONFIG::mouse {
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			CONFIG::touch {
				removeEventListener(TouchEvent.TOUCH_TAP, onTap);
			}
		}
		
		CONFIG::mouse
		protected function onMouseOut(e:MouseEvent):void {
			_tooltip && _tooltip.hide();
		}
		
		CONFIG::mouse
		protected function onMouseOver(e:MouseEvent):void {
			_tooltip && _tooltip.show();
		}
		
		protected function addListeners():void {
			if (_hasListener) return;
			_hasListener = true;
			CONFIG::mouse {
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			CONFIG::touch {
				addEventListener(TouchEvent.TOUCH_TAP, onTap);
			}
		}
		
		public function destroy():void {
			removeListeners();
			
			_tooltip && _tooltip.destroy();
		}
		
		public function attachTooltip(tooltip:ITooltip):void {
			if (_tooltip) {
				_tooltip.destroy();
			}
			_tooltip = tooltip;
			if(_tooltip)
				addListeners();
		}
	}

}