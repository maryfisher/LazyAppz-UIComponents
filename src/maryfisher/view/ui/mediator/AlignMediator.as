package maryfisher.view.ui.mediator {
	import flash.geom.Rectangle;
	import maryfisher.framework.util.ErrorUtil;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.data.AlignData;
	import maryfisher.view.ui.data.AlignIntData;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AlignMediator {
		
		/** TODO
		 * Dictionaries instead of Vectors, key is target:IDisplayObject, one vector for all of them to loop through
		 * update(target)
		 * AlignDatas hold both x and y info (so one data instead of two)
		 * 
		 * POSSIBLE??
		 * interface IAlignable - DisplayObject holds AlignData, uses static AlignMediator methods
		 */
		private var _alignDatasX:Vector.<AlignData>;
		private var _alignDatasY:Vector.<AlignData>;
		private var _alignInts:Vector.<AlignIntData>;
		private var _distX:int;
		private var _distY:int;
		private var _startY:int;
		private var _startX:int;
		private var _endX:int;
		private var _endY:int;
		//private var _lastTarget:IDisplayObject;
		
		public function AlignMediator(distX:int = 0, distY:int = 0, startX:int = 0, startY:int = 0) {
			_startY = startY;
			_startX = startX;
			_distY = distY;
			_distX = distX;
			_alignDatasX = new Vector.<AlignData>();
			_alignDatasY = new Vector.<AlignData>();
			_alignInts = new Vector.<AlignIntData>();
		}
		
		//public function getAlignData(target:IDisplayObject):AlignData {
			//for each (var data:AlignData in _alignDatas) {
				//if (target == data.target) {
					//return data;
				//}
			//}
			//
			//return null;
		//}
		
		private function sortAlignment(arg1:AlignData, arg2:AlignData):int {
			if (arg1.index > arg2.index) {
				return 1;
			}else if (arg1.index > arg2.index) {
				return -1;
			}
			
			return 0;
		}
		
		/** TODO
		 * static??
		 */
		private function alignTarget(data:AlignData, isX:Boolean):void {
			if (!data.nextTo) {
				if (isX) {
					data.target.x = _startX;
				}else{
					data.target.y = _startY;
				}
				updateDim(data.target);
				return;
			}
			if(isX){
				if(data.alignment == AlignData.NEXT_TO){
					data.target.x = data.nextTo.width + data.nextTo.x + data.dist;
				}else {
					data.target.x = data.nextTo.x;
				}
			}else{
				if(data.alignment == AlignData.NEXT_TO){
					data.target.y = data.nextTo.height + data.nextTo.y + data.dist;
				}else {
					data.target.y = data.nextTo.y;
				}
			}
			updateDim(data.target);
		}
		
		private function updateDim(target:IDisplayObject):void {
			_endX = Math.max(target.width + target.x, _endX);
			_endY = Math.max(target.height + target.y, _endY);
		}
		
		public function addAlignData(data:AlignData, isX:Boolean):void {
			if (isX) {
				_alignDatasX.push(data);
				alignTarget(data, true);
			}else {
				_alignDatasY.push(data);
				alignTarget(data, false);
			}
		}
		
		/** TODO
		 * isn't this ListMediator functionality??
		 */
		public function alignXLine(targetLine:Array, pos:int):void {
			ErrorUtil.notImplemented("AlignMediator", "alignXLine");
		}
		public function alignYLine(targetLine:Array, pos:int):void {
			ErrorUtil.notImplemented("AlignMediator", "alignYLine");
		}
		
		public function alignOnX(target:IDisplayObject, nextTo:IDisplayObject):void {
			addAlignmentX(target, AlignData.ON_LINE, nextTo);
		}
		
		public function alignOnY(target:IDisplayObject, nextTo:IDisplayObject):void {
			addAlignmentY(target, AlignData.ON_LINE, nextTo);
		}
		
		public function alignNextTo(target:IDisplayObject, nextTo:IDisplayObject, dist:int = 0):void {
			addAlignmentX(target, AlignData.NEXT_TO, nextTo, dist);
		}
		
		public function alignBelow(target:IDisplayObject, nextTo:IDisplayObject, dist:int = 0):void {
			addAlignmentY(target, AlignData.NEXT_TO, nextTo, dist);
		}
		
		public function alignStartX(target:IDisplayObject):void {
			addAlignmentX(target, "", null);
		}
		
		public function alignStartY(target:IDisplayObject):void {
			addAlignmentY(target, "", null);
		}
		
		public function addAlignmentX(target:IDisplayObject, alignmentX:String, nextToX:IDisplayObject, distX:int = 0):void {
			var data:AlignData = new AlignData(target, nextToX, alignmentX, _alignDatasX.length, distX);
			_alignDatasX.push(data);
			alignTarget(data, true);
		}
		
		public function addAlignmentY(target:IDisplayObject, alignmentY:String, nextToY:IDisplayObject, distY:int = 0):void {
			var data:AlignData = new AlignData(target, nextToY, alignmentY, _alignDatasY.length, distY);
			_alignDatasY.push(data);
			alignTarget(data, false);
		}
		
		public function addAlignChild(target:IDisplayObject, nextToX:IDisplayObject, nextToY:IDisplayObject, 
										alignmentX:String, alignmentY:String, distX:int = 0, distY:int = 0):void {
			
			addAlignmentX(target, alignmentX, nextToX, distX);
			addAlignmentY(target, alignmentY, nextToY, distY);
			
			//var data:AlignData = new AlignData(target, nextToX, nextToY, alignmentX, alignmentY, _alignDatas.length, distX, distY);
			//_alignDatas.push(data);
			//alignTarget(data);
		}
		
		public function getDimensions():Rectangle {
			return new Rectangle(_startX, _startY, _endX, _endY);
		}
		
		public function updateAlignments():void {
			_alignDatasX.sort(sortAlignment);
			_alignDatasY.sort(sortAlignment);
			for each (var data:AlignData in _alignDatasX) {
				alignTarget(data, true);
			}
			for each (data in _alignDatasY) {
				alignTarget(data, false);
			}
		}
		
		public function reset():void {
			_alignDatasX.length = 0;
			_alignDatasY.length = 0;
		}
		
		public function setDistances(distX:int, distY:int):void {
			_distY = distY;
			_distX = distX;
		}
		
		public function setStartPos(startX:int, startY:int):void {
			_startX = startX;
			_startY = startY;
		}
	}

}