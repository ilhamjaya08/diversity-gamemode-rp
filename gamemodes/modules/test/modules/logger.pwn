#define RUN_TESTS
#define LIGHT_TEST_REPORT

#include <a_samp>
#include <chrono>
#include "..\..\core\logger.pwn"
#include <YSI\y_testing>

Test:TEST_LOG_NONE()
{
  new result = Log_Save(E_LOG_NONE, "This is a y_testing here!");
  ASSERT(result == 0);
}

Test:TEST_LOG_ACP_BAN()
{
  new result = Log_Save(E_LOG_ACP_BAN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_ADD_SALARY()
{
  new result = Log_Save(E_LOG_ADD_SALARY, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_ADMIN_CHAT()
{
  new result = Log_Save(E_LOG_ADMIN_CHAT, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_ADMIN_COMMAND()
{
  new result = Log_Save(E_LOG_ADMIN_COMMAND, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_ADM_RESET_PASS()
{
  new result = Log_Save(E_LOG_ADMIN_RESET_PASSWORD, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_ADMIN_SELL()
{
  new result = Log_Save(E_LOG_ADMIN_SELL, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_APARTMENT()
{
  new result = Log_Save(E_LOG_APARTMENT, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_APARTMENT_SAFE()
{
  new result = Log_Save(E_LOG_APARTMENT_ITEMS, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_APARTMENT_ITEMS()
{
  new result = Log_Save(E_LOG_APARTMENT_SAFE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_BAN()
{
  new result = Log_Save(E_LOG_BAN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_BIZ()
{
  new result = Log_Save(E_LOG_BIZ, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_BUSINESS()
{
  new result = Log_Save(E_LOG_BUSINESS, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_CHANGE_CHAR_NAME()
{
  new result = Log_Save(E_LOG_CHANGE_CHAR_NAME, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_CHARITY()
{
  new result = Log_Save(E_LOG_CHARITY, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_CHEAT()
{
  new result = Log_Save(E_LOG_CHEAT, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_CONNECTIONS()
{
  new result = Log_Save(E_LOG_CONNECTIONS, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_CREATE_VEHICLE()
{
  new result = Log_Save(E_LOG_CREATE_VEHICLE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_CURE()
{
  new result = Log_Save(E_LOG_CURE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_DEPOSIT()
{
  new result = Log_Save(E_LOG_DEPOSIT, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_DESTROY_ITEM()
{
  new result = Log_Save(E_LOG_DESTROY_ITEM, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_DROP_PICK()
{
  new result = Log_Save(E_LOG_DROP_PICK, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_DROP_WEAPON()
{
  new result = Log_Save(E_LOG_DROP_WEAPON, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_DYNAMIC_JOB()
{
  new result = Log_Save(E_LOG_DYNAMIC_JOB, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_DYNAMIC_VEHICLE()
{
  new result = Log_Save(E_LOG_DYNAMIC_VEHICLE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_EDIT_OBJECT()
{
  new result = Log_Save(E_LOG_EDIT_OBJECT, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_FACTION_CHAT()
{
  new result = Log_Save(E_LOG_FACTION_CHAT, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_FACTION_OOC_CHAT()
{
  new result = Log_Save(E_LOG_FACTION_OOC_CHAT, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_FINE_COIN()
{
  new result = Log_Save(E_LOG_FINE_COIN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_FINE()
{
  new result = Log_Save(E_LOG_FINE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_FACTION_WITHDRAW()
{
  new result = Log_Save(E_LOG_FACTION_WITHDRAW, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_GARAGE()
{
  new result = Log_Save(E_LOG_GARAGE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_GENERATE_COIN()
{
  new result = Log_Save(E_LOG_GENERATE_COIN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_GENERATE_VIP()
{
  new result = Log_Save(E_LOG_GENERATE_VIP, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_GIVE()
{
  new result = Log_Save(E_LOG_GIVE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_GUN_AUTH()
{
  new result = Log_Save(E_LOG_GUN_AUTH, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_HEAL()
{
  new result = Log_Save(E_LOG_HEAL, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_HOUSE_ITEMS()
{
  new result = Log_Save(E_LOG_HOUSE_ITEMS, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_HOUSE()
{
  new result = Log_Save(E_LOG_HOUSE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_HOUSE_SAFE()
{
  new result = Log_Save(E_LOG_HOUSE_SAFE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_IP_BAN()
{
  new result = Log_Save(E_LOG_IP_BAN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_JAIL()
{
  new result = Log_Save(E_LOG_JAIL, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_KICK()
{
  new result = Log_Save(E_LOG_KICK, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_KILL()
{
  new result = Log_Save(E_LOG_KILL, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_LEAVE_TAXI()
{
  new result = Log_Save(E_LOG_LEAVE_TAXI, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_LICENSE()
{
  new result = Log_Save(E_LOG_LICENSE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_MYSQL()
{
  new result = Log_Save(E_LOG_MYSQL, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_OFFER()
{
  new result = Log_Save(E_LOG_OFFER, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_OFFER_VEH()
{
  new result = Log_Save(E_LOG_OFFER_VEH, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_OFFLINE_FINE()
{
  new result = Log_Save(E_LOG_OFFLINE_FINE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_OFFLINE_FINE_COIN()
{
  new result = Log_Save(E_LOG_OFFLINE_FINE_COIN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_PAY()
{
  new result = Log_Save(E_LOG_PAY, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_PM()
{
  new result = Log_Save(E_LOG_PM, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_RCON()
{
  new result = Log_Save(E_LOG_RCON, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_REDEEM_CODE()
{
  new result = Log_Save(E_LOG_REDEEM_CODE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_REDEEM_COIN()
{
  new result = Log_Save(E_LOG_REDEEM_COIN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_RESET_STORAGE()
{
  new result = Log_Save(E_LOG_RESET_STORAGE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_RESET_VIP()
{
  new result = Log_Save(E_LOG_RESET_VIP, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_SET_ACP_NAME()
{
  new result = Log_Save(E_LOG_SET_ACP_NAME, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_SET_ADMIN()
{
  new result = Log_Save(E_LOG_SET_ADMIN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_SET_ITEM()
{
  new result = Log_Save(E_LOG_SET_ITEM, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_SET_NAME()
{
  new result = Log_Save(E_LOG_SET_NAME, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_SET_PLAYER()
{
  new result = Log_Save(E_LOG_SET_PLAYER, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_SPAWN_ITEM()
{
  new result = Log_Save(E_LOG_SPAWN_ITEM, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_STORAGE()
{
  new result = Log_Save(E_LOG_STORAGE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_TEMP_BAN()
{
  new result = Log_Save(E_LOG_TEMP_BAN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_TICKET()
{
  new result = Log_Save(E_LOG_TICKET, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_TRANSFER()
{
  new result = Log_Save(E_LOG_TRANSFER, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_UNWARN()
{
  new result = Log_Save(E_LOG_UNWARN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_VEHICLE_STORAGE()
{
  new result = Log_Save(E_LOG_VEHICLE_STORAGE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_VENDING_MACHINE()
{
  new result = Log_Save(E_LOG_VENDING_MACHINE, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_WARN()
{
  new result = Log_Save(E_LOG_WARN, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_WEAPON()
{
  new result = Log_Save(E_LOG_WEAPON, "This is a y_testing here!");
  ASSERT(result == 1);
}

Test:TEST_LOG_WITHDRAW()
{
  new result = Log_Save(E_LOG_WITHDRAW, "This is a y_testing here!");
  ASSERT(result == 1);
}
