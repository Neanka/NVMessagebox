// Decompiled by AS3 Sorcerer 4.99
// www.as3sorcerer.com

//MessageBoxButtonEntry

package 
{
    import Shared.AS3.BSScrollingListEntry;
    import Shared.AS3.BSScrollingList;

    public class MessageBoxButtonEntry extends BSScrollingListEntry 
    {


        public function CalculateBorderWidth():Number
        {
            return (textField.getLineMetrics(0).width + 30);
        }

        public function SetBorderWidth(_arg_1:Number):*
        {
            border.width = _arg_1;
            border.x = ((textField.getLineMetrics(0).x - ((border.width - textField.getLineMetrics(0).width) / 2)) + 2.5);
        }

        override public function SetEntryText(_arg_1:Object, _arg_2:String):*
        {
            super.SetEntryText(_arg_1, BSScrollingList.TEXT_OPTION_MULTILINE);
        }


    }
}//package 

