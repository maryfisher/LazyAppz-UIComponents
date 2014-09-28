package maryfisher.view.ui.component {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import maryfisher.view.ui.button.ButtonColorScheme;
	import maryfisher.framework.view.core.BaseSprite;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IDropDownBase;
	import maryfisher.view.ui.interfaces.IIDItem;
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
		protected var _dropTop:IIDItem;
		protected var _selectedIndex:int = -1;
		protected var _buttons:Vector.<IButton>;
		private var _selectedListener:Function;
		private var _id:String;
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
			
			_buttons = new Vector.<IButton>();
			
			if(autoBuild)
				buildMenu();
		}
		
		protected function createTop():void {
			throw new Error("[BaseDropDownMenu] [createTop] Please overwrite this method to create _dropTop.")
		}
		
		protected function createBase():void {
			throw new Error("[BaseDropDownMenu] [createBase] Please overwrite this method to create _dropBase.")
		}
		
		protected function createListButton(id:String, label:String):IButton {
			throw new Error("[BaseDropDownMenu] [createListButton] Please overwrite this method to create a list button.")
			return null;
		}
		
		public function resetTop():void {
			throw new Error("[BaseDropDownMenu] [resetTop] Please overwrite this method to reset the _dropTop.")
		}
		
		protected function updateTop(b:IButton):void {
			throw new Error("[BaseDropDownMenu] [resetTop] Please overwrite this method to update the content of _dropTop.")
		}
		
		private function onDropped(isVisible:Boolean):void {
			if (isVisible) {
				//positionBase();
				stage.addChild(_dropBase as DisplayObject);
				onVisible();
			}else {
				stage.contains(_dropBase as DisplayObject) && stage.removeChild(_dropBase as DisplayObject);
				onInvisible();
			}
		}
		
		private function positionBase():void {
			var rect:Rectangle = getRect(stage);
			_dropBase.x = rect.x;
			_dropBase.y = rect.y + _dropTop.height;
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
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
		
		protected function onElementSelected(el:IButton):void {
			updateTop(el);
			_selectedIndex = _buttons.indexOf(el);
			_selectedListener && _selectedListener(_selectedIndex);
			_bubbleSignal.dispatch(new GenericEvent(true));
			//_dropBase.actHeight = _maxHeight - _topH;
			//_scroller && (_dropMediator.listHeight = _maxHeight - _topH);
		}
		
		public function addListElement(id:String, label:String):IButton {
			var b:IButton = createListButton(id, label);
			_dropMediator.addListElement(b);
			_buttons.push(b);
			return b;
		}
		
		
		/**
		 * 
		 * @param	list	Function.<index:int>
		 */
		public function addSelectedListener(list:Function):void {
			_selectedListener = list;
		}
		
		public function init():void {
			
			if (!stage) {
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				return;
			}
			
			positionBase();
			if (_maxHeight < _dropBase.height) {
				if(!_scroller){
					createScroller();
				}
			}
			_dropMediator.init();
		}
		
		public function reset():void {
			_selectedIndex = -1;
			//_dropBase.removeContent();
			_dropMediator.reset();
			_buttons.length = 0;
			resetTop();
			_scroller && _scroller.reset();
		}
		
		public function select(index:int):void {
			_selectedIndex = index;
			updateTop(_buttons[index]);
			_dropMediator.selectElement(_buttons[index]);
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get selectedIndex():int {
			return _selectedIndex;
		}
	}

}