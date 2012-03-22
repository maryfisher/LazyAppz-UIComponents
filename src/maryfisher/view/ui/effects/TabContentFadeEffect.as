package maryfisher.view.ui.effects {
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import maryfisher.view.ui.interfaces.ITabSelectedEffect;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TabContentFadeEffect implements ITabSelectedEffect {
		
		public function TabContentFadeEffect() {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITabSelectedEffect */
		
		public function onTabSelected(oldContent:DisplayObject, newContent:DisplayObject):void {
			var tween:Object = { time: time, transition:"easeOutSine" };
			
			Tweener.addTween(oldContent, {base: tween, alpha: 0});
			Tweener.addTween(newContent, {base: tween, alpha: 1});
		}
		
		public function onAddContent(content:DisplayObject):void {
			content.alpha = 0;
		}
		
	}

}