package maryfisher.view.ui.mediator {
	import adobe.utils.CustomActions;
	import com.greensock.TweenMax;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.view.StageCommand;
	import maryfisher.framework.data.LocaleText;
	import maryfisher.framework.data.LocaleTextParameter;
	import maryfisher.framework.view.ITickedObject;
	import maryfisher.view.ui.component.FormatText;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class ProgressTextMediator implements ITickedObject {
		
		private var _currentIndex:int;
		private var _localeText:LocaleText;
		private var _text:FormatText;
		private var _onFinishedListener:Function;
		private var _updatesSignal:Signal;
		private var _isRunning:Boolean;
		private var _isHTML:Boolean;
		private var _breaks:Vector.<LocaleTextParameter>;
		private var _breakIndex:int = -1;
		private var _currentBreak:LocaleTextParameter;
		private var _chunk:int = 1;
		private var _speed:int = 1;
		private var _currentTime:int;
		private var _skip:Boolean;
		private var _speedIndex:int = -1;
		private var _speeds:Vector.<LocaleTextParameter>;
		private var _currentSpeed:LocaleTextParameter;
		private var _params:Dictionary;
		private var _paramIndex:Dictionary;
		private var _currentParam:Dictionary;
		private var _activeParams:Vector.<String>;
		
		public function ProgressTextMediator(chunk:int = 1, speed:int = 1) {
			_chunk = chunk;
			_speed = speed;
			_updatesSignal = new Signal(LocaleTextParameter);
			_params = new Dictionary();
			_paramIndex = new Dictionary();
			_currentParam = new Dictionary();
			_activeParams = new Vector.<String>();
		}
		
		public function setText(text:FormatText, localeText:LocaleText, isHTML:Boolean = false):void {
			_isHTML = isHTML;
			_text = text;
			_localeText = localeText;
			_breaks = _localeText.getParams("pause") || new Vector.<LocaleTextParameter>();
			_speeds = _localeText.getParams("speed") || new Vector.<LocaleTextParameter>();
			//trace("[ProgressTextMediator] setText breaks", _breaks, localeText.text);
			_currentBreak = null;
			_breakIndex = -1;
			_speedIndex = -1;
			getNextBreak();
			getNextSpeed();
			if(_currentSpeed){
				setSpeed();
			}
			
			for each (var id:String in _activeParams) {
				_params[id] = _localeText.getParams(id) || new Vector.<LocaleTextParameter>();
				_paramIndex[id] = -1;
				_currentParam[id] = null;
				getNextParam(id);
			}
		}
		
		public function activateParam(id:String):void {
			_activeParams.push(id);
		}
		
		public function deactivateParam(id:String):void {
			var index:int = _activeParams.indexOf(id);
			if (index == -1) return;
			_activeParams.splice(index, 1);
		}
		
		private function getNextParam(id:String):void {
			_paramIndex[id]++;
			var index:int = _paramIndex[id];
			if (index >= _params[id].length) {
				_currentParam[id] = null;
				return;
			}
			_currentParam[id] = _params[id][index];
		}
		
		private function getNextSpeed():void {
			_speedIndex++;
			if (_speedIndex >= _speeds.length) {
				_currentSpeed = null;
				return;
			}
			_currentSpeed = _speeds[_speedIndex];
		}
		
		private function getNextBreak():void {
			_breakIndex++;
			if (_breakIndex >= _breaks.length) {
				_currentBreak = null;
				return;
			}
			_currentBreak = _breaks[_breakIndex];
		}
		
		public function start():void {
			if (_isRunning) return;
			_currentIndex = -1;
			_currentTime = 0;
			register();
		}
		
		public function stop():void {
			if (!_isRunning) return;
			TweenMax.killDelayedCallsTo(register);
			_isRunning = false;
			new StageCommand(StageCommand.UNREGISTER_TICK, this);
		}
		
		/* INTERFACE maryfisher.framework.view.ITickedObject */
		
		public function nextTick(interval:int):void {
			
			if (_currentTime % _speed == 0) {
				if (_skip) {
					_currentIndex = _localeText.formattedText.length;
				}else {
					if (_chunk == -1) {
						if(_currentBreak){
							_currentIndex = _currentBreak.indexFormatted;
						}else {
							_currentIndex = _localeText.formattedText.length;
						}
					} else {
						_currentIndex += _chunk;
					}
				}
				
				//_updatesSignal.dispatch(_currentIndex);
				
				if (_isHTML) {
					_text.htmlText = _localeText.formattedText.substr(0, _currentIndex);
				}else {
					_text.text = _localeText.formattedText.substr(0, _currentIndex);
				}
				
				if (_currentSpeed && _currentIndex == _currentSpeed.indexFormatted) {
					setSpeed();
				}
				
				for each (var id:String in _activeParams) {
					if (_currentParam[id] && _currentIndex == _currentParam[id].indexFormatted) {
						_updatesSignal.dispatch(_currentParam[id]);
					}
				}
				
				if (_currentBreak && _currentIndex == _currentBreak.indexFormatted) {
					stop();
					TweenMax.delayedCall(parseFloat(_currentBreak.getAttribute("time")), register);
					getNextBreak();
					return;
				}
				
				if (_currentIndex >= _localeText.formattedText.length) {
					stop();
					_onFinishedListener && _onFinishedListener();
				}
			}
			_currentTime++;
		}
		
		private function register():void {
			_isRunning = true;
			new StageCommand(StageCommand.REGISTER_TICK, this);
		}
		
		private function setSpeed():void {
			_speed = parseInt(_currentSpeed.getAttribute("val"));
			getNextSpeed();
		}
		
		/**
		 * 
		 * @param	value: Function.<LocaleTextParameter>
		 */
		public function addUpdatesListener(value:Function):void {
			_updatesSignal.add(value);
		}
		
		public function set onFinishedListener(value:Function):void {
			_onFinishedListener = value;
		}
		
		public function set chunk(value:int):void {
			_chunk = value;
		}
		
		public function set speed(value:Number):void {
			_speed = value;
		}
		
		public function set skip(value:Boolean):void {
			_skip = value;
		}
		
		public function get isRunning():Boolean {
			return _isRunning;
		}
		
	}

}