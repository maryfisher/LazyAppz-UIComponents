package maryfisher.view.ui.button {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class HoverSpriteButton extends Sprite {
		
		protected var _tooltip:ITooltip;
		
		public function HoverSpriteButton(tooltip:ITooltip = null) {
			_tooltip = tooltip;
			
			CONFIG::mouse {
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			CONFIG::touch {
				addEventListener(TouchEvent.TOUCH_TAP, onTap);
			}
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
		
		public function set tooltip(value:ITooltip):void {
			_tooltip = value;
		}
		
	}

}