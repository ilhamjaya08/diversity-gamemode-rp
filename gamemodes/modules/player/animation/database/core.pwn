#define MAX_PLAYER_ANIMATION 300


enum E_PLAYER_ANIM
{
	bool:AnimExists,
	AnimLib[32],
	AnimName[32]
}

new AnimData[MAX_PLAYERS][MAX_PLAYER_ANIMATION][E_PLAYER_ANIM];