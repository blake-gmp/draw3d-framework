/* ------------------------------------
       Draws3d System by heisenberg
   ------------------------------------*/

/* MYSQL EXAMPLE
CREATE TABLE draws3d (
id INT(13) UNSIGNED PRIMARY KEY,
text VARCHAR(255) NOT NULL,
x float(20) NOT NULL,
y float(20) NOT NULL,
z float(20) NOT NULL,
r INT(3) NOT NULL,
g INT(3) NOT NULL,
b INT(3) NOT NULL,
h INT(13) NOT NULL,
visible INT(13) NOT NULL
);
*/

//-------------------------//

local enable_perm = false;
local show_draws = true;
local passwordDraws = "draws123";
EnabledDraws <- true;

function getPasswordDraws(){return passwordDraws;}

//-------------------------//

Permission <- array(getMaxSlots())
for (local i = 0; i < getMaxSlots(); i++)
    Permission[i] = false;
		
//-------------------------//

addEventHandler("onInit",function()
{
   enabledDraws3dSystem(true);
   enabledPermission(false);
})

//-------------------------//

addEventHandler("onPlayerDisconnect", function(pid, reason)
{
    if(EnabledDraws)
    Permission[pid] = false
});

//-------------------------//

function checkPermissionDraws(pid){
  if(Permission[pid]) 
    return true;
  else {
    sendMessageToPlayer(pid, 255, 0,0, "Nie posiadasz uprawnieñ do edycji drawów 3d");
    return false;
	}
}

//-------------------------//

function enabledPermission(bool = false){
   enable_perm = bool;
}

//-------------------------//

addEventHandler("onPlayerJoin", function(pid)
{
  if(EnabledDraws) {
  
   foreach(val in draws)
    if(!(val.getRemove()))
      val.updateToClient(pid);
  
      if(!(show_draws)){
      local packet = Packet()
      packet.writeUInt16(PacketDraws.DC_VISIBLE_DRAWS)
      packet.writeBool(bool)
      packet.send(pid, RELIABLE);
  }

  if(enable_perm)
   Permission[pid] = true;
   }
})

//-------------------------//

function setVisibleDraws(bool = true){
  if(EnabledDraws) {
  show_draws = bool;
  local packet = Packet()
  packet.writeUInt16(PacketDraws.DC_VISIBLE_DRAWS)
  packet.writeBool(bool)
  packet.sendToAll(RELIABLE)
  }
}