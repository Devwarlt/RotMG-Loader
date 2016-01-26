package
{
    import flash.display.Sprite;
    import flash.display.Loader;
    import flash.display.Bitmap;
    import flash.system.Security;
    import flash.net.LocalConnection;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import flash.net.URLVariables;
    import flash.events.ProgressEvent;
    import flash.events.Event;

    [SWF(backgroundColor="#000000", width="800", height="600", frameRate="60")]
    public class RotMGLoader extends Sprite 
    {

        private static const BAR_WIDTH:int = 200;
        private static const BAR_HEIGHT:int = 20;
        private static const SQUARE_WIDTH:int = 4;
        private static const SQUARE_HEIGHT:int = 4;

        public static var textEmbed_:Class = RotMGLoader_textEmbed_;

        private var loader_:Loader;
        private var progressBar_:ProgressBar;
        private var title_:Bitmap;

        public function RotMGLoader()
        {
            //Security.allowDomain("*");
            this.progressBar_ = new ProgressBar(BAR_WIDTH, BAR_HEIGHT, SQUARE_WIDTH, SQUARE_HEIGHT);
            this.progressBar_.x = ((stage.stageWidth / 2) - (BAR_WIDTH / 2));
            this.progressBar_.y = ((stage.stageHeight / 2) - (BAR_HEIGHT / 2));
            addChild(this.progressBar_);
            this.title_ = new textEmbed_();
            this.title_.x = ((stage.stageWidth / 2) - (this.title_.width / 2));
            this.title_.y = ((this.progressBar_.y - this.title_.height) - 4);
            addChild(this.title_);
            var _local1 = "http://rotmgtesting.appspot.com/AssembleeGameClient.swf";
            var _local2:LocalConnection = new LocalConnection();
            if (_local2.domain == "www.realmofthemadgod.com")
            {
                _local1 = "http://www.realmofthemadgod.com/AssembleeGameClient.swf";
            };
            var _local3:URLRequest = new URLRequest(_local1);
            var _local4:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
            _local3.requestHeaders.push(_local4);
            _local3.data = new URLVariables(("time=" + Number(new Date().getTime())));
            this.loader_ = new Loader();
            this.loader_.load(_local3);
            this.loader_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress, false, 0, true);
            this.loader_.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete, false, 0, true);
            addChild(this.loader_);
        }
        private function onProgress(_arg1:ProgressEvent):void
        {
            var _local2:Number = (((_arg1.bytesTotal == 0)) ? (1 << 20) : _arg1.bytesTotal);
            var _local3:Number = (_arg1.bytesLoaded / _local2);
            if (_local3 > 1)
            {
                _local3 = 1;
            };
            this.progressBar_.update(_local3);
        }
        private function onComplete(_arg1:Event):void
        {
            removeChild(this.progressBar_);
            removeChild(this.title_);
            var _local2:Sprite = Sprite(this.loader_.content);
            addChild(_local2);
            this.loader_.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this.loader_.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
            this.loader_ = null;
        }

    }
}//package 

import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Graphics;

class ProgressBar extends Sprite 
{

    public var width_:int;
    public var height_:int;
    public var squareWidth_:int;
    public var squareHeight_:int;
    private var squares_:Vector.<Square>;
    private var bar_:Shape;
    private var frame_:Shape;

    public function ProgressBar(_arg1:int, _arg2:int, _arg3:int, _arg4:int):void
    {
        var _local8:int;
        var _local9:int;
        this.squares_ = new Vector.<Square>();
        super();
        this.width_ = _arg1;
        this.height_ = _arg2;
        this.squareWidth_ = _arg3;
        this.squareHeight_ = _arg4;
        var _local5:Vector.<int> = new Vector.<int>();
        var _local6:int;
        while (_local6 < _arg2)
        {
            _local5.push(_local6);
            _local6 = (_local6 + this.squareHeight_);
        };
        var _local7:int;
        while (_local7 < _arg1)
        {
            _local5 = Vector.<int>(shuffle(_local5));
            _local8 = 0;
            while (_local8 < _local5.length)
            {
                _local9 = _local5[_local8];
                this.squares_.push(new Square(_local7, _local9));
                _local8++;
            };
            _local7 = (_local7 + this.squareWidth_);
        };
        this.bar_ = new Shape();
        addChild(this.bar_);
        this.frame_ = new Shape();
        addChild(this.frame_);
        this.update(0);
    }
    public static function shuffle(_arg1:Object):Vector.<Object>
    {
        var _local4:Object;
        var _local5:int;
        var _local2:Vector.<Object> = Vector.<Object>(_arg1);
        var _local3:int;
        while (_local3 < _local2.length)
        {
            _local4 = _local2[_local3];
            _local5 = int((Math.random() * _local2.length));
            _local2[_local3] = _local2[_local5];
            _local2[_local5] = _local4;
            _local3++;
        };
        return (_local2);
    }

    public function update(_arg1:Number):void
    {
        var _local5:Square;
        var _local2:Graphics = this.frame_.graphics;
        _local2.clear();
        _local2.beginFill(0x616161, 1);
        _local2.drawRect(0, -4, this.width_, 4);
        _local2.drawRect(-4, 0, 4, this.height_);
        _local2.drawRect(0, this.height_, this.width_, 4);
        _local2.drawRect(this.width_, 0, 4, this.height_);
        _local2.endFill();
        _local2 = this.bar_.graphics;
        _local2.clear();
        var _local3:int = int((_arg1 * this.squares_.length));
        var _local4:int;
        while (_local4 < _local3)
        {
            _local5 = this.squares_[_local4];
            _local2.beginFill(0xFF0000);
            _local2.drawRect(_local5.destX_, _local5.destY_, this.squareWidth_, this.squareHeight_);
            _local2.endFill();
            _local4++;
        };
    }

}
class Square 
{

    public var destX_:int;
    public var destY_:int;

    public function Square(_arg1:int, _arg2:int)
    {
        this.destX_ = _arg1;
        this.destY_ = _arg2;
    }
}

