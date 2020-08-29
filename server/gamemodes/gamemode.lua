function onGamemodeInit()
  print('Gamemode loaded successfully!')
  createVehicle(400, -9.9193, 40.6951, 3.1096, 0, 0)
  local car = createVehicle(400, -9.9193, 40.6951, 3.1096, 0, 0)
  setVehicleVirtualWorld(car, 5)
  createVehicle(484, -258.6933, -352.0168, 1.8031, 0, 0)
  createVehicle(484, -242.0115, -367.5419, 1.3931, 0, 0)
  setTimer((60*1000), true, sendClientMessageToAll, '�������, ��� ������� �� ����� �������!', 0xFFFF00FF)
  -- ������� �������� �� �������� :�
  testPickup = createPickup(1239, 2, -25.3066, 47.5188, 3.1171, 0, 0)
end

local playerVehicles = {}

function onPlayerConnect(playerid)
  playerVehicles[playerid] = createVehicle(487, math.random(0, 50), math.random(0, 50), 2.0, 1, 1)
  sendClientMessage(playerid, '{FF0000}����� {28B463FF}���������� {F4D03FFF}�� ������!', 0xFFFFFFFF)
  sendClientMessageToAll('{FF0000}' .. getPlayerName(playerid) .. ' {FFFFFF}������� �� ��� ������!', 0xFF0000FF)
end

function onPlayerSpawn(playerid)
  resetWeapons(playerid)
  setPlayerSkin(playerid, 312)
  setPlayerPos(playerid, math.random(0, 50), math.random(0, 50), 2.0)
  giveWeapon(playerid, 24, 15)
end

function onPlayerDisconnect(playerid, reason)
  if playerVehicles[playerid] then
    destroyVehicle(playerVehicles[playerid])
  end
  sendClientMessageToAll('{FF0000}' .. getPlayerName(playerid) .. ' ������ ����� � ����� � �������!', 0xFF0000FF)
end

function onPlayerChat(playerid, message)
  sendClientMessageToAll('[' .. getPlayerName(playerid) .. ']: {919191}' .. message, 0xFFFFFFFF)
end

function onPlayerPickPickup(playerid, pickupid)
  if pickupid == testPickup then
    sendClientMessage(playerid, '�� ������� �����!', 0xFFFFFFFF)
  end
end

function onPlayerCommand(playerid, command)
  if command == 'help' then
    sendClientMessage(playerid, '{FFFFFF}������! �������, ������ ���, ���� ��������!', 0xFFFFFFFF)
    return true
  elseif command == 'kickme' then
    sendClientMessage(playerid, '{FFFFFF}�� ���� ������� � ������� �� ������ �������!', 0xFFFFFFFF)
    kickPlayer(playerid)
    return true
  elseif command == 'freezeme' then
    sendClientMessage(playerid, '�� ����������!', 0xFFFFFFFF)
    setPlayerControlable(playerid, false)
    return true
  elseif command == 'unfreezeme' then
    sendClientMessage(playerid, '�� �����������!', 0xFFFFFFFF)
    setPlayerControlable(playerid, true)
    return true
  elseif command:match('^setvw%s(%d+)') then
    local vw = command:match('^setvw%s(%d+)')
    setPlayerVirtualWorld(playerid, vw)
    return true
  elseif command:match('^setint%s(%d+)') then
    local int = command:match('^setint%s(%d+)')
    setPlayerInterior(playerid, int)
    return true
  elseif command:match('^skin%s(%d+)') then
    local skinid = command:match('^skin%s(%d+)')
    setPlayerSkin(playerid, tonumber(skinid))
    return true
  end
  sendClientMessage(playerid, '{FF0000}����������� �������! {FFFFFF}������� /help ��� ������.', 0xFFFFFFFF)
end

function onIncomingPacket(bitStream, clientIP, clientPort)
  -- ������ ������������� (������-������� �� ��������)
  local packetID = SLNet.readInt16(bitStream)
  if packetID == S_PACKETS.ONFOOT_SYNC then
    SLNet.setReadPointerOffset(bitStream, 4)
    -- ������������� �� 4-�� ��������, ������ ���� ��������
    -- ���� � WIKI �� GitHub, ��� �� ���� ��� �������
    local pos =
    {
      SLNet.readFloat(bitStream),
      SLNet.readFloat(bitStream),
      SLNet.readFloat(bitStream)
    }
    local playerid = getIDbyAddress(clientIP, clientPort)
    if playerid ~= -1 then
      local x, y, z = getPlayerPos(playerid)
      local dist = getDistBetweenPoints(pos[1], pos[2], pos[3], x, y, z)
      if dist > 50 then
        sendClientMessage(playerid, '���������� ������������� ���-��������', 0xFF0000FF)
        kickPlayer(playerid)
        return false
      end
    end
  end
  return true -- ���� �� ��������� TRUE, PACKET �� ������������ ��������
  -- ���� ����� ������������ PACKET, ����� ������������ RETURN FALSE
  -- ���������� BitStream ����� ��������, ��� ����� ����� ������ ��� ���������
end

function onIncomingRPC(bitStream, clientIP, clientPort)
  return true -- ���� �� ��������� TRUE, RPC �� ������������ ��������
  -- ���� ����� ������������ RPC, ����� ������������ RETURN FALSE
  -- ���������� BitStream ����� ��������, ��� ����� ����� ������ ��� ���������
end