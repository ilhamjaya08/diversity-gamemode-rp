/*
	Vehicle object system
*/
#include <YSI\y_hooks>

// Defined

#define MAX_VEHICLE_OBJECT	5

#define MAX_COLOR_MATERIAL	5

#define OBJECT_TYPE_BODY	1
#define OBJECT_TYPE_TEXT	2


// Variable
new ListedVehObject[MAX_PLAYERS][MAX_VEHICLE_OBJECT];


// Enum's

enum E_VEHICLE_OBJECT {
    vehObjectID,
    vehObjectVehicleIndex,
    vehObjectType,
    vehObjectModel,
    vehObjectColor,

    vehObjectText[32],
    vehObjectFont[24],
    vehObjectFontSize,
    vehObjectFontColor,

    vehObject,
    
    bool:vehObjectExists,

    Float:vehObjectPosX,
    Float:vehObjectPosY,
    Float:vehObjectPosZ,
    Float:vehObjectPosRX,
    Float:vehObjectPosRY,
    Float:vehObjectPosRZ
};
new VehicleObjects[MAX_DYNAMIC_VEHICLES][MAX_VEHICLE_OBJECT][E_VEHICLE_OBJECT];


enum bodyEnums {
    Model,
    Name[37]
};

new BodyWork[][bodyEnums] = {
    {1000,"Generic Spoiler"},
    {1001,"Generic Spoiler"},
    {1002,"Generic Spoiler"},
    {1003,"Generic Spoiler"},
    {1004,"Bonnet Scoop"},
    {1005,"Bonnet Scoop"},
    {1006,"Generic Vehicle Roof-Scoop"},
    {1007,"Generic Vehicle Side Skirt (L)"},
    {1011,"Bonnet Scoop"},
    {1012,"Bonnet Scoop"},
    {1013,"Round Fog Lamps"},
    {1014,"Generic Spoiler"},
    {1015,"Generic Spoiler"},
    {1016,"Generic Spoiler"},
    {1017,"Generic Vehicle Side Skirt (R)"},
    {1018,"Curved Twin Cylinder Generic Exhaust"},
    {1019,"Twin Cylinder Generic Exhaust"},
    {1020,"Large Generic Exhaust"},
    {1021,"Medium Generic Exhaust"},
    {1022,"Small Generic Exhaust"},
    {1023,"Generic Spoiler"},
    {1024,"Square Fog Lamps"},
    {1026,"Sultan Side Skirt Type 1 (L)"},
    {1027,"Sultan Side Skirt Type 1 (R)"},
    {1028,"Sultan Exhaust Type 1"},
    {1029,"Sultan Exhaust Type 2"},
    {1030,"Sultan Side Skirt Type 2 (R)"},
    {1031,"Sultan Side Skirt Type 1 (L)"},
    {1032,"Sultan Roof Scoop type 1"},
    {1033,"Sultan Roof Scoop type 2"},
    {1034,"Elegy Exhaust type 1"},
    {1035,"Elegy Roof Scoop Type 1"},
    {1036,"Elegy Side Skirt type 1 (L)"},
    {1037,"Elegy Exhaust Type 2"},
    {1038,"Elegy Roof Scoop type 2"},
    {1039,"Elegy Side Skirt type 2 (L)"},
    {1040,"Elegy Side Skirt type 1 (R)"},
    {1041,"Elegy Side Skirt type 2 (R)"},
    {1042,"Broadway Side Skirt (L)"},
    {1043,"Broadway Exhaust type 2"},
    {1044,"Broadway Exhaust type 1"},
    {1045,"Flash Exhaust type 2"},
    {1046,"Flash Exhaust type 1"},
    {1047,"Flash Side Skirt type 1 (L)"},
    {1048,"Flash Side Skirt type 2 (L)"},
    {1049,"Flash Spoiler type 1"},
    {1050,"Flash Spoiler type 2"},
    {1051,"Flash Side Skirt type 1 (R)"},
    {1052,"Flash Side Skirt type 2 (R)"},
    {1053,"Flash Roof Scoop type 2"},
    {1054,"Flash Roof Scoop type 1"},
    {1055,"Stratum Roof Scoop type 1"},
    {1056,"Stratum Side Skirt type 1 (L)"},
    {1057,"Stratum Side Skirt type 2 (L)"},
    {1058,"Stratum Spoiler type 1"},
    {1059,"Stratum Exhaust type 2"},
    {1060,"Stratum Spoiler type 2"},
    {1061,"Stratum Roof Scoop type 2"},
    {1062,"Stratum Side Skirt type 1 (R)"},
    {1063,"Stratum Side Skirt type 2 (R)"},
    {1064,"Stratum Exhaust type 1"},
    {1065,"Jester Exhaust type 1"},
    {1066,"Jester Exhaust type 2"},
    {1067,"Jester Roof Scoop type 1"},
    {1068,"Jester Roof Scoop type 2"},
    {1069,"Jester Side Skirt type 1 (L)"},
    {1070,"Jester Side Skirt type 2 (L)"},
    {1071,"Jester Side Skirt type 1 (R)"},
    {1072,"Jester Side Skirt type 2 (R)"},
    {1088,"Uranus Roof Scoop 1"},
    {1089,"Uranus Exhaust Type 1"},
    {1090,"Uranus Side Skirt type 1 (L)"},
    {1091,"Uranus Roof Scoop 2"},
    {1092,"Uranus Exhaust Type 2"},
    {1093,"Uranus Side Skirt type 2 (L)"},
    {1094,"Uranus Side Skirt type 1 (R)"},
    {1095,"Uranus Side Skirt type 2 (R)"},
    {1099,"Broadway Side Skirt (R)"},
    {1100,"Remington Misc. Part 1"},
    {1101,"Remington Side Skirt type 1 (R)"},
    {1102,"Savanna Side Skirt (R)"},
    {1103,"Blade Roof type 2"},
    {1104,"Blade Exhaust type 1"},
    {1105,"Blade Exhaust type 2"},
    {1106,"Remington Side Skirt type 2 (L)"},
    {1107,"Blade Side Skirt (R)"},
    {1108,"Blade Side Skirt (L)"},
    {1109,"Slamvan Rear Bullbars type 1"},
    {1110,"Slamvan Rear Bullbars type 2"},
    {1111,"Slamvan hood ornament 1 (not used)"},
    {1112,"Slamvan hood ornament 2 (not used)"},
    {1113,"Slamvan Exhaust type 1"},
    {1114,"Slamvan Exhaust type 2"},
    {1115,"Slamvan Front Bullbars type 1"},
    {1116,"Slamvan Front Bullbars type 2"},
    {1117,"Slamvan Front Bumper"},
    {1118,"Slamvan Side Skirt type 1 (L)"},
    {1119,"Slamvan Side Skirt type 2 (L)"},
    {1120,"Slamvan Side Skirt type 1 (R)"},
    {1121,"Slamvan Side Skirt type 2 (R)"},
    {1122,"Remington Side Skirt type 1 (L)"},
    {1123,"Remington Misc. Part 2"},
    {1124,"Remington Side Skirt type 2 (R)"},
    {1125,"Remington Misc. Part 3"},
    {1126,"Remington Exhaust type 1"},
    {1127,"Remington Exhaust type 2"},
    {1128,"Blade Roof Type 1"},
    {1129,"Savanna Exhaust type 1"},
    {1130,"Savanna Roof type 1"},
    {1131,"Savanna Roof type 2"},
    {1132,"Savanna Exhaust type 2"},
    {1133,"Savanna Side Skirt (L)"},
    {1134,"Tornado Side Skirt (L)"},
    {1135,"Tornado Exhaust type 2"},
    {1136,"Tornado Exhaust type 1"},
    {1137,"Tornado Side Skirt (R)"},
    {1138,"Sultan Spoiler type 1"},
    {1139,"Sultan Spoiler type 2"},
    {1140,"Sultan Rear Bumper type 2"},
    {1141,"Sultan Rear Bumper type 1"},
    {1142,"Oval Bonnet Vents (R)"},
    {1143,"Oval Bonnet Vents (L)"},
    {1144,"Square Bonnet Vents (R)"},
    {1145,"Square Bonnet Vents (L)"},
    {1146,"Elegy Spoiler type 2"},
    {1147,"Elegy Spoiler type 1"},
    {1148,"Elegy Rear Bumper type 2"},
    {1149,"Elegy Rear Bumper type 1"},
    {1150,"Flash Rear Bumper type 1"},
    {1151,"Flash Rear Bumper type 2"},
    {1152,"Flash Front Bumper type 2"},
    {1153,"Flash Front Bumper type 1"},
    {1154,"Stratum Rear Bumper type 1"},
    {1155,"Stratum Front Bumper type 1"},
    {1156,"Stratum Rear Bumper type 2"},
    {1157,"Stratum Front Bumper type 2"},
    {1158,"Jester Spoiler type 2"},
    {1159,"Jester Rear Bumper type 1"},
    {1160,"Jester Front bumper type 1"},
    {1161,"Jester Rear bumper type2"},
    {1162,"Jester Spoiler type 1"},
    {1163,"Uranus Spoiler type 2"},
    {1164,"Uranus Spoiler type 1"},
    {1165,"Uranus Front Bumper type 2"},
    {1166,"Uranus Rear Bumper type 2"},
    {1167,"Uranus Front Bumper type 1"},
    {1168,"Uranus Rear Bumper type 1"},
    {1169,"Sultan Front Bumper type 1"},
    {1170,"Sultan Front Bumper type 2"},
    {1171,"Elegy Front Bumper type 1"},
    {1172,"Elegy Front Bumper type 2"},
    {1173,"Jester Front Bumper type 2"},
    {1174,"Broadway Front Bumper type 1"},
    {1175,"Broadway Front Bumper type 2"},
    {1176,"Broadway Rear Bumper type 1"},
    {1178,"Remington Rear Bumper type 2"},
    {1179,"Remington Front Bumper type 1"},
    {1180,"Remington Rear Bumper type 2"},
    {1181,"Blade Front Bumper type 2"},
    {1182,"Blade Front Bumper type 1"},
    {1183,"Blade Rear Bumper type 2"},
    {1184,"Blade Rear Bumper type 1"},
    {1185,"Remington Front Bumper type 2"},
    {1186,"Savanna Rear Bumper type 2"},
    {1187,"Savanna Rear Bumper type 1"},
    {1188,"Savanna Front Bumper type 2"},
    {1189,"Savanna Front Bumper type 1"},
    {1190,"Tornado Rear Bumper type 1"},
    {1191,"Tornado Rear Bumper type 2"},
    {1192,"Tornado Front Bumper type 1"},
    {1193,"Tornado Front Bumper type 2"},
    {19308, "Taxi Sign"}
};
Function:Vehicle_ObjectLoad(vehicleid)
{
	if(cache_num_rows())
	{
		for(new slot = 0; slot != cache_num_rows(); slot++)
        { 
            if(!VehicleObjects[vehicleid][slot][vehObjectExists])
            {
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                cache_get_field_content(slot, "text", VehicleObjects[vehicleid][slot][vehObjectText], 32);
                cache_get_field_content(slot, "font", VehicleObjects[vehicleid][slot][vehObjectFont], 32);			

                VehicleObjects[vehicleid][slot][vehObjectID] 		        = cache_get_field_int(slot, "id");
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] 		= cache_get_field_int(slot, "vehicle");
                VehicleObjects[vehicleid][slot][vehObjectType] 		    	= cache_get_field_int(slot, "type");
                VehicleObjects[vehicleid][slot][vehObjectModel] 		    = cache_get_field_int(slot, "model");
				VehicleObjects[vehicleid][slot][vehObjectColor]				= cache_get_field_int(slot, "color");

                VehicleObjects[vehicleid][slot][vehObjectFontColor] 	    = cache_get_field_int(slot, "fontcolor");
                VehicleObjects[vehicleid][slot][vehObjectFontSize] 	    	= cache_get_field_int(slot, "fontsize");

                VehicleObjects[vehicleid][slot][vehObjectPosX] 				= cache_get_field_float(slot, "x");
                VehicleObjects[vehicleid][slot][vehObjectPosY] 				= cache_get_field_float(slot, "y");
                VehicleObjects[vehicleid][slot][vehObjectPosZ] 				= cache_get_field_float(slot, "z");

                VehicleObjects[vehicleid][slot][vehObjectPosRX] 		    = cache_get_field_float(slot, "rx");
                VehicleObjects[vehicleid][slot][vehObjectPosRY] 		    = cache_get_field_float(slot, "ry");
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] 		    = cache_get_field_float(slot, "rz");

                Vehicle_AttachObject(vehicleid, slot);
            }
        }
	}
	return 1;
}

