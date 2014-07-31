package maryfisher.view.ui.component {
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import maryfisher.framework.core.ViewController;
	import maryfisher.framework.view.core.BaseSpriteView;
	import maryfisher.view.ui.interfaces.ITooltip;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSpriteTooltip extends BaseSpriteView implements ITooltip {
		
		private var _mouseOver:Boolean = false;
		private var _ownerMouseOut:Boolean = false;
		private var _owner:DisplayObject;
		protected var _distX:int;
		protected var _distY:int;
		
		public function BaseSpriteTooltip(owner:DisplayObject) {
			super();
			_owner = owner;
			
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITooltip */
		
		public function switchVisibility():void {
			visible = !visible;
		}
		
		override public function show():void {
			
			//addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			var p:Rectangle = _owner.getRect(stage);
			x = p.x + _distX;
			y = p.y + _distY;
			
			if (x + contentWidth > ViewController.stageWidth) {
				x = p.x - contentWidth;
			}
			if (y + contentHeight > ViewController.stageHeight) {
				y -= (p.y + contentHeight) - ViewController.stageHeight + 20;
			}
			//_owner.stage.addChild(this);
			//trace("show tooltip");
			super.show();
		}
		
		protected function get contentHeight():int {
			return height;
		}
		
		protected function get contentWidth():int {
			return width;
		}
		
		private function onMouseOver(e:MouseEvent):void {
			_mouseOver = true;
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);			
		}
		
		override public function hide():void {
			//if (!_ownerMouseOut && _mouseOver) {
				//_ownerMouseOut = true;
				//return;
			//}
			//TweenMax.delayedCall(0.1, hideForReal);
			//
		//}
		//
		//private function hideForReal():void {
			//trace(_mouseOver);
			//if (_mouseOver) return;
			//_ownerMouseOut = false;
			//_mouseOver = false;
			//removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			//removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//_owner.stage.contains(this) && _owner.stage.removeChild(this);
			//trace("hide tooltip");
			super.hide();
		}
		
		private function onMouseOut(e:MouseEvent):void {
			//this is for children that trigger mouse out
			var rect:Rectangle = getRect(stage);
			if(!(stage.mouseX < rect.left || stage.mouseX > rect.right || stage.mouseY < rect.top || stage.mouseY > rect.bottom)){
				return;
			}
			trace("hide tooltip");
			_mouseOver = false;
			hide();
		}
		
		override public function destroy():void {
			//hide();
			removeView();
			super.destroy();
		}
	}

}