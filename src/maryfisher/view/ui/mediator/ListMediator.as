package maryfisher.view.ui.mediator {
	import flash.geom.Point;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ListMediator {
		
		private var _posX:int;
		private var _posY:int;
		private var _index:int;
		private var _childWidth:int;
		private var _childHeight:int;
		private var distX:int;
		private var distY:int;
		private var columns:int = 1;
		//private var _initiated:Boolean;
		private var _isHorizontal:Boolean = true;
		private var _children:Vector.<IDisplayObject>;
		private var _startY:int;
		private var _startX:int;
		private var _hasVariableDims:Boolean = false;
		
		public function ListMediator() {
			//_initiated = false;
			_children = new Vector.<IDisplayObject>();
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
		
		public function setDistances(dX:int, dY:int):void {
			distX = dX;
			distY = dY;
		}
		
		public function addListChild(child:IDisplayObject):void {
			child && (_children.push(child));
			setChildPos(child);
		}
		
		private function setChildPos(child:IDisplayObject):void {
			if (_hasVariableDims) {
				_childWidth = child.width;
				_childHeight = child.height;
			}else{
				_childWidth = _childWidth || child.width;
				_childHeight = _childHeight || child.height;
			}
			
			if(child){
				child.x = _posX;
				child.y = _posY;
			}
			
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
		
		public function getChildPos(child:IDisplayObject):Point {
			var p:Point = new Point();
			var index:int = _children.indexOf(child);
			if (index) {
				p.y = Math.ceil(index / columns);
				p.x = index % columns;
			}
			return p;
		}
		
		public function getLastChildPos():Point {
			var p:Point = new Point();
			var index:int = _children.length - 1;
			if (index >= 0) {
				p.y = Math.ceil(index / columns);
				p.x = index % columns;
			}
			return p;
		}
		
		public function getNextChildPos():Point {
			return new Point(_posX, _posY);
		}
		
		/**
		 * resets index, start positions, removes all children
		 */
		public function reset():void {
			_children = new Vector.<IDisplayObject>();
			_index = 0;
			_posX = _startX;
			_posY = _startY;
		}
		
		public function removeListChild(child:IDisplayObject):void {
			_children.splice(_children.indexOf(child), 1);
			updateChildPos();
		}
		
		public function invalidate():void {
			_index = 0;
			_posX = _startX;
			_posY = _startY;
			var l:int = _children.length;
			for (var i:int = 0; i < l; i++) {
				setChildPos(_children[i]);
			}
		}
		
		public function getHeight():int {
			if (_index % columns == 0) {
				return _posY;
			}
			return _posY + _childHeight + distY;
		}
		
		public function getWidht():int {
			return _posX;
		}
		
		public function set hasVariableDims(value:Boolean):void {
			_hasVariableDims = value;
		}
		
		public function get children():Vector.<IDisplayObject> {
			return _children;
		}
	}
}