Vehicle_ObjectSave(vehicleid, slot)
{
	if(VehicleObjects[vehicleid][slot][vehObjectExists])
    {
        new query[500];

        format(query, sizeof(query), "UPDATE `vehicle_object` SET `model`='%d', `color`='%d',`type`='%d', `x`='%f',`y`='%f',`z`='%f', `rx`='%f',`ry`='%f',`rz`='%f'",
            VehicleObjects[vehicleid][slot][vehObjectModel],
            VehicleObjects[vehicleid][slot][vehObjectColor],
            VehicleObjects[vehicleid][slot][vehObjectType],
            VehicleObjects[vehicleid][slot][vehObjectPosX], 
            VehicleObjects[vehicleid][slot][vehObjectPosY], 
            VehicleObjects[vehicleid][slot][vehObjectPosZ], 
            VehicleObjects[vehicleid][slot][vehObjectPosRX],
            VehicleObjects[vehicleid][slot][vehObjectPosRY], 
            VehicleObjects[vehicleid][slot][vehObjectPosRZ]
        );

        format(query, sizeof(query), "%s, `text`='%s',`font`='%s', `fontsize`='%d',`fontcolor`='%d' WHERE `id`='%d' AND `vehicle` = '%d'",
            query, 
            SQL_ReturnEscaped(VehicleObjects[vehicleid][slot][vehObjectText]), 
            VehicleObjects[vehicleid][slot][vehObjectFont], 
            VehicleObjects[vehicleid][slot][vehObjectFontSize], 
            VehicleObjects[vehicleid][slot][vehObjectFontColor], 
            VehicleObjects[vehicleid][slot][vehObjectID],
			VehicleObjects[vehicleid][slot][vehObjectVehicleIndex]
        );
        
        mysql_tquery(g_iHandle, query);
    }
	return 1;
}

