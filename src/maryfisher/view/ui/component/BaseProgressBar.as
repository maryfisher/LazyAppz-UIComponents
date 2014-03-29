package maryfisher.view.ui.component {
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseProgressBar extends Sprite {
		
		//protected var _mask:Bitmap;
		protected var _mask:DisplayObject;
		protected var _bar:Bitmap;
		protected var _lastProgress:Number;
		private var _isHorizontal:Boolean;
		
		public function BaseProgressBar(isHorizontal:Boolean) {
			_isHorizontal = isHorizontal;
			
		}
		
		protected function setBar(bar:Bitmap, mask:DisplayObject):void {
			_bar = bar;
			_mask = mask;
			_isHorizontal ? _mask.width = 0 : _mask.height = 0;
			_bar.mask = _mask;
			addChild(_bar);
			addChild(_mask)
		}
		
		public function setProgress(percent:Number):void {
			//if (percent > 1) {
				//percent = percent * 0.01;
			//}
			if (_lastProgress == percent) {
				return;
			}
			var diff:Number = percent - _lastProgress;
			_lastProgress = percent;
			TweenMax.killTweensOf(_mask);
			//Tweener.addTween(_mask, { width: percent * _bar.width, time: 4 } );
			if(_isHorizontal){
				TweenMax.to(_mask, 3 * diff, { width: percent * _bar.width } );
			}else {
				TweenMax.to(_mask, 3 * diff, { height: percent * _bar.height } );
			}
			//_mask.width = percent * _bar.width;
		}
		
	}

}