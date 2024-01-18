ptask Player_MechanicUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;    
		
	if(IsRepairingVehicle(playerid))
	{
		static vehicleid,index;
		vehicleid = GetRepairVehicle(playerid);
		new
			id = Workshop_Nearest(playerid),
			is_owner = Workshop_IsOwner(playerid, id),
			repair_type = GetRepairType(playerid)
		;

		switch(repair_type)
		{
			case REPAIR_ENGINE:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal memperbaiki kendaraan, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal memperbaiki kendaraan, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memperbaiki kendaraan, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memperbaiki kendaraan, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						if((!IsABoat(vehicleid) && !IsABike(vehicleid) && !IsABicycle(vehicleid)) && !GetHoodStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memperbaiki kendaraan, kap kendaraan tertutup!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Memperbaiki ~y~mesin ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						if(!IsPlayerInDynamicArea(playerid, mechanic_zone_repair[0]) && !IsPlayerInDynamicArea(playerid, mechanic_zone_repair[1]) && !IsPlayerInDynamicArea(playerid, mechanic_zone_ship))
						{
							if((id = Workshop_Nearest(playerid)) != -1)
							{
								if(is_owner || Workshop_Employe(playerid, id))
								{
									if((index = Vehicle_ReturnID(vehicleid)) && VehicleData[index][vehEngineUpgrade] == 0)
									{
										SetVehicleHealth(vehicleid, 1000);
									}
									else
									{
										SetVehicleHealth(vehicleid, 2000);
									}

								}
								else
								{
									if((index = Vehicle_ReturnID(vehicleid)) && VehicleData[index][vehEngineUpgrade] == 0)
									{
										SetVehicleHealth(vehicleid, 500);
									}
									else
									{
										SetVehicleHealth(vehicleid, 1000);
									}						
								}
							}
							else 
							{
								if((index = Vehicle_ReturnID(vehicleid)) && VehicleData[index][vehEngineUpgrade] == 0)
								{
									SetVehicleHealth(vehicleid, 500);
								}
								else
								{
									SetVehicleHealth(vehicleid, 1000);
								}
							}
						}
						else 
						{
							if((index = Vehicle_ReturnID(vehicleid)) && VehicleData[index][vehEngineUpgrade] == 0)
							{
								SetVehicleHealth(vehicleid, 1000);
							}
							else
							{
								SetVehicleHealth(vehicleid, 2000);
							}	
						}

						Mechanic_AddEXP(playerid, ENGINE_EXP);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Engine ~g~Fixed!", 3000, 6);
						SendServerMessage(playerid, "Sukses memperbaiki "YELLOW"mesin "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_TIRE:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal memperbaiki ban kendaraan, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal memperbaiki ban kendaraan, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memperbaiki ban kendaraan, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memperbaiki ban kendaraan, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Memperbaiki ~y~ban ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						new panels, doors, lights, tires;
						GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
						UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 0);
						Mechanic_AddEXP(playerid, TIRE_EXP);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Tire ~g~Fixed!", 3000, 6);
						SendServerMessage(playerid, "Sukses memperbaiki "YELLOW"ban "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_BODY:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal memperbaiki body kendaraan, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal memperbaiki body kendaraan, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memperbaiki body kendaraan, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memperbaiki body kendaraan, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Memperbaiki ~y~body ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}
							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						ClearAnimations(playerid);
						UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);
						index = Vehicle_ReturnID(vehicleid);
						VehicleData[index][vehBodyRepair] = 1000.0;

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						Mechanic_AddEXP(playerid, BODY_EXP);
						GameTextForPlayer(playerid, "~w~Body ~g~Fixed!", 3000, 6);
						SendServerMessage(playerid, "Sukses memperbaiki "YELLOW"body "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_COLOR:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mewarnai kendaraan, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mewarnai kendaraan, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mewarnai kendaraan, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mewarnai kendaraan, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses ~y~mewarnai ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						if(!Inventory_Count(playerid, "Spray Can"))
							return ShowPlayerFooter(playerid, "Gagal mewarnai mewarnai kendaraan, Spray Can tidak ada!", 3000, 1), Mechanic_Reset(playerid);

						ClearAnimations(playerid);

						Vehicle_SetColor(vehicleid, GetPVarInt(playerid, "MechanicColor1"), GetPVarInt(playerid, "MechanicColor2"));
						Mechanic_AddEXP(playerid, COLOR_EXP);
						Inventory_Remove(playerid, "Spray Can", 1);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Respray ~g~Done!", 3000, 6);
						SendServerMessage(playerid, "Sukses "YELLOW"mewarnai body "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_PAINTJOB:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mengganti paintjob kendaraan, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mengganti paintjob kendaraan, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti paintjob kendaraan, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti paintjob kendaraan, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses melakukan ~y~paintjob ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						if(!Inventory_Count(playerid, "Spray Can"))
							return ShowPlayerFooter(playerid, "Gagal mewarnai paintjob kendaraan, Spray Can tidak ada!", 3000, 1), Mechanic_Reset(playerid);

						ClearAnimations(playerid);

						Vehicle_SetPaintjob(vehicleid, GetPVarInt(playerid, "MechanicPaintjob"));

						Mechanic_AddEXP(playerid, PAINTJOB_EXP);
						Inventory_Remove(playerid, "Spray Can", 1);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Paintjob ~g~Done!", 3000, 6);
						SendServerMessage(playerid, "Sukses melakukan "YELLOW"paintjob "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_WHEELS:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mengganti ban, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mengganti ban, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti ban, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti ban, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses mengganti ~y~ban ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
						Vehicle_AddComponent(vehicleid, GetPVarInt(playerid, "MechanicWheels"));
						Mechanic_AddEXP(playerid, TIRE_EXP);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Wheels ~g~changed!", 3000, 6);
						SendServerMessage(playerid, "Sukses mengganti "YELLOW"ban "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_HYDRAULIC:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal memasang hydraulics, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal memasang hydraulics, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memasang hydraulics, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal memasang hydraulics, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses pemasangan ~y~hydraulics ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
						Mechanic_AddEXP(playerid, HYDRAULIC_EXP);
						Vehicle_AddComponent(vehicleid, 1087);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Hydraulics ~g~installed!", 3000, 6);
						SendServerMessage(playerid, "Sukses memasang "YELLOW"hydraulics "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_ENGUPGRADE:
			{	
				//ngecheck pas masih proses
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mengupgrade engine, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal menguprade engine, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal menguprade engine, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal menguprade engine, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses pemasangan ~y~upgraded engine ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else //jalanin pas prosesnya kelar
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);

						//Tambahin EXP buat upgrade
						Mechanic_AddEXP(playerid, UPGRADE_EXP);
						//Ngeset variabel upgrade buat kendraannya 
						Vehicle_AddUpgrade(vehicleid, 1);
						SetVehicleHealth(vehicleid, 2000);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Engine ~g~Upgraded!", 3000, 6);
						SendServerMessage(playerid, "Sukses mengupgrade "YELLOW"engine "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_BODYUPGRADE:
			{	
				//ngecheck pas masih proses
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mengupgrade body, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mengupgrade body, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengupgrade body, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengupgrade body, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses pemasangan ~y~upgraded body ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else //jalanin pas prosesnya kelar
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);

						//Tambahin EXP buat upgrade
						Mechanic_AddEXP(playerid, UPGRADE_EXP);
						//Ngeset variabel upgrade buat kendraannya 
						Vehicle_AddUpgrade(vehicleid, 3);
						UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);
						index = Vehicle_ReturnID(vehicleid);
						VehicleData[index][vehBodyRepair] = 1000.0;

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Body ~g~Upgraded!", 3000, 6);
						SendServerMessage(playerid, "Sukses mengupgrade "YELLOW"Body "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_GASUPGRADE:
			{	
				//ngecheck pas masih proses
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mengganti component, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mengupgrade fuel tank, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengupgrade fuel tank, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengupgrade fuel tank, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses pemasangan ~y~upgraded fuel tank ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else //jalanin pas prosesnya kelar
					{
						ClearAnimations(playerid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);

						//Tambahin EXP buat upgrade
						Mechanic_AddEXP(playerid, UPGRADE_EXP);
						//Ngeset variabel upgrade buat kendraannya 
						Vehicle_AddUpgrade(vehicleid, 2);
						UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Fuel Tank ~g~Upgraded!", 3000, 6);
						SendServerMessage(playerid, "Sukses mengupgrade "YELLOW"Fuel Tank "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_MODIF:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mengganti component, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mengganti component, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti component, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti component, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses mengganti ~y~component ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						new componentid = GetPVarInt(playerid, "MechanicModif");

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						Vehicle_AddComponent(vehicleid, componentid);
						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
						Mechanic_AddEXP(playerid, MODIF_EXP);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						VehicleData[vehicleid][vehModSectionPreview] = 0;
						VehicleData[vehicleid][vehModCompPreview] = 0;
						GameTextForPlayer(playerid, "~w~Component ~g~changed!", 3000, 6);
						SendServerMessage(playerid, "Sukses mengganti "YELLOW"component "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_UNINSTALL_MOD:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mencopot component, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mencopot component, terlalu jauh dari kendaraan yang dicopot!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mencopot component, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mencopot component, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses mencopot ~y~component ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						new
							componentid = GetPVarInt(playerid, "MechanicUninstallCompMod")
						;

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}
							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						Vehicle_RemoveComponent(vehicleid, componentid);
						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Component ~r~removed!", 3000, 6);
						SendServerMessage(playerid, "Sukses mencopot "YELLOW"component "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_NEON:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal mengganti neon, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal mengganti neon, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti neon, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal mengganti neon, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses mengganti ~y~neon ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						new componentid = GetPVarInt(playerid, "MechanicNeon");
						index = Vehicle_ReturnID(vehicleid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						switch(componentid)
						{
							case 0:
							{
								if(VehicleData[index][vehNeonColor] > 0)
								{
									Vehicle_ReplaceNeon(vehicleid, 18647);
								}
								else
								{
									Vehicle_CreateNeon(vehicleid, 18647); //Mera
								}
							}
							case 1:
							{
								if(VehicleData[index][vehNeonColor] > 0)
								{
									Vehicle_ReplaceNeon(vehicleid, 18648);
								}
								else
								{
									Vehicle_CreateNeon(vehicleid, 18648); // Blue
								}
							}
							case 2:
							{
								if(VehicleData[index][vehNeonColor] > 0)
								{
									Vehicle_ReplaceNeon(vehicleid, 18651);
								}
								else
								{
									Vehicle_CreateNeon(vehicleid, 18651); //Pfrple
								}
							}
							case 3:
							{
								if(VehicleData[index][vehNeonColor] > 0)
								{
									Vehicle_ReplaceNeon(vehicleid, 18650);
								}
								else
								{
									Vehicle_CreateNeon(vehicleid, 18650); //Yellow
								}
							}
							case 4:
							{
								if(VehicleData[index][vehNeonColor] > 0)
								{
									Vehicle_ReplaceNeon(vehicleid, 18649);
								}
								else
								{
									Vehicle_CreateNeon(vehicleid, 18649); //Green
								}
							}
							case 5:
							{
								if(VehicleData[index][vehNeonColor] > 0)
								{
									Vehicle_ReplaceNeon(vehicleid, 18652);
								}
								else
								{
									Vehicle_CreateNeon(vehicleid, 18652);
								}
							}
							case 6:
							{
								if(VehicleData[index][vehNeonColor] > 0)
								{
									Vehicle_UninstallNeon(VehicleData[index][vehVehicleID]);
								}
								else
								{
									SendErrorMessage(playerid, "There is no neon installed on this vehicle");
								}
							}
						}

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
						Mechanic_AddEXP(playerid, MODIF_EXP);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Neon ~g~changed!", 3000, 6);
						SendServerMessage(playerid, "Sukses mengganti "YELLOW"Neon "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_TURBO:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal menginstall turbo, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal menginstall turbo, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal menginstall turbo, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal menginstall turbo, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses menginstall ~y~turbo ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						new componentid = GetPVarInt(playerid, "MechanicTurbo");
						index = Vehicle_ReturnID(vehicleid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						switch(componentid)
						{
							case 0:
							{
								VehicleData[index][vehTurbo] = 1;
							}
							case 1:
							{
								VehicleData[index][vehTurbo] = 2;
							}
							case 2:
							{
								VehicleData[index][vehTurbo] = 3;
							}
						}

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
						Mechanic_AddEXP(playerid, MODIF_EXP);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Turbo ~g~Installed!", 3000, 6);
						SendServerMessage(playerid, "Sukses menginstall "YELLOW"Turbo "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
			case REPAIR_INTERIM_MT, REPAIR_FULL_MT:
			{
				if(GetRepairTime(playerid))
				{
					SetRepairTime(playerid, GetRepairTime(playerid) - 1);
					
					if(GetRepairTime(playerid))
					{
						if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
							return ShowPlayerFooter(playerid, "Gagal maintenance, kondisi player berubah!", 3000, 1), Mechanic_Reset(playerid);

						if(Vehicle_Nearest(playerid, 5) != vehicleid)
							return ShowPlayerFooter(playerid, "Gagal maintenance, terlalu jauh dari kendaraan yang diperbaiki!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsValidVehicle(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal maintenance, kendaraan menghilang!", 3000, 1), Mechanic_Reset(playerid);

						if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
							return ShowPlayerFooter(playerid, "Gagal maintenance, mesin kendaraan menyala!", 3000, 1), Mechanic_Reset(playerid);

						ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Proses ~y~maintenance ~w~kendaraan ~g~%d detik ~w~lagi ...", GetRepairTime(playerid)), 1000);
					}
					else
					{
						ClearAnimations(playerid);

						index = Vehicle_ReturnID(vehicleid);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								if(WorkshopData[id][wComponent] < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponent yang ada di workshop tidak mencukupi (%d component)!", WorkshopData[id][wComponent]);
								}
							}
							else
							{
								if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
								{
									Mechanic_Reset(playerid);
									return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
								}

							}
						}
						else
						{
							if(Inventory_Count(playerid, "Component") < GetRepairComponent(playerid))
							{
								Mechanic_Reset(playerid);
								return SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!.", GetRepairComponent(playerid));
							}
						}

						new
							accumulated_mileage = Vehicle_GetAccumulatedMileage(vehicleid),
							current_mileage = Vehicle_GetCurrentMileage(vehicleid)
						;

						if (repair_type == REPAIR_INTERIM_MT)
						{
							if (current_mileage > 50)
							{
								Vehicle_ReduceCurrentMileage(vehicleid, (SAFE_MILEAGE / 2));
								Vehicle_AddDurabilityMileage(vehicleid, (SAFE_MILEAGE / 2));
							}
							else
							{
								Vehicle_SetCurrentMileage(vehicleid, 0.0);
								Vehicle_SetDurabilityMileage(vehicleid, SAFE_MILEAGE);
							}
						}
						else
						{
							Vehicle_SetCurrentMileage(vehicleid, 0.0);
							Vehicle_SetDurabilityMileage(vehicleid, SAFE_MILEAGE);
						}

						Vehicle_SetAccumulatedMileage(vehicleid, accumulated_mileage + current_mileage);
						Vehicle_Save(vehicleid);

						ClearAnimations(playerid);
						PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
						Mechanic_AddEXP(playerid, MAINTENANCE_EXP);

						if((id = Workshop_Nearest(playerid)) != -1)
						{
							if(is_owner || Workshop_Employe(playerid, id))
							{
								WorkshopData[id][wComponent] -= GetRepairComponent(playerid);
							}
							else
							{
								Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
							}
						}
						else
						{
							Inventory_Remove(playerid, "Component", GetRepairComponent(playerid));
						}

						GameTextForPlayer(playerid, "~w~Maintenance ~g~Finished!", 3000, 6);
						SendServerMessage(playerid, "Sukses "YELLOW"maintenance "WHITE"kendaraan "CYAN"%s!", GetVehicleNameByVehicle(vehicleid));

						Mechanic_Reset(playerid);
					}
				}
			}
		}
	}
	return 1;
}