Vehicle_ObjectAdd(playerid, vehicleid, model, type)
{
    if(Iter_Contains(Vehicle, vehicleid))
	{
        if(GetPlayerVIPLevel(playerid) >= 2)
        {
            for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
            { 
                if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
                {
                    VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                    VehicleObjects[vehicleid][slot][vehObjectType] = type;
                    VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = VehicleData[vehicleid][vehIndex];
                    VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                    VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                    VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                    VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                    if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
                    {
                        format(VehicleObjects[vehicleid][slot][vehObjectText], 32, "TEXT");
                        format(VehicleObjects[vehicleid][slot][vehObjectFont], 24, "Arial");
                        VehicleObjects[vehicleid][slot][vehObjectFontColor] = 1;
                        VehicleObjects[vehicleid][slot][vehObjectFontSize] = 24; 
                    }

                    Vehicle_ObjectEdit(playerid, vehicleid, slot);
                    SendServerMessage(playerid, "You are now editing \"%s\".", GetVehObjectNameByModel(VehicleObjects[vehicleid][slot][vehObjectModel]));

                    mysql_tquery(g_iHandle, sprintf("INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", VehicleObjects[vehicleid][slot][vehObjectVehicleIndex]), "Vehicle_ObjectDB", "dd", vehicleid, slot);
                    return 1;
                }
            }
        }
        else
        {
            for(new slot = 0; slot < MAX_VEHICLE_OBJECT-2; slot++)
            { 
                if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
                {
                    VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                    VehicleObjects[vehicleid][slot][vehObjectType] = type;
                    VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = VehicleData[vehicleid][vehIndex];
                    VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                    VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                    VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                    VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                    VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                    if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
                    {
                        format(VehicleObjects[vehicleid][slot][vehObjectText], 32, "TEXT");
                        format(VehicleObjects[vehicleid][slot][vehObjectFont], 24, "Arial");
                        VehicleObjects[vehicleid][slot][vehObjectFontColor] = 1;
                        VehicleObjects[vehicleid][slot][vehObjectFontSize] = 24; 
                    }

                    Vehicle_ObjectEdit(playerid, vehicleid, slot);
                    SendServerMessage(playerid, "You are now editing \"%s\".", GetVehObjectNameByModel(VehicleObjects[vehicleid][slot][vehObjectModel]));

                    mysql_tquery(g_iHandle, sprintf("INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", VehicleObjects[vehicleid][slot][vehObjectVehicleIndex]), "Vehicle_ObjectDB", "dd", vehicleid, slot);
                    return 1;
                }
            }
        }		
	}
	return 0;
}

