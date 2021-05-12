/* ------------------------------------
       Draws3d System by heisenberg
   ------------------------------------*/
   
draws <- {};

//-------------------------//

function enabledDraws3dSystem(bool = false)
{
  EnabledDraws = bool
  if(!(bool)) return

  local query = mysql_query("SELECT * FROM `draws3d`")
  
  if(!(query)) return
  if(mysql_num_rows(query) <= 0) return
  
	local data;
    while(data = mysql_fetch_assoc(query)) 
       addDraw3d(data["text"], data["x"], data["y"], data["z"], data["r"], data["g"], data["b"], data["h"], data["visible"], data["id"]);
}

//-------------------------//

class addDraw3d {
  m_id = null
  m_drawId = null
  m_text = null
  m_position = null
  m_color = null
  m_visible = null
  m_h = null
  m_remove = null
  
  constructor (text, x,y,z, r=255,g=255,b=255, h=50, visible=700, drawId = -1) {
 
    if(drawId == -1) { if(draws.len() <= 0) m_drawId = 0; else m_drawId = draws[draws.len()-1].m_drawId+1; drawsSql.insertDraw(text, x,y,z,r,g,b,visible,h,m_drawId) }
	else m_drawId = drawId
	
    m_id = draws.len()
	m_text = text
	m_position = {x=x, y=y, z=z}
	m_color = {r=r, g=g, b=b}
	m_visible = visible
	m_h = h
	m_remove = false
	
	draws[m_id] <- this
	updateToAll()
  }
  
  function updateToClient(pid){
    local packet = Packet()
    packet.writeUInt16(PacketDraws.DC_UPDATE_DRAW3D)
    packet.writeInt16(m_id)
    packet.writeString("|" + m_id + "| " + m_text)
    packet.writeInt32(m_position.x)
    packet.writeInt32(m_position.y + m_h)
    packet.writeInt32(m_position.z)
    packet.writeInt16(m_color.r)
    packet.writeInt16(m_color.g)
    packet.writeInt16(m_color.b)
    packet.writeInt32(m_visible)
    packet.send(pid, RELIABLE)
  }

  function updateToAll(){
    local packet = Packet()
    packet.writeUInt16(PacketDraws.DC_UPDATE_DRAW3D)
    packet.writeInt16(m_id)
    packet.writeString("|" + m_id + "| " + m_text)
    packet.writeInt32(m_position.x)
    packet.writeInt32(m_position.y + m_h)
    packet.writeInt32(m_position.z)
    packet.writeInt16(m_color.r)
    packet.writeInt16(m_color.g)
    packet.writeInt16(m_color.b)
    packet.writeInt32(m_visible)
    packet.sendToAll(RELIABLE)
  }
  
  function removeToAll(){
    m_text = "";
    m_visible = 0;
	m_remove = true;
    local packet = Packet()
    packet.writeUInt16(PacketDraws.DC_REM_DRAW3D)
    packet.writeInt16(m_id)
    packet.sendToAll(RELIABLE)
    drawsSql.deleteDraw(m_drawId)
   }
  
  function setText(text){m_text=text; drawsSql.updateText(m_drawId,text); updateToAll()}
  function setPosition(x,y,z){m_position.x=x; m_position.y=y; m_position.z=z; drawsSql.updatePosition(m_drawId,x,y,z); updateToAll()}
  function setColor(r,g,b){m_color.r=r; m_color.g=g; m_color.b=b; drawsSql.updateColor(m_drawId, r,g,b); updateToAll()}
  function setVisible(visible){m_visible=visible; drawsSql.updateVisible(m_drawId, visible); updateToAll()}
  function setHeight(h){m_h=h; drawsSql.updateHeight(m_drawId, h); updateToAll()}
  
  function getText(){return m_text}
  function getPosition(){return m_position}
  function getColor(){return m_color}
  function getVisible(){return m_visible}
  function getHeight(){return m_h}
  function getRemove(){return m_remove}
}

class drawsSql{
   function insertDraw(m_text, x,y,z,r,g,b,m_visible,m_h,drawId){mysql_query(format("INSERT INTO `draws3d`(`id`, `text`, `x`, `y`, `z`, `r`, `g`, `b`, `h`, `visible`) VALUES (%d, '%s', %f, %f, %f, %d, %d, %d, %d, %d)", drawId, m_text, x,y,z,r,g,b,m_h,m_visible))}  
   function updateText(drawId,text){mysql_query(format("UPDATE `draws3d` SET `text` = '%s' WHERE `id` = %d LIMIT 1", text, drawId))}
   function updatePosition(drawId,x,y,z){mysql_query(format("UPDATE `draws3d` SET `x` = %f, `y` = %f, `z` = %f WHERE `id` = %d LIMIT 1", x,y,z, drawId))}
   function updateHeight(drawId, h){mysql_query(format("UPDATE `draws3d` SET `h` = %d WHERE `id` = %d LIMIT 1", h, drawId))}
   function updateVisible(drawId, visible){mysql_query(format("UPDATE `draws3d` SET `visible` = %d WHERE `id` = %d LIMIT 1", visible, drawId))}
   function updateColor(drawId, r,g,b){mysql_query(format("UPDATE `draws3d` SET `r` = %d, `g` = %d, `b` = %d WHERE `id` = %d LIMIT 1", r,g,b, drawId))}
   function deleteDraw(drawId){mysql_query(format("DELETE FROM `draws3d` WHERE `id` = %d", drawId))}
}

//-------------------------//