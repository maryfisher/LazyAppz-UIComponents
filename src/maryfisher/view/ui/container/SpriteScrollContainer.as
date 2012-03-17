package maryfisher.view.ui.container {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SpriteScrollContainer extends Sprite implements IScrollContainer, IListContainer{
		
		
		public function SpriteScrollContainer() {
			
		}
		
		public function addElement(elm:DisplayObject):void {
			elm.x = elm.width * numChildren;
			addChild(elm);
		}
		
		/* INTERFACE org.osflash.signals.events.IBubbleEventHandler */
		
		public function scrolledContent(currentPage:int):void {
			for (var i:int = 0; i < numChildren; i++ ) {
				getChildAt(i).alpha = (i == currentPage) ? 1 : 0.3;
			}
		}
	}

}