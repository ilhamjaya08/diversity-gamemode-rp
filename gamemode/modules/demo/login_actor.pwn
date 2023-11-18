/// New script bawah
new regisactor[6];

// ====
stock loadactor()
{
	regisactor[0] = CreateActor(216, 1025.4653,-2179.4604,40.4760,264.5856);
	regisactor[1] = CreateActor(137, 1026.8890,-2180.6724,40.4688,355.8084);
	SetActorVirtualWorld(regisactor[0], 0);
	SetActorVirtualWorld(regisactor[1], 0);
	regisactor[2] = CreateActor(59, 1095.0803,-2237.8887,49.3594,271.6400);
	regisactor[3] = CreateActor(93, 1096.2987,-2236.6831,49.3594,179.9578);
	regisactor[4] = CreateActor(29, 1084.3536,-2248.9753,46.8906,87.2090);
	regisactor[5] = CreateActor(90, 1085.0560,-2244.5759,46.7033,82.9082);
	SetActorVirtualWorld(regisactor[2], 0);
	SetActorVirtualWorld(regisactor[3], 0);
	SetActorVirtualWorld(regisactor[4], 0);
	SetActorVirtualWorld(regisactor[5], 0);
	ApplyActorAnimation(regisactor[1], "GRAVEYARD", "mrnF_loop", 4.1, 1, 0, 0, 0, 0);
	ApplyActorAnimation(regisactor[2], "PED","IDLE_CHAT",4.0,1,0,0,1,1);
	ApplyActorAnimation(regisactor[3], "PED","IDLE_CHAT",4.0,1,0,0,1,1);
//	ApplyActorAnimation(regisactor[4], "PED","IDLE_CHAT",4.0,1,0,0,1,1);
//	ApplyActorAnimation(regisactor[5], "PED","IDLE_CHAT",4.0,1,0,0,1,1);
}