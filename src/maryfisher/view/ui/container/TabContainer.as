package maryfisher.view.ui.container {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import matchmaker.component.tab.TabBar;
	import matchmaker.component.tab.TabButton;
	import matchmaker.event.TabEvent;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TabContainer extends Sprite{
		
		private var _tabBar:TabBar;
		private var _content:Dictionary;
		
		public function TabContainer(tabBar:TabBar) {
			_tabBar = tabBar;
			addChild(_tabBar);
			_content = new Dictionary(true);
			_tabBar.addEventListener(TabEvent.TAB_CLICKED, handleTabClicked, true, 0, true);
		}
		
		private function handleTabClicked(e:TabEvent):void {
			selectTab(e.id);
		}
		
		public function addContent(content:DisplayObject, id:String, overlap:Boolean = false):void {
			if (!overlap) {
				if (_tabBar.align == TabBar.ALIGN_VERTICAL) {
					content.x = _tabBar.width;
				}else {
					content.y = _tabBar.height;
				}
			}
			
			addChildAt(content, 0);
			content.visible = false;
			_content[id] = content;
		}
		
		public function selectTab(id:String):void {
			trace('selectTab', id, _tabBar.selectedTab);
			if (_tabBar.selectedTab) {
				if (_content[_tabBar.selectedTab] != null) {
					_content[_tabBar.selectedTab].visible = false;
				}
			}
			if (_content[id] != null) {
				_content[id].visible = true;
			}
			_tabBar.selectTab(id);
		}
	}

}