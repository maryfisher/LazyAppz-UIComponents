package maryfisher.view.ui.mediator {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import maryfisher.framework.command.sound.SoundCommand;
	import maryfisher.framework.command.view.StageCommand;
	import maryfisher.framework.core.AssetController;
	import maryfisher.framework.core.ILoaderDataRequest;
	import maryfisher.framework.data.LoaderData;
	import maryfisher.framework.sound.ISound;
	import maryfisher.framework.view.ITickedObject;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class MusicMediator implements ISound, ITickedObject, ILoaderDataRequest {
		
		private var _loaderData:LoaderData;
		private var _channel:SoundChannel;
		private var _onFinishedListener:Function;
		private var _soundType:String;
		private var _soundTransform:SoundTransform;
		private var _sound:Sound;
		private var _fileIds:Vector.<String>;
		private var _fileIndex:int;
		private var _doLoop:Boolean;
		private var _fadeIn:Boolean;
		private var _fadeOut:Boolean;
		private var _interval:int = 0;
		private var _assetId:String;
		
		public function MusicMediator() {
			
		}
		
		public function init(assetId:String, fileIds:Vector.<String>, soundId:String, doLoop:Boolean = false):void {
			_assetId = assetId;
			_doLoop = doLoop;
			_fileIds = fileIds;
			_fileIndex = 0;
			
			_soundType = soundId;
			
			AssetController.registerForLoaderData(this);
		}
		
		/* INTERFACE maryfisher.framework.core.ILoaderDataRequest */
		
		public function get loaderDataId():String {
			return _assetId;
		}
		
		public function set loaderData(value:LoaderData):void {
			_loaderData = value;
		}
		
		public function start():void {
			loadFile(!_doLoop ? _fileIds.pop() : _fileIds[_fileIndex]);
		}
		
		private function loadFile(fileId:String):void {
			closeSound();
			
			_sound = new Sound();
			
			var req:URLRequest = new URLRequest(_loaderData.path + fileId + ".mp3");
			var context:SoundLoaderContext = new SoundLoaderContext(8000, true);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_sound.load(req, context);
			//SoundController.registerSound(this);
			
			play();
		}
		
		private function onError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		/* INTERFACE maryfisher.framework.sound.ISound */
		
		public function play():void {
			_channel = _sound.play();
			if (_fadeIn) {
				_channel.soundTransform = new SoundTransform(0);
				//new SoundCommand(SoundCommand.GET_SOUNDTRANSFORM, _soundType, 0, null, this);
				new SoundCommand(SoundCommand.GET_SOUNDTRANSFORM, _soundType, 0, this);
			} else {
				//new SoundCommand(SoundCommand.REGISTER_CHANNEL, _soundType, 0, _channel);
				new SoundCommand(SoundCommand.REGISTER_CHANNEL, _soundType, 0, this);
			}
			_channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function closeSound():void {
			if (_sound) {
				if (_sound.bytesLoaded != _sound.bytesTotal) {
					_sound.close();
				}
			}
		}
		
		public function stop():void {
			closeSound();
			_channel && _channel.stop();
		}
		
		public function next():void {
			_fileIndex++;
			if (_fileIndex == _fileIds.length)
				_fileIndex = 0;
			loadFile(_fileIds[_fileIndex]);
		}
		
		public function prev():void {
			_fileIndex--;
			if (_fileIndex < 0)
				_fileIndex = _fileIds.length - 1;
			loadFile(_fileIds[_fileIndex]);
		}
		
		/* INTERFACE maryfisher.framework.view.ITickedObject */
		
		public function nextTick(interval:int):void {
			if (!_channel) {
				new StageCommand(StageCommand.UNREGISTER_TICK, this);
				return;
			}
			
			/** NOTE
			 * what a strange f***ing bug
			 * dont remove this stupid looking code
			 * _channel.soundTransform.volume += 0.01 wont work!!!!
			 */
			if (_interval % 10 == 0) {
				var s:SoundTransform = _channel.soundTransform;
				s.volume += 0.01;
				_channel.soundTransform = s;
				if (_channel.soundTransform.volume >= _soundTransform.volume) {
					new StageCommand(StageCommand.UNREGISTER_TICK, this);
					//new SoundCommand(SoundCommand.REGISTER_CHANNEL, _soundType, 0, _channel);
					new SoundCommand(SoundCommand.REGISTER_CHANNEL, _soundType, 0, this);
					if (_doLoop) {
						_fadeIn = false;
					}
				}
			}
			_interval++;
		}
		
		public function destroy():void {
			if (_channel) {
				_fileIds.length = 0;
				_doLoop = false;
				stop();
			}
		}
		
		public function set channelTransform(value:SoundTransform):void {
			//_channel && (_channel.soundTransform = _soundTransform);
			_channel && (_channel.soundTransform = value);
		}
		
		public function set soundTransform(value:SoundTransform):void {
			_soundTransform = value;
			_interval = 0;
			new StageCommand(StageCommand.REGISTER_TICK, this);
		}
		
		public function set fadeIn(value:Boolean):void {
			_fadeIn = value;
		}
		
		public function set fadeOut(value:Boolean):void {
			_fadeOut = value;
		}
		
		private function onSoundComplete(e:Event):void {
			_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			//new SoundCommand(SoundCommand.UNREGISTER_CHANNEL, _soundType, 0, _channel);
			new SoundCommand(SoundCommand.UNREGISTER_CHANNEL, _soundType, 0, this);
			_channel = null;
			if (_doLoop) {
				next();
				_onFinishedListener && _onFinishedListener();
				return;
			}
			
			if (_fileIds.length > 0) {
				loadFile(_fileIds.pop());
				return;
			}
			_onFinishedListener && _onFinishedListener();
		}
		
		public function set onFinishedListener(value:Function):void {
			_onFinishedListener = value;
		}
		
		public function get fileIndex():int {
			return _fileIndex;
		}
		
		public function set fileIndex(value:int):void {
			if (_channel) {
				_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				//new SoundCommand(SoundCommand.UNREGISTER_CHANNEL, _soundType, 0, _channel);
				new SoundCommand(SoundCommand.UNREGISTER_CHANNEL, _soundType, 0, this);
				_channel.stop();
				_channel = null;
			}
			_fileIndex = value;
			_onFinishedListener && _onFinishedListener();
			loadFile(_fileIds[_fileIndex]);
		}
	}

}