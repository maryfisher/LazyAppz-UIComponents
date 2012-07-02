package maryfisher.view.ui.component {
	import flash.display.Sprite;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSpriteTooltip extends Sprite implements ITooltip {
		
		public function BaseSpriteTooltip() {
			super();
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITooltip */
		
		public function switchVisibility():void {
			visible = !visible;
		}
		
		public function show():void {
			visible = true;
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function destroy():void {
			
		}
		
	}

}