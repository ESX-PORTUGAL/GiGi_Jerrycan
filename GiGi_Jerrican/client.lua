  ESX = nil
  local PlayerData = {}

  Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
		  PlayerData = ESX.GetPlayerData()
	   end
   end)

  function hintToDisplay(text)
	  SetTextComponentFormat("STRING")
	  AddTextComponentString(text)
   end

local BombasGasolina = {
[1] =  { x =  265.93,   y = 2598.23,   z= 44.00},
[2] =  { x =  1039.18,  y = 2664.51,   z= 38.80},
[3] =  { x =  1202.03,  y = 2654.3,    z= 37.00},
[4] =  { x =  2673.77,  y = 3266.88,   z= 54.60},
[5] =  { x =  46.38165, y = 2788.985,  z= 57.25},
[6] =  { x =  2001.67,  y = 3779.96,   z= 31.60},
[7] =  { x =  1705.941, y = 6425.467,  z= 32.10},
[8] =  { x =  161.6476, y = 6636.276,  z= 31.00},
[9] =  { x = -92.71315, y = 6409.929,  z= 31.00},
[10] = { x = -1428.294, y = -268.493,  z= 45.50},
[11] = { x = -2073.929, y = -327.205,  z= 12.65},
[12] = { x = -531.2448, y = -1220.597, z= 17.80},
[13] = { x =  818.1863, y = -1040.818, z= 26.00},
[14] = { x =  1211.178, y = -1389.252, z= 34.80},
[15] = { x =  641.8681, y =  260.6178, z= 102.50},
[16] = { x =  2559.545, y =  373.7634, z= 108.00},
}

  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(0)
		  for index, value in pairs(BombasGasolina) do
			  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, value.x, value.y, value.z)
			  if dist < 7.5 then
				  DrawText3Ds(value.x, value.y, value.z + 1.0, 'Comprar [~g~E~s~] Jerrican')
				  if dist <= 1.5 then
					  if IsControlJustPressed(0,38) then
						  OpenMenu()
					   end
				   end
			   end
		   end
	   end
   end)

   function OpenMenu()
	  ESX.UI.Menu.CloseAll()
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'GiGi_Jerrican',
		  {
			  title    = 'Bem Vindo',
			  align    = 'top-right',
			  elements = {
			  {label = 'Jerrican (25$)'},
			 }
		  },
		  function(data, menu)
			  RequestAnimDict("anim@move_m@trash")
              while not HasAnimDictLoaded("anim@move_m@trash") do
              Citizen.Wait(0)
              end
              TaskPlayAnim(GetPlayerPed(-1),'anim@move_m@trash', 'pickup', 1.0, -1.0, 1.0, 0, 0, 0, 0, 0 )
			  exports['mythic_notify']:DoHudText('success', 'Compras te um Jerrican (25$)')
			  ESX.UI.Menu.CloseAll()
			  TriggerServerEvent('GiGi_Jerrican:buy', 1)
		  end,
	     function(data, menu)
		  menu.close()
	  end)
   end

  function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.030, 66, 66, 66, 150)
 end
