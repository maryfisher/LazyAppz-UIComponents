package maryfisher.view.ui.mediator {
	import flash.utils.Dictionary;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	import maryfisher.view.ui.interfaces.ITabSelectedEffect;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TabsMediator implements ITabSelectedEffect{
		
		private var _tabButtons:Dictionary;
		private var _content:Dictionary;
		private var _selectedTab:String;
		private var _effect:ITabSelectedEffect;
		private var _tabUpdate:Signal;
		
		public function TabsMediator() {
			_content = new Dictionary();
			_tabButtons = new Dictionary();
			_tabUpdate = new Signal(IButton);
			_effect = this;
			//_tabBar.addOnTabSelected(onTabSelected);
		}
		
		private function onTabSelected(button:IButton):void {
			selectTab(button.id);
		}
		
		public function addContent(content:IDisplayObject, tab:IButton):void {
			_content[tab.id] = content;
			_tabButtons[tab.id] = tab;
			tab.addClickedListener(onTabSelected);
			_effect.onAddContent(content);
		}
		
		public function selectTab(id:String):void {
			_effect.startTransition(_content[_selectedTab], _content[id]);
			
			if (_selectedTab && _tabButtons[_selectedTab]) {
				(_tabButtons[_selectedTab] as IButton).selected = false;
			}
			
			
			if (_selectedTab == id) {
				_selectedTab = null;
				_tabUpdate.dispatch(null);
				return;
			}
			
			_selectedTab = id;
			
			(_tabButtons[_selectedTab] as IButton).selected = true;
			
			_tabUpdate.dispatch((_tabButtons[_selectedTab] as IButton));
		}
		
		public function reset():void {
			_content = new Dictionary();
			_tabButtons = new Dictionary();
			_selectedTab = null;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITabSelectedEffect */
		
		public function onAddContent(content:IDisplayObject):void {
			content.visible = false;
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.ITabSelectedEffect */
		
		public function startTransition(oldContent:IDisplayObject, newContent:IDisplayObject):void {
			oldContent && (oldContent.visible = false);
			if (oldContent == newContent) return;
			newContent && (newContent.visible = true);
		}
		
		public function getContent(b:IButton):IDisplayObject {
			return _content[b.id];
		}
		
		public function set effect(value:ITabSelectedEffect):void {
			_effect = value;
		}
		
		public function get tabUpdate():Signal {
			return _tabUpdate;
		}
		
		//private function addOnTabSelected(listener:Function):void {
			//_tabUpdate.add(listener);
		//}
	}

}