Vehicle_AttachObject(vehicleid, slot)
{
    if(Iter_Contains(Vehicle, vehicleid))
	{
        new
            model       = VehicleObjects[vehicleid][slot][vehObjectModel],
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
            Float:vposx,
            Float:vposy,
            Float:vposz
        ;

        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

        VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

        GetVehiclePos(VehicleData[vehicleid][vehVehicleID], vposx, vposy, vposz);

        VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);

        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 15);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 15);

        if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
        {
            Vehicle_ObjectColorSync(vehicleid, slot);
        }
        else 
        {
            Vehicle_ObjectTextSync(vehicleid, slot);
        }

        AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], VehicleData[vehicleid][vehVehicleID], x, y, z, rx, ry, rz);
        // printf("Vehicle ID : %d Vehicle ID 2 : %d Slot : %d Real X : %.2f Y: %.2f Z: %.2f RX : %.2f RY : %.2f RZ : %.2f", vehicleid, VehicleData[vehicleid][vehVehicleID], slot, x, y, z, rx, ry, rz);
        Vehicle_ObjectUpdate(vehicleid, slot);
        return 1;
    }
    return 0;
}
Vehicle_ObjectColorSync(vehicleid, slot)
{
    if(Iter_Contains(Vehicle, vehicleid))
	{
        SetDynamicObjectMaterial(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectModel], "none", "none", RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectColor]]));
        Vehicle_ObjectSave(vehicleid, slot);
	    return 1;
    }
    return 0;
}
Vehicle_ObjectTextSync(vehicleid, slot)
{
    if(Iter_Contains(Vehicle, vehicleid))
	{
        SetDynamicObjectMaterialText(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectText], 130, VehicleObjects[vehicleid][slot][vehObjectFont], VehicleObjects[vehicleid][slot][vehObjectFontSize], 1, RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectFontColor]]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
        Vehicle_ObjectSave(vehicleid, slot);
        return 1;
    }
    return 0;
}
Vehicle_ObjectUpdate(vehicleid, slot)
{   
	if(Iter_Contains(Vehicle, vehicleid))
	{
        new
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ]
        ;

        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_X, x);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_Y, y);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_Z, z);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_R_X, rx);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_R_Y, ry);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_R_Z, rz);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 15);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 15);
        return 1;
    }
    return 0;
}

