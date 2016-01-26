package mx.core
{
    import flash.display.Bitmap;
    import mx.utils.NameUtil;
    import flash.display.BitmapData;

    public class FlexBitmap extends Bitmap 
    {

        mx_internal static const VERSION:String = "4.0.0.14159";

        public function FlexBitmap(_arg1:BitmapData=null, _arg2:String="auto", _arg3:Boolean=false)
        {
            var bitmapData = _arg1;
            var pixelSnapping:String = _arg2;
            var smoothing:Boolean = _arg3;
            super(bitmapData, pixelSnapping, smoothing);
            try
            {
                name = NameUtil.createUniqueName(this);
            }
            catch(e:Error)
            {
            };
        }
        override public function toString():String
        {
            return (NameUtil.displayObjectToString(this));
        }

    }
}