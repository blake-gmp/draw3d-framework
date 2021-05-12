/* ------------------------------------
       Draws3d System by heisenberg
   ------------------------------------*/

local function cmd_draw_add(pid, params)
{
    local args = sscanf("s", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.add <text>");
       return;
    }
    if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
  local pos = getPlayerPosition(pid);
  if(args[0].len() > 240) {sendMessageToPlayer(pid, 255, 255,255, "Maksymalna d³ugoœæ tekstu: 240"); return;}
  addDraw3d(args[0], pos.x, pos.y, pos.z);
  sendMessageToPlayer(pid, 255, 255, 255, "Dodano nowy draw.");
}

local function cmd_draw_text(pid, params)
{
    local args = sscanf("ds", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.text <drawId> <text>");
       return;
    }
    if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
	local id = args[0];
	if(!(id in draws)) return;
	if(args[1].len() > 240) {sendMessageToPlayer(pid, 255, 255,255, "Maksymalna d³ugoœæ tekstu: 240"); return;}
	draws[id].setText(args[1]);
}

local function cmd_draw_rem(pid, params)
{
    local args = sscanf("d", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.rem <drawId>");
       return;
    }
	  if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
	local id = args[0];
	if(!(id in draws)) return;
	draws[id].removeToAll();
	sendMessageToPlayer(pid, 255, 255, 255, "Usuniêto drawa o ID:" + id);
}

local function cmd_draw_position(pid, params)
{
    local args = sscanf("d", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.pos <drawId>");
       return;
    }
	  if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
	local id = args[0];
	local pos = getPlayerPosition(pid);
	if(!(id in draws)) return;
	draws[id].setPosition(pos.x,pos.y,pos.z);
	sendMessageToPlayer(pid, 255, 255, 255, "Zaktualizowano pozycje drawa.");
}

local function cmd_draw_color(pid, params)
{
    local args = sscanf("dddd", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.color <drawId> <r> <g> <b>");
       return;
    }
	  if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
	local id = args[0];
	if(!(id in draws)) return;
	draws[id].setColor(args[1], args[2], args[3]);
	sendMessageToPlayer(pid, 255, 255, 255, "Zaktualizowano kolor drawa.");
}

local function cmd_draw_range(pid, params)
{
    local args = sscanf("dd", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.range <drawId> <range>");
       return;
    }
	  if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
	local id = args[0];
	if(!(id in draws)) return;
	draws[id].setVisible(args[1]);
	sendMessageToPlayer(pid, 255, 255, 255, "Zaktualizowano zasiêg widocznoœci drawa.");
}

local function cmd_draw_height(pid, params)
{
    local args = sscanf("dd", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.height <drawId> <height>");
       return;
    }
	  if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
	local id = args[0];
	if(!(id in draws)) return;
	draws[id].setHeight(args[1]);
	sendMessageToPlayer(pid, 255, 255, 255, "Zaktualizowano wysokoœæ drawa.");
}

local function cmd_draw_show(pid, params)
{
	  if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;
    
	setVisibleDraws(true);
	sendMessageToPlayer(pid, 255, 255, 255, "Odkryto wszystkie drawy 3d.");
}

local function cmd_draw_hide(pid, params)
{
	  if(!(EnabledDraws)) return; if(!(checkPermissionDraws(pid))) return;

    setVisibleDraws(false);
	sendMessageToPlayer(pid, 255, 255, 255, "Ukryto wszystkie drawy 3d.");
}

local function cmd_draw_login(pid, params)
{
    local args = sscanf("s", params);
    if(!args)
    {
       sendMessageToPlayer(pid, 255, 0, 0, "/draw.login <pass>");
       return;
    }
	
	  if(!(EnabledDraws)) return;

    if(args[0].toupper() == getPasswordDraws().toupper()) {
	  Permission[pid] = true;
	  sendMessageToPlayer(pid, 255, 255, 255, "Mo¿esz teraz edytowaæ drawy 3d.");
	}
	else {
	  sendMessageToPlayer(pid, 255, 255, 255, "B³êdne has³o.");
	}
}

local function cmd_draw_help(pid, params)
{
    sendMessageToPlayer(pid, 255, 255, 255, "Komendy:");
    sendMessageToPlayer(pid, 255, 255, 255, "/draw.add /draw.text /draw.rem");
	sendMessageToPlayer(pid, 255, 255, 255, "/draw.pos /draw.color /draw.range");
	sendMessageToPlayer(pid, 255, 255, 255, "/draw.height /draw.login /draw.help");
}

local function cmdHandler(pid, cmd, params)
{
	switch (cmd)
	{
	case "draw.add":
		cmd_draw_add(pid, params);
		break;
	case "draw.text":
		cmd_draw_text(pid, params);
		break;
	case "draw.rem":
		cmd_draw_rem(pid, params);
		break;
	case "draw.pos":
		cmd_draw_position(pid, params);
		break;
	case "draw.color":
		cmd_draw_color(pid, params);
		break;
	case "draw.range":
		cmd_draw_range(pid, params);
		break;
	case "draw.height":
		cmd_draw_height(pid, params);
		break;
	case "draw.show":
		cmd_draw_show(pid, params);
		break;
	case "draw.hide":
		cmd_draw_hide(pid, params);
		break;
	case "draw.login":
		cmd_draw_login(pid, params);
		break;
	case "draw.help":
		cmd_draw_help(pid, params);
		break;
	case "draw":
		cmd_draw_help(pid, params);
		break;
	}
}

addEventHandler("onPlayerCommand", cmdHandler);

//-------------------------//