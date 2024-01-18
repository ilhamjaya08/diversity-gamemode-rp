// ========================[ DIALOG RESPONSE ]========================
Dialog:MechanicMenu(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		//Kalau tidak di workshop dan bukan employee atau owner workshop
		new
			work_time,
			required_component,
			menu_id = strval(inputtext),
			nearest_workshop = Workshop_Nearest(playerid),
			is_at_workshop = nearest_workshop != -1,
			is_part_of_workshop = is_at_workshop ? Workshop_IsOwner(playerid, nearest_workshop) || Workshop_Employe(playerid, nearest_workshop) : false,
			workshop_component = is_at_workshop ? WorkshopData[nearest_workshop][wComponent] : 0,
			has_spray_can = Inventory_Count(playerid, "Spray Can") > 0,
			mechanic_component = Inventory_Count(playerid, "Component"),
			is_at_mechanic_center = (IsPlayerInDynamicArea(playerid, mechanic_zone_repair[0]) || IsPlayerInDynamicArea(playerid, mechanic_zone_repair[1]) || IsPlayerInDynamicArea(playerid, mechanic_zone_ship)),
			repair_vehicleid = GetRepairVehicle(playerid),
			has_any_preview_mod = (VehicleData[repair_vehicleid][vehModSectionPreview] || VehicleData[repair_vehicleid][vehModCompPreview]),
			is_insufficient_component
		;

		// Jika tidak memilih menu-nya, maka tidak ada aksi lanjutan.
		if (menu_id < 1)
		{
			SetRepairVehicle(playerid, 0);
			return 1;
		}

		// Tidak boleh mengakses menu lain jika kendaraan tersebut masih ada preview mod.
		if (menu_id != MECH_MENU_ID_MODIF && has_any_preview_mod)
		{
			ShowPlayerFooter(playerid, "Anda harus tetapkan (~g~/mm applymod~w~) atau batalkan (~r~/mm cancelmod~w~) preview mod kendaraan ini~n~sebelum mengakses menu lainnya!", 3000, 1);
			cmd_mechanicmenu(playerid, "");
			return 1;
		}

		// Melakukan tindakan mekanik sesuai dengan ID menu-nya.
		switch (menu_id)
		{
			case MECH_MENU_ID_CHANGE_COLOR, MECH_MENU_ID_CHANGE_PAINTJOB:
			{
				// Harus berada di mechanic center atau workshop.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menentukan waktu pengerjaan.
				work_time = 30;
				// Mendapatkan komponen yang dibutuhkan (sesuai dengan ID menu-nya).
				required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Hanya bisa mengubah warna kendaraan (termasuk paintjob) di workshop yang bukan tempat bekerjanya.
				if (is_at_workshop && !is_part_of_workshop)
				{
					SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini untuk mengubah warna kendaraan!");
					return 1;
				}

				// Hanya bisa mengubah warna kendaraan (termasuk paintjob) di mechanic center.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					SendErrorMessage(playerid, "Anda tidak bisa mengubah warna kendaraan di luar mechanic center atau di workshop tempat Anda bekerja!");
					return 1;
				}

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (is_at_mechanic_center && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				// Harus memiliki spray can.
				if (!has_spray_can)
				{
					ShowPlayerFooter(playerid, "Beli '~y~Spray Can~w~' terlebih dahulu!", 3000, 1);
					return 1;
				}

				// Munculkan dialog.
				if (menu_id == MECH_MENU_ID_CHANGE_COLOR)
				{
					Dialog_Show(playerid, MechanicColor, DIALOG_STYLE_INPUT, "Mechanic Menu - Change Color", WHITE"Kamu akan mewarnai kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pewarnaan: "YELLOW"%d detik\n\n"WHITE"Masukkan warna dengan format: "RED"warna1,warna2 "WHITE"misalkan "GREEN"1,3?", "Spray", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
				}
				else
				{
					Dialog_Show(playerid, MechanicPaintjob, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Change Paintjob", WHITE"Kamu akan mewarnai (paintjob) kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pewarnaan: "YELLOW"%d detik\n\n"WHITE"Apa kamu ingin melanjutkan proses pergantian paintjob?", "Paintjob", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
				}
			}
			case MECH_MENU_ID_REPAIR_TIRE, MECH_MENU_ID_REPAIR_BODY:
			{
				// Harus berada di mechanic center atau workshop.
				if (menu_id != MECH_MENU_ID_REPAIR_TIRE && !is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menyimpan state ban kendaraan.
				new panels, doors, lights, tires;

				// Menentukan waktu pengerjaan.
				work_time = 30;
				// Mendapatkan komponen yang dibutuhkan (sesuai dengan ID menu-nya).
				required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);
				// Mendapatkan state status damage kendaraannya.
				GetVehicleDamageStatus(repair_vehicleid, panels, doors, lights, tires);

				if (menu_id == MECH_MENU_ID_REPAIR_TIRE)
				{
					// Hanya untuk kendaraan yang memiliki ban.
					if (!IsVehicleHasTire(repair_vehicleid))
					{
						ShowPlayerFooter(playerid, "Kendaraan ini tidak memiliki ban!.", 3000, 1);
						return 1;
					}

					// Tidak perlu perbaikan jika bannya masih bagus.
					if (!tires)
					{
						ShowPlayerFooter(playerid, "Ban kendaraan dalam keadaan bagus!.", 3000, 1);
						return 1;
					}
				}
				else
				{
					// Hanya bisa memperbaiki body kendaraan di workshop yang bukan tempat bekerjanya.
					if (is_at_workshop && !is_part_of_workshop)
					{
						SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini untuk memperbaiki body kendaraan!");
						return 1;
					}

					// Hanya bisa memperbaiki body kendaraan di mechanic center.
					if (!is_at_workshop && !is_at_mechanic_center)
					{
						SendErrorMessage(playerid, "Anda tidak bisa memperbaiki body kendaraan di luar mechanic center atau di workshop tempat Anda bekerja!");
						return 1;
					}

					// Tidak perlu perbaikan jika bannya masih bagus.
					if (!panels && !doors && !lights)
					{
						ShowPlayerFooter(playerid, "Body kendaraan dalam keadaan bagus!.", 3000, 1);
						return 1;
					}
				}

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop && is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (is_at_mechanic_center && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				// Munculkan dialog.
				if (menu_id == MECH_MENU_ID_REPAIR_TIRE)
				{
					Dialog_Show(playerid, MechanicTire, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Repair Tire", WHITE"Kamu akan memperbaiki ban kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu perbaikan: "YELLOW"%d detik\n\n"WHITE"Apakah kamu yakin ingin memperbaiki ban kendaraan ini?", "Fix", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
				}
				else
				{
					Dialog_Show(playerid, MechanicBody, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Repair Body", WHITE"Kamu akan memperbaiki kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu perbaikan: "YELLOW"%d detik\n\n"WHITE"Apakah kamu yakin ingin memperbaiki body kendaraan ini?", "Fix", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
				}
			}
			case MECH_MENU_ID_HALF_REPAIR_ENGINE, MECH_MENU_ID_REPAIR_ENGINE:
			{
				// Harus berada di mechanic center atau workshop.
				if (menu_id != MECH_MENU_ID_HALF_REPAIR_ENGINE && !is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menghitung komponen yang diperlukan dan waktu pengerjaannya untuk repair engine.
				Mechanic_CalculateRepairEngine(playerid, repair_vehicleid, required_component, work_time);

				// Jika tidak mendapatkan komponen dan waktu pengerjaan yang diperlukan, akan dianggap tidak bisa melakukan repair.
				if (!required_component && !work_time)
				{
					ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa diperbaiki!", 3000, 1);
					return 1;
				}

				// Jika hasil perhitungan tidak mendapatkan hasil kalkulasi komponen, maka diambil dari penetapan di /mechanicmenu.
				if (!required_component)
				{
					required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				}

				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop && is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (!is_at_workshop && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				Dialog_Show(playerid, MechanicEngine, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Repair Engine", WHITE"Kamu akan memperbaiki kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu perbaikan: "YELLOW"%d detik\n\n"WHITE"Apakah kamu yakin ingin memperbaiki kendaraan ini?", "Repair", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
			}
			case MECH_MENU_ID_INSTALL_HYDRAULICS, MECH_MENU_ID_CHANGE_WHEELS, MECH_MENU_ID_UPGRADE:
			{
				// Harus berada di mechanic center atau workshop.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menentukan waktu pengerjaan.
				work_time = 30;
				// Mendapatkan komponen yang dibutuhkan (sesuai dengan ID menu-nya).
				required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Hanya bisa mengubah komponen kendaraan di workshop yang bukan tempat bekerjanya.
				if (is_at_workshop && !is_part_of_workshop)
				{
					SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini untuk mengubah komponen kendaraan!");
					return 1;
				}

				// Hanya bisa mengubah komponen kendaraan di mechanic center.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					SendErrorMessage(playerid, "Anda tidak bisa mengubah komponen kendaraan di luar mechanic center atau di workshop tempat Anda bekerja!");
					return 1;
				}

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop && is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (is_at_mechanic_center && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				if (menu_id == MECH_MENU_ID_INSTALL_HYDRAULICS)
				{
					Dialog_Show(playerid, MechanicHydraulics, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Install Hydraulics", WHITE"Kamu akan memasangkan hydraulics kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pemasangan: "YELLOW"%d detik\n\n"WHITE"Apa kamu ingin melanjutkan proses pemasangan hydraulics?", "Install", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
				}
				if (menu_id == MECH_MENU_ID_CHANGE_WHEELS)
				{
					Dialog_Show(playerid, MechanicWheels, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Change Wheel", WHITE"Kamu akan mengganti roda kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pemasangan: "YELLOW"%d detik\n\n"WHITE"Apakah kamu setuju untuk mengganti roda kendaraan tersebut?", "Change", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
				}
				if (menu_id == MECH_MENU_ID_UPGRADE)
				{
					Dialog_Show(playerid, MechanicUpgrade, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Upgrade Engine", WHITE"Kamu akan mengupgrade engine kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pemasangan: "YELLOW"%d detik\n\n"WHITE"Apa kamu ingin melanjutkan proses pemasangan engine?", "Install", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
				}
			}
			case MECH_MENU_ID_MODIF:
			{
				// Harus berada di mechanic center atau workshop.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menentukan waktu pengerjaan.
				work_time = 30;
				// Mendapatkan komponen yang dibutuhkan (sesuai dengan ID menu-nya).
				required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Hanya bisa mengubah komponen kendaraan di workshop yang bukan tempat bekerjanya.
				if (is_at_workshop && !is_part_of_workshop)
				{
					SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini untuk mengubah komponen kendaraan!");
					return 1;
				}

				// Hanya bisa mengubah komponen kendaraan di mechanic center.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					SendErrorMessage(playerid, "Anda tidak bisa mengubah komponen kendaraan di luar mechanic center atau di workshop tempat Anda bekerja!");
					return 1;
				}

				// Tidak diperbolehkan memodifikasi kendaraan jika tidak mungkin dimodifikasi.
				if (!Vehicle_HasAnyModableComponent(repair_vehicleid))
				{
					ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa dimodifikasi!");
					return 1;
				}

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop && is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (is_at_mechanic_center && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				Dialog_Show(playerid, VehicleMod, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Vehicle Modification", WHITE"Kamu akan mengganti komponen kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pemasangan: "YELLOW"%d detik\n\n"WHITE"Apa kamu ingin melanjutkan proses pemasangan engine?", "Install", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
			}
			case MECH_MENU_ID_UNINSTALL_MODIF:
			{
				// Harus berada di mechanic center atau workshop.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menentukan waktu pengerjaan.
				work_time = 30;
				// Mendapatkan komponen yang dibutuhkan (sesuai dengan ID menu-nya).
				required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Hanya bisa mengubah komponen kendaraan di workshop yang bukan tempat bekerjanya.
				if (is_at_workshop && !is_part_of_workshop)
				{
					SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini untuk mengubah komponen kendaraan!");
					return 1;
				}

				// Hanya bisa mengubah komponen kendaraan di mechanic center.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					SendErrorMessage(playerid, "Anda tidak bisa mengubah komponen kendaraan di luar mechanic center atau di workshop tempat Anda bekerja!");
					return 1;
				}

				// Tidak diperbolehkan memodifikasi kendaraan jika tidak mungkin dimodifikasi.
				if (!Vehicle_HasAnyModableComponent(repair_vehicleid))
				{
					ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa dimodifikasi!");
					return 1;
				}

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop && is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (is_at_mechanic_center && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				Dialog_Show(playerid, VehicleUninstallMod, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Uninstall Vehicle Modification", WHITE"Kamu akan mencopot modifikasi kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pemasangan: "YELLOW"%d detik\n\n"WHITE"Apa kamu ingin melanjutkan proses pencopotan modifikasi?", "Install", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
			}
			case MECH_MENU_ID_NEON:
			{
				// Harus berada di mechanic center atau workshop.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menentukan waktu pengerjaan.
				work_time = 30;
				// Mendapatkan komponen yang dibutuhkan (sesuai dengan ID menu-nya).
				required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Hanya bisa memasang neon kendaraan di workshop yang bukan tempat bekerjanya.
				if (is_at_workshop && !is_part_of_workshop)
				{
					SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini untuk memasang neon kendaraan!");
					return 1;
				}

				// Hanya bisa memasang neon kendaraan di mechanic center.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					SendErrorMessage(playerid, "Anda tidak bisa memasang neon kendaraan di luar mechanic center atau di workshop tempat Anda bekerja!");
					return 1;
				}

				// Tidak diperbolehkan memasang neon selain di kendaraan darat
				if(!IsFourWheelVehicle(repair_vehicleid))
				{
					ShowPlayerFooter(playerid, "Tidak bisa memasang neon pada jenis kendaraan ini!");
					return 1;
				}

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop && is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (is_at_mechanic_center && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				Dialog_Show(playerid, VehicleNeon, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Vehicle Neon", WHITE"Kamu akan mengganti neon kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pemasangan: "YELLOW"%d detik\n\n"WHITE"Apa kamu ingin melanjutkan proses pemasangan engine?", "Install", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
			}
			case MECH_MENU_ID_TURBO:
			{
				// Harus berada di mechanic center atau workshop.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				// Menentukan waktu pengerjaan.
				work_time = 30;
				// Mendapatkan komponen yang dibutuhkan (sesuai dengan ID menu-nya).
				required_component = Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:menu_id);
				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				// Hanya bisa memasang neon kendaraan di workshop yang bukan tempat bekerjanya.
				if (is_at_workshop && !is_part_of_workshop)
				{
					SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini untuk menginstall turbo kendaraan!");
					return 1;
				}

				// Hanya bisa memasang neon kendaraan di mechanic center.
				if (!is_at_workshop && !is_at_mechanic_center)
				{
					SendErrorMessage(playerid, "Anda tidak bisa menginstall turbo kendaraan di luar mechanic center atau di workshop tempat Anda bekerja!");
					return 1;
				}

				// Tidak diperbolehkan memasang neon selain di kendaraan darat
				if(!IsSportCar(repair_vehicleid))
				{
					ShowPlayerFooter(playerid, "Tidak bisa menginstall turbo pada jenis kendaraan ini!");
					return 1;
				}

				// Menetapkan waktu pengerjaan.
				SetRepairTime(playerid, work_time);
				// Menetapkan component yang dibutuhkan.
				SetRepairComponent(playerid, required_component);

				// Blok ini untuk player yang berada di workshop terdekat.
				if (is_at_workshop)
				{
					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (is_part_of_workshop && (workshop_component < required_component))
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}

					// Untuk player yang bukan bagian dari workshop, namun komponen di inventory kurang.
					if (!is_part_of_workshop && is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				// Jika di mechanic center, harus memiliki komponen yang cukup.
				if (is_at_mechanic_center && is_insufficient_component)
				{
					SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
					return 1;
				}

				Dialog_Show(playerid, MechanicTurbo, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Vehicle Turbo", WHITE"Kamu akan menginstall turbo kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu pemasangan: "YELLOW"%d detik\n\n"WHITE"Apa kamu ingin melanjutkan proses pemasangan engine?", "Install", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
			}
			case MECH_MENU_ID_INTERIM_MT, MECH_MENU_ID_FULL_MT:
			{
				// Harus berada di mechanic center atau workshop.
				if (menu_id != MECH_MENU_ID_INTERIM_MT && !is_at_workshop && !is_at_mechanic_center)
				{
					ShowPlayerFooter(playerid, "Anda ~g~harus berada ~w~di ~y~mechanic center ~w~atau ~y~workshop~w~!", 3000, 1);
					return 1;
				}

				new
					interim_mt_component,
					interim_mt_work_time,
					full_mt_component,
					full_mt_work_time
				;

				// Menghitung komponen yang diperlukan dan waktu pengerjaannya untuk repair engine.
				Mechanic_CalculateMaintenance(playerid, repair_vehicleid, interim_mt_component, interim_mt_work_time, full_mt_component, full_mt_work_time);

				// Jika kondisi kendaraan dalam keadaan prima, maka servis ini tidak diperlukan
				if (!interim_mt_component && !full_mt_component)
				{
					ShowPlayerFooter(playerid, "Kendaraan ini dalam kondisi baik!", 3000, 1);
					return 1;
				}

				if (menu_id == MECH_MENU_ID_INTERIM_MT)
				{
					SetRepairComponent(playerid, interim_mt_component);
					SetRepairTime(playerid, interim_mt_work_time);

					required_component = interim_mt_component;
					work_time = interim_mt_work_time;

					SetRepairingVehicle(playerid, 0);
					SetRepairType(playerid, REPAIR_INTERIM_MT);
				}
				else
				{
					SetRepairComponent(playerid, full_mt_component);
					SetRepairTime(playerid, full_mt_work_time);

					required_component = full_mt_component;
					work_time = full_mt_work_time;

					SetRepairingVehicle(playerid, 0);
					SetRepairType(playerid, REPAIR_FULL_MT);
				}

				// Memeriksa apakah component yang dibutuhkan mencukupi atau tida.
				is_insufficient_component = (mechanic_component < required_component);

				if (!IsABike(repair_vehicleid) && !is_at_workshop && !is_at_mechanic_center)
				{
					SendErrorMessage(playerid, "Anda harus berada di mechanic center atau workshop!");
					return 1;
				}
				// Blok ini untuk player yang berada di workshop terdekat.
				else if (is_at_workshop)
				{
					// Mekanik non pegawai workshop tidak boleh servis kendaraan di workshop tersebut.
					if (!is_part_of_workshop)
					{
						SendErrorMessage(playerid, "Anda bukan pegawai di workshop ini!");
						return 1;
					}

					// Untuk player yang merupakan bagian dari workshop, namun komponen workshop-nya kurang.
					if (workshop_component < required_component)
					{
						SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
						return 1;
					}
				}
				else
				{
					// Harus memiliki komponen yang cukup.
					if (is_insufficient_component)
					{
						SendErrorMessage(playerid, "Komponen yang kamu punya tidak mencukupi (%d component)!", mechanic_component);
						return 1;
					}
				}

				Dialog_Show(playerid, MechanicMaintenance, DIALOG_STYLE_MSGBOX, "Mechanic Menu - Maintenance", WHITE"Kamu akan melakukan servis untuk kendaraan: "CYAN"%s\n"WHITE"Komponen yang digunakan: "YELLOW"%d komponen\n"WHITE"Estimasi waktu perbaikan: "YELLOW"%d detik\n\n"WHITE"Apakah kamu yakin ingin melakukan servis untuk kendaraan ini?", "Repair", "Close", GetVehicleNameByVehicle(repair_vehicleid), required_component, work_time);
			}
		}
	}

	return 1;
}
Dialog:MechanicTurbo(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, MechanicTurboList, DIALOG_STYLE_LIST, "Turbo List", "Turbo Level 1\nTurbo Level 2 +1000 Component\nTurbo Level 3 +2000 Component", "Install", "Close");
	}
	return 1;
}
Dialog:MechanicTurboList(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			nearest_workshop = Workshop_Nearest(playerid),
			is_at_workshop = nearest_workshop != -1, 
			vehicleid = GetPVarInt(playerid, "MechanicVehicle"),
			required_component = GetRepairComponent(playerid),
			is_part_of_workshop = is_at_workshop ? Workshop_IsOwner(playerid, nearest_workshop) || Workshop_Employe(playerid, nearest_workshop) : false,
			workshop_component = is_at_workshop ? WorkshopData[nearest_workshop][wComponent] : 0
		;

		switch(listitem)
		{
			case 0:
			{
				//turbo level 1
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_TURBO);
				SetPVarInt(playerid, "MechanicTurbo", listitem);
				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"menginstall turbo "LIGHTBLUE"charge "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai menginstall "YELLOW"turbo "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 1:
			{		
				//Turbo level 2
				if (is_part_of_workshop && (workshop_component < required_component+1000))
				{
					SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
					return 1;
				}
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_TURBO);
				SetPVarInt(playerid, "MechanicTurbo", listitem);
				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"menginstall turbo"LIGHTBLUE"charge level 2 "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai menginstall "YELLOW"turbo"WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 2:
			{
				if (is_part_of_workshop && (workshop_component < required_component+2000))
				{
					SendErrorMessage(playerid, "Komponen yang ada di workshop tidak mencukupi (%d component)!", workshop_component);
					return 1;
				}
				//Turbo Level3
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_TURBO);
				SetPVarInt(playerid, "MechanicTurbo", listitem);
				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"menginstall turbo"LIGHTBLUE"charge level 3 "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai menginstall "YELLOW"turbo "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
		}
	}
	return 1;
}
Dialog:MechanicUpgradeList(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static index;
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");
		switch(listitem)
		{
			case 0:
			{
		
				if((index = Vehicle_ReturnID(vehicleid)) && VehicleData[index][vehEngineUpgrade] == 1) return SendServerMessage(playerid, "Mesin kendaraan "YELLOW"%s "WHITE"sudah di upgrade!", GetVehicleNameByVehicle(vehicleid));
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_ENGUPGRADE);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"mengupgrade "LIGHTBLUE"engine "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai mengupgrade "YELLOW"engine "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 1:
			{		
				if((index = Vehicle_ReturnID(vehicleid)) && VehicleData[index][vehGasUpgrade] == 2) return SendServerMessage(playerid, "Fuel tank kendaraan "YELLOW"%s "WHITE"sudah di upgrade!", GetVehicleNameByVehicle(vehicleid));
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_GASUPGRADE);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"mengupgrade "LIGHTBLUE"fuel tank "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai mengupgrade "YELLOW"fuel tank "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 2:
			{
				//Body upgrade
				if((index = Vehicle_ReturnID(vehicleid)) && VehicleData[index][vehBodyUpgrade] == 3) return SendServerMessage(playerid, "Body kendaraan "YELLOW"%s "WHITE"sudah di upgrade!", GetVehicleNameByVehicle(vehicleid));
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_BODYUPGRADE);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"mengupgrade "LIGHTBLUE"body "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai mengupgrade "YELLOW"body "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
		}
	}
	return 1;
}
Dialog:MechTune_ChooseComponent(playerid, response, listitem, inputtext[])
{
	new
		// Mendapatkan ID vehicle yang ingin dimodif.
		vehicleid = GetPVarInt(playerid, "MechanicVehicle"),
		// Mendapatkan ID component mod yang dipilih
		componentid = strval(inputtext),
		// Untuk menyimpan section yang bisa di-mod
		section_list[256]
	;

	// Mendapatkan list section yang bisa di-mod.
	Vehicle_GetModableSection(vehicleid, section_list);

	if (!response)
	{
		Dialog_Show(playerid, MechTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		return 1;
	}

	if (strlen(inputtext) < 1)
	{
		ShowPlayerFooter(playerid, "Anda belum memilih component!");
		Dialog_Show(playerid, MechTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		return 1;
	}

	if (!IsModValid(vehicleid, componentid))
	{
		ShowPlayerFooter(playerid, "Component ini tidak dapat dipasang di kendaraan ini!");
		Dialog_Show(playerid, MechTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		return 1;
	}

	new mod_section = VehicleMod_GetComponentSection(componentid);

	if (!mod_section)
	{
		ShowPlayerFooter(playerid, "Component ini tidak valid!");
		Dialog_Show(playerid, MechTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		return 1;
	}

	SendClientMessageEx(playerid, -1, "preview section: %d | preview componentid: %d | selected section: %d | selection componentid: %d",
		VehicleData[vehicleid][vehModSectionPreview],
		VehicleData[vehicleid][vehModCompPreview],
		mod_section,
		componentid
	);

	if (VehicleData[vehicleid][vehModCompPreview] >= 1000 && VehicleData[vehicleid][vehModCompPreview] <= MAX_VEHICLE_MOD_ID) {
		Mechanic_CancelMod(playerid, vehicleid);
	}

	VehicleData[vehicleid][vehModSectionPreview] = mod_section;
	VehicleData[vehicleid][vehModCompPreview] = componentid;

	if (mod_section == VEHICLE_MOD_SECTION_SIDESKIRT)
	{
		VehicleMod_ApplySideskirt(vehicleid, componentid);
	}
	else
	{
		AddVehicleComponent(vehicleid, componentid);
	}

	if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
	{
		SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang pratinjau (preview) komponen kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));
	}

	SendServerMessage(playerid, "Anda memasang pratinjau (preview) "YELLOW"component "WHITE"di kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	SendServerMessage(playerid, "Gunakan "YELLOW"/mm applymod "WHITE"untuk memasang permanen di kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	return 1;
}
Dialog:MechTune_ChooseSection(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		return 1;
	}

	if (strlen(inputtext) < 1)
	{
		return 1;
	}

	new
		// Mendapatkan ID vehicle yang ingin dimodif.
		vehicleid = GetPVarInt(playerid, "MechanicVehicle"),
		// Mendapatkan section mod yang dipilih
		section = strval(inputtext)
	;

	if (!Vehicle_IsModSectionModable(vehicleid, section))
	{
		ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa dimodifikasi!");
		return 1;
	}

	new modable_components[512];

	if (section == VEHICLE_MOD_SECTION_WHEELS)
	{
		Vehicle_GetModableComponent(vehicleid, section, true, modable_components);
		ShowPlayerDialog(playerid, DIALOG_MOD_SELECT_WHEELS, DIALOG_STYLE_PREVIEW_MODEL, "Available Components", modable_components, "Select", "Close");
	}
	else
	{
		Vehicle_GetModableComponent(vehicleid, section, false, modable_components);
		Dialog_Show(playerid, MechTune_ChooseComponent, DIALOG_STYLE_TABLIST_HEADERS, "Available Components", modable_components, "Select", "Cancel");
	}

	return 1;
}
Dialog:MechTune_ConfRemoveMod(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		return 1;
	}

	if (!IsPlayerConnected(playerid))
	{
		return 1;
	}

	if(IsRepairingVehicle(playerid))
	{
		ShowPlayerFooter(playerid, "Anda sedang memperbaiki kendaraan!", 3000, 1);
		return 1;
	}

	// Mendapatkan ID kendaraan yang ingin diperbaiki.
	new
		nearest_vehicleid = Vehicle_Nearest(playerid, 5),
		vehicleid = GetPVarInt(playerid, "MechanicVehicle")
	;

	if (vehicleid < 1 || vehicleid == INVALID_VEHICLE_ID || nearest_vehicleid != vehicleid)
	{
		ShowPlayerFooter(playerid, "Tidak ada kendaraan terdekat!", 3000, 1);
		return 1;
	}

	new
		componentid = GetPVarInt(playerid, "MechanicUninstallCompMod")
	;

	if (componentid < 1000 || componentid > MAX_VEHICLE_MOD_ID)
	{
		ShowPlayerFooter(playerid, "Anda belum memilih modifikasi yang ingin dicopot!", 3000, 1);
		return 1;
	}

	SetRepairingVehicle(playerid, 1);
	SetRepairType(playerid, REPAIR_UNINSTALL_MOD);

	if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
	{
		SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"mencopot komponen kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));
	}

	SendServerMessage(playerid, "Mulai mencopot "YELLOW"komponen "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	return 1;
}
Dialog:MechTune_RemoveMod(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		return 1;
	}

	if (strlen(inputtext) < 1)
	{
		return 1;
	}

	new
		// Mendapatkan ID vehicle yang ingin dimodif.
		vehicleid = GetPVarInt(playerid, "MechanicVehicle"),
		// Mendapatkan section mod yang dipilih
		section = strval(inputtext)
	;

	// Tidak akan memunculkan dialog jika tidak ada mod apapun yang terpasang.
	if (Vehicle_CountInstalledMod(vehicleid) == 0)
	{
		ShowPlayerFooter(playerid, "Kendaraan ini tidak ada modifikasinya!");
		return 1;
	}

	// Tidak akan memunculkan dialog jika tidak ada mod yang terpasang di section tertentu.
	if (!Vehicle_HasInstalledMod(vehicleid, section))
	{
		ShowPlayerFooter(playerid, "Kendaraan ini tidak ada modifikasinya di section ini!");
		return 1;
	}

	new
		mod_name[64],
		componentid = VehicleData[vehicleid][vehMod][section]
	;

	// Menyimpan PVar untuk section yang ingin dihapus mod-nya.
	SetPVarInt(playerid, "MechanicUninstallCompSection", section);
	SetPVarInt(playerid, "MechanicUninstallCompMod", componentid);

	// Mendapatkan nama component mod-nya.
	VehicleMod_GetComponentName(componentid, true, mod_name);

	// Memunculkan dialog konfirmasi.
	Dialog_Show(playerid, MechTune_ConfRemoveMod, DIALOG_STYLE_MSGBOX, "Confirm Uninstall Mod", "Anda akan mencopot modifikasi kendaraan "YELLOW"%s"WHITE" dari kendaraan "CYAN"%s.\nApakah Anda yakin?", "Ya", "Tidak", mod_name, GetVehicleNameByVehicle(vehicleid));

	return 1;
}
//List Neon
Dialog:VehicleNeon(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, VehicleNeonList, DIALOG_STYLE_LIST, "Neon Color", "Red\nBlue\nPfrple\nYellow\nGreen\nWhite\nUninstall", "Install", "Close");
	}
	return 1;
}
Dialog:VehicleNeonList(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");
		switch(listitem)
		{
			case 0:
			{
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_NEON);
				SetPVarInt(playerid, "MechanicNeon", listitem);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang "LIGHTBLUE"neon "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai memasang "YELLOW"neon "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 1:
			{
				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_NEON);
				SetPVarInt(playerid, "MechanicNeon", listitem);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang "LIGHTBLUE"neon "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai memasang "YELLOW"neon "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 2:
			{
		

				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_NEON);
				SetPVarInt(playerid, "MechanicNeon", listitem);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang "LIGHTBLUE"neon "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai memasang "YELLOW"neon "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 3:
			{
		

				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_NEON);
				SetPVarInt(playerid, "MechanicNeon", listitem);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang "LIGHTBLUE"neon "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai memasang "YELLOW"neon "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 4:
			{
		

				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_NEON);
				SetPVarInt(playerid, "MechanicNeon", listitem);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang "LIGHTBLUE"neon "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai memasang "YELLOW"neon "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 5:
			{
		

				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_NEON);
				SetPVarInt(playerid, "MechanicNeon", listitem);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang "LIGHTBLUE"neon "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai memasang "YELLOW"neon "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
			case 6:
			{
									
				static index;
				index = Vehicle_ReturnID(vehicleid);
				if(VehicleData[index][vehNeonColor] <= 0)
					return	SendErrorMessage(playerid, "There is no neon installed on this vehicle");

				SetRepairingVehicle(playerid, 1);
				SetRepairType(playerid, REPAIR_NEON);
				SetPVarInt(playerid, "MechanicNeon", listitem);

				if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
					SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang "LIGHTBLUE"neon "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

				SendServerMessage(playerid, "Mulai memasang "YELLOW"neon "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
			}
		}
	}
	return 1;
}
//Listnya
Dialog:VehicleMod(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			vehicleid = GetPVarInt(playerid, "MechanicVehicle"),
			// Untuk menyimpan section yang bisa di-mod
			section_list[256]
		;
		// new modelid = GetVehicleModel(vehicleid);

		// Mendapatkan list section yang bisa di-mod.
		Vehicle_GetModableSection(vehicleid, section_list);

		if (!Vehicle_HasAnyModableComponent(vehicleid))
		{
			ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa dimodifikasi!");
			return 1;
		}

		Dialog_Show(playerid, MechTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		
		// switch (modelid)
		// {
		// 	case 534 .. 536, 558 .. 562, 565, 567, 575, 576:
		// 	{
		// 		new Query[128];
		// 		mysql_format(g_iHandle, Query, sizeof Query, "SELECT DISTINCT part FROM vehicle_components WHERE cars=%i OR cars=-1 ORDER BY CAST(part AS CHAR)", modelid);
		// 		mysql_tquery(g_iHandle, Query, "MechanicOnTuneLoad", "ii", playerid, 0);
		// 	}
		// 	default:
		// 	{
		// 		static Query[352];
				
		// 		mysql_format(g_iHandle, Query, sizeof Query,
		// 		"SELECT " \
		// 		"IF(parts & 1 <> 0,'Exhausts','')," \
		// 		"IF(parts & 2 <> 0,'Hood','')," \
		// 		"IF(parts & 4 <> 0,'Lamps','')," \
		// 		"IF(parts & 8 <> 0,'Roof','')," \
		// 		"IF(parts & 16 <> 0,'Side Skirts','')," \
		// 		"IF(parts & 32 <> 0,'Spoilers','')," \
		// 		"IF(parts & 64 <> 0,'Vents','')" \
		// 		"FROM vehicle_model_parts WHERE modelid=%i", modelid);
		// 		mysql_tquery(g_iHandle, Query, "MechanicOnTuneLoad", "ii", playerid, 1);
		// 	}
		// }
	}
	return 1;
}
Dialog:VehicleUninstallMod(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			vehicleid = GetPVarInt(playerid, "MechanicVehicle"),
			// Untuk menyimpan section yang bisa di-mod
			section_list[256]
		;

		if (!Vehicle_HasAnyModableComponent(vehicleid))
		{
			ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa dimodifikasi!");
			return 1;
		}

		// Mendapatkan list section yang bisa di-mod.
		Vehicle_GetInstalledMod(vehicleid, section_list);

		// Memunculkan pesan error jika tidak ada mod apapundi dalamnya.
		if (strlen(section_list) < 1)
		{
			ShowPlayerFooter(playerid, "Tidak ada modifikasi apapun di kendaraan ini!");
			return 1;
		}

		Dialog_Show(playerid, MechTune_RemoveMod, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
	}
	return 1;
}
Dialog:MechanicUpgrade(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, MechanicUpgradeList, DIALOG_STYLE_LIST, "Upgrade List", "Upgrade Engine\nUpgrade Fuel Tank\nUpgrade Body", "Install", "Close");
	}
	return 1;
}
Dialog:MechanicHydraulics(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");

		SetRepairingVehicle(playerid, 1);
		SetRepairType(playerid, REPAIR_HYDRAULIC);

		if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
			SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasangkan "LIGHTBLUE"hydraulics "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

		SendServerMessage(playerid, "Mulai memasang "YELLOW"hydraulics "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	}
	return 1;
}

Dialog:MechanicEngine(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");

		SetRepairingVehicle(playerid, 1);
		SetRepairType(playerid, REPAIR_ENGINE);

		if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
			SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memperbaiki "LIGHTBLUE"mesin "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

		SendServerMessage(playerid, "Mulai memperbaiki "YELLOW"mesin "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	}
	return 1;
}

Dialog:MechanicMaintenance(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");

		SetRepairingVehicle(playerid, 1);

		if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
			SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"melakukan "LIGHTBLUE"maintenance "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

		SendServerMessage(playerid, "Mulai melakukan "YELLOW"maintenance "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	}
	return 1;
}

Dialog:MechanicBody(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");

		SetRepairingVehicle(playerid, 1);
		SetRepairType(playerid, REPAIR_BODY);

		if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
			SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memperbaiki "LIGHTBLUE"body "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

		SendServerMessage(playerid, "Mulai memperbaiki "YELLOW"body "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	}
	return 1;
}

Dialog:MechanicTire(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");

		SetRepairingVehicle(playerid, 1);
		SetRepairType(playerid, REPAIR_TIRE);

		if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
			SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memperbaiki "LIGHTBLUE"ban "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

		SendServerMessage(playerid, "Mulai memperbaiki "YELLOW"ban "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	}
	return 1;
}

Dialog:MechanicColor(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			color1, color2,
			vehicleid = GetRepairVehicle(playerid),
			component = GetRepairComponent(playerid),
			time = GetRepairTime(playerid);

		if(sscanf(inputtext, "p<,>dd", color1, color2))
			return Dialog_Show(playerid, MechanicColor, DIALOG_STYLE_INPUT, "Mechanic Menu - Change Color", WHITE"(error) Format warna tidak sesuai\n\nMasukkan warna dengan format: "RED"warna1,warna2 "WHITE"misalkan "GREEN"1,3?", "Spray", "Close", GetVehicleNameByVehicle(vehicleid), component, time);

		if(color1 > 255 || color1 < 0)
			return Dialog_Show(playerid, MechanicColor, DIALOG_STYLE_INPUT, "Mechanic Menu - Change Color", WHITE"(error) Warna1 hanya dibatasi 0 - 255\n\nMasukkan warna dengan format: "RED"warna1,warna2 "WHITE"misalkan "GREEN"1,3?", "Spray", "Close", GetVehicleNameByVehicle(vehicleid), component, time);

		if(color2 > 255 || color2 < 0)
			return Dialog_Show(playerid, MechanicColor, DIALOG_STYLE_INPUT, "Mechanic Menu - Change Color", WHITE"(error) Warna2 hanya dibatasi 0 - 255\n\nMasukkan warna dengan format: "RED"warna1,warna2 "WHITE"misalkan "GREEN"1,3?", "Spray", "Close", GetVehicleNameByVehicle(vehicleid), component, time);

		SetRepairingVehicle(playerid, 1);
		SetRepairType(playerid, REPAIR_COLOR);

		SetPVarInt(playerid, "MechanicColor1", color1);
		SetPVarInt(playerid, "MechanicColor2", color2);

		if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
			SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"mulai "LIGHTBLUE"mewarnai "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

		SendServerMessage(playerid, "Mulai "YELLOW"mewarnai body "WHITE"kendaraan "CYAN"%s "WHITE"(warna: "GREEN"%d,%d"WHITE").", GetVehicleNameByVehicle(vehicleid), color1, color2);
	}
	return 1;
}

Dialog:MechanicPaintjob(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			vehicleid = GetRepairVehicle(playerid),
			modelid = GetVehicleModel(vehicleid)
		;

		switch (modelid)
		{
			case 483: Dialog_Show(playerid, MechanicPaintjobSelect, DIALOG_STYLE_LIST, "Paintjobs", "Paintjob ID: 0\n(Uninstall Paintjob)", "Select", "Cancel");
			case 575: Dialog_Show(playerid, MechanicPaintjobSelect, DIALOG_STYLE_LIST, "Paintjobs", "Paintjob ID: 0\nPaintjob ID: 1\n(Uninstall Paintjob)", "Select", "Cancel");
			case 534 .. 536, 558 .. 562, 565, 567, 576: Dialog_Show(playerid, MechanicPaintjobSelect, DIALOG_STYLE_LIST, "Paintjobs", "Paintjob ID: 0\nPaintjob ID: 1\nPaintjob ID: 2\n(Uninstall Paintjob)", "Select", "Cancel");
			default: SendErrorMessage(playerid, "Kendaraan ini tidak support paintjob!.");
		}
	}
	return 1;
}

Dialog:MechanicPaintjobSelect(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			vehicleid = GetPVarInt(playerid, "MechanicVehicle"),
			modelid = GetVehicleModel(vehicleid),
			is_remove_paintjob
		;

		switch (modelid)
		{
			case 483: is_remove_paintjob = listitem == 1;
			case 575: is_remove_paintjob = listitem == 2;
			case 534 .. 536, 558 .. 562, 565, 567, 576: is_remove_paintjob = listitem == 3;
		}

		SetRepairingVehicle(playerid, 1);
		SetRepairType(playerid, REPAIR_PAINTJOB);

		SetPVarInt(playerid, "MechanicPaintjob", is_remove_paintjob ? 3 : listitem);

		if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
			SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"%s "LIGHTBLUE"paintjob "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), (is_remove_paintjob ? "menghapus" : "memasangkan"), GetVehicleNameByVehicle(vehicleid));

		SendServerMessage(playerid, "Mulai "YELLOW"paintjob "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	}
	return 1;
}

Dialog:MechanicWheels(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new detail[128], wheels[] = {1025, 1073, 1074, 1075, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1096, 1097, 1096};

	    for (new i = 0; i != sizeof(wheels); i++)
	    	strcat(detail, sprintf("%i\n", wheels[i]));

	    ShowPlayerDialog(playerid, DIALOG_SELECT_WHEELS, DIALOG_STYLE_PREVIEW_MODEL, "Select Wheels", detail, "Select", "Close");
    	ShowPlayerFooter(playerid, "Pilih ~r~roda ~w~pada opsi berikut!", 3000, 1);
	}
	return 1;
}
Dialog:MechanicTune(playerid, response, listitem, inputtext[])
{
    if (response)
    {
		new vehicleid = GetPVarInt(playerid, "MechanicVehicle");
        new modelid = GetVehicleModel(vehicleid);
        switch (modelid)
        {
            case 534 .. 536, 558 .. 562, 565, 567, 575, 576:
            {
                if (!strcmp(inputtext, "Wheels") || !strcmp(inputtext, "Hydraulics"))
                {
					return SendErrorMessage(playerid, "Wheels dan Hydraulics disabled");
                }
                else
                {
                    new Query[128];
		            
                    mysql_format(g_iHandle, Query, sizeof Query, "SELECT componentid,type FROM vehicle_components WHERE cars=%i AND part='%e' ORDER BY type", modelid, inputtext);
                    mysql_tquery(g_iHandle, Query, "MechanicOnTuneLoad", "ii", playerid, 2);
                }
            }
            default:
            {
                new Query[128];
		        
                mysql_format(g_iHandle, Query, sizeof Query, "SELECT componentid,type FROM vehicle_components WHERE cars<=0 AND part='%e' ORDER BY type", inputtext);
                mysql_tquery(g_iHandle, Query, "MechanicOnTuneLoad", "ii", playerid, 2);
            }
        }
    }
    return 1;
}

Dialog:MechanicTuneTwo(playerid, response, listitem, inputtext[])        
{
    if (!response) return cmd_mm(playerid, "");
	new vehicleid = GetPVarInt(playerid, "MechanicVehicle");
	new componentid;

	if (!sscanf(inputtext, "i", componentid)) SetPVarInt(playerid, "MechanicModif", componentid);
	else return RemoveVehicleComponent(vehicleid, 1087);

	//Untuk ngecheck kalau modnya valid atau tidak.
	if(!IsModValid(vehicleid, componentid)) return SendErrorMessage(playerid, "Komponen kendaraan tidak valid, coba komponen yang lain!");
	// // sideskirts and vents that have left and right side should be applied twice
	switch (componentid)
	{
		case 1007, 1027, 1030, 1039, 1040, 1051, 1052, 1062, 1063, 1071, 1072, 1094, 1099, 1101, 1102, 1107, 1120, 1121, 1124, 1137, 1142 .. 1145: SetPVarInt(playerid, "MechanicModif2", componentid);
	}

	SetRepairingVehicle(playerid, 1);
	SetRepairType(playerid, REPAIR_MODIF);
	if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
		SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang komponen kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

	SendServerMessage(playerid, "Mulai memasang "YELLOW"komponent "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
    return 1;
}

