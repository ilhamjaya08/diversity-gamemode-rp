/*
    Name: VBMail
	Description: Email system
	Author: ViniBorn
	Contact : vini-elite@hotmail.com
	Country : Brazil


	***        ***   ***   *****     ***   ***   *** ***       *****      ********    ******    ***
	 ***      ***    ***   *** ***   ***   ***   ***   **    ***   ***    ***  ***    *** ***   ***
	  ***    ***     ***   ***  ***  ***   ***   *** **      ***   ***    *** ***     ***  ***  ***
	   ***  ***      ***   ***   *** ***   ***   ***   **    ***   ***    ***  ***    ***   *** ***
        ******       ***   ***    ******   ***   *** ****      *****      ***   ***   ***    ******
        
        
        
        
        
        Do not remove the credits.
        Your name is valuable, do not mess it.


        Comments:

        - The default directory for saving e-mail is: scriptfiles / emails. Create e-mail folder.

        - The default directory for user accounts is: scriptfiles / users. Modify the Players defines, according to
		  where the accounts are saved on your server.

		- The inbox each player has a capacity of 10 emails.
		
		
		Updates :

		* 20/08/11

			- New method for reading email using DIALOG_STYLE_LIST
			- Indication of e-mails (Read) or (not read)


*/

#include <a_samp>
#include <Dini>

#define Local      "/emails/%s.ini"     // Directory of emails
#define Players    "/users/%s.ini"      // Directory of accounts

new Receiver[MAX_PLAYERS][32];
static const Status[2][14] = {
{"(Read) - "},
{"(Not read) - "}
};
new Emails[][10] = {
"1",
"2",
"3",
"4",
"5",
"6",
"7",
"8",
"9",
"10"
};

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" E-mail system       By: ViniBorn");
	print("    - Do not remove the credits -    ");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
    print("\n\tE-mail system finished.");
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/buypc", cmdtext, true, 10) == 0)
	{
	    if(GetPlayerMoney(playerid) < 2000)
	        return SendClientMessage(playerid, 0xAFAFAFAA,"You don't have this amount.");

        new email[32];
	    format(email,32,Local,Player(playerid));

	    if(dini_Exists(email))
			return SendClientMessage(playerid, 0xAFAFAFAA,"You already have a computer.");

    	dini_Create(email);

    	for(new i=0;i<sizeof(Emails);i++)
            dini_Set(email,Emails[i],"Empty");

		GameTextForPlayer(playerid, "Cost : $ 2.000", 5000, 1);
		GivePlayerMoney(playerid, -2000);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, 0xAFAFAFAA, "Now you can use /email.");

		return 1;
	}
	if(strcmp("/email", cmdtext, true, 10) == 0)
	{
	    new email[32];
	    format(email,32,Local,Player(playerid));

    	if(!dini_Exists(email))
			return SendClientMessage(playerid, 0xAFAFAFAA,"You don't have a computer.");

	    new listitems[] = "Read\nSend\nDelete";
	    ShowPlayerDialog(playerid, 225, DIALOG_STYLE_LIST, "My email : ", listitems,"Select","Exit");

	    return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 225)
	{
	    if(!response)
	        return 0;
		else
		{
		    new str[128], email[32], string[1024];
		    format(email,32,Local,Player(playerid));
		    switch (listitem)
			{
    			case 0:
				{
					for(new i=0;i<sizeof(Emails);i++)
					{
						format(str,128,"{C2A2DA}%d - %s\n",strval(Emails[i]),dini_Get(email,Emails[i]));
						strcat(string, str);
					}
				    ShowPlayerDialog(playerid, 226, DIALOG_STYLE_LIST, "Inbox : ", string,"Select","Back");
			    }
			    case 1:	ShowPlayerDialog(playerid, 227,DIALOG_STYLE_INPUT,"E-mail","Enter the receiver's name:","Send","Back");
			    case 2: ShowPlayerDialog(playerid, 228,DIALOG_STYLE_INPUT,"E-mail","Enter the number of e-mail:","Delete","Back");
			}
		}
	}
    else if(dialogid == 226)//Read
	{
	    if(!response)
	    {
	        new listitems[] = "Read\nSend\nDelete";
	        ShowPlayerDialog(playerid, 225, DIALOG_STYLE_LIST, "My email : ", listitems,"Select","Exit");
        }
		else
	        MyEmail(playerid,listitem);
	}
	else if(dialogid == 227)//Send (receiver)
	{
	    if(!response)
	    {
	        new listitems[] = "Read\nSend\nDelete";
	        ShowPlayerDialog(playerid, 225, DIALOG_STYLE_LIST, "My email : ", listitems,"Select","Exit");
        }
		else
		{
      		new file[64];
			format(file, sizeof(file), Players,inputtext);
			if(dini_Exists(file))
			{
			    new giveid = ReturnUser(inputtext);
			    format(file,32,Local,Player(giveid));
			    
			    if(!dini_Exists(file))
					return SendClientMessage(playerid, 0xAA3333AA,"[ERROR] The player doesn't have a computer.");

           		new str[128];
				format(str,128,"You are about to send an email to %s. Enter your message.", inputtext);
			    SendClientMessage(playerid, 0xFFD700AA,str);
			    format(Receiver[playerid],32,inputtext);
			    return ShowPlayerDialog(playerid,229,DIALOG_STYLE_INPUT,"E-mail","Enter your message:","Send","Back");
    	   	}
			else
	    		SendClientMessage(playerid,0xAA3333AA,"[ERROR] The account doesn't exist.");
   		}
	}
	else if(dialogid == 228)//Delete
	{
	    if(!response)
	    {
	        new listitems[] = "Read\nSend\nDelete";
	        ShowPlayerDialog(playerid, 225, DIALOG_STYLE_LIST, "My email : ", listitems,"Select","Exit");
        }
		else
		{
	        new n;
			n = strval(inputtext);

		    new email[32];
		    format(email,32,Local,Player(playerid));
			dini_Set(email,Emails[n-1],"Empty");
		}
	}
	else if(dialogid == 229)//Send (message)
	{
	    if(response)
	    {
	    	SendClientMessage(playerid,0xFFD700AA,"E-mail successfully sent.");
			SendEmail(playerid,inputtext);
		}
	}
	else if(dialogid == 230)//Show e-mail
	{
	    if(response)
	    {
	        new listitems[] = "Read\nSend\nDelete";
	        ShowPlayerDialog(playerid, 225, DIALOG_STYLE_LIST, "My email : ", listitems,"Select","Exit");
        }
	}
	return 1;
}

