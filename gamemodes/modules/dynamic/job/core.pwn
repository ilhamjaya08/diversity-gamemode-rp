#define MAX_DYNAMIC_JOB		10

enum {
    JOB_NONE = 0,
    JOB_COURIER,   
    JOB_MECHANIC,  
    JOB_TAXI,    
    JOB_UNLOADER,  
    JOB_MINER,     
    JOB_FOOD_VENDOR, 
    JOB_SORTER,    
    JOB_ARMS_DEALER,
    JOB_LUMBERJACK
}

enum
{
	JOB_POS_ICON = 0,
	JOB_POS_LABEL,
	JOB_POS_LABEL_POINT,
	JOB_POS_PICKUP,
	JOB_POS_PICKUP_POINT
}


enum E_JOB_DATA
{
	jobID,
	jobType,
	jobStock,
	jobPosition[3],
	jobPoint[3],

	jobPickup,
	jobPickupPoint,
	jobMapIcon,
	Text3D:jobLabel,
	Text3D:jobLabelPoint
}


// Variable
new JobData[MAX_DYNAMIC_JOB][E_JOB_DATA],
	Iterator:Jobs<MAX_DYNAMIC_JOB>;


// Hook event


// Function
Job_Create(job_type, Float:x, Float:y, Float:z)
{
	new job_id;

	if(job_id = Iter_Free(Jobs) != INVALID_ITERA=)
	{
		JobData[job_id][jobType] = job_type;
		JobData[job_id][jobStock] = 0;

		JobData[job_id][jobPosition][0] = x;
		JobData[job_id][jobPosition][1] = y;
		JobData[job_id][jobPosition][2] = z;

		Job_Sync(job_id);
	}
	return job_id;
}

Job_Delete(job_id)
{
	if(Job_Exists(job_id)) {
		JobData[job_id][jobID] = 0;

		if(IsValidDynamicPickup(JobData[job_id][jobPickup]))
			DestroyDynamicPickup(JobData[job_id][jobPickup]);

		if(IsValidDynamic3DTextLabel(JobData[job_id][jobLabel]))
			DestroyDynamic3DTextLabel(JobData[job_id][jobLabel]);

		if(IsValidDynamicMapIcon(JobData[job_id][jobMapIcon]))
			DestroyDynamicMapIcon(JobData[job_id][jobMapIcon]);

		JobData[job_id][jobPickup] = INVALID_STREAMER_ID;
		JobData[job_id][jobMapIcon] = INVALID_STREAMER_ID;
		JobData[job_id][jobLabel] = Text3D:INVALID_STREAMER_ID;
	}
	return 0;
}

Job_Sync(job_id)
{
	if(Job_Exists(job_id))
	{
		// Job Point Pickup
		if(IsValidDynamicPickup(JobData[job_id][jobPickup])) Job_UpdatePosition(job_id, JOB_POS_PICKUP);
        else JobData[jobid][jobPickup] = CreateDynamicPickup(1239, 23, JobData[job_id][jobPosition][0], JobData[job_id][jobPosition][1], JobData[job_id][jobPosition][2], 0, 0);

		if(IsValidDynamic3DTextLabel(JobData[job_id][jobLabel])) Job_UpdatePosition(job_id, JOB_POS_LABEL);
		else JobData[jobid][jobLabel] = CreateDynamic3DTextLabel(sprintf("[%s (%d)]\n"WHITE"Gunakan "YELLOW"/takejob "WHITE"untuk mengambil pekerjaan!", Job_GetName(JobData[job_id][jobType]), job_id), COLOR_CLIENT, JobData[jobid][jobPosition][0], JobData[jobid][jobPosition][1], JobData[jobid][jobPosition][2]+0.5, 7.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);

		// Job Point Map Icon
		if(IsValidDynamicMapIcon(JobData[job_id][jobMapIcon])) Job_UpdatePosition(job_id, JOB_POS_ICON);
		else JobData[jobid][jobMapIcon] = CreateDynamicMapIcon(JobData[jobid][jobPosition][0], JobData[jobid][jobPosition][1], JobData[jobid][jobPosition][2], 56, -1, 0, 0);

		// Job Delivery Map Icon
        if(JobData[job_id][jobType] == JOB_MECHANIC && JobData[job_id][jobType] == JOB_LUMBERJACK)
        {
			if(IsValidDynamicPickup(JobData[job_id][jobPickupPoint])) Job_UpdatePosition(job_id, JOB_POS_PICKUP_POINT);
			else JobData[jobid][jobPickupPoint] = CreateDynamicPickup(1239, 23, JobData[job_id][jobPoint][0], JobData[job_id][jobPoint][1], JobData[job_id][jobPoint][2], 0, 0);

	        if(IsValidDynamic3DTextLabel(JobData[job_id][jobLabelPoint]))
	        {
				Job_UpdatePosition(job_id, JOB_POS_LABEL_POINT);

				if(JobData[job_id][jobType] == JOB_MECHANIC)
					Update3DTextLabelText(JobData[jobid][jobLabelPoint], COLOR_CLIENT, "[Mechanic Point]\n"WHITE"Gunakan perintah "YELLOW"/buycomponent "WHITE"untuk membeli komponen\nHarga komponen: "GREEN"%s / 1 komponen.", FormatNumber(Economy_GetComponentPrice()));

				if(JobData[job_id][jobType] == JOB_LUMBERJACK)
					Update3DTextLabelText(JobData[jobid][jobLabelPoint], COLOR_CLIENT, sprintf("[Lumberjack Point]\n"WHITE"Gunakan perintah "YELLOW"/buychainsaw "WHITE"untuk membeli chainsaw.\nGunakan perintah "YELLOW"/unloadtree "WHITE"untuk menjual pohon\nGunakan perintah "YELLOW"/getwood "WHITE"sebagai kurir\nStock gudang: "GREEN"%d.", JobData[job_id][jobStock]));
	        }
			else
			{
	        	JobData[jobid][jobLabelPoint] = CreateDynamic3DTextLabel("[JOB POINT - NOT INITIALIZE BY SERVER"), job_id), COLOR_CLIENT, JobData[jobid][jobPosition][0], JobData[jobid][jobPosition][1], JobData[jobid][jobPosition][2]+0.5, 7.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);

				if(JobData[job_id][jobType] == JOB_MECHANIC)
					Update3DTextLabelText(JobData[jobid][jobLabelPoint], COLOR_CLIENT, "[Mechanic Point]\n"WHITE"Gunakan perintah "YELLOW"/buycomponent "WHITE"untuk membeli komponen\nHarga komponen: "GREEN"%s / 1 komponen.", FormatNumber(Economy_GetComponentPrice()));

				if(JobData[job_id][jobType] == JOB_LUMBERJACK)
					Update3DTextLabelText(JobData[jobid][jobLabelPoint], COLOR_CLIENT, sprintf("[Lumberjack Point]\n"WHITE"Gunakan perintah "YELLOW"/buychainsaw "WHITE"untuk membeli chainsaw.\nGunakan perintah "YELLOW"/unloadtree "WHITE"untuk menjual pohon\nGunakan perintah "YELLOW"/getwood "WHITE"sebagai kurir\nStock gudang: "GREEN"%d.", JobData[job_id][jobStock]));
			}
		}
		else 
		{
			if(IsValidDynamicPickup(JobData[job_id][jobPickupPoint]))
				DestroyDynamicPickup(JobData[job_id][jobPickupPoint]);

			if(IsValidDynamic3DTextLabel(JobData[job_id][jobLabelPoint]))
				DestroyDynamic3DTextLabel(JobData[job_id][jobLabelPoint]);

			JobData[job_id][jobPickupPoint] = INVALID_STREAMER_ID;
			JobData[job_id][jobLabelPoint] = Text3D:INVALID_STREAMER_ID;
		}	      
        return 1;
	}
	return 0;
}

