/* ------------------------------------
       Draws3d System by heisenberg
   ------------------------------------*/
   
local draws = {};
local visible = true;
//-------------------------//

function enabledDraws3d(bool)
{
  foreach(val in draws)
    val.visible = bool
}

//-------------------------//

local function onPacketHandler(packet)
{
    local id = packet.readUInt16();

    switch(id)
    {
	    case PacketDraws.DC_VISIBLE_DRAWS:
		    local visible_draws = packet.readBool();
			visible = visible_draws;
			  foreach(val in draws)
                val.visible = visible;
		break;
		
		case PacketDraws.DC_UPDATE_DRAW3D:
            local _id = packet.readInt16();
            local name = packet.readString();
            local posx = packet.readInt32();
            local posy = packet.readInt32();
            local posz = packet.readInt32();
            local r = packet.readInt16();
            local g = packet.readInt16();
            local b = packet.readInt16();
            local range = packet.readInt32();
			
			if(_id in draws){
                draws[_id].visible = false;
                draws[_id].updateText(0, "");
                draws[_id].updateText(1, "");
				draws[_id].updateText(2, "");
				
			local Msg = correctingLines(name, 60);
			    foreach(i, val in Msg.getText())
				   if(i==0 || i==1 || i==2)
				     draws[_id].updateText(i, val);
					 
			draws[_id].setColor(r,g,b);
			draws[_id].setWorldPosition(posx, posy, posz);
			draws[_id].distance = range;
			draws[_id].visible = true;
			}
			else{
			draws[_id] <- Draw3d(posx, posy, posz);
			draws[_id].visible = false;
			draws[_id].insertText("");
			draws[_id].insertText("");
			draws[_id].insertText("");

			local Msg = correctingLines(name, 60);
			    foreach(i, val in Msg.getText())
				   if(i==0 || i==1 || i==2)
				     draws[_id].updateText(i, val);
			    
			draws[_id].setColor(r,g,b);
			draws[_id].distance = range;
			draws[_id].visible = true;
			}
	    break;

        case PacketDraws.DC_REM_DRAW3D:
		
        local _id = packet.readInt16();

        if(_id in draws){
            draws[_id].visible = false;
            draws[_id].updateText(0, "");
            draws[_id].updateText(1, "");
		    draws[_id].updateText(2, "");
			delete draws[_id];
        }
        break;
    }
}

addEventHandler("onPacket", onPacketHandler);
print("Draws3d System by heisenberg/blake loaded...");
//-------------------------//