stock MyEmail(playerid,number)
{
    new email[32],email2[128];
    format(email,32,Local,Player(playerid));

    if(strcmp(dini_Get(email,Emails[number]),"Empty",true)==0)
        return ShowPlayerDialog(playerid, 225, DIALOG_STYLE_LIST, "My email : ", "Read\nSend\nDelete","Select","Exit");

    format(email2,128,"%s",dini_Get(email,Emails[number]));
    if(email2[1] == 'N')
    {
		strdel(email2,0,14);
		dini_Set(email,Emails[number],email2);
		format(email2,128,"%s%s",Status[0],dini_Get(email,Emails[number]));
		dini_Set(email,Emails[number],email2);
	}
    ShowPlayerDialog(playerid, 230, DIALOG_STYLE_MSGBOX, "Inbox", email2, "Back", "Exit");
    return 1;
}

stock SendEmail(playerid,const string[])
{
	new email[32],str[128];
    format(email,32,Local,Receiver[playerid]);
    if(!dini_Exists(email))
    {
	    for(new i=0;i<sizeof(Emails);i++)
            dini_Set(email,Emails[i],"Empty");
    }
    else
    {
        format(str,128,"%s %s - Sender : %s",Status[1],string,Player(playerid));
		for(new i=0;i<sizeof(Emails);i++)
   	    	if(strcmp(dini_Get(email,Emails[i]),"Empty",true)==0)
   	    	{
   	    	    new giveid = ReturnUser(Receiver[playerid]);
   	    	    if(IsPlayerConnected(giveid))
   	    	        GameTextForPlayer(giveid, "You received a new e-mail.", 5000, 5);
    			dini_Set(email,Emails[i],str);
    			return 1;
   			}

        return SendClientMessage(playerid,0xAA3333AA,"[ERROR] The inbox is full.");
	}
	return 1;
}

stock Player(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	return pname;
}

stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	    if(string[i] > '9' || string[i] < '0') return 0;

	return 1;
}

stock ReturnUser(PlayerName[])
{
	if(IsNumeric(PlayerName))
	    return strval(PlayerName);
	else
	{
		new found=0, id;
		for(new i=0; i <= MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
		  		new foundname[MAX_PLAYER_NAME];
		  		GetPlayerName(i, foundname, MAX_PLAYER_NAME);
				new namelen = strlen(foundname);
				new bool:searched=false;
		    	for(new pos=0; pos <= namelen; pos++)
				{
					if(searched != true)
					{
						if(strfind(foundname,PlayerName,true) == pos)
						{
			                found++;
							id = i;
						}
					}
				}
			}
		}
		if(found == 1)
			return id;
		else
			return INVALID_PLAYER_ID;
	}
}