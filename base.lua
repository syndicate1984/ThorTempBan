This is a script made by Hyp3🐉#6025 and Syndicatu'#4174 for Thor Romania Roleplay.

Depedencies: vRP

How to install: 

First, go to base.lua
Add this: 

MySQL.createCommand("vRP/get_banned","SELECT * FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/get_bannedtime","SELECT * FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_banned","UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id")
MySQL.createCommand("vRP/set_tempbanned","UPDATE vrp_users SET tempban = @tempban, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id")

And remove the old ones

After, you should replace BAN functions with:

function vRP.getBannedReason(user_id, cbr)
	local task = Task(cbr, {false})

	MySQL.query("vRP/get_banned", {user_id = user_id}, function(rows, affected)
		if #rows > 0 then
			task({rows[1]})
		else
			task()
		end
	end)
end

function vRP.getBannedTime(user_id, cbr)
	local task = Task(cbr, {false})

	MySQL.query("vRP/get_bannedtime", {user_id = user_id}, function(rows, affected)
		if #rows > 0 then
			task({rows[1].tempban})
		else
			task()
		end
	end)
end

--- sql
function vRP.setBanned(user_id,banned,reason,by)
	if(banned == false)then
		reason = ""
	end
	if(tostring(by) ~= "Consola")then
		theAdmin = vRP.getUserId(by)
		adminName = GetPlayerName(by)
		banBy = adminName.." ["..theAdmin.."]"
	else
		banBy = "Consola"
	end
	MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned, reason = reason, bannedBy = banBy})
end

function vRP.setTemporarBan(user_id,timeban,reason,admin)
  if admin == nil then
    admin = "Consola/No Name"
  end
  MySQL.execute("vRP/set_tempbanned", {user_id = user_id, tempban = timeban, reason = reason, bannedBy = admin})
end

function vRP.ban(source,reason,admin)
    local user_id = vRP.getUserId(source)
  
    if user_id ~= nil then
      vRP.setBanned(user_id,1,reason,admin)
        motiv = "De: "..admin.."\nMotiv: "..reason.."\nID-ul Tau: ["..user_id.."]\n\nPentru Unban Apeal intra pe Discord: discord.io/thorvintage"
      vRP.kick(source,"[Thor-Ban] "..motiv)
    end
  end
  
function vRP.TempBan(source,reason,timehash,normaltime,admin)
local user_id = vRP.getUserId(source)

if user_id ~= nil then
    tempban_stamp = normaltime.." "..timehash
    vRP.setTemporarBan(user_id,tempban_stamp,reason,admin)
    motiv = "Ban temporar ("..normaltime..")\n Banat de: "..admin.." \n Motiv: "..reason.." \n Id-ul tau: "..user_id.." \n Unban Appeal pe discord.io/thorvintage"
    vRP.kick(source,"[TempBan] "..motiv)
end
end

After this, you need to add this function over main thread

function split(str, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(t,cap)
        end
        last_end = e+1
        s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
        cap = str:sub(last_end)
        table.insert(t, cap)
    end
    return t
end

And the last one step is to replace the 'if not banned then' line with ` if not banned and (tostring(actDate) == tostring(banHash[2]) or tostring(actDate) <= tostring(banHash[2]))  then`
	and you put that over at if not banned and (tostring(actDate) == tostring(banHash[2]) or tostring(actDate) <= tostring(banHash[2]))  then
	banHash = split(banDate, " ")

		Now, you need to replace admin module ban function with this one:

local function ch_tempban(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.prompt(player,"User id to ban: ","",function(player,id)
            id = parseInt(id)
            vRP.prompt(player,"Reason: ","",function(player,reason)
            local source = vRP.getUserSource(id)
            if source ~= nil then
                vRP.prompt(player,"An: (2019,20202)","",function(player,year)
                    if (year ~= nil or year ~= " ") and (#year == 4 and tonumber(year) >= 2020) then
                        vRP.prompt(player,"luna: (maxim 12)","",function(player,luna)
                            if (luna ~= nil or luna ~= " ") and (tonumber(luna) <= 12) then
                                vRP.prompt(player,"zi: (maxim 31)","",function(player,zi)
                                if (zi ~= nil or zi ~= " ") and (tonumber(zi) <= 31) then
                                    normaltime = zi.."/"..luna.."/"..year
                                    timehash = os.time{year=year, month=luna, day=zi}
                                    vRP.TempBan(source,reason,timehash,normaltime,player)
                                    vRPclient.notify(player,{"banned user "..id.. " pana pe "..zi.."/"..luna.."/"..year})
                                else
                                    vRPclient.notify(player,{"Pune o zi reala"})
                                end
                                end)
                            else
                                vRPclient.notify(player,{"Pune o luna reala(1,2,3,4)"})
                                print(luna)
                            end
                            end)
                        else
                            vRPclient.notify(player,{"Pune un an real!"})
                        end
                    end)
                end
            end)
        end)
    end
end

local function ch_ban(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"User id to ban: ","",function(player,id)
			id = parseInt(id)
			vRP.prompt(player,"Reason: ","",function(player,reason)
				local source = vRP.getUserSource(id)
				if source ~= nil then
					vRP.ban(source,reason,player)
					vRPclient.notify(player,{"banned user "..id})
				end
			end)
		end)
	end
end

and add this :
if vRP.hasPermission(user_id,"player.ban") then
    menu["TempBan"] = {ch_tempban}
end 

to line 464

(!) If you do this like me, all will be ok!
