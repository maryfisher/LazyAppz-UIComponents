package maryfisher.view.ui.component {
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.button.HoverField;
	import maryfisher.view.ui.interfaces.IProgressBar;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseProgressBar extends HoverField implements IProgressBar {
		
		//protected var _mask:Bitmap;
		protected var _mask:DisplayObject;
		protected var _bar:DisplayObject;
		protected var _lastProgress:Number = 0;
		private var _isHorizontal:Boolean;
		
		public function BaseProgressBar(isHorizontal:Boolean) {
			_isHorizontal = isHorizontal;
			
		}
		
		public function setBar(bar:IDisplayObject, mask:IDisplayObject):void {
			_bar = bar as DisplayObject;
			_mask = mask as DisplayObject;
			//_isHorizontal ? _mask.width = _lastProgress * _bar.width : _mask.height = _lastProgress * _bar.height;
			_isHorizontal ? _mask.x = -_bar.width : _mask.y = _bar.height;
			_bar.mask = _mask;
			addChild(_bar);
			addChild(_mask)
		}
		
		public function setProgress(percent:Number):void {
			if (percent > 1) {
				percent = 1;
			}else if (percent < 0) {
				percent = 0;
			}
			if (_lastProgress == percent) {
				return;
			}
			
			var diff:Number = percent - _lastProgress;
			_lastProgress = percent;
			TweenMax.killTweensOf(_mask);
			//Tweener.addTween(_mask, { width: percent * _bar.width, time: 4 } );
			if(_isHorizontal){
				//TweenMax.to(_mask, 3 * diff, { width: percent * _bar.width } );
				//_mask.width = percent * _bar.width;
				TweenMax.to(_mask, 10 * diff, { x: percent * _bar.width - _bar.width} );
			}else {
				//_mask.height = percent * _bar.height;
				TweenMax.to(_mask, 3 * diff, { height: percent * _bar.height } );
				//TweenMax.to(_mask, 10 * diff, { y: _bar.height - percent * _bar.height } );
			}
		}
		
		override public function get width():Number {
			return _bar.width;
		}
		
		override public function get height():Number {
			return _bar.height;
		}
	}

}