function main()
  print('Gamemode loaded successfully!')
end

function onPlayerConnect(playerid)
end

function onPlayerDisconnect(playerid, reason)
end

function onPlayerChat(playerid, message)
  sendClientMessageToAll('[' .. getPlayerName(playerid) .. ']: {919191}' .. message, 0xFFFFFFFF)
end

function onPlayerCommand(playerid, command)
  if command == 'help' then
    sendClientMessage(playerid, '{FFFFFF}������! �������, ������ ���, ���� ��������!', 0xFFFFFFFF)
    return true
  end
  sendClientMessage(playerid, '{FF0000}����������� �������! {FFFFFF}������� /help ��� ������.', 0xFFFFFFFF)
end