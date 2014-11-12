package maryfisher.view.ui.component {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.interfaces.IPage;
	import maryfisher.view.ui.mediator.ListMediator;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseSpritePage extends Sprite implements IPage {
		
		protected var _listMed:ListMediator;
		
		public function BaseSpritePage() {
			_listMed = new ListMediator();
		}
		
		public function addContent(content:IDisplayObject):void {
			_listMed.addListChild(content);
			addChild(content as DisplayObject);
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function show():void {
			visible = true;
		}
		
		public function get listMediator():ListMediator {
			return _listMed;
		}
		
	}

}