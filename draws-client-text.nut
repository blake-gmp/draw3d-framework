/* ------------------------------------
       Draws3d System by heisenberg
   ------------------------------------*/
   
class correctingLines
{
   maxLen = null
   textTab = null
   color = null

   constructor(_text, _lenLines)
   {
      textTab = []
      maxLen = _lenLines
      cont(_text)
   }

   function cont(text) {
     local textLen = text.len();
     local polLen = textLen/2;
     local val = maxLen;
     local min = 0;
	 if(textLen <= maxLen) { textTab.push(text.slice(min, textLen)); return; }
	 
     while(textLen > maxLen) {
       if(val >= textLen) { textTab.push(text.slice(min, textLen)); return; }
       local counter = 0;
       while(text[val] != ' ') {
         val--;
         counter++;
         if(counter >= polLen) break;
        }
        textTab.push(text.slice(min, val));
		min = val+1;
        val = val+maxLen;
       }
   }

   function getText() {return textTab;}
}
