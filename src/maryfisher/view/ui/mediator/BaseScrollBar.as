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
		
		public function BaseScrollBar() {
			alpha = 0;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IScrollBar */
		
		public function setScrollDims(scrollMax:int, scrollHeight:int):void {
			removeChildren();
			_scrollHeight = scrollHeight;
			_scrollMax = scrollMax;
			
			createTrack(_scrollHeight);
			createThumb((_scrollHeight / _scrollMax) * _scrollHeight);
		}
		
		public function startScrolling(scrollEnd:int):void {
			//fade in
			var perc:Number = scrollEnd / (_scrollMax - _scrollHeight);
			var pos:int = (_scrollHeight - _thumb.height) * perc;
			
			TweenMax.killTweensOf(this);
			TweenMax.killTweensOf(_thumb);
			TweenMax.to(this, 0.7, { alpha: 1 } );
			TweenMax.to(_thumb, 0.7, { y: pos } );
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IScrollBar */
		
		public function finishedScrolling():void {
			TweenMax.killTweensOf(this);
			TweenMax.to(this, 0.7, { alpha: 0 } );
		}
		
		protected function createTrack(trackHeight:int):void {
			//_track = new Bitmap(new BitmapData(10, _scrollHeight));
			//addChild(_track);
		}
		
		protected function createThumb(thumbHeight:int):void {
			//_thumb = new Bitmap(new BitmapData(8, thumbHeight, false, 0x333333));
			//_thumb.y = 1;
			//_thumb.x = 1;
			//addChild(_thumb);
		}
		
	}

}