package maryfisher.view.ui.mediator {
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import maryfisher.framework.core.AssetController;
	import maryfisher.framework.data.LoaderData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class VideoMediator {
		
		private var _video:Video;
		private var _stream:NetStream;
		private var _bufferTime:int;
		private var _activeUrl:String;
		private var _loaderData:LoaderData;
		private var _onFinishedListener:Function;
		protected var _netConnection:NetConnection;
		protected var _isLoaded:Boolean;
		protected var _isPlaying:Boolean;
		
		public function VideoMediator() {
			_netConnection = new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatus, false, 0, true);
			_netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError, false, 0, true);
			_netConnection.connect(null);
		}
		
		public function init(width:int, height:int, id:String, fileId:String, bufferTime:Number = 8 ): void {
			
			_bufferTime = bufferTime;
			
			_video = new Video (width, height);
			
			//_activeUrl = url;
			_loaderData = AssetController.getLoaderData(id);
			_activeUrl = _loaderData.path + fileId + ".f4v";
			_stream = new NetStream(_netConnection);
			_stream.bufferTime = _bufferTime;
			/** TODO
			 * ???
			 */
			_stream.client={onMetaData:function(obj:Object):void{} }
			/** TODO
			 * _stream.soundTransform
			 */
			_stream.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
			_stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError);
			
			_video.attachNetStream(_stream);
		}
		
		public function addOnFinished(list:Function):void {
			_onFinishedListener = list;
		}
		
		public function playVideo() : void {
			
			if (!_isLoaded) {
				_stream.play(_activeUrl);
				_isLoaded = true;
			} else {
				_stream.resume();
			}
			_isPlaying = true;
		}
		
		public function pauseVideo():void {
			_stream.pause();
			_isPlaying = false;
		}
		
		public function stopVideo() : void {
			_stream.pause();
			_stream.seek(0);
			
			_isPlaying = false;
			_onFinishedListener && _onFinishedListener();
		}
		
		public function reset():void {
			
			_isLoaded = false;
			_isPlaying = false;
			if (_video != null) {
				_video.clear();
				_stream.close();
				_stream.dispose();
				
				_stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatus, false);
				_stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError, false);
				
				_stream = null;
				_video = null;
			}
		}
		
		protected function netStatus(e:NetStatusEvent):void {
			trace("[VideoMediator] NetStatusEvent", e.info.code);
			switch (e.info.code) {
				case "NetStream.Play.StreamNotFound" :
					trace("[VideoMediator] Unable to locate video:", _activeUrl);
					break;
				case "NetStream.Play.Start" :
					//start des buffer ladens -> Ladebalken
					break;
				case "NetStream.Buffer.Full" :
					//ladebalken kann weg
					break;
				case "NetStream.Play.Stop" :
					stopVideo();
					break;
			}
		}

		protected function securityError(e:SecurityErrorEvent):void {
			trace("[VideoMediator] SecurityErrorEvent: ", e);
		}
		
		protected function asyncError(e:AsyncErrorEvent):void {
			//IGNORE ASYNCHRONOUS ERRORS
		}
		
		public function get video():Video {
			return _video;
		}
	}

}