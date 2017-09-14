// Decompiled by AS3 Sorcerer 4.99
// www.as3sorcerer.com

//MessageBoxMenu

package 
{
    import Shared.IMenu;
	import flash.display.Loader;
	import flash.net.URLRequest;
    import flash.text.TextField;
    import Shared.AS3.BSScrollingList;
    import flash.display.MovieClip;
    import flash.text.TextFieldAutoSize;
    import flash.events.Event;
    import Shared.GlobalFunc;
    import Shared.BGSExternalInterface;

    public class MessageBoxMenu extends IMenu 
    {

        public var Body_tf:TextField;
		public var Body2_tf:TextField;
		public var Header_tf:TextField;
        public var List_mc:BSScrollingList;
        public var BGRect_mc:MovieClip;
        public var BGRectBlack_mc:MovieClip;
        public var BGSCodeObj:Object;
        private var fCenterY:Number;
        private var DisableInputCounter:uint;
        private var ListYBuffer:Number;
        private var MenuMode:Boolean = false;
		private var orig_x: int;
		private var orig_y: int;

        public function MessageBoxMenu()
        {
            this.BGSCodeObj = new Object();
            this.Body_tf.autoSize = TextFieldAutoSize.LEFT;
			this.Body2_tf.autoSize = TextFieldAutoSize.LEFT;
            this.List_mc.addEventListener(BSScrollingList.ITEM_PRESS, this.onItemPress);
            this.List_mc.addEventListener(BSScrollingList.PLAY_FOCUS_SOUND, this.playFocusSound);
            addEventListener(Event.ENTER_FRAME, this.initDisableInputCounter);
            this.visible = false;
            this.List_mc.disableInput = true;
            this.fCenterY = (this.y + (this.BGRect_mc.height / 2));
            this.DisableInputCounter = 0;
            this.ListYBuffer = (this.BGRect_mc.height - (this.List_mc.y + this.List_mc.height));
            this.__setProp_BGRect_mc_MenuObj_Background_0();
            this.__setProp_List_mc_MenuObj_ButtonList_0();
			orig_x = this.x;
			orig_y = this.y;
        }

        public function get bodyText():String
        {
            return (this.Body_tf.text);
        }

        public function set bodyText(_arg_1:String):*
        {
            GlobalFunc.SetText(this.Body_tf, _arg_1, true);
        }

        public function get buttonArray():Array
        {
            return (this.List_mc.entryList);
        }

        public function set buttonArray(_arg_1:Array):*
        {
            this.List_mc.entryList = _arg_1;
        }

        public function get selectedIndex():uint
        {
            return (this.List_mc.selectedIndex);
        }

        public function set menuMode(_arg_1:Boolean):*
        {
            this.MenuMode = _arg_1;
        }

        public function ForceInit():*
        {
            if (this.List_mc.numListItems == 0)
            {
                this.List_mc.listEntryClass = "MessageBoxButtonEntry";
                this.List_mc.numListItems = 4;
                this.List_mc.onComponentInit(null);
            };
        }

        public function InvalidateMenu():*
        {
			var moded: Boolean = false;
			var oldtext: String = this.Body_tf.text; // format {rep}|factionName|repRank
			var strArray: Array;
			var factionName: String;
			var repRank: String;
			var loader: Loader;
			var request: URLRequest;
				var child:* = null;
				var i:* = 0;
				while (i < this.numChildren) {
					child = this.getChildAt(i);
					if (child.name == "lines"){
						this.removeChild(child);
						break;
					};
					i++;
				};
			if (oldtext.search(/{rep}/) == 0)//oldtext.search(/{rep}/) == 0)
			{
				moded = true;
				strArray = oldtext.split("|");
				factionName = strArray[1];
				repRank = strArray[2];

				loader = new Loader();
				loader.name = "lines";
				request = new URLRequest("F4NV//Reputation//Factions//"+factionName+".swf");
				loader.load(request);
				loader.x -= 100;
				//loader.y -= 100;
				this.addChild(loader);
				this.setChildIndex(this.List_mc, this.numChildren - 1);
				
				
				this.List_mc.y = 400;
				this.List_mc.InvalidateData();
				this.BGRect_mc.height = ((this.List_mc.y + this.List_mc.shownItemsHeight) + this.ListYBuffer);
				this.BGRect_mc.width = 740;	
				this.Body_tf.y += 10000;
				this.x = orig_x - 100;
				this.List_mc.x = 145;
				if (this.BGRectBlack_mc != null)
				{
					this.BGRectBlack_mc.height = ((this.List_mc.y + this.List_mc.shownItemsHeight) + this.ListYBuffer);
					this.BGRectBlack_mc.visible = this.MenuMode;
					this.BGRectBlack_mc.width = 740;
				};
				this.y = (this.fCenterY - (this.BGRect_mc.height / 2));
				GlobalFunc.SetText(Header_tf, Translator("$F4NV_" + factionName), true);
				GlobalFunc.SetText(Body2_tf, Translator("$F4NV_"+repRank)+"<BR><BR>"+Translator("$F4NV_DESC_"+repRank), true);
			}
			else
			{
				GlobalFunc.SetText(Header_tf, Translator(""), true);
				GlobalFunc.SetText(Body2_tf, Translator(""), true);
				this.Body_tf.y = 16;
				this.List_mc.x = 45;
				this.BGRectBlack_mc.width = 540;
				this.BGRect_mc.width = 540;	
				this.x = orig_x;
				if (((this.Body_tf.text.length > 0) && (!(this.Body_tf.getCharBoundaries((this.Body_tf.text.length - 1)) == null))))
				{
					this.List_mc.y = ((this.Body_tf.y + this.Body_tf.getCharBoundaries((this.Body_tf.text.length - 1)).bottom) + 30);
				};
				this.List_mc.InvalidateData();
				this.BGRect_mc.height = ((this.List_mc.y + this.List_mc.shownItemsHeight) + this.ListYBuffer);
				if (this.BGRectBlack_mc != null)
				{
					this.BGRectBlack_mc.height = ((this.List_mc.y + this.List_mc.shownItemsHeight) + this.ListYBuffer);
					this.BGRectBlack_mc.visible = this.MenuMode;
				};
				this.y = (this.fCenterY - (this.BGRect_mc.height / 2));
			}		
			

            this.List_mc.selectedIndex = 0;
            stage.stageFocusRect = false;
            stage.focus = this.List_mc;
            this.visible = true;
        }
		
		static public function Translator(str:String):String
		{
			var translator:TextField = new TextField();
			translator.visible = false;
			if (str == "")
			{
				translator = null;
				return "";
			}
			if (str.charAt(0) != "$")
			{
				translator = null;
				return str;
			}
			GlobalFunc.SetText(translator, str, false);
			str = translator.text;
			translator = null;
			return str;
		}

        private function initDisableInputCounter(e:Event):*
        {
            this.DisableInputCounter++;
            if (this.DisableInputCounter > 3)
            {
                removeEventListener(Event.ENTER_FRAME, this.initDisableInputCounter);
                this.List_mc.disableInput = false;
            };
        }

        private function onItemPress(_arg_1:Event):*
        {
            if (this.List_mc.selectedEntry.buttonIndex != undefined)
            {
                BGSExternalInterface.call(this.BGSCodeObj, "onButtonPress", this.List_mc.selectedEntry.buttonIndex);
            };
        }

        private function playFocusSound():*
        {
            if (this.BGSCodeObj.PlayFocusSound != undefined)
            {
                BGSExternalInterface.call(this.BGSCodeObj, "PlayFocusSound");
            };
        }

        internal function __setProp_BGRect_mc_MenuObj_Background_0():*
        {
            try
            {
                this.BGRect_mc["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.BGRect_mc.bracketCornerLength = 6;
            this.BGRect_mc.bracketLineWidth = 1.5;
            this.BGRect_mc.bracketPaddingX = 0;
            this.BGRect_mc.bracketPaddingY = 0;
            this.BGRect_mc.BracketStyle = "horizontal";
            this.BGRect_mc.bShowBrackets = false;
            this.BGRect_mc.bUseShadedBackground = true;
            this.BGRect_mc.ShadedBackgroundMethod = "Shader";
            this.BGRect_mc.ShadedBackgroundType = "normal";
            try
            {
                this.BGRect_mc["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function __setProp_List_mc_MenuObj_ButtonList_0():*
        {
            try
            {
                this.List_mc["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.List_mc.disableSelection = false;
            this.List_mc.listEntryClass = "MessageBoxButtonEntry";
            this.List_mc.numListItems = 5;
            this.List_mc.restoreListIndex = false;
            this.List_mc.textOption = "Shrink To Fit";
            this.List_mc.verticalSpacing = 7.5;
            try
            {
                this.List_mc["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }


    }
}//package 

