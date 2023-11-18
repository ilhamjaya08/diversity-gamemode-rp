#define CARD_DEALER 1
#define CARD_PLAYER 2

enum E_BLACKJACK_DATA
{
    cardGame,
    cardScore,
    cardTurn,
    cardGamePrize,
    cardValue,
    cardValueType,
    cardValueTen,
    cardPlayerType,
    cardMaxBet,
    bool:cardPlayerTurn,
    bool:cardPlayerStand
}
new CardData[MAX_PLAYERS][E_BLACKJACK_DATA];
