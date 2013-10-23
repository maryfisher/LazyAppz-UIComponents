package maryfisher.view.ui.mediator {
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import maryfisher.view.ui.interfaces.IScrollBar;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseScrollBar extends Sprite implements IScrollBar {
		
		protected var _track:DisplayObject;
		protected var _thumb:DisplayObject;
		private var _scrollMax:int;
		private var _scrollHeight:int;
		private var _isInvisible:Boolean;
		private var _fadeOutSpeed:Number = 0.7;
		private var _fadeInSpeed:Number = 0.3;
		
		public function BaseScrollBar(isInvisible:Boolean) {
			_isInvisible = isInvisible;
			if(_isInvisible) alpha = 0;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IScrollBar */
		
		public function setScrollDims(scrollMax:int, scrollHeight:int):void {
			removeChildren();
			_scrollHeight = scrollHeight;
			_scrollMax = scrollMax;
			
			if (_scrollHeight >= _scrollMax) return;
			
			createTrack(_scrollHeight);
			createThumb((_scrollHeight / _scrollMax) * _scrollHeight);
		}
		
		public function startScrolling(scrollEnd:int):void {
			//fade in
			var perc:Number = scrollEnd / (_scrollMax - _scrollHeight);
			var px:int = scrollEnd > _thumb.y ? -1 : 1;
			var pos:int = (_scrollHeight - _thumb.height) * perc + px;
			
			
			TweenMax.killTweensOf(_thumb);
			TweenMax.to(_thumb, _fadeInSpeed, { y: pos } );
			
			if (!_isInvisible) return;
			TweenMax.killTweensOf(this);
			TweenMax.to(this, _fadeInSpeed, { alpha: 1 } );
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IScrollBar */
		
		public function finishedScrolling():void {
			if (!_isInvisible) return;
			TweenMax.killTweensOf(this);
			TweenMax.to(this, _fadeOutSpeed, { alpha: 0 } );
		}
		
		protected function createTrack(trackHeight:int):void {	}
		
		protected function createThumb(thumbHeight:int):void {	}
		
		public function set fadeOutSpeed(value:Number):void {
			_fadeOutSpeed = value;
		}
		
		public function set fadeInSpeed(value:Number):void {
			_fadeInSpeed = value;
		}
		
	}

}