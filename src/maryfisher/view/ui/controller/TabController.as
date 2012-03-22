package maryfisher.view.ui.controller {
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ITabBar;
	import maryfisher.view.ui.interfaces.ITabSelectedEffect;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TabController {
		
		private var _tabButtons:Dictionary;
		private var _content:Dictionary;
		private var _selectedTab:String;
		private var _effect:ITabSelectedEffect;
		
		public function TabController() {
			_content = new Dictionary();
			_tabButtons = new Dictionary();
			_tabBar.addOnTabSelected(onTabSelected);
		}
		
		private function onTabSelected(id:String):void {
			selectTab(id);
		}
		
		public function addContent(content:DisplayObject, tab:IButton, id:String):void {
			content.visible = false;
			_content[id] = content;
			_tabButtons[id] = tab;
			_effect && _effect.onAddContent(content);
		}
		
		public function selectTab(id:String):void {
			if (_effect) {
				_effect.onTabSelected(_content[_selectedTab], _content[id]);
			}
			
			if (_selectedTab && _tabButtons[_selectedTab]) {
				//_content[_selectedTab].visible = false;
				(_tabButtons[_selectedTab] as IButton).selected = false;
			}
			
			_selectedTab = id;
			
			//_content[_selectedTab] && _content[_selectedTab].visible = true;
			(_tabButtons[_selectedTab] as IButton).selected = true;
		}
		
		public function set effect(value:ITabSelectedEffect):void {
			_effect = value;
		}
	}

}