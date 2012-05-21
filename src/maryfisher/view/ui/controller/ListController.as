package maryfisher.view.ui.controller {
	import flash.geom.Point;
	import maryfisher.austengames.view.ui.preparation.conversation.ConversationItem;
	import maryfisher.view.ui.interfaces.IListObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ListController {
		
		private var _posX:int;
		private var _posY:int;
		private var _index:int;
		private var _childWidth:int;
		private var _childHeight:int;
		private var distX:int;
		private var distY:int;
		private var columns:int;
		//private var _initiated:Boolean;
		private var _isHorizontal:Boolean;
		private var _children:Vector.<IListObject>;
		private var _startY:int;
		private var _startX:int;
		
		public function ListController() {
			//_initiated = false;
			_children = new Vector.<IListObject>();
			//reset();
		}
		
		public function setStartPos(startX:int, startY:int):void {
			_startX = startX;
			_startY = startY;
			_posX = _startX;
			_posY = _startY;
		}
		
		public function setDimensions(width:int, height:int):void {
			_childWidth = width;
			_childHeight = height;
		}
		
		public function setColumns(rows:int, isHorizontal:Boolean = true):void {
			_isHorizontal = isHorizontal;
			columns = rows;
		}
		
		public function setDistances(d:Point):void {
			distX = d.x;
			distY = d.y;
		}
		
		public function addListChild(child:IListObject):void {
			_children.push(child);
			setChildPos(child);
		}
		
		private function setChildPos(child:IListObject):void {
			//if (!_initiated) {
				//distX += child.width;
				//if (!_isHorizontal) {
					_childWidth = _childWidth || child.width;
					_childHeight = _childHeight || child.height;
					//if (_childWidth < child.width) {
						//_childWidth = child.width;
					//}
					//_childHeight = child.height;
				//}else {
					//_childWidth = child.width;
					//if (_childHeight < child.height) {
						//_childHeight = child.height;
					//}
				//}
				//distY += child.height;
				
				//_initiated = true;
			//}else if (child) {
				//
			//}
			
			child.x = _posX;
			child.y = _posY;
			if (_isHorizontal) {
				_posX += _childWidth + distX;
			}else {
				_posY += _childHeight + distY;
			}
			_index++;
			
			if (columns != -1) {
				if (_index % columns == 0) {
					if(_isHorizontal){
						_posX = _startX;
						_posY += _childHeight + distY;
					}else {
						_posY = _startY;
						_posX += _childWidth + distX;
					}
				}
			}
		}
		
		public function updateChildPos():void {
			_index = 0;
			_posX = _startX;
			_posY = _startY;
			for (var i:int; i < _children.length; i++ ) {
				setChildPos(_children[i]);
			}
		}
		
		public function getChildPos(child:IListObject):Point {
			var p:Point = new Point();
			var index:int = _children.indexOf(child);
			if (index) {
				p.y = Math.ceil(index / columns);
				p.x = index % columns;
			}
			return p;
		}
		
		/**
		 * resets index, start positions, removes all children
		 */
		public function reset():void {
			_children = new Vector.<IListObject>();
			_index = 0;
			_posX = _startX;
			_posY = _startY;
		}
		
		public function removeListChild(child:IListObject):void {
			_children.splice(_children.indexOf(child), 1);
			updateChildPos();
		}
	}
}