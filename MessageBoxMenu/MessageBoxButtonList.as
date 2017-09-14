// Decompiled by AS3 Sorcerer 4.99
// www.as3sorcerer.com

//MessageBoxButtonList

package 
{
    import Shared.AS3.BSScrollingList;

    public class MessageBoxButtonList extends BSScrollingList 
    {


        override public function InvalidateData():*
        {
            super.InvalidateData();
            this.SetEntryBorderWidths();
        }

        private function SetEntryBorderWidths():*
        {
            var _local_4:MessageBoxButtonEntry;
            var _local_5:Number;
            var _local_6:MessageBoxButtonEntry;
            var _local_1:Number = 0;
            var _local_2:uint;
            while (_local_2 < uiNumListItems)
            {
                _local_4 = (GetClipByIndex(_local_2) as MessageBoxButtonEntry);
                if (((_local_4) && (_local_4.textField)))
                {
                    _local_5 = _local_4.CalculateBorderWidth();
                    if (_local_5 > _local_1)
                    {
                        _local_1 = _local_5;
                    };
                };
                _local_2++;
            };
            var _local_3:uint;
            while (_local_3 < uiNumListItems)
            {
                _local_6 = (GetClipByIndex(_local_3) as MessageBoxButtonEntry);
                if (_local_6)
                {
                    _local_6.SetBorderWidth(_local_1);
                };
                _local_3++;
            };
        }

        override protected function updateScrollPosition(_arg_1:uint):*
        {
            super.updateScrollPosition(_arg_1);
            this.SetEntryBorderWidths();
        }


    }
}//package 

