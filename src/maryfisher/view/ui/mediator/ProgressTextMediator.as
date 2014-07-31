package maryfisher.view.ui.mediator {
	import com.greensock.TweenMax;
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
		
		public function ProgressTextMediator(chunk:int = 1, speed:int = 1) {
			_chunk = chunk;
			_speed = speed;
			_updatesSignal = new Signal(int);
		}
		
		public function setText(text:FormatText, localeText:LocaleText, isHTML:Boolean = false):void {
			_isHTML = isHTML;
			_text = text;
			_localeText = localeText;
			_breaks = _localeText.getParams("pause") || new Vector.<LocaleTextParameter>();
			//trace("[ProgressTextMediator] setText breaks", _breaks, localeText.text);
			_currentBreak = null;
			_breakIndex = -1;
			getNextBreak();
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
			_isRunning = false;
			new StageCommand(StageCommand.UNREGISTER_TICK, this);
		}
		
		/* INTERFACE maryfisher.framework.view.ITickedObject */
		
		public function nextTick(interval:int):void {
			
			if(_currentTime % _speed == 0){
				_currentIndex += _chunk;
				_updatesSignal.dispatch(_currentIndex);
				
				if (_currentBreak && _currentIndex == _currentBreak.indexFormatted) {
					stop();
					//trace("[ProgressTextMediator] next call in", _currentBreak.content.@time);
					TweenMax.delayedCall(_currentBreak.content.@time, register);
					getNextBreak();
					return;
				}
				if (_isHTML) {
					_text.htmlText = _localeText.formattedText.substr(0, _currentIndex);
				}else {
					_text.text = _localeText.formattedText.substr(0, _currentIndex);
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
		
		/**
		 * 
		 * @param	value: Function.<int>
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
		
		public function set speed(value:int):void {
			_speed = value;
		}
		
	}

}