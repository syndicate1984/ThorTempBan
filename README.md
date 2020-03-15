# ThorTempBan

Support Discord : https://discord.gg/ewrPBBx
Depedencies: vRP

# SQL 

ALTER TABLE vrp_users ADD IF NOT EXISTS tempban varchar(150) NOT NULL DEFAULT 'No Temp Ban' ;

ALTER TABLE vrp_users ADD IF NOT EXISTS bannedReason varchar(150) NOT NULL DEFAULT 'No Ban Reason' ;

ALTER TABLE vrp_users ADD IF NOT EXISTS bannedBy varchar(150) NOT NULL DEFAULT 'No Ban By' ;
