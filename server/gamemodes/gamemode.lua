function main()
  print('Gamemode loaded successfully!')
end

function onPlayerConnect(playerid)
  server.setPlayerPos(playerid, {1537.3419, -10.9145, 22.2729, 295.8700})
  print(server.getPlayerName(playerid) .. ' ������������� � �������!')
  server.sendClientMessageToAll(server.getPlayerName(playerid) .. ' ������������� � �������!', 0xFF0000FF)
  local pPos = server.getPlayerPos(playerid)
  --server.createVehicle(400, {pPos[1], pPos[2], pPos[3]}, {0, 0})
  server.SendClientMessage(playerid, 'Welcome to the SL:MP server!', 0xFFFFFFFF)
end

function onPlayerDisconnect(playerid, reason)
  print(server.getPlayerName(playerid) .. ' ������������ �� �������!')
  server.sendClientMessageToAll(server.getPlayerName(playerid) .. ' ������������ �� �������!', 0xFF0000FF)
end

function onPlayerChat(playerid, message)
  print(server.getPlayerName(playerid) .. ': ' .. message)
  server.sendClientMessageToAll('['..server.getPlayerName(playerid)..']: ' .. message, 0xFFFFFFFF)
end