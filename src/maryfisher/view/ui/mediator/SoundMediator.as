package maryfisher.view.ui.mediator {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
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
	public class SoundMediator implements ISound, ILoaderDataRequest {
		
		private var _loaderData:LoaderData;
		private var _channels:Vector.<SoundChannel>;
		private var _soundType:String;
		private var _soundTransform:SoundTransform;
		private var _sounds:Dictionary;
		private var _assetId:String;
		
		public function SoundMediator(soundType:String, assetId:String) {
			_sounds = new Dictionary();
			_channels = new Vector.<SoundChannel>();
			_assetId = assetId;
			_soundType = soundType;
			AssetController.registerForLoaderData(this);
			new SoundCommand(SoundCommand.GET_SOUNDTRANSFORM, _soundType, 0, this);
		}
		
		public function addSound(fileId:String, volume:Number = 1):void {
			var sound:Sound = new Sound();
			
			
			var req:URLRequest = new URLRequest(_loaderData.path + fileId + ".mp3");
			var context:SoundLoaderContext = new SoundLoaderContext(8000, true);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onError);
			sound.load(req, context);
			
			var channel:SoundChannel = sound.play();
			//TODO sound missing
			if (!channel) return;
			
			_channels.push(channel);
			_sounds[channel] = sound;
			channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			if (volume == 1) {
				channel.soundTransform = _soundTransform;
			} else {
				channel.soundTransform = new SoundTransform(_soundTransform.volume * volume);
			}
			//new SoundCommand(SoundCommand.REGISTER_CHANNEL, _soundType, 0, this);
		}
		
		/* INTERFACE maryfisher.framework.core.ILoaderDataRequest */
		
		public function get loaderDataId():String {
			return _assetId;
		}
		
		public function set loaderData(value:LoaderData):void {
			_loaderData = value;
		}
		
		private function onError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		public function stop():void {
			for each (var channel:SoundChannel in _channels) {
				channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				channel.stop();
			}
			_channels.length = 0;
			_sounds = new Dictionary();
		}
		
		public function destroy():void {
			stop();
		}
		
		/* INTERFACE maryfisher.framework.sound.ISound */
		
		public function play():void {
			for each (var channel:SoundChannel in _channels) {
				/** TODO
				 * resume from position
				 */
			}
		}
		
		public function pause():void {
			for each (var channel:SoundChannel in _channels) {
				var pos:Number = channel.position;
				/** TODO
				 * wegschreiben?
				 */
				channel.stop();
			}
		}
		
		public function set channelTransform(value:SoundTransform):void {
			for each (var channel:SoundChannel in _channels) {				
				channel.soundTransform = value;
			}
		}
		
		public function set soundTransform(value:SoundTransform):void {
			_soundTransform = value;
		}
		
		private function onSoundComplete(e:Event):void {
			var channel:SoundChannel = e.currentTarget as SoundChannel;
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_channels.splice(_channels.indexOf(channel), 1);
			delete _sounds[channel];
		}
	}

}