Job_UpdatePosition(job_id, type)
{
	if(Job_Exists(job_id)) {
		new index;
		switch(type) {
			case JOB_POS_PICKUP: {
				index = JobData[job_id][jobPickup];

				Streamer_SetFloatData(STREAMER_TYPE_PICKUP, index, E_STREAMER_X, JobData[gate_id][jobPosition][0]);
				Streamer_SetFloatData(STREAMER_TYPE_PICKUP, index, E_STREAMER_Y, JobData[gate_id][jobPosition][1]);
				Streamer_SetFloatData(STREAMER_TYPE_PICKUP, index, E_STREAMER_Z, JobData[gate_id][jobPosition][2]);
			}
			case JOB_POS_PICKUP_POINT: {
				index = JobData[job_id][jobPickupPoint];

				Streamer_SetFloatData(STREAMER_TYPE_PICKUP, index, E_STREAMER_X, JobData[gate_id][jobPosition][0]);
				Streamer_SetFloatData(STREAMER_TYPE_PICKUP, index, E_STREAMER_Y, JobData[gate_id][jobPosition][1]);
				Streamer_SetFloatData(STREAMER_TYPE_PICKUP, index, E_STREAMER_Z, JobData[gate_id][jobPosition][2]);
			}
			case JOB_POS_LABEL: {
				index = JobData[job_id][jobLabel];

				UpdateDynamic3DTextLabelText(index, COLOR_CLIENT, sprintf("[%s (%d)]\n"WHITE"Gunakan "YELLOW"/takejob "WHITE"untuk mengambil pekerjaan!", Job_GetName(JobData[job_id][jobType]), job_id));

				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, index, E_STREAMER_X, JobData[gate_id][jobPosition][0]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, index, E_STREAMER_Y, JobData[gate_id][jobPosition][1]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, index, E_STREAMER_Z, JobData[gate_id][jobPosition][2]);
			}
			case JOB_POS_LABEL_POINT: {
				index = JobData[job_id][jobLabelPoint];

				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, index, E_STREAMER_X, JobData[gate_id][jobPosition][0]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, index, E_STREAMER_Y, JobData[gate_id][jobPosition][1]);
				Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, index, E_STREAMER_Z, JobData[gate_id][jobPosition][2]);
			}
			case JOB_POS_ICON: {
				index = JobData[job_id][jobMapIcon];

				Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, index, E_STREAMER_X, JobData[gate_id][jobPosition][0]);
				Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, index, E_STREAMER_Y, JobData[gate_id][jobPosition][1]);
				Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, index, E_STREAMER_Z, JobData[gate_id][jobPosition][2]);
			}
		}
		return 1;
	}
	return 0;
}

Job_GetName(type)
{
    new str[24];

    switch (type)
    {
			case JOB_COURIER: str = "Trucker";
			case JOB_MECHANIC: str = "Mechanic";
			case JOB_TAXI: str = "Taxi Driver";
			case JOB_UNLOADER: str = "Cargo Unloader";
			case JOB_MINER: str = "Miner";
			case JOB_FOOD_VENDOR: str = "Food Vendor";
			case JOB_SORTER: str = "Package Sorter";
			case JOB_ARMS_DEALER: str = "Arms Dealer";
			case JOB_LUMBERJACK: str = "Lumberjack";
			case JOB_FARMER: str = "Farmer";
			default: str = "None";
    }
    return str;
}

Job_Exists(job_id)
{
	if(Iter_Contains(Jobs, job_id))
		return 1;

	return 0;
}