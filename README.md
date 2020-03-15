# ThorTempBan

Support Discord : https://discord.gg/ewrPBBx
Depedencies: vRP

# How to install 

# Copy&Paste

Paste base.lua in vrp

# Vrp/modules/admin.lua

# Paste this two fuction in vrp/modules/admin.lua

local function ch_tempban(player,choice)

	local user_id = vRP.getUserId(player)
	
	if user_id ~= nil then
	
		vRP.prompt(player,"User id to ban: ","",function(player,id)
		
			id = parseInt(id)
			
			vRP.prompt(player,"Reason: ","",function(player,reason)
			
				local source = vRP.getUserSource(id)
				
        if source ~= nil then
	
          vRP.prompt(player,"An: (2020,2021)","",function(player,year)
	  
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


# Add this to your admin menu


        if vRP.hasPermission(user_id,"player.ban") then
	
          menu["TempBan"] = {ch_tempban}
	  
        end
	

# SQL 

ALTER TABLE vrp_users ADD IF NOT EXISTS tempban varchar(150) NOT NULL DEFAULT 'No Temp Ban' ;

ALTER TABLE vrp_users ADD IF NOT EXISTS bannedReason varchar(150) NOT NULL DEFAULT 'No Ban Reason' ;

ALTER TABLE vrp_users ADD IF NOT EXISTS bannedBy varchar(150) NOT NULL DEFAULT 'No Ban By' ;
