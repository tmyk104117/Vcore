package com.ablesky.vcore.video 
{
	import com.ablesky.asUi.display.SpriteUI;
	import com.ablesky.asUi.utils.Logger;
	import com.ablesky.vcore.events.BaseVideoEvent;
	import com.ablesky.vcore.interfaces.IPlayCore;
	import com.ablesky.vcore.model.vo.KeyInfo;
	import com.ablesky.vcore.model.vo.MetaData;
	import com.ablesky.vcore.model.vo.PlayListData;
	import com.ablesky.vcore.model.vo.PlayStatus;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import com.ablesky.vcore.net.httpstreaming.HTTPStreamingState;
	/**
	 * ...
	 * @author szhang
	 */
	public class BaseVideo extends SpriteUI implements IPlayCore 
	{
		protected var _video:Video ;
		protected var _vw:Number = 0 ;
		protected var _vh:Number = 0 ;
		protected var _nc:NetConnection ;
		protected var _ns:NetStream; 
		protected var currentNSVideoIsOver:Boolean = false ;
		/**
		 * _time用作派发数据更新数据
		 */
		protected var _timer:Timer;
		protected  var _metaObj:MetaData;
		protected var _vol:Number = 0;
		protected var _nstime:int = 0 ;
		protected var _nsBytsLoaded:uint = 0;
		protected var _nsBytesTotal:uint = 0 ;
		//当调用play的时候需要指定
		protected var _startKey:KeyInfo;
		protected var _endKey:KeyInfo;		
		protected var _loadedTime:int;
		protected var jumpT:int;	
		//解码状态
		protected var _state:String = HTTPStreamingState.INIT;
		protected var _prevState:String = null;		
		//播放状态
		protected var _status:int = PlayStatus.NOINIT;
		protected var _prevStatus:int = PlayStatus.NOINIT;		
		public function BaseVideo() 
		{
			init();
			addEvents();
		}
		
		public function init():void
		{
			createNetStream();
		}
		
		protected function createNetStream():void
		{
			_nc = new NetConnection();
			_nc.connect(null);
			_ns = new NetStream(_nc);
			_metaObj = new MetaData();
			_ns.client = _metaObj;
			_video = new Video();
			_video.smoothing = true ;
			_video.attachNetStream(_ns);
			addChild(_video);
			_video.visible = true ;
		}

		protected function setState(value:String):void
		{
			_prevState = _state;
			_state = value;
		}
		
		protected function setStatus(value:int):void
		{
			_prevStatus = _status;
			_status = value;
		}
		
		protected function onSecurity(e:SecurityErrorEvent):void
		{
		}
		
		protected function onIOError(e:IOErrorEvent):void
		{
			
		}
		
		protected function onHttpStatus(e:HTTPStatusEvent):void
		{

		}
		
		protected function addEvents():void
		{
			_metaObj.addEventListener(BaseVideoEvent.GOT_METADATA, onGotMetaData);
		}
		
		protected function onGotMetaData(e:BaseVideoEvent):void
		{
			trace("9999999999999999999999999");
		}
		
		protected function onComplete(e:Event):void
		{
		
		}
		
		protected function onProgress(e:ProgressEvent):void
		{

		}
		
		protected function onNetStatus(e:NetStatusEvent):void
		{
			
		}
		
		protected function createVideoList():void
		{
			
		}
		
		public function seek(time:int):void
		{
			
		}
		
		public function play(url:String,startKey:KeyInfo,endKey:KeyInfo=null):void
		{
			_startKey = startKey;
			_endKey = endKey ;
			setState(HTTPStreamingState.INIT);	
		}
		
		public function pause():void
		{
			_ns.pause();
			setStatus(PlayStatus.PAUSED);
		}
		
		public function resume():void
		{
			_ns.resume();
			setStatus(PlayStatus.PLAYING);
		}
		
		public function close():void
		{
			
		}
		
		public function loadNextVideo():void
		{
			
		}
		
		public function createPlayList():void
		{
			
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			_video.width = value;
		}
		
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			_video.height = value;
		}
		
		public function get metaObj():MetaData 
		{
			return _metaObj;
		}
		
		public function get vol():Number 
		{
			return _vol;
		}
		
		public function set vol(value:Number):void 
		{
			_vol = value;
			var soundTF:SoundTransform = _ns.soundTransform;
			soundTF.volume = value;
			_ns.soundTransform = soundTF;
		}
		
		

		
		public function get nsBytsLoaded():uint 
		{
			return _nsBytsLoaded;
		}
		
		public function set nsBytsLoaded(value:uint):void 
		{
			_nsBytsLoaded = value;
		}
		
		public function get nsBytesTotal():uint 
		{
			return _nsBytesTotal;
		}
		
		public function set nsBytesTotal(value:uint):void 
		{
			_nsBytesTotal = value;
		}
		
		public function get ns():NetStream 
		{
			return _ns;
		}
		
		public function get startKey():KeyInfo 
		{
			return _startKey;
		}
		
		public function set startKey(value:KeyInfo):void 
		{
			_startKey = value;
		}
		
		public function get endKey():KeyInfo 
		{
			return _endKey;
		}
		
		public function set endKey(value:KeyInfo):void 
		{
			_endKey = value;
		}
		
		public function get loadedTime():int 
		{
			return _loadedTime;
		}
		
		public function get nstime():int 
		{
			return _nstime;
		}
		
		public function get status():int 
		{
			return _status;
		}
		
		public function get prevStatus():int 
		{
			return _prevStatus;
		}
		

		
	}

}