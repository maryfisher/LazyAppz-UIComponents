package maryfisher.view.ui.effects {
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.ITabSelectedEffect;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TabContentFadeEffect implements ITabSelectedEffect {
		
		public function TabContentFadeEffect() {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITabSelectedEffect */
		
		public function startTransition(oldContent:IDisplayObject, newContent:IDisplayObject):void {
			var tween:Object = { time: 0.3, transition:"easeOutSine" };
			
			Tweener.addTween(oldContent, {base: tween, alpha: 0});
			Tweener.addTween(newContent, {base: tween, alpha: 1});
		}
		
		public function onAddContent(content:IDisplayObject):void {
			content.alpha = 0;
		}
		
	}

}