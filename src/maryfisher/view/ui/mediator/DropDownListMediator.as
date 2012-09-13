package maryfisher.view.ui.mediator {
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.IDropDownList;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DropDownListMediator {
		
		private var _listMediator:ListMediator;
		private var _selectedElement:IDisplayObject;
		private var _dropDownList:IDropDownList;
		private var _maxHeight:int;
		private var _maxWidth:int;
		private var _listener:Function;
		
		public function DropDownListMediator() {
			
		}
		
		public function addListElement(obj:IDisplayObject):void {
			_listMediator.addListChild(obj);
			_dropDownList.addListChild(obj);
		}
		
		public function set dropDownList(value:IDropDownList):void {
			_dropDownList = value;
			//_dropDownList.addListener();
		}
		
		public function defineBounds(maxWidth:int, maxHeight:int):void {
			_maxWidth = maxWidth;
			_maxHeight = maxHeight;
			
		}
		
		public function addOnElementSelected(listener:Function):void {
			_listener = listener;
			
		}
	}

}