package maryfisher.view.ui.component {
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ProgressBar extends Sprite {
		
		protected var _mask:Bitmap;
		protected var _bar:Bitmap;
		protected var _lastProgress:Number;
		
		public function ProgressBar() {
			
		}
		
		public function setProgress(percent:Number):void {
			if (percent > 1) {
				percent = percent * 0.01;
			}
			_lastProgress = percent;
			Tweener.addTween(_mask, { width: percent * _bar.width, time:1 } );
			_mask.width = percent * _bar.width;
		}
		
	}

}