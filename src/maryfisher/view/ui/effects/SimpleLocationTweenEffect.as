package maryfisher.view.ui.effects {
	import com.greensock.TweenLite;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.ILocationTweenEffect;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SimpleLocationTweenEffect implements ILocationTweenEffect{
		
		public function SimpleLocationTweenEffect() {
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ILocationTweenEffect */
		
		public function tweenObj(obj:IDisplayObject, posX:int, posY:int):void {
			TweenLite.to(obj, 0.3, { x: posX, y: posY } );
		}
		
	}

}