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
		
		static public const FACE_LEFT:int = 0;
		static public const FACE_RIGHT:int = 1;
		static public const FACE_UP:int = 2;
		static public const FACE_DOWN:int = 3;
		
		private var _mouseOver:Boolean = false;
		private var _ownerMouseOut:Boolean = false;
		protected var _ownerRect:Rectangle;
		protected var _owner:DisplayObject;
		//protected var _distX:int;
		protected var _paddingX:int;
		protected var _paddingY:int;
		//protected var _distY:int;
		protected var _face:int;
		protected var _defaultFace:int;
		
		public function BaseSpriteTooltip(owner:DisplayObject) {
			super();
			_owner = owner;
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITooltip */
		
		public function switchVisibility():void {
			visible = !visible;
		}
		
		override public function show():void {
			
			_ownerRect = _owner.getRect(stage);
			
			if (_defaultFace == FACE_LEFT) {
				faceLeft();
				//if (x + contentWidth > ViewController.stageWidth) {
					//faceRight();
				//}else {
					//faceLeft();
				//}
				//if (y + contentHeight > ViewController.stageHeight) {
					////y -= (p.y + contentHeight) - ViewController.stageHeight + 20;
					//faceDown();
				//}
			} else if (_defaultFace == FACE_RIGHT) {
				faceRight();
			} else if(_defaultFace == FACE_DOWN){
				faceDown();
			} else if(_defaultFace == FACE_UP){
				faceUp();
			}
			checkBounds();
			
			super.show();
		}
		
		private function checkBounds():void {
			if (x + contentWidth > ViewController.stageWidth) {
				faceRight();
			}else if(x < 0) {
				faceLeft();
			}
			if (y + contentHeight > ViewController.stageHeight) {
				faceDown();
			}else if(y < 0){
				faceUp();
			}
		}
		
		private function faceRight():void {
			x = _ownerRect.x - contentWidth - _paddingX;
			y = _ownerRect.y + _paddingY;
			_face = FACE_RIGHT;
		}
		
		private function faceLeft():void {
			x = _ownerRect.x + _owner.width + _paddingX;
			y = _ownerRect.y + _paddingY;
			_face = FACE_LEFT;
		}
		
		private function faceDown():void {
			x = _ownerRect.x + (_ownerRect.width - contentWidth >> 1);
			y = _ownerRect.y - contentHeight - _paddingY;
			_face = FACE_DOWN;
		}
		
		private function faceUp():void {
			x = _ownerRect.x + (_ownerRect.width - contentWidth >> 1);
			y = _ownerRect.y + _ownerRect.height + _paddingY;
			_face = FACE_UP;
		}
		
		protected function get contentHeight():int {
			return height;
		}
		
		protected function get contentWidth():int {
			return width;
		}
		
		public function set paddingX(value:int):void {
			_paddingX = value;
			//_distX = _owner.width + _paddingX;
		}
		
		public function set paddingY(value:int):void {
			_paddingY = value;
			//_distY = _owner.height + _paddingY;
		}
		
		public function set defaultFace(value:int):void {
			_defaultFace = value;
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