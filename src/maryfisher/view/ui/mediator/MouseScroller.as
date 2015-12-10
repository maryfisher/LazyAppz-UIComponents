package maryfisher.view.ui.mediator {
	import flash.events.MouseEvent;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MouseScroller extends BaseScroller {
		
		public function MouseScroller() {
			
		}
		
		override public function assignContent(content:IViewListener):void {
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
		
	}

}