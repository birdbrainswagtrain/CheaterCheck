# CheaterCheck
Check all players that join vs a database of cheaters!
<br>
<br>
Configuration:
<br>
  ConVars:
<br>
    cc_kick - 1 = kick detected cheaters 0 = keep 'em on your server! (overrided by CheaterFound hook!)
<br>
  Hooks:
<br>
    CheaterFound - Called when a player is detected as a cheater! Arguments: Entity (cheater), String (reason)
<br>
    Example:
<br>
      hook.Add("CheaterFound", "CheaterFound", function(ply, rsn)
<br>
        ply:Kick("CHEATER FOUND! (" .. rsn .. ")")
<br>
      end )
