package maryfisher.view.ui.mediator {
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import maryfisher.view.ui.interfaces.IDisplayObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ListMediator {
		
		private var _posX:int;
		private var _posY:int;
		private var _childWidth:int;
		private var _childHeight:int;
		private var _distX:int;
		private var _distY:int;
		private var _startY:int;
		private var _startX:int;
		
		private var _columns:int = 1;
		
		private var _tableDistances:Array;
		
		private var _index:int;
		private var _children:Vector.<IDisplayObject>;
		
		private var _isHorizontal:Boolean = true;
		private var _hasVariableDims:Boolean = false;
		private var _frontToBack:Boolean = true;
		private var _doTween:Boolean = false;
		private var _hasDynamicColumns:Boolean;
		private var _dynamicColumnWidth:int;
		
		public function ListMediator() {
			_children = new Vector.<IDisplayObject>();
		}
		
		/**
		 * 
		 * @param	startX
		 * @param	startY
		 */
		public function setStartPos(startX:int, startY:int):void {
			_startX = startX;
			_startY = startY;
			_posX = _startX;
			_posY = _startY;
		}
		
		/**
		 * dimensions of the to be listed children
		 * @param	width
		 * @param	height
		 */
		public function setDimensions(width:int, height:int):void {
			_childWidth = width;
			_childHeight = height;
		}
		
		/**
		 * 
		 * @param	columns
		 * @param	isVertical
		 */
		public function setColumns(columns:int, isVertical:Boolean = true):void {
			_isHorizontal = isVertical;
			_columns = columns;
		}
		
		/**
		 * for dimensions that vary with the index position
		 * @param	dist
		 */
		public function setTableDistances(dist:Array):void {
			_tableDistances = dist;
		}
		
		/**
		 * distance between the listed children
		 * @param	dX
		 * @param	dY
		 */
		public function setDistances(dX:int, dY:int):void {
			_distX = dX;
			_distY = dY;
		}
		
		/**
		 * variable dimensions takes children into account that have different dimensions
		 */
		public function set hasVariableDims(value:Boolean):void {
			_hasVariableDims = value;
		}
		
		/**
		 * later children are listed further down 
		 * (instead of putting them in the first position and recalculating positions of the other children)
		 */
		public function set frontToBack(value:Boolean):void {
			_frontToBack = value;
		}
		
		public function dynamicColumns(maxWidth:int):void {
			_hasDynamicColumns = true;
			_dynamicColumnWidth = maxWidth;
		}
		
		/**
		 * do a tween animation when adding a new child
		 */
		public function set doTween(value:Boolean):void {
			_doTween = value;
		}
		
		/**
		 * 
		 * @param 	child
		 */
		public function addListChild(child:IDisplayObject):void {
			if(_frontToBack){
				child && (_children.push(child));
				setChildPos(child);
			}else {
				child && (_children.unshift(child));
				updateChildPos();
			}
		}
		
		private function setChildPos(child:IDisplayObject):void {
			if(!_tableDistances) {
				if (_hasVariableDims) {
					_childWidth = child.width;
					_childHeight = child.height;
				}else{
					_childWidth = _childWidth || child.width;
					_childHeight = _childHeight || child.height;
				}
			}else {
				_childWidth = _tableDistances[_index % _columns];
				_childHeight = _childHeight || child.height;
			}
			
			//if (child) {
				if (_doTween) {
					TweenLite.to(child, 0.3, { x: _posX, y:_posY } );
				}else{
					child.x = _posX;
					child.y = _posY;
				}
			//}
			
			if (_isHorizontal) {
				_posX += _childWidth + _distX;
			}else {
				_posY += _childHeight + _distY;
			}
			_index++;
			
			if (_hasDynamicColumns) {
				if (_isHorizontal) {
					if (_posX >= _dynamicColumnWidth) {
						_posX = _startX;
						_posY += _childHeight + _distY;
					}
				}else {
					if (_posY >= _dynamicColumnWidth) {
						_posY = _startY;
						_posX += _childWidth + _distX;
					}
				}
			}else if (_columns != -1) {
				if (_index % _columns == 0) {
					if(_isHorizontal){
						_posX = _startX;
						_posY += _childHeight + _distY;
					}else {
						_posY = _startY;
						_posX += _childWidth + _distX;
					}
				}
			}
		}
		
		/**
		 * calculates positions for all children anew
		 */
		public function updateChildPos():void {
			_index = 0;
			_posX = _startX;
			_posY = _startY;
			for (var i:int; i < _children.length; i++ ) {
				setChildPos(_children[i]);
			}
		}
		
		/**
		 * for custom gaps
		 * @param	distX
		 * @param	distY
		 */
		public function addToChildPos(distX:int, distY:int):void {
			_posX += distX;
			_posY += distY;
		}
		
		/**
		 * 
		 * @param	child
		 * @return position of the child
		 */
		//public function getChildPos(child:IDisplayObject):Point {
			//var p:Point = new Point();
			//var index:int = _children.indexOf(child);
			//if (index) {
				//p.y = Math.ceil(index / _columns);
				//p.x = index % _columns;
			//}
			//return p;
		//}
		
		/**
		 * 
		 * @return position of the last child
		 */
		public function getLastChildPos():Point {
			//var p:Point = new Point();
			//var index:int = _children.length - 1;
			//if (index >= 0) {
				//p.y = Math.ceil(index / _columns);
				//p.x = index % _columns;
			//}
			//return p;
			var child:IDisplayObject = _children[_children.length - 1];
			return new Point(child.x, child.y);
		}
		
		/**
		 * 
		 * @return position of the next child
		 */
		public function getNextChildPos():Point {
			return new Point(_posX, _posY);
		}
		
		/**
		 * resets index / start positions, removes all children
		 */
		public function reset():void {
			_children = new Vector.<IDisplayObject>();
			_index = 0;
			_posX = _startX;
			_posY = _startY;
		}
		
		/**
		 * removes on ListChild and updates positions of all others so no gaps appear
		 * @param	child
		 */
		public function removeListChild(child:IDisplayObject):void {
			_children.splice(_children.indexOf(child), 1);
			updateChildPos();
		}
		
		/**
		 * 
		 * @return height
		 */
		public function get height():int {
			if (_index % _columns == 0) {
				return _posY;
			}
			return _posY + _childHeight + _distY;
		}
		
		/**
		 * @return width
		 */
		public function get width():int {
			return _posX;
		}
		
		/**
		 * @return children
		 */
		public function get children():Vector.<IDisplayObject> {
			return _children;
		}
		
		/**
		 * @return last child index
		 */
		public function get index():int {
			return _index;
		}
	}
}