package maryfisher.view.ui.mediator {
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.IViewListener;
	import maryfisher.view.ui.interfaces.IButtonContainer;
	import maryfisher.view.ui.interfaces.IDropDownBase;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DropDownListMediator {
		
		private var _listMediator:ListMediator;
		private var _selectedElement:IButtonContainer;
		private var _selectedElementPos:Point;
		//private var _maxHeight:int;
		//private var _maxWidth:int;
		//private var _listener:Function;
		private var _scroller:BaseScroller;
		private var _dropListener:IViewListener;
		private var _listOrder:Vector.<IButtonContainer>;
		
		private var _dropTop:IViewListener;
		private var _dropBase:IDropDownBase;
		private var _hideOnOut:Boolean;
		private var _elementSelectedListener:Function;
		private var _switchListener:Function;
		
		public function DropDownListMediator(dropTop:IViewListener, dropBase:IDropDownBase, hideOnOut:Boolean = false, dropListener:IViewListener = null) {
			_hideOnOut = hideOnOut;
			_dropBase = dropBase;
			_dropListener = dropListener;
			_dropTop = dropTop;
			
			_selectedElementPos = new Point();
			
			_dropBase.addListener(MouseEvent.CLICK, onElementSelected);
			_dropBase.visible = false;
			
			_listMediator = new ListMediator();
			_listMediator.setColumns(1);
			
			_listOrder = new Vector.<IButtonContainer>();
		}
		
		public function set elementSelectedListener(value:Function):void {
			_elementSelectedListener = value;
		}
		
		//public function set scrollClass(cl:Class):void {
			//_scroller = new cl();
			//_scroller.assignContent(_dropBase);
		//}
		
		private function onElementSelected(e:MouseEvent):void {
			
			selectElement(e.target as IButtonContainer);
			
			_elementSelectedListener && _elementSelectedListener(_selectedElement);
		}
		
		public function set itemHeight(h:int):void {
			_listMediator.setDimensions(100, h);
		}
		
		public function reset():void {
			_listMediator.reset();
			_dropBase.removeBaseContent();
			//_dropTop.removeChildren();
			_scroller && (_scroller.reset());
			_selectedElement = _dropTop as IButtonContainer;
			_listOrder.length = 0;
		}
		
		/**
		 * 
		 * @param	h Height of the scrollable part
		 */
		public function set listHeight(h:int):void {
			_scroller && (_scroller.defineScrollArea(_selectedElement.width, h));
		}
		
		public function addListElement(obj:IButtonContainer, isEmpty:Boolean = false):void {
			if (!_selectedElement) {
				_selectedElement = obj;
				_selectedElement.x = _selectedElementPos.x;
				_selectedElement.y = _selectedElementPos.y;
				if (!_dropListener) {
					_dropListener = _selectedElement;
				}
				//if(obj != _dropTop) _dropTop.addDisplayChild(obj);
				_listMediator.setDimensions(obj.width, obj.height);
				//_listMediator.setStartPos(0, obj.height);
				//_dropBase.x = 0;
				//_dropBase.y = obj.height;
			}else {
				if (obj.button.id != _selectedElement.button.id) {
					_listMediator.addListChild(obj);
					_dropBase.addContent(obj);
				}else {
					_selectedElement = obj;
				}
				
				if (isEmpty) {
				
				}else{
					_listOrder.push(obj);
				}
			}
			
		}
		
		public function removeListElement(obj:IButtonContainer):void {
			if (obj == _selectedElement) {
				/** TODO
				 * 
				 */
			}else {
				_listMediator.removeListChild(obj);
				_dropBase.removeContent(obj);
				_listOrder.splice(_listOrder.indexOf(obj), 1);
			}
		}
		
		private function onSwitch(e:MouseEvent):void {
			//trace("[DropdDownListMediator] onSwitch");
			
			_dropBase.visible = !_dropBase.visible;
			if (_dropBase.visible) {
				_switchListener && _switchListener(_dropBase.visible);
				if (_hideOnOut) {					
					_dropBase.addListener(MouseEvent.MOUSE_OUT, onHide);
				}
				_dropBase.addStageListener(MouseEvent.CLICK, onHide, true);
			}else {
				if (_dropBase.hasStageListener(MouseEvent.CLICK)) {
					removeOnHide();
				}
				_switchListener && _switchListener(_dropBase.visible);
				
			}
			
		}
		
		private function onHide(e:MouseEvent):void {
			
			//Fix for double click: hide -> switch
			if (e.target == _dropListener) return;
			
			//trace("[DropdDownListMediator] onHide");
			_dropBase.visible = false;
			removeOnHide();
			_switchListener && _switchListener(_dropBase.visible);
		}
		
		private function removeOnHide():void {
			_dropBase.removeStageListener(MouseEvent.CLICK, onHide, true)
			//_dropBase.stage && _dropBase.stage.removeEventListener(MouseEvent.CLICK, onHide, true)
			if(_hideOnOut) _dropBase.removeListener(MouseEvent.MOUSE_OUT, onHide);
		}
		
		//public function selectElementById(index:int):void {
			//
		//}
		
		public function selectElement(im:IButtonContainer):void {
			_selectedElement = im;
			//if(_elementSelectedListener == null){
				//_selectedElement.x = _selectedElementPos.x;
				//_selectedElement.y = _selectedElementPos.y;
				//_dropTop.removeChildren();
				//_dropTop.addDisplayChild(_selectedElement);
			//}
			
			_listMediator.reset();
			_dropBase.removeBaseContent();
			
			for each (var item:IButtonContainer in _listOrder) {
				if (item.button.id == _selectedElement.button.id ) continue;
				_listMediator.addListChild(item);
				_dropBase.addContent(item);
			}
			//_dropBase.updateHeight();
		}
		
		public function init():void {
			_dropListener.addListener(MouseEvent.CLICK, onSwitch, false);
			update();
		}
		
		public function update():void {
			var nextChildPos:int = _listMediator.getNextChildPos().y;
			if (nextChildPos == 0) return;
			if (_dropBase.height > nextChildPos) _dropBase.actHeight = nextChildPos;
			_scroller && (_scroller.updateContent());
		}
		
		//public function update():void {
			//trace("next child", _listMediator.getNextChildPos().y);
			//var nextChild:int = _listMediator.getNextChildPos().y;
			//if (_dropBase.height > nextChild) _dropBase.actHeight = nextChild;
			//_scroller && (_scroller.updateContent());
		//}
		
		//public function set dropDownList(value:IDropDownList):void {
			//_dropDownList = value;
			//_scroller.assignContent(_dropDownList);
			//_dropDownList.addListener();
		//}
		
		public function get scroller():BaseScroller {
			return _scroller;
		}
		
		public function set scroller(value:BaseScroller):void {
			_scroller = value;
			_scroller.assignContent(_dropBase);
			
		}
		
		public function get listMediator():ListMediator {
			return _listMediator;
		}
		
		public function set droppedListener(value:Function):void {
			_switchListener = value;
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
		
		public function dispose():void {
			_dropListener.removeListener(MouseEvent.CLICK, onSwitch);
			removeOnHide();
		}
		
		public function set enabled(value:Boolean):void {
			if (value) {
				_dropListener.addListener(MouseEvent.CLICK, onSwitch);
			}else {
				_dropListener.removeListener(MouseEvent.CLICK, onSwitch);
			}
		}
	}

}