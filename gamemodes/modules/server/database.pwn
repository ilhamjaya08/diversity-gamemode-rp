/*==============================================================================

                                Database module

==============================================================================*/

enum E_CONNECTION_DATA
{
    szDatabaseHostname[32],
    szDatabaseUsername[32],
    szDatabaseName[32],
    szDatabasePassword[64]
};

// new
//     connectionInfo[E_CONNECTION_DATA];

MySqlStartConnection()
{
    mysql_log(ERROR | WARNING);
    g_iHandle = mysql_connect_file();

    if(mysql_errno(g_iHandle) != 0) {
        SendRconCommand("password lk&iu&sds7*)");
        SendRconCommand("hostname Occurred error connection to database ...");

        new error[128];
        mysql_error(error, sizeof(error), g_iHandle);
        printf("[Database] Failed! Error: [%d] %s", mysql_errno(g_iHandle), error);
    }
    else
    {
        printf("[Database] Connected!");
        CallRemoteFunction("OnDBConnReady", "");
    }
    return 1;
}

MySqlCloseConnection()
{
    mysql_close(g_iHandle);
    return 1;
}