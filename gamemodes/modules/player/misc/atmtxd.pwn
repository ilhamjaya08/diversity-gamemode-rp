new PlayerText:LayerPertama[MAX_PLAYERS];
new PlayerText:LayerKedua[MAX_PLAYERS];
new PlayerText:ATMVisual[MAX_PLAYERS];
new PlayerText:WithdrawButton[MAX_PLAYERS];
new PlayerText:TransferButton[MAX_PLAYERS];
new PlayerText:PaycheckButton[MAX_PLAYERS];
new PlayerText:AccountBalanceVisual[MAX_PLAYERS];
new PlayerText:SalaryButton[MAX_PLAYERS];
new PlayerText:BankMoneyVisual[MAX_PLAYERS];
new PlayerText:ATMCloseButton[MAX_PLAYERS];

CreateATMDraw(playerid)
{
	LayerPertama[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 121.000000, "_");
	PlayerTextDrawFont(playerid, LayerPertama[playerid], 1);
	PlayerTextDrawLetterSize(playerid, LayerPertama[playerid], 0.600000, 22.500001);
	PlayerTextDrawTextSize(playerid, LayerPertama[playerid], 298.500000, 126.000000);
	PlayerTextDrawSetOutline(playerid, LayerPertama[playerid], 1);
	PlayerTextDrawSetShadow(playerid, LayerPertama[playerid], 0);
	PlayerTextDrawAlignment(playerid, LayerPertama[playerid], 2);
	PlayerTextDrawColor(playerid, LayerPertama[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, LayerPertama[playerid], 255);
	PlayerTextDrawBoxColor(playerid, LayerPertama[playerid], 255);
	PlayerTextDrawUseBox(playerid, LayerPertama[playerid], 1);
	PlayerTextDrawSetProportional(playerid, LayerPertama[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, LayerPertama[playerid], 0);

	LayerKedua[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 127.000000, "_");
	PlayerTextDrawFont(playerid, LayerKedua[playerid], 1);
	PlayerTextDrawLetterSize(playerid, LayerKedua[playerid], 0.600000, 21.150022);
	PlayerTextDrawTextSize(playerid, LayerKedua[playerid], 298.500000, 116.500000);
	PlayerTextDrawSetOutline(playerid, LayerKedua[playerid], 1);
	PlayerTextDrawSetShadow(playerid, LayerKedua[playerid], 0);
	PlayerTextDrawAlignment(playerid, LayerKedua[playerid], 2);
	PlayerTextDrawColor(playerid, LayerKedua[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, LayerKedua[playerid], 255);
	PlayerTextDrawBoxColor(playerid, LayerKedua[playerid], -2016478465);
	PlayerTextDrawUseBox(playerid, LayerKedua[playerid], 1);
	PlayerTextDrawSetProportional(playerid, LayerKedua[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, LayerKedua[playerid], 0);

	ATMVisual[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 126.000000, "ATM");
	PlayerTextDrawFont(playerid, ATMVisual[playerid], 1);
	PlayerTextDrawLetterSize(playerid, ATMVisual[playerid], 0.245831, 1.299998);
	PlayerTextDrawTextSize(playerid, ATMVisual[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ATMVisual[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ATMVisual[playerid], 0);
	PlayerTextDrawAlignment(playerid, ATMVisual[playerid], 1);
	PlayerTextDrawColor(playerid, ATMVisual[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ATMVisual[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ATMVisual[playerid], 50);
	PlayerTextDrawUseBox(playerid, ATMVisual[playerid], 0);
	PlayerTextDrawSetProportional(playerid, ATMVisual[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ATMVisual[playerid], 0);

	WithdrawButton[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 194.000000, "WITHDRAW");
	PlayerTextDrawFont(playerid, WithdrawButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, WithdrawButton[playerid], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, WithdrawButton[playerid], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, WithdrawButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, WithdrawButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, WithdrawButton[playerid], 2);
	PlayerTextDrawColor(playerid, WithdrawButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, WithdrawButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, WithdrawButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, WithdrawButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WithdrawButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, WithdrawButton[playerid], 1);

	TransferButton[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 226.000000, "TRANSFER");
	PlayerTextDrawFont(playerid, TransferButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TransferButton[playerid], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, TransferButton[playerid], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, TransferButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TransferButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, TransferButton[playerid], 2);
	PlayerTextDrawColor(playerid, TransferButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TransferButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TransferButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, TransferButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TransferButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TransferButton[playerid], 1);

	PaycheckButton[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 291.000000, "PAYCHECK");
	PlayerTextDrawFont(playerid, PaycheckButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, PaycheckButton[playerid], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, PaycheckButton[playerid], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, PaycheckButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, PaycheckButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, PaycheckButton[playerid], 2);
	PlayerTextDrawColor(playerid, PaycheckButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PaycheckButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, PaycheckButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, PaycheckButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PaycheckButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PaycheckButton[playerid], 1);

	AccountBalanceVisual[playerid] = CreatePlayerTextDraw(playerid, 269.000000, 155.000000, "Account Balance :");
	PlayerTextDrawFont(playerid, AccountBalanceVisual[playerid], 1);
	PlayerTextDrawLetterSize(playerid, AccountBalanceVisual[playerid], 0.216664, 1.399999);
	PlayerTextDrawTextSize(playerid, AccountBalanceVisual[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AccountBalanceVisual[playerid], 1);
	PlayerTextDrawSetShadow(playerid, AccountBalanceVisual[playerid], 0);
	PlayerTextDrawAlignment(playerid, AccountBalanceVisual[playerid], 1);
	PlayerTextDrawColor(playerid, AccountBalanceVisual[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, AccountBalanceVisual[playerid], 255);
	PlayerTextDrawBoxColor(playerid, AccountBalanceVisual[playerid], 50);
	PlayerTextDrawUseBox(playerid, AccountBalanceVisual[playerid], 0);
	PlayerTextDrawSetProportional(playerid, AccountBalanceVisual[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, AccountBalanceVisual[playerid], 0);

	SalaryButton[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 258.000000, "SALARY");
	PlayerTextDrawFont(playerid, SalaryButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SalaryButton[playerid], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, SalaryButton[playerid], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, SalaryButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SalaryButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, SalaryButton[playerid], 2);
	PlayerTextDrawColor(playerid, SalaryButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SalaryButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SalaryButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, SalaryButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SalaryButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SalaryButton[playerid], 1);

	BankMoneyVisual[playerid] = CreatePlayerTextDraw(playerid, 304.000000, 173.000000, " ");
	PlayerTextDrawFont(playerid, BankMoneyVisual[playerid], 1);
	PlayerTextDrawLetterSize(playerid, BankMoneyVisual[playerid], 0.216664, 1.399999);
	PlayerTextDrawTextSize(playerid, BankMoneyVisual[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, BankMoneyVisual[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BankMoneyVisual[playerid], 0);
	PlayerTextDrawAlignment(playerid, BankMoneyVisual[playerid], 1);
	PlayerTextDrawColor(playerid, BankMoneyVisual[playerid], 9109759);
	PlayerTextDrawBackgroundColor(playerid, BankMoneyVisual[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BankMoneyVisual[playerid], 50);
	PlayerTextDrawUseBox(playerid, BankMoneyVisual[playerid], 0);
	PlayerTextDrawSetProportional(playerid, BankMoneyVisual[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BankMoneyVisual[playerid], 0);

	ATMCloseButton[playerid] = CreatePlayerTextDraw(playerid, 367.000000, 128.000000, "X");
	PlayerTextDrawFont(playerid, ATMCloseButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ATMCloseButton[playerid], 0.258332, 0.800000);
	PlayerTextDrawTextSize(playerid, ATMCloseButton[playerid], 16.500000, 8.500000);
	PlayerTextDrawSetOutline(playerid, ATMCloseButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ATMCloseButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, ATMCloseButton[playerid], 2);
	PlayerTextDrawColor(playerid, ATMCloseButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ATMCloseButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ATMCloseButton[playerid], -16776961);
	PlayerTextDrawUseBox(playerid, ATMCloseButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ATMCloseButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ATMCloseButton[playerid], 1);
    return 1;
}
DestroyATMDraw(playerid)
{
    PlayerTextDrawDestroy(playerid, LayerPertama[playerid]);
	PlayerTextDrawDestroy(playerid, LayerKedua[playerid]);
	PlayerTextDrawDestroy(playerid, ATMVisual[playerid]);
	PlayerTextDrawDestroy(playerid, WithdrawButton[playerid]);
	PlayerTextDrawDestroy(playerid, TransferButton[playerid]);
	PlayerTextDrawDestroy(playerid, PaycheckButton[playerid]);
	PlayerTextDrawDestroy(playerid, AccountBalanceVisual[playerid]);
	PlayerTextDrawDestroy(playerid, SalaryButton[playerid]);
	PlayerTextDrawDestroy(playerid, BankMoneyVisual[playerid]);
	PlayerTextDrawDestroy(playerid, ATMCloseButton[playerid]);
    return 1;
}

CloseATM(playerid)
{
    PlayerTextDrawHide(playerid, LayerPertama[playerid]);
    PlayerTextDrawHide(playerid, LayerKedua[playerid]);
    PlayerTextDrawHide(playerid, ATMVisual[playerid]);
    PlayerTextDrawHide(playerid, WithdrawButton[playerid]);
    PlayerTextDrawHide(playerid, TransferButton[playerid]);
    PlayerTextDrawHide(playerid, PaycheckButton[playerid]);
    PlayerTextDrawHide(playerid, AccountBalanceVisual[playerid]);
    PlayerTextDrawHide(playerid, SalaryButton[playerid]);
    PlayerTextDrawHide(playerid, BankMoneyVisual[playerid]);
    PlayerTextDrawHide(playerid, ATMCloseButton[playerid]);
    CancelSelectTextDrawEx(playerid);
    return 1;
}