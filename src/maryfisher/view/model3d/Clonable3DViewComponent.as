package maryfisher.view.model3d {
	import flash.display.Sprite;
	import maryfisher.framework.view.IClonableViewComponent;
	import maryfisher.framework.view.IViewComponent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Clonable3DViewComponent extends Sprite implements IClonableViewComponent, IViewComponent{
		
		public function Clonable3DViewComponent(clone:Boolean = false) {
			if(clone) {
				return;
			}
			init();
		}
		
		/* INTERFACE maryfisher.framework.view.IClonableViewComponent */
		
		public function clone():IViewComponent {
			return this;
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		public function get componentType():String {
			return "";
		}
		
		public function destroy():void {
			
		}
		
		public function addOnFinished(listener:Function):void {
			
		}
		
		protected function init():void {
			
		}
	}

}