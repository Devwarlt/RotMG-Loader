package mx.utils
{
    import mx.core.mx_internal;
    import flash.utils.getQualifiedClassName;
    import flash.display.DisplayObject;
    import mx.core.IRepeaterClient;
    use namespace mx_internal;

    public class NameUtil 
    {

        mx_internal static const VERSION:String = "4.0.0.14159";

        private static var counter:int = 0;

        public static function createUniqueName(_arg1:Object):String
        {
            if (!_arg1)
            {
                return (null);
            };
            var _local2:String = getQualifiedClassName(_arg1);
            var _local3:int = _local2.indexOf("::");
            if (_local3 != -1)
            {
                _local2 = _local2.substr((_local3 + 2));
            };
            var _local4:int = _local2.charCodeAt((_local2.length - 1));
            if ((((_local4 >= 48)) && ((_local4 <= 57))))
            {
                _local2 = (_local2 + "_");
            };
            return ((_local2 + counter++));
        }
        public static function displayObjectToString(_arg1:DisplayObject):String
        {
            var result:String;
            var o:DisplayObject;
            var s:String;
            var indices:Array;
            var displayObject:DisplayObject = _arg1;
            try
            {
                o = displayObject;
                while (o != null)
                {
                    if (((((o.parent) && (o.stage))) && ((o.parent == o.stage)))) break;
                    s = ((((("id" in o)) && (o["id"]))) ? o["id"] : o.name);
                    if ((o is IRepeaterClient))
                    {
                        indices = IRepeaterClient(o).instanceIndices;
                        if (indices)
                        {
                            s = (s + (("[" + indices.join("][")) + "]"));
                        };
                    };
                    result = (((result == null)) ? s : ((s + ".") + result));
                    o = o.parent;
                };
            }
            catch(e:SecurityError)
            {
            };
            return (result);
        }
        public static function getUnqualifiedClassName(_arg1:Object):String
        {
            var _local2:String;
            if ((_arg1 is String))
            {
                _local2 = (_arg1 as String);
            }
            else
            {
                _local2 = getQualifiedClassName(_arg1);
            };
            var _local3:int = _local2.indexOf("::");
            if (_local3 != -1)
            {
                _local2 = _local2.substr((_local3 + 2));
            };
            return (_local2);
        }

    }
}