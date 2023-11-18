#if defined _inc_func
  #undef _inc_func
#endif
#if defined CORE_LOGGER_FUNC
  #endinput
#endif
#define CORE_LOGGER_FUNC



// Make sure you have run create_log_folder.sh if you don't have ever run it!
Log_Save(type, const text[])
{
    new
        File:file,
        Timestamp:now = Timestamp:Now() + Hours:7,
        file_path[128],
        file_time[32],
        write_attempt = 0
    ;

    TimeFormat(now, "%d-%m-%Y", file_time);

    switch (type)
    {
        case E_LOG_ACP_BAN:
        {
            format(file_path, sizeof(file_path), "logs/acp_ban/acp_ban_log_%s.log", file_time);
        }
        case E_LOG_ADD_SALARY:
        {
            format(file_path, sizeof(file_path), "logs/add_salary/add_salary_log_%s.log", file_time);
        }
        case E_LOG_ADMIN_CHAT:
        {
            format(file_path, sizeof(file_path), "logs/admin_chat/admin_chat_log_%s.log", file_time);
        }
        case E_LOG_ADMIN_COMMAND:
        {
            format(file_path, sizeof(file_path), "logs/admin_command/admin_command_log_%s.log", file_time);
        }
        case E_LOG_ADMIN_RESET_PASSWORD:
        {
            format(file_path, sizeof(file_path), "logs/admin_reset_password/admin_reset_password_log_%s.log", file_time);
        }
        case E_LOG_ADMIN_SELL:
        {
            format(file_path, sizeof(file_path), "logs/admin_sell/admin_sell_log_%s.log", file_time);
        }
        case E_LOG_BAN:
        {
            format(file_path, sizeof(file_path), "logs/ban/ban_log_%s.log", file_time);
        }
        case E_LOG_BIZ:
        {
            format(file_path, sizeof(file_path), "logs/biz/biz_log_%s.log", file_time);
        }
        case E_LOG_BUSINESS:
        {
            format(file_path, sizeof(file_path), "logs/business/business_log_%s.log", file_time);
        }
        case E_LOG_CHANGE_CHAR_NAME:
        {
            format(file_path, sizeof(file_path), "logs/change_char_name/change_char_name_log_%s.log", file_time);
        }
        case E_LOG_CHARITY:
        {
            format(file_path, sizeof(file_path), "logs/charity/charity_log_%s.log", file_time);
        }
        case E_LOG_CHEAT:
        {
            format(file_path, sizeof(file_path), "logs/cheat/cheat_log_%s.log", file_time);
        }
        case E_LOG_CONNECTIONS:
        {
            format(file_path, sizeof(file_path), "logs/connections/connections_log_%s.log", file_time);
        }
        case E_LOG_CREATE_VEHICLE:
        {
            format(file_path, sizeof(file_path), "logs/create_vehicle/create_vehicle_log_%s.log", file_time);
        }
        case E_LOG_CURE:
        {
            format(file_path, sizeof(file_path), "logs/cure/cure_log_%s.log", file_time);
        }
        case E_LOG_DEPOSIT:
        {
            format(file_path, sizeof(file_path), "logs/deposit/deposit_log_%s.log", file_time);
        }
        case E_LOG_DESTROY_ITEM:
        {
            format(file_path, sizeof(file_path), "logs/destroy_item/destroy_item_log_%s.log", file_time);
        }
        case E_LOG_DROP_PICK:
        {
            format(file_path, sizeof(file_path), "logs/drop_pick/drop_pick_log_%s.log", file_time);
        }
        case E_LOG_DROP_WEAPON:
        {
            format(file_path, sizeof(file_path), "logs/drop_weapon/drop_weapon_log_%s.log", file_time);
        }
        case E_LOG_DYNAMIC_JOB:
        {
            format(file_path, sizeof(file_path), "logs/dynamic_job/dynamic_job_log_%s.log", file_time);
        }
        case E_LOG_DYNAMIC_VEHICLE:
        {
            format(file_path, sizeof(file_path), "logs/dynamic_vehicle/dynamic_vehicle_log_%s.log", file_time);
        }
        case E_LOG_EDIT_OBJECT:
        {
            format(file_path, sizeof(file_path), "logs/edit_object/edit_object_log_%s.log", file_time);
        }
        case E_LOG_FACTION_CHAT:
        {
            format(file_path, sizeof(file_path), "logs/faction_chat/faction_chat_log_%s.log", file_time);
        }
        case E_LOG_FACTION_OOC_CHAT:
        {
            format(file_path, sizeof(file_path), "logs/faction_ooc_chat/faction_ooc_chat_log_%s.log", file_time);
        }
        case E_LOG_FINE_COIN:
        {
            format(file_path, sizeof(file_path), "logs/fine_coin/fine_coin_log_%s.log", file_time);
        }
        case E_LOG_FINE:
        {
            format(file_path, sizeof(file_path), "logs/fine/fine_log_%s.log", file_time);
        }
        case E_LOG_FACTION_WITHDRAW:
        {
            format(file_path, sizeof(file_path), "logs/faction_withdraw/faction_withdraw_log_%s.log", file_time);
        }
        case E_LOG_GARAGE:
        {
            format(file_path, sizeof(file_path), "logs/garage/garage_log_%s.log", file_time);
        }
        case E_LOG_GENERATE_COIN:
        {
            format(file_path, sizeof(file_path), "logs/generate_coin/generate_coin_log_%s.log", file_time);
        }
        case E_LOG_GENERATE_VIP:
        {
            format(file_path, sizeof(file_path), "logs/generate_vip/generate_vip_log_%s.log", file_time);
        }
        case E_LOG_GIVE:
        {
            format(file_path, sizeof(file_path), "logs/give/give_log_%s.log", file_time);
        }
        case E_LOG_GUN_AUTH:
        {
            format(file_path, sizeof(file_path), "logs/gun_auth/gun_auth_log_%s.log", file_time);
        }
        case E_LOG_HEAL:
        {
            format(file_path, sizeof(file_path), "logs/heal/heal_log_%s.log", file_time);
        }
        case E_LOG_HOUSE_ITEMS:
        {
            format(file_path, sizeof(file_path), "logs/house_items/house_items_log_%s.log", file_time);
        }
        case E_LOG_HOUSE:
        {
            format(file_path, sizeof(file_path), "logs/house/house_log_%s.log", file_time);
        }
        case E_LOG_HOUSE_SAFE:
        {
            format(file_path, sizeof(file_path), "logs/house_safe/house_safe_log_%s.log", file_time);
        }
        case E_LOG_IP_BAN:
        {
            format(file_path, sizeof(file_path), "logs/ip_ban/ip_ban_log_%s.log", file_time);
        }
        case E_LOG_JAIL:
        {
            format(file_path, sizeof(file_path), "logs/jail/jail_log_%s.log", file_time);
        }
        case E_LOG_KICK:
        {
            format(file_path, sizeof(file_path), "logs/kick/kick_log_%s.log", file_time);
        }
        case E_LOG_KILL:
        {
            format(file_path, sizeof(file_path), "logs/kill/kill_log_%s.log", file_time);
        }
        case E_LOG_LEAVE_TAXI:
        {
            format(file_path, sizeof(file_path), "logs/leave_taxi/leave_taxi_log_%s.log", file_time);
        }
        case E_LOG_LICENSE:
        {
            format(file_path, sizeof(file_path), "logs/license/license_log_%s.log", file_time);
        }
        case E_LOG_MYSQL:
        {
            format(file_path, sizeof(file_path), "logs/mysql/mysql_log_%s.log", file_time);
        }
        case E_LOG_OFFER:
        {
            format(file_path, sizeof(file_path), "logs/offer/offer_log_%s.log", file_time);
        }
        case E_LOG_OFFER_VEH:
        {
            format(file_path, sizeof(file_path), "logs/offer_veh/offer_veh_log_%s.log", file_time);
        }
        case E_LOG_OFFLINE_FINE:
        {
            format(file_path, sizeof(file_path), "logs/offline_fine/offline_fine_log_%s.log", file_time);
        }
        case E_LOG_OFFLINE_FINE_COIN:
        {
            format(file_path, sizeof(file_path), "logs/offline_fine_coin/offline_fine_coin_log_%s.log", file_time);
        }
        case E_LOG_PAY:
        {
            format(file_path, sizeof(file_path), "logs/pay/pay_log_%s.log", file_time);
        }
        case E_LOG_PM:
        {
            format(file_path, sizeof(file_path), "logs/pm/pm_log_%s.log", file_time);
        }
        case E_LOG_RCON:
        {
            format(file_path, sizeof(file_path), "logs/rcon/rcon_log_%s.log", file_time);
        }
        case E_LOG_REDEEM_CODE:
        {
            format(file_path, sizeof(file_path), "logs/redeem_code/redeem_code_log_%s.log", file_time);
        }
        case E_LOG_REDEEM_COIN:
        {
            format(file_path, sizeof(file_path), "logs/redeem_coin/redeem_coin_log_%s.log", file_time);
        }
        case E_LOG_RESET_STORAGE:
        {
            format(file_path, sizeof(file_path), "logs/reset_storage/reset_storage_log_%s.log", file_time);
        }
        case E_LOG_RESET_VIP:
        {
            format(file_path, sizeof(file_path), "logs/reset_vip/reset_vip_log_%s.log", file_time);
        }
        case E_LOG_SET_ACP_NAME:
        {
            format(file_path, sizeof(file_path), "logs/set_acp_name/set_acp_name_log_%s.log", file_time);
        }
        case E_LOG_SET_ADMIN:
        {
            format(file_path, sizeof(file_path), "logs/set_admin/set_admin_log_%s.log", file_time);
        }
        case E_LOG_SET_ITEM:
        {
            format(file_path, sizeof(file_path), "logs/set_item/set_item_log_%s.log", file_time);
        }
        case E_LOG_SET_NAME:
        {
            format(file_path, sizeof(file_path), "logs/set_name/set_name_log_%s.log", file_time);
        }
        case E_LOG_SET_PLAYER:
        {
            format(file_path, sizeof(file_path), "logs/set_player/set_player_log_%s.log", file_time);
        }
        case E_LOG_SPAWN_ITEM:
        {
            format(file_path, sizeof(file_path), "logs/spawn_item/spawn_item_log_%s.log", file_time);
        }
        case E_LOG_STORAGE:
        {
            format(file_path, sizeof(file_path), "logs/storage/storage_log_%s.log", file_time);
        }
        case E_LOG_TEMP_BAN:
        {
            format(file_path, sizeof(file_path), "logs/temp_ban/temp_ban_log_%s.log", file_time);
        }
        case E_LOG_TICKET:
        {
            format(file_path, sizeof(file_path), "logs/ticket/ticket_log_%s.log", file_time);
        }
        case E_LOG_TRANSFER:
        {
            format(file_path, sizeof(file_path), "logs/transfer/transfer_log_%s.log", file_time);
        }
        case E_LOG_UNWARN:
        {
            format(file_path, sizeof(file_path), "logs/unwarn/unwarn_log_%s.log", file_time);
        }
        case E_LOG_VEHICLE_STORAGE:
        {
            format(file_path, sizeof(file_path), "logs/vehicle_storage/vehicle_storage_log_%s.log", file_time);
        }
        case E_LOG_VENDING_MACHINE:
        {
            format(file_path, sizeof(file_path), "logs/vending_machine/vending_machine_log_%s.log", file_time);
        }
        case E_LOG_WARN:
        {
            format(file_path, sizeof(file_path), "logs/warn/warn_log_%s.log", file_time);
        }
        case E_LOG_WEAPON:
        {
            format(file_path, sizeof(file_path), "logs/weapon/weapon_log_%s.log", file_time);
        }
        case E_LOG_WITHDRAW:
        {
            format(file_path, sizeof(file_path), "logs/withdraw/withdraw_log_%s.log", file_time);
        }
        case E_LOG_APARTMENT_ITEMS:
        {
            format(file_path, sizeof(file_path), "logs/apartment_items/apartmentitem_log_%s.log", file_time);
        }
        case E_LOG_APARTMENT:
        {
            format(file_path, sizeof(file_path), "logs/apartment/apartment_log_%s.log", file_time);
        }
        case E_LOG_APARTMENT_SAFE:
        {
            format(file_path, sizeof(file_path), "logs/apartment_safe/apartmentsafe_log_%s.log", file_time);
        }
        default:
        {
            printf("[LOG WRITER] Log type not supported. Current value log type: %d", type);
            printf("[LOG WRITER] Content: %s", text);
            return 0;
        }
    }

    while (!file)
    {
        file = fopen(file_path, filemode:io_append);
        write_attempt++;

        if (write_attempt > 3)
        {
            printf("[LOG WRITER] Something wrong when writing text into \"%s\" with io_append. Dumping the content...", file_path);
            printf("[LOG WRITER] [Dump from: %s] -> %s", file_path, text);
            return 0;
        }
    }

    fwrite(file, text);
    fwrite(file, "\r\n");
    fclose(file);
    return 1;
}