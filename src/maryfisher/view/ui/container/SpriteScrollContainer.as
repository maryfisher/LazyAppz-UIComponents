package maryfisher.view.ui.container {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import maryfisher.view.ui.interfaces.IListContainer;
	import maryfisher.view.ui.interfaces.IScrollContainer;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SpriteScrollContainer extends Sprite implements IScrollContainer, IListContainer{
		
		
		public function SpriteScrollContainer() {
			
		}
		
		public function addElement(elm:DisplayObject, dist:int = -1):void {
			//if (!dist) {
				elm.x = elm.width * numChildren;
			//}
			addChild(elm);
		}
		
		public function scrolledContent(currentPage:int):void {
			for (var i:int = 0; i < numChildren; i++ ) {
				getChildAt(i).alpha = (i == currentPage) ? 1 : 0.3;
			}
		}
	}

}