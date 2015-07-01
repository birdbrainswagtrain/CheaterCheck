CC = CC or {}

function CC.CheaterFound()
	local name = net.ReadString()
	local sid = net.ReadString()
	
	chat.AddText(
		Color(50, 50, 50), "[",
		Color(255, 0, 0), "Cheater",
		Color(255, 255, 255), "Check",
		Color(50, 50, 50), "] ",
		Color(255, 0, 0), name,
		Color(255, 255, 255), " (" .. sid .. ") is a ",
		Color(255, 0, 0), "CHEATER!"
	)

	surface.PlaySound("buttons/button6.wav")
end

net.Receive("CC.CheaterFound", CC.CheaterFound)
