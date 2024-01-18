CMD:removebody(playerid, params[])
{
    new index, Float:x, Float:y, Float:z;
	if(sscanf(params, "d", index))
		return SendSyntaxMessage(playerid, "/removebody [corpsid)]");

    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
        return SendErrorMessage(playerid, "You're not police officer or medic!");

	GetDynamicActorPos(BodyData[index][bodyObject], x, y, z);
    if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
    {
		if(Body_Delete(index, true)) 
		{
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);

			SendCustomMessage(playerid, "CORPSES:", "You removed dead body from the ground");
			SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s takes the body and puts it inside body bag.", ReturnName(playerid));
		}
		else SendErrorMessage(playerid, "There are no body with this ID!");
    }
    else SendErrorMessage(playerid, "You're not near any dead body!");
    return 1;
}