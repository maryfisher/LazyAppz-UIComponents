package maryfisher.view.ui.effects {
	import com.greensock.easing.Sine;
	import com.greensock.TweenMax;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.ITabSelectedEffect;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TabContentFadeEffect implements ITabSelectedEffect {
		private var _oldContent:IDisplayObject;
		private var _newContent:IDisplayObject;
		
		public function TabContentFadeEffect() {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITabSelectedEffect */
		
		public function startTransition(oldContent:IDisplayObject, newContent:IDisplayObject):void {
			_newContent = newContent;
			_oldContent = oldContent;
			//var tween:Object = { time: 0.3, transition:"easeOutSine" };
			//
			//Tweener.addTween(oldContent, {base: tween, alpha: 0});
			//Tweener.addTween(newContent, {base: tween, alpha: 1});
			if(oldContent)
				TweenMax.to(oldContent, 0.3, { ease: Sine.easeInOut, alpha: 0, onComplete: onOldComplete});
			TweenMax.to(newContent, 0.3, { ease: Sine.easeInOut, alpha: 1, onComplete: onNewComplete });
		}
		
		private function onNewComplete():void {
			
		}
		
		private function onOldComplete():void {
			
		}
		
		public function onAddContent(content:IDisplayObject):void {
			content.alpha = 0;
		}
		
	}

}