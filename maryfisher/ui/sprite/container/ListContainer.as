package maryfisher.ui.sprite.container {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ListContainer extends Sprite {
		
		private var _posX:int;
		private var _posY:int;
		private var _index:int;
		private var _childWidth:int;
		private var _childHeight:int;
		private var distX:int;
		private var distY:int;
		private var columns:int;
		private var _initiated:Boolean;
		private var _isHorizontal:Boolean;
		
		public function ListContainer() {
			_initiated = false
			reset();
		}
		
		public function setDimensions(b:Point):void {
			
		}
		
		public function setColumns(rows:int, isHorizontal:Boolean = true):void {
			_isHorizontal = isHorizontal;
			columns = rows;
		}
		
		public function setDistances(d:Point):void {
			distX = d.x;
			distY = d.y;
		}
		
		public function addListChild(child:DisplayObject):void {
			if (child is FamilyContainer) {
				//if (!hasEventListener(List)) {
					(child as FamilyContainer).updateSignal.add(updateChildPos);
				//}
			}
			setChildPos(child);
			
			addChild(child);
		}
		
		private function setChildPos(child:DisplayObject):void {
			trace(_isHorizontal);
			//if (!_initiated) {
				//distX += child.width;
				if(!_isHorizontal){
					if (_childWidth < child.width) {
						_childWidth = child.width;
					}
					_childHeight = child.height;
				}else {
					_childWidth = child.width;
					if (_childHeight < child.height) {
						_childHeight = child.height;
					}
				}
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
			//trace('ListContainer', index, posY, posX, columns, y, name);
			if (columns != -1) {
				if (_index % columns == 0) {
					if(_isHorizontal){
						_posX = 0;	
						_posY += _childHeight + distY;
					}else {
						_posY = 0;
						_posX += _childWidth + distX;
					}
				}
			}
		}
		
		public function updateChildPos():void {
			//var j:int = 0;
			_index = 0;
			_posX = 0;
			_posY = 0;
			for (var i:int; i < numChildren; i++ ) {
				var child:DisplayObject = getChildAt(i);
				setChildPos(child);
				if (child is FamilyContainer) {
					var num:int = (child as FamilyContainer).familyNumber;
					for (var j:int = 1; j < num; j++ ) {
						setChildPos((child as FamilyContainer).getNextChild(j));
					}
				}
			}
		}
		
		public function getChildPos(child:DisplayObject):Point {
			var p:Point = new Point();
			if (contains(child)) {
				var index:int = getChildIndex(child);
				p.y = Math.ceil(index / columns);
				p.x = index % columns;
			}
			trace('getChildPos', p);
			return p;
		}
		
		public function reset():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			_index = 0;
			_posX = 0;
			_posY = 0;
		}
	}
}