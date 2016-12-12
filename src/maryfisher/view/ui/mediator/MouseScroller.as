package maryfisher.view.ui.mediator {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	import maryfisher.view.ui.component.BaseBitmap;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MouseScroller extends BaseScroller {
		
		private var _bg:BaseBitmap;
		
		public function MouseScroller() {
			_bg = new BaseBitmap();
		}
		
		override public function assignContent(content:IDisplayObjectContainer):void {
			super.assignContent(content);
			
			CONFIG::mouse {
				if(!_content.hasListener(MouseEvent.MOUSE_OVER)){
					_content.addListener(MouseEvent.MOUSE_OVER, onMouseOver);
					_content.addListener(MouseEvent.MOUSE_OUT, onMouseOut);
				}
			}
		}
		
		CONFIG::mouse
		protected function onMouseOut(e:MouseEvent):void {
			_content.removeListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		CONFIG::mouse
		protected function onMouseOver(e:MouseEvent):void {
			_content.addListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		CONFIG::mouse
		protected function onMouseWheel(e:MouseEvent):void {
			_end += e.delta * 10;
			
			scrollContent();
		}
		
		override public function updateContent():void {
			super.updateContent();
			
			/** TODO
			 * replace with ScrollBG class (DropDownBase)
			 */
			if(_content.width > 0 && _content.height > 0){
				_bg.bitmapData = new BitmapData(_content.width, _content.height, true, 0);
			}
			
			if(!_content.containsContent(_bg)){
				_content.addContentAt(_bg, 0);
			}
		}
		
	}

}