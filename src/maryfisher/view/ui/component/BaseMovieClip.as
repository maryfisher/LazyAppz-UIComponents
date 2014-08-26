package maryfisher.view.ui.component {
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import maryfisher.framework.command.view.StageCommand;
	import maryfisher.framework.view.IMovieClip;
	import maryfisher.framework.view.ITickedObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseMovieClip extends BaseSprite implements ITickedObject, IMovieClip{
		static public const DEFAULT_FRAME:String = "defaultFrame";
		
		private var _currentFrame:int = -1;
		private var _loop:Boolean;
		private var _framesById:Dictionary;
		//private var _idleFrames:Vector.<Vector.<Bitmap>>;
		private var _idleFrames:Vector.<Vector.<int>>;
		//private var _currentFrames:Vector.<Bitmap>;
		private var _currentFrames:Vector.<int>;
		private var _currentBitmap:Bitmap;
		private var _isPlaying:Boolean;
		private var _onClipFinished:Function;
		private var _frameId:String;
		private var _idle:Boolean;
		private var _allFrames:Vector.<Bitmap>;
		
		public function BaseMovieClip(arr:Array) {
			_allFrames = Vector.<Bitmap>(arr);
			//_idleFrames = new Vector.<Vector.<Bitmap>>();
			_idleFrames = new Vector.<Vector.<int>>();
			_framesById = new Dictionary();
		}
		
		protected function addFrames(arr:Array, frameId:String = DEFAULT_FRAME):void {
			//_framesById[frameId] = Vector.<Bitmap>(arr);
			_framesById[frameId] = Vector.<int>(arr);
		}
		
		protected function addIdleFrames(arr:Array):void {
			//_idleFrames.push(Vector.<Bitmap>(arr));
			_idleFrames.push(Vector.<int>(arr));
		}
		
		public function play(frameId:String = null, loop:Boolean = false):void {
			_loop = loop;
			_frameId = frameId || DEFAULT_FRAME;
			_isPlaying = true;
			_currentFrames = _framesById[_frameId];
			trace("[BaseMovieClip] play register Tick");
			nextTick(0);
			new StageCommand(StageCommand.REGISTER_TICK, this);
		}
		
		public function stop():void {
			if (_isPlaying) {
				//trace("[BaseMovieClip] stop");
				_isPlaying = false;
				new StageCommand(StageCommand.UNREGISTER_TICK, this);
			}
		}
		
		public function nextTick(interval:int):void {
			_currentFrame++;
			//trace("[BaseMovieClip] currentFrame", _currentFrame, "loop", _loop, "isPlaying", _isPlaying);
			if (_currentFrame == _currentFrames.length) {
				//_currentFrame = 0;
				_currentFrame = -1;
				if (!_loop) {
					stop();
					if (!_idle) {
						if (_onClipFinished != null) {
							_onClipFinished(this);
						}
						//return;
					}else {
						/** TODO
						 * IdleData
						 */
						TweenMax.delayedCall(4, setIdleFrames);
					}
					return;
				}
			}
			var newBitmap:Bitmap = _allFrames[_currentFrames[_currentFrame]];
			if (newBitmap == _currentBitmap) return;
			if (_currentBitmap) removeChild(_currentBitmap);
			_currentBitmap = newBitmap;
			addChild(_currentBitmap);
		}
		
		/* INTERFACE maryfisher.view.ui.interfaces.IMovieClip */
		/**
		 * 
		 * @param	onClipFinished Function.<IMovieClip>
		 */
		public function addOnFinished(onClipFinished:Function):void {
			_onClipFinished = onClipFinished;
			
		}
		
		public function set idle(value:Boolean):void {
			if (_idle == value) return;
			_idle = value;
			if (_idle) {
				setIdleFrames();
				//startIdling();
			}else {
				/** TODO
				 * zurück zu default?
				 */
				stop();
			}
		}
		
		//private function startIdling():void {
			//_loop = false;
			//_isPlaying = true;
			//new StageCommand(StageCommand.REGISTER_TICK, this);
		//}
		
		private function setIdleFrames():void {
			_currentFrames = _idleFrames[int(Math.random() * _idleFrames.length)];
			_loop = false;
			_isPlaying = true;
			//trace("[BaseMovieClip] setIdleFrames register Tick");
			new StageCommand(StageCommand.REGISTER_TICK, this);
		}
	}

}