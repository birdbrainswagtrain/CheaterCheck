util.AddNetworkString("CC.CheaterFound")

CC = CC or {}

include("cc_list.lua")

CC.ShouldKick = CreateConVar("cc_kick",	0, FCVAR_ARCHIVE, "Prevent cheaters from playing on your server!")

function CC.Check()
	for k,v in pairs(player.GetAll()) do
		local rsn = CC.List[v:SteamID()]
		
		if !rsn then 
			continue 
		end

		if hook.Run("CheaterFound", v, rsn) then 
			return
		end
		
		MsgC(
			Color(50, 50, 50), "[",
			Color(255, 0, 0), "Cheater",
			Color(255, 255, 255), "Check",
			Color(50, 50, 50), "] ",
			Color(255, 0, 0), v:Nick(),
			Color(255, 255, 255), " (" .. v:SteamID() .. ") is a ",
			Color(255, 0, 0), "CHEATER!\n"
		)
		
		net.Start("CC.CheaterFound")
		net.WriteString(v:Nick())
		net.WriteString(v:SteamID())
		net.Broadcast()
		
		if CC.ShouldKick:GetBool() then
			v:Kick("[CheaterCheck] You are a cheater! (" .. rsn .. ")")
		end
	end
end

function CC.CheckCheater(ply)
	local rsn = CC.List[ply:SteamID()]
		
	if !rsn then 
		return
	end
	
	if hook.Run("CheaterFound", ply, rsn) then 
		return
	end
	
	MsgC(
		Color(50, 50, 50), "[",
		Color(255, 0, 0), "Cheater",
		Color(255, 255, 255), "Check",
		Color(50, 50, 50), "] ",
		Color(255, 0, 0), ply:Nick(),
		Color(255, 255, 255), " (" .. ply:SteamID() .. ") is a ",
		Color(255, 0, 0), "CHEATER!\n"
	)
		
	net.Start("CC.CheaterFound")
	net.WriteString(ply:Nick())
	net.WriteString(ply:SteamID())
	net.WriteString(rsn)
	net.Broadcast()
	
	if CC.ShouldKick:GetBool() then
		ply:Kick("[CheaterCheck] You are a cheater! (" .. rsn .. ")")
	end
end

hook.Add("PlayerInitialSpawn", "CC.CheckCheater", CC.CheckCheater)

function CC.CheckCommand(ply, cmd, args, argStr)
	if !IsValid(ply) or ply:IsAdmin() or ply:IsSuperAdmin() then
		CC.Check()
	else
		ply:SendLua([[
		chat.AddText(
			Color(50, 50, 50), "[",
			Color(255, 0, 0), "Cheater",
			Color(255, 255, 255), "Check",
			Color(50, 50, 50), "] ",
			Color(255, 0, 0), "You don't have permission to do that!"
		)
	)]])
	end
end

concommand.Add("cc", CC.CheckCommand)

MsgC(
	Color(50, 50, 50), "[",
	Color(255, 0, 0), "Cheater",
	Color(255, 255, 255), "Check",
	Color(50, 50, 50), "] ",
	Color(255, 255, 255), "Checking ",
	Color(255, 0, 0), tostring(table.Count(CC.List)) .. " cheaters!\n"
)
