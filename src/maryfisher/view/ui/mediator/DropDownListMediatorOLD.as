package maryfisher.view.ui.mediator {
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import maryfisher.corset.mysteries.view.components.BaseDropDownItem;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.IDisplayObjectContainer;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DropDownListMediator {
		
		private var _listMediator:ListMediator;
		private var _selectedElement:IDisplayObject;
		private var _selectedElementPos:Point;
		//private var _maxHeight:int;
		//private var _maxWidth:int;
		private var _listener:Function;
		private var _scroller:BaseScroller;
		private var _dropListener:IDisplayObject;
		private var _listOrder:Vector.<IDisplayObject>;
		
		private var _dropTop:IDisplayObjectContainer;
		private var _dropBase:IDisplayObjectContainer;
		private var _hideOnOut:Boolean;
		private var _elementSelectedListener:Function;
		
		public function DropDownListMediator(dropTop:IDisplayObjectContainer, dropBase:IDisplayObjectContainer, hideOnOut:Boolean = false, dropListener:IDisplayObject = null) {
			_hideOnOut = hideOnOut;
			_dropBase = dropBase;
			_dropListener = dropListener;
			_dropTop = dropTop;
			
			_selectedElementPos = new Point();
			
			_dropBase.addListener(MouseEvent.CLICK, onElementSelected);
			_dropBase.visible = false;
			
			_listMediator = new ListMediator();
			_listMediator.setColumns(1);
			
			_listOrder = new Vector.<IDisplayObject>();
		}
		
		public function set elementSelectedListener(value:Function):void {
			_elementSelectedListener = value;
		}
		
		public function set scrollClass(cl:Class):void {
			_scroller = new cl();
			_scroller.assignContent(_dropBase);
		}
		
		private function onElementSelected(e:MouseEvent):void {
			
			//var posX:int, posY:int;
			//if (_selectedElement) {
				//posX = _selectedElement.x;
				//posY = _selectedElement.y;
			//}
			_selectedElement = e.target as IDisplayObject;
			if(_elementSelectedListener == null){
				_selectedElement.x = _selectedElementPos.x;
				_selectedElement.y = _selectedElementPos.y;
				_dropTop.removeChildren();
				_dropTop.addDisplayChild(_selectedElement);
			}
			
			_listMediator.reset();
			_dropBase.removeChildren();
			
			for each (var item:IDisplayObject in _listOrder) {
				if (item == _selectedElement ) continue;
				_listMediator.addListChild(item);
				_dropBase.addDisplayChild(item);
			}
			
			_elementSelectedListener && _elementSelectedListener(_selectedElement);
		}
		
		public function set itemHeight(h:int):void {
			_listMediator.setDimensions(100, h);
		}
		
		public function reset():void {
			_listMediator.reset();
			_dropBase.removeChildren();
			_dropTop.removeChildren();
			_scroller && (_scroller.reset());
		}
		
		/**
		 * 
		 * @param	h Height of the scrollable part
		 */
		public function set listHeight(h:int):void {
			_scroller && (_scroller.defineScrollArea(_selectedElement.width, h));
		}
		
		public function addListElement(obj:IDisplayObject, isEmpty:Boolean = false):void {
			if (!_selectedElement) {
				_selectedElement = obj;
				_selectedElement.x = _selectedElementPos.x;
				_selectedElement.y = _selectedElementPos.y;
				if (!_dropListener) {
					_dropListener = _selectedElement;
				}
				if(!isEmpty) _dropTop.addDisplayChild(obj);
				_listMediator.setDimensions(obj.width, obj.height);
				//_listMediator.setStartPos(0, obj.height);
				_dropBase.x = 0;
				_dropBase.y = obj.height;
			}else{
				_listMediator.addListChild(obj);
				_dropBase.addDisplayChild(obj);
			}
			if (isEmpty) {
				
			}else{
				_listOrder.push(obj);
			}
		}
		
		private function onSwitch(e:MouseEvent):void {
			_dropBase.visible = !_dropBase.visible;
			//e.stopImmediatePropagation();
			if (_dropBase.visible) {
				if (_hideOnOut) {					
					_dropBase.addListener(MouseEvent.MOUSE_OUT, onHide);
				}
				_dropBase.stage.addEventListener(MouseEvent.CLICK, onHide, true);
			}else {
				if (_dropBase.stage.hasEventListener(MouseEvent.CLICK)) {
					removeOnHide();
				}
			}
		}
		
		private function onHide(e:MouseEvent):void {
			_dropBase.visible = false;
			removeOnHide();
		}
		
		private function removeOnHide():void {
			_dropBase.stage.removeEventListener(MouseEvent.CLICK, onHide, true)
			if(_hideOnOut) _dropBase.removeListener(MouseEvent.MOUSE_OUT, onHide);
		}
		
		public function init():void {
			_dropListener.addListener(MouseEvent.CLICK, onSwitch, false);
			_scroller && (_scroller.updateContent());
		}
		
		//public function set dropDownList(value:IDropDownList):void {
			//_dropDownList = value;
			//_scroller.assignContent(_dropDownList);
			//_dropDownList.addListener();
		//}
		
		public function get scroller():BaseScroller {
			return _scroller;
		}
		
		public function get listMediator():ListMediator {
			return _listMediator;
		}
		
		public function setSelectedElementPos(posX:int, posY:int):void {
			_selectedElementPos.x = posX;
			_selectedElementPos.y = posY;
		}
		
		//public function defineBounds(maxWidth:int, maxHeight:int):void {
			//_maxWidth = maxWidth;
			//_maxHeight = maxHeight;
			//
		//}
		
		//public function addOnElementSelected(listener:Function):void {
			//_listener = listener;
			//
		//}
		
		public function destroy():void {
			_dropListener.removeListener(MouseEvent.CLICK, onSwitch);
			removeOnHide();
		}
	}

}