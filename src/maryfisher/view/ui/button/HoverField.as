package maryfisher.view.ui.button {
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.component.BaseSprite;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class HoverField extends BaseSprite implements IDisplayObject{
		private var _tooltip:ITooltip;
		
		public function HoverField() {
			//mouseChildren = false;
			
		}
		
		CONFIG::touch
		private function onTap(e:TouchEvent):void {
			_tooltip && _tooltip.switchVisibility();
		}
		
		CONFIG::mouse
		protected function onMouseOut(e:MouseEvent):void {
			_tooltip && _tooltip.hide();
		}
		
		CONFIG::mouse
		protected function onMouseOver(e:MouseEvent):void {
			_tooltip && _tooltip.show();
		}
		
		private function addListeners():void {
			CONFIG::mouse {
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			CONFIG::touch {
				addEventListener(TouchEvent.TOUCH_TAP, onTap);
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
			
			_tooltip.destroy();
		}
		
		public function attachTooltip(tooltip:ITooltip):void {
			_tooltip = tooltip;
			
			addListeners();
		}
	}

}