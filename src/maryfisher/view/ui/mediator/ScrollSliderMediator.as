package maryfisher.view.ui.mediator {
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import maryfisher.framework.command.view.StageCommand;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.framework.view.ITickedObject;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ScrollSliderMediator extends SliderMediator implements ITickedObject {
		
		private var _isScrolling:Boolean;
		private var _direction:int;
		private var _speed:int;
		private var _maxSpeed:int;
		private var _contentMax:int;
		private var _contentMin:int;
		private var _content:IDisplayObject;
		
		public function ScrollSliderMediator(maxSpeed:int, doTween:Boolean=true) {
			super(doTween);
			_maxSpeed = maxSpeed;
		}
		
		public function assignContent(content:IDisplayObject, scrollWidth:int, scrollHeight:int):void {
			_content = content;
			_content.clipRect = new Rectangle(_content.x, _content.y, scrollWidth, scrollHeight);
			
			_contentMax = !_isVertical ? _content.x : _content.y;
			updateContent();
		}
		
		/* INTERFACE maryfisher.framework.view.ITickedObject */
		
		public function nextTick(interval:int):void {
			if (_speed < _maxSpeed) {
				_speed++;
			}
			var currentPos:int = _isVertical ? _content.y : _content.x;
			if ((_direction < 0 && currentPos == _contentMin) || (_direction > 0 && currentPos == _contentMax)) {
				stopScrolling();
				return;
			}
			
			var end:int = currentPos + _direction * _speed;
			if (_direction < 0) {
				end = Math.max(_contentMin, end);
			}else {
				end = Math.min(_contentMax, end);
			}
			if (_isVertical) {
				_content.y = end;
			}else {
				_content.x = end;
			}
		}
		
		public function updateContent():void {
			_contentMin = _contentMax - (!_isVertical ? _content.width : _content.height);
		}
		
		override protected function onComplete():void {
			if (_isScrolling) {
				if (_currentPos != _maxPos || _currentPos != _minPos) {
					stopScrolling();
				}
				return;
			}
			if (_currentPos != _maxPos && _currentPos != _minPos) return;
			
			_direction = _currentPos == _maxPos ? -1 : 1;
			_isScrolling = true;
			new StageCommand(StageCommand.REGISTER_TICK, this);
		}
		
		private function stopScrolling():void {
			new StageCommand(StageCommand.UNREGISTER_TICK, this);
			_isScrolling = false;
			_speed = 0;
		}
		
		CONFIG::touch
		override protected function onTouchEnd(e:TouchEvent):void { 
			super.onTouchEnd();
			if (!_isScrolling) return;
			stopScrolling();
		}
		CONFIG::mouse
		override protected function onMouseDown(ev:MouseEvent):void {
			super.onMouseDown(ev);
			if (!_isScrolling) return;
			stopScrolling();
		}
		
		public function set maxSpeed(value:int):void {
			_maxSpeed = value;
		}
		
	}

}