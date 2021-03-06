package maryfisher.view.ui.component.starling {
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.interfaces.IProgressBar;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingProgressBar extends BaseStarling implements IProgressBar {
		
		protected var _mask:DisplayObject;
		protected var _bar:DisplayObject;
		protected var _lastProgress:Number = 0;
		private var _isHorizontal:Boolean;
		
		public function BaseStarlingProgressBar(isHorizontal:Boolean) {
			_isHorizontal = isHorizontal;
		}
		
		public function setBar(bar:IDisplayObject, mask:IDisplayObject):void {
			_bar = bar as DisplayObject;
			_mask = mask as DisplayObject;
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
			if(_isHorizontal){
				TweenMax.to(_mask, 10 * diff, { x: percent * _bar.width - _bar.width} );
			}else {
				TweenMax.to(_mask, 3 * diff, { height: percent * _bar.height } );
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