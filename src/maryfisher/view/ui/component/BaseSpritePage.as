package maryfisher.view.ui.component {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.IPage;
	import maryfisher.view.ui.mediator.ListMediator;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSpritePage extends Sprite implements IPage {
		
		private var _listMediator:ListMediator;
		//private var _maxPageWidth:int;
		//private var _isHorizontal:Boolean;
		
		public function BaseSpritePage() {
			//_isHorizontal = isHorizontal;
			//_maxPageWidth = pageWidth;
			_listMediator = new ListMediator();
			_listMediator.setColumns(1, true);
			_listMediator.hasVariableDims = true;
			visible = false;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IPage */
		
		//public function hasRoom(content:IDisplayObject):Boolean {
			//var childPos:Point = _listMediator.getLastChildPos();
			//var max:int = _isHorizontal ? childPos.x + content.width : childPos.y + content.height;
			//if (max <= _maxPageWidth) {
				//addContent(content);
			//}
			//return false;
		//}
		
		public function addContent(content:IDisplayObject):void {
			_listMediator.addListChild(content);
			addChild(content as DisplayObject);
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function show():void {
			visible = true;
		}
		
		public function get listMediator():ListMediator {
			return _listMediator;
		}
		
	}

}