Vehicle_ObjectDelete(vehicleid, slot)
{
    if(Iter_Contains(Vehicle, vehicleid))
	{
        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

        VehicleObjects[vehicleid][slot ][vehObject] = INVALID_OBJECT_ID;

        VehicleObjects[vehicleid][slot][vehObjectModel] = 0;
        VehicleObjects[vehicleid][slot][vehObjectExists] = false;

        VehicleObjects[vehicleid][slot][vehObjectColor] = 0;


        VehicleObjects[vehicleid][slot][vehObjectPosX] = VehicleObjects[vehicleid][slot][vehObjectPosY] = VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;
        VehicleObjects[vehicleid][slot][vehObjectPosRX] = VehicleObjects[vehicleid][slot][vehObjectPosRY] = VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_object` WHERE `id` = '%d'", VehicleObjects[vehicleid][slot][vehObjectID]));
        return 1;
    }
    return 0;
}

Vehicle_ObjectDestroy(vehicleid)
{
    if(Iter_Contains(Vehicle, vehicleid))
	{
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        {
            if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

            VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

            VehicleObjects[vehicleid][slot][vehObjectModel] = 0;
            VehicleObjects[vehicleid][slot][vehObjectExists] = false;

            
            VehicleObjects[vehicleid][slot][vehObjectColor] = 1;

            VehicleObjects[vehicleid][slot][vehObjectPosX] = VehicleObjects[vehicleid][slot][vehObjectPosY] = VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;
            VehicleObjects[vehicleid][slot][vehObjectPosRX] = VehicleObjects[vehicleid][slot][vehObjectPosRY] = VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;
        }
        return 1;
    }
    return 0;
}

Vehicle_ObjectEdit(playerid, vehicleid, slot, bool:text = false)
{
	if(Iter_Contains(Vehicle, vehicleid))
	{
        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

        new 
            Float:x,
            Float:y,
            Float:z,
            Float:rx = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz = VehicleObjects[vehicleid][slot][vehObjectPosRZ]
        ;

        GetVehiclePos(VehicleData[vehicleid][vehVehicleID], x, y, z);
        VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;
        VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(VehicleObjects[vehicleid][slot][vehObjectModel], x, y, z, rx, ry, rz);   

        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 15);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 15);
        
        PlayerData[playerid][pEditVehicleObject] = vehicleid;
        PlayerData[playerid][pEditVehicleObjectSlot] = slot;
        PlayerData[playerid][pEditingMode] = VEHICLE;
        if(text) 
        {
            Vehicle_ObjectTextSync(vehicleid, slot);
        }
        EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
        return 1;
    }
    return 0;
}

stock GetRelative2DPosFromWorld2DPos(Float:source_x,Float:source_y, Float:dest_x, Float:dest_y, &Float:rel_x, &Float:rel_y)
{
    if (dest_x >= source_x && dest_y >= source_y)
    {
        // Kuadran 1
        rel_x = dest_x - source_x;
        rel_y = dest_y - source_y;
    }
    else if (dest_x <= source_x && dest_y >= source_y)
    {
        // Kuadran 2
        rel_x = -(floatabs(dest_x) - floatabs(source_x));
        rel_y = dest_y - source_y;
    }
    else if (dest_x <= source_x && dest_y <= source_y)
    {
        // Kuadran 3
        rel_x = -(floatabs(dest_x) - floatabs(source_x));
        rel_y = -(floatabs(dest_y) - floatabs(source_y));
    }
    else if (dest_x >= source_x && dest_y <= source_y)
    {
        // Kuadran 4
        rel_x = dest_x - source_x;
        rel_y = -(floatabs(dest_y) - floatabs(source_y));
    }

    return 1;
}

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(response == EDIT_RESPONSE_FINAL)
    {
        switch(PlayerData[playerid][pEditingMode])
        {
            case VEHICLE:
            {
                new 
                    vehicleid = PlayerData[playerid][pEditVehicleObject],
                    slot = PlayerData[playerid][pEditVehicleObjectSlot],
                    Float:vx,
                    Float:vy,
                    Float:vz,
                    Float:va,
                    Float:real_x,
                    Float:real_y,
                    Float:real_z,
                    Float:real_a
                ;

                GetVehiclePos(vehicleid, vx, vy, vz);
                GetVehicleZAngle(vehicleid, va);

                real_x = x - vx;
                real_y = y - vy;
                real_z = z - vz;
                real_a = rz - va;

				new Float:v_size[3];
				GetVehicleModelInfo(VehicleData[vehicleid][vehModel], VEHICLE_MODEL_INFO_SIZE, v_size[0], v_size[1], v_size[2]);
				if(	(real_x >= v_size[0] || -v_size[0] >= real_x) || 
					(real_y >= v_size[1] || -v_size[1] >= real_y) ||
					(real_z >= v_size[2] || -v_size[2] >= real_z))
				{
					ShowPlayerFooter(playerid, "Posisi object terlal jauh dari body kendaraan.");
                    ResetEditing(playerid);
                    return 1;
				}

                if(IsPlayerInModshop(playerid) == -1)
		        {
					ShowPlayerFooter(playerid, "You are not inside modshop garage!");
                    ResetEditing(playerid);
                    return 1;
                }


                VehicleObjects[vehicleid][slot][vehObjectPosX] = real_x;                
                VehicleObjects[vehicleid][slot][vehObjectPosY] = real_y;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = real_z;
                VehicleObjects[vehicleid][slot][vehObjectPosRX] = rx;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = ry;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = real_a;

                Vehicle_ObjectUpdate(vehicleid, slot);
                Vehicle_AttachObject(vehicleid, slot);
                Vehicle_ObjectSave(vehicleid, slot);

                ShowPlayerFooter(playerid, "Posisi object telah di ubah!.");
            }
        }
    }
    if(response == EDIT_RESPONSE_CANCEL)
    {
        ResetEditing(playerid);
    }

	return 1;
}

GetVehObjectNameByModel(model)
{
    new
        name[32];

    for (new i = 0; i < sizeof(BodyWork); i ++) if(BodyWork[i][Model] == model) {
        strcat(name, BodyWork[i][Name]);

        break;
    }
    return name;
}

Function:Vehicle_ObjectDB(vehicleid, slot)
{
	if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
		return 0;

	VehicleObjects[vehicleid][slot][vehObjectID] = cache_insert_id();
    printf("%d", VehicleObjects[vehicleid][slot][vehObjectID]);


	Vehicle_ObjectSave(vehicleid, slot);
	return 1;
}

CMD:buyvacc(playerid, params[])
{
    new 
		vehid,
        id,
        models[175] = {-1, ... },
    	count
	;
	
	if(IsPlayerInModshop(playerid) == -1)
		return SendErrorMessage(playerid, "You're not inside modshop!");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You're not driving any vehicle!");

	vehid = GetPlayerVehicleID(playerid);

    if(!IsFourWheelVehicle(vehid))
        return SendErrorMessage(playerid, "You cannot buy modification on this vehicle!");

	if(GetEngineStatus(vehid))
		return SendErrorMessage(playerid, "Matikan mesin kendaraan!");

    if((id = Vehicle_ReturnID(vehid)) != -1 && Vehicle_IsOwned(playerid, id)) 
    {
		for (new i; i < sizeof(BodyWork); i++)
		{
			models[count++] = BodyWork[i][Model];
		}
		ShowCustomSelection(playerid, "Vehicle Object List", MODEL_SELECTION_VEHOBJECT, models, count);
    	return 1;
    } 
    else SendErrorMessage(playerid, "Invalid vehicle id.");
    return 1;
}

CMD:vacc(playerid, params[])
{
    new 
		vehid,
        string[1024],
        count,
        vehicleid
	;

	if(IsPlayerInModshop(playerid) == -1)
		return SendErrorMessage(playerid, "You're not inside modshop!");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You're not driving any vehicle!");

	vehid = GetPlayerVehicleID(playerid);

	if(GetEngineStatus(vehid))
		return SendErrorMessage(playerid, "Matikan mesin kendaraan!");

    vehicleid = Vehicle_ReturnID(vehid);

    if(vehicleid == -1)
        return SendErrorMessage(playerid, "Invalid vehicle id!");

    if(Vehicle_IsOwned(playerid, vehicleid)) 
    {
        format(string,sizeof(string),"Index\tName\n");
        for (new i = 0; i < MAX_VEHICLE_OBJECT; i++)
        {
            if(VehicleObjects[vehicleid][i][vehObjectExists])
            {
                if(VehicleObjects[vehicleid][i][vehObjectType] == OBJECT_TYPE_BODY)
                {
                    format(string,sizeof(string),"%s#%d\t%s\n", string, i, GetVehObjectNameByModel(VehicleObjects[vehicleid][i][vehObjectModel]));
                }
                else
                {
                    format(string,sizeof(string),"%s#%d\t%s\n", string, i, VehicleObjects[vehicleid][i][vehObjectText]);
                }

                if (count < 5)
                {
                    ListedVehObject[playerid][count] = i;
                    count = count + 1;
                }
            }
        }

        if(!count) 
        {
            SendErrorMessage(playerid, "You don't have vehicle toys installed!");
        }
        else 
        {
            PlayerData[playerid][pEditVehicleObject] = vehicleid;
            Dialog_Show(playerid, EditingVehObject, DIALOG_STYLE_TABLIST_HEADERS, "Editing Vehicle Object", string, "Select","Exit");
        }
    	return 1;
    }
    return 1;
}

Dialog:EditingVehObject(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        PlayerData[playerid][pEditVehicleObjectSlot] = ListedVehObject[playerid][listitem];
        new 
            string[24],
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject]
        ;

        format(string,sizeof(string),"Vehicle Edit Object (#%d)",PlayerData[playerid][pEditVehicleObjectSlot]);
        Dialog_Show(playerid, VACCSE, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "Set Accesories Color\nEdit Position%s", "Select", "Back", VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY ? ("\nRemove From Vehicle") : ("\nEdit Text\nRemove From Vehicle"));
    }
    return 1;
}

Dialog:VACCSE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject],
            modelid = VehicleObjects[vehicleid][slot][vehObjectModel]
        ;

        switch(listitem)
        {
            case 0:
            {
                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
                    Dialog_Show(playerid, VACCSE, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit", "Set Accesories Color\nEdit Position%s", "Select", "Back", VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY ? ("\nRemove From Vehicle") : ("\nEdit Text\nRemove From Vehicle"));

				Dialog_Show(playerid, VEH_OBJECT_COLOR, DIALOG_STYLE_INPUT, "Select Index", color_string, "Select", "Close");
                SendServerMessage(playerid, "You're now editing color of %s!", GetVehObjectNameByModel(modelid));
            }
            case 1:
            {
				if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
				{
                    SetVehicleZAngle(vehicleid, 0.0);
					Vehicle_ObjectEdit(playerid, vehicleid, slot);
					SendServerMessage(playerid, "You're now editing %s!", GetVehObjectNameByModel(modelid));
				}
				else
				{
                    SetVehicleZAngle(vehicleid, 0.0);
					Vehicle_ObjectEdit(playerid, vehicleid, slot, true);
					SendServerMessage(playerid, "You're now editing sticker!");
				}
			}
            case 2:
            {
                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
                {
                    Vehicle_ObjectDelete(vehicleid, slot);
                    SendServerMessage(playerid, "You removed %s from your vehicle!", GetVehObjectNameByModel(modelid));
                }
                else
                {
                    Dialog_Show(playerid, VEH_OBJECT_TEXT, DIALOG_STYLE_LIST, "Vehicle Accesories > Edit Text", "Text Name\nText Size\nText Font\nText Color", "Select", "Close");
                }
            }
            case 3:
            {
                Vehicle_ObjectDelete(vehicleid, slot);
                SendServerMessage(playerid, "You removed vehicle text object!", GetVehObjectNameByModel(modelid));
            }
        }
    }
    return 1;
}

CMD:addvehobject(playerid, params[])
{
	if(CheckAdmin(playerid, 7))
        return PermissionError(playerid);
    
    static 
        vehicle,
        modelid,
        id = -1;
    
    if(sscanf(params,"dd", vehicle, modelid))
        return SendSyntaxMessage(playerid, "/addvehtext [vehicleid] [modelid]");

    if((id = Vehicle_ReturnID(vehicle)) != -1 && Vehicle_IsOwned(playerid, id)) 
    {
    	if(Vehicle_ObjectAdd(playerid, id, modelid, OBJECT_TYPE_BODY)) SendServerMessage(playerid, "Sukses membuat custom object pada kendaraan id %d.", id);
    	else SendServerMessage(playerid, "Tidak ada slot untuk kendaraan ini lagi.");
    	return 1;
    } 
    else SendErrorMessage(playerid, "Invalid vehicle id.");

    return 1;
}
CMD:addvehtext(playerid, params[])
{
	if(CheckAdmin(playerid, 7))
        return PermissionError(playerid);
    
    static 
        vehicle,
        id = -1;
    
    if(sscanf(params,"d", vehicle))
        return SendSyntaxMessage(playerid, "/addvehtext [vehicleid]");

    if((id = Vehicle_ReturnID(vehicle)) != -1) 
    {
    	if(Vehicle_ObjectAdd(playerid, id, 18661, OBJECT_TYPE_TEXT)) SendServerMessage(playerid, "Sukses membuat text-object pada kendaraan id %d.", id);
    	else SendServerMessage(playerid, "Tidak ada slot untuk kendaraan ini lagi.");
    	return 1;
    } 
    else SendErrorMessage(playerid, "Invalid vehicle id.");

    return 1;
}
Dialog:VEH_OBJECT_COLOR(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject]        
		;

        if(!(0 <= strval(inputtext) <= sizeof(ColorList)-1))
            return Dialog_Show(playerid, VEH_OBJECT_COLOR, DIALOG_STYLE_INPUT, "Input Color", color_string, "Update", "Close");
		
		VehicleObjects[vehicleid][slot][vehObjectColor] = strval(inputtext);
		Vehicle_ObjectColorSync(vehicleid, slot);
    }
	return 1;
}
Dialog:VEH_OBJECT_TEXT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Input Text name 32 Character : ", "Update", "Close");
			}
			case 1:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTSIZE, DIALOG_STYLE_INPUT, "Input Text Size", "Input Text Size Maximal Ukuran 200 : ", "Update", "Close");
			}
			case 2:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTFONT, DIALOG_STYLE_LIST, "Input Text Font", object_font, "Update", "Close");
			}
			case 3:
			{
				Dialog_Show(playerid, VEH_OBJECT_TEXTCOLOR, DIALOG_STYLE_INPUT, "Input Text Color", color_string, "Update", "Close");
			}
		}
	}
	return 1;
}
Dialog:VEH_OBJECT_TEXTNAME(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject]
        ;

		if(isnull(inputtext))
			return Dialog_Show(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Error : Text tidak boleh kosong\n\nInput Text name 32 Character : ", "Select", "Close");

		if(strlen(inputtext) > 32)
			return Dialog_Show(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Error : Nama lebih dari 32 karakter\n\nMasukan nama text 32 character! : ", "Select", "Close");

		format(VehicleObjects[vehicleid][slot][vehObjectText], 32, "%s", inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
		
	}
	return 1;
}
Dialog:VEH_OBJECT_TEXTCOLOR(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject]        
		;

        if(!(0 <= strval(inputtext) <= sizeof(ColorList)-1))
            return Dialog_Show(playerid, VEH_OBJECT_TEXTFONT, DIALOG_STYLE_INPUT, "Input Text Color", color_string, "Update", "Close");
		
		VehicleObjects[vehicleid][slot][vehObjectFontColor] = strval(inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
    }
    return 1;
}
Dialog:VEH_OBJECT_TEXTSIZE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject]
        ;

		if(!(0 < strval(inputtext) <= 200))
			return Dialog_Show(playerid, VEH_OBJECT_TEXTSIZE, DIALOG_STYLE_INPUT, "Input Text Size", WHITE"error: ukuran dibatasi mulai dari 1 sampai 200\n\nMasukkan ukuran font mulai dari angka 1 sampai 200 :", "Update", "Back");

		VehicleObjects[vehicleid][slot][vehObjectFontSize] = strval(inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
	}
	return 1;
}
Dialog:VEH_OBJECT_TEXTFONT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject]
        ;

		if(listitem == sizeof(FontNames) - 1)
			return Dialog_Show(playerid, VEH_OBJECT_FONTCUSTOM, DIALOG_STYLE_INPUT, "Input Text Font - Custom Font", "Masukkan nama font yang akan kamu ubah:", "Input", "Back");

		format(VehicleObjects[vehicleid][slot][vehObjectFont], 32, "%s", inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
	}
	return 1;
}
Dialog:VEH_OBJECT_FONTCUSTOM(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        new 
            slot = PlayerData[playerid][pEditVehicleObjectSlot],
            vehicleid = PlayerData[playerid][pEditVehicleObject]
        ;
		if(!strlen(inputtext))
			return Dialog_Show(playerid, VEH_OBJECT_FONTCUSTOM, DIALOG_STYLE_INPUT, "Input Text Font - Custom Font", "Error : nama font tidak boleh kosong!\n\nMasukkan nama font yang akan kamu ubah\nPastikan nama font benar!:", "Input", "Back");

		format(VehicleObjects[vehicleid][slot][vehObjectFont], 32, "%s", inputtext);
		Vehicle_ObjectTextSync(vehicleid, slot);
	}
	return 1;
}		

// Vehicle_ObjectColor(playerid, vehicleid, slot)
// {
// 	new color[155];
//     for(new mx = 0; mx != MAX_COLOR_MATERIAL; mx++)  {
//         strcat(color, sprintf("{%06x}Color #%d %s\n", ColorList[VehicleObjects[vehicleid][slot][vehObjectColor][mx]] >>> 8, mx+1, (VehicleObjects[vehicleid][slot][vehObjectColor][mx] == 1) ? ("(original)") : ("")));
//     }
//     Dialog_Show(playerid, VEH_OBJECT_COLOR, DIALOG_STYLE_LIST, "Select Index", color, "Select", "Close");
//     return 1;
// }
