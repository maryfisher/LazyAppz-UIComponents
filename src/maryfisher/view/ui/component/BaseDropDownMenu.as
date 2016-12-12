package maryfisher.view.ui.component {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import maryfisher.view.ui.button.ButtonColorScheme;
	import maryfisher.view.ui.component.BaseSprite;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IButtonContainer;
	import maryfisher.view.ui.interfaces.IDropDownBase;
	import maryfisher.view.ui.interfaces.IScrollBar;
	import maryfisher.view.ui.mediator.BaseScroller;
	import maryfisher.view.ui.mediator.BarScroller;
	import maryfisher.view.ui.mediator.DropDownListMediator;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseDropDownMenu extends BaseSprite {
		
		protected var _bubbleSignal:DeluxeSignal;
		protected var _dropMediator:DropDownListMediator;
		protected var _dropBase:IDropDownBase;
		protected var _dropTop:IButtonContainer;
		//protected var _dropTop:IIDItem;
		protected var _selectedIndex:int = -1;
		protected var _buttons:Vector.<IButtonContainer>;
		private var _selectedListener:Function;
		private var _id:String;
		private var _enabled:Boolean;
		protected var _maxHeight:int;
		protected var _scroller:BaseScroller;
		protected var _topH:int;
		protected var _w:int;
		
		public function BaseDropDownMenu(id:String, w:int, maxHeight:int, topH:int, autoBuild:Boolean = true) {
			_w = w;
			_topH = topH;
			_maxHeight = maxHeight;
			_id = id;
			
			_bubbleSignal = new DeluxeSignal(this);
			
			_buttons = new Vector.<IButtonContainer>();
			
			if(autoBuild)
				buildMenu();
		}
		
		protected function createTop():void {
			throw new Error("[BaseDropDownMenu] [createTop] Please overwrite this method to create _dropTop.")
		}
		
		protected function createBase():void {
			throw new Error("[BaseDropDownMenu] [createBase] Please overwrite this method to create _dropBase.")
		}
		
		protected function createListButton(id:String, label:String):IButtonContainer {
			throw new Error("[BaseDropDownMenu] [createListButton] Please overwrite this method to create a list button.")
			return null;
		}
		
		public function resetTop():void {
			throw new Error("[BaseDropDownMenu] [resetTop] Please overwrite this method to reset the _dropTop.")
		}
		
		protected function updateTop(b:IButtonContainer):void {
			throw new Error("[BaseDropDownMenu] [resetTop] Please overwrite this method to update the content of _dropTop.")
		}
		
		private function onDropped(isVisible:Boolean):void {
				trace("on Dropped");
			if (isVisible) {
				positionBase();
				stage.addChild(_dropBase as DisplayObject);
				onVisible();
			}else {
				stage.contains(_dropBase as DisplayObject) && stage.removeChild(_dropBase as DisplayObject);
				onInvisible();
			}
		}
		
		protected function positionBase():void {
			var rect:Rectangle = getRect(stage);
			_dropBase.x = rect.x;
			var h:int = Math.min(_maxHeight, _dropBase.height);
			if (rect.y + h + _dropTop.height > stage.stageHeight) {
				_dropBase.y = rect.y - h;
			}else {
				_dropBase.y = rect.y + _dropTop.height;
			}
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		protected function dispatchUpdate():void {
			_selectedListener && _selectedListener(_selectedIndex);
			_bubbleSignal.dispatch(new GenericEvent(true));
		}
		
		public function buildMenu():void {
			createTop();
			addChild(_dropTop as DisplayObject);
			createBase();
			
			_dropMediator = new DropDownListMediator(_dropTop, _dropBase, false, _dropTop);
			_dropMediator.elementSelectedListener = onElementSelected;
			_dropMediator.droppedListener = onDropped;
			//_dropMediator.listMediator.setStartPos(0, 0);
			_dropMediator.addListElement(_dropTop);
		}
		
		protected function onVisible():void {
			
		}
		
		protected function onInvisible():void {
			
		}
		
		protected function createScroller():void {
			
			if(_scroller){
				_dropMediator.scroller = _scroller;
				_dropMediator.listHeight = _dropBase.actHeight//_maxHeight;
			}
		}
		
		protected function onElementSelected(el:IButtonContainer):void {
			updateTop(el);
			_selectedIndex = _buttons.indexOf(el);
			dispatchUpdate();
		}
		
		public function addListElement(id:String, label:String):IButtonContainer {
			var b:IButtonContainer = createListButton(id, label);
			_dropMediator.addListElement(b);
			_buttons.push(b);
			return b;
		}
		
		public function removeListElement(id:String):void {
			for each (var b:IButtonContainer in _buttons) {
				if (b.button.id == id) {
					_dropMediator.removeListElement(b);
					break;
				}
			}
			_buttons.splice(_buttons.indexOf(b), 1);
		}
		
		
		/**
		 * 
		 * @param	list	Function.<int>
		 */
		public function addSelectedListener(list:Function):void {
			_selectedListener = list;
		}
		
		public function init():void {
			
			if (!stage) {
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				return;
			}
			
			//positionBase();
			//if (_maxHeight < _dropBase.height) {
				//if(!_scroller){
					//createScroller();
				//}
			//}
			updateBase();
			_dropMediator.init();
		}
		
		/** TODO
		 * implement
		 */
		public function update():void {
			updateBase();
			_dropMediator.update();
		}
		
		private function updateBase():void {
			positionBase();
			if (_maxHeight < _dropBase.height) {
				if(!_scroller){
					createScroller();
				}
			}
		}
		
		public function reset():void {
			_selectedIndex = -1;
			//_dropBase.removeContent();
			_dropMediator.reset();
			_buttons.length = 0;
			resetTop();
			_scroller && _scroller.reset();
		}
		
		public function destroy():void {
			_scroller && _scroller.dispose();
			_dropMediator.dispose();
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled == value) return;
			_enabled = value;
			_dropMediator.enabled = _enabled
		}
		
		public function select(index:int):void {
			_selectedIndex = index;
			updateTop(_buttons[index]);
			_dropMediator.selectElement(_buttons[index]);
			_bubbleSignal.removeAll();
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get selectedIndex():int {
			return _selectedIndex;
		}
	}

}