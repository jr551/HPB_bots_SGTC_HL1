#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>
#include <fun>
#include <engine>

#define PLUGIN "SGTC BOTS GIVE WEAPONS"
#define VERSION "1.0"
#define AUTHOR "Freeman"

public plugin_init()
{
	register_plugin(PLUGIN,VERSION,AUTHOR)
	register_event("ResetHUD", "event_spawn", "b");
	set_task(float(10),"checkPlayers",_,_,_,"b")
}
public event_spawn(id)
{
	//log_amx( "[SGTC Weapons]  spawn.");
	//make_sure_has_gun(id);
	
}

public make_sure_has_gun(id) 
{	

	
	
	if(is_user_alive(id) && is_user_bot(id) ) 
	{
	
		new iWeapon = get_user_weapon( id );
		new szWeapon[ 32 ];
		    
		if ( iWeapon )
			get_weaponname( iWeapon , szWeapon , 31 );  
		else
			return 0;
			
		new szUsername[ 32 ];
		get_user_name(id,  szUsername, 31);
			
			
		log_amx( "[SGTC Weapons] %s has weapon: %s.", szUsername,  szWeapon);
		
		if (equal( szWeapon, "weapon_batsup") || equal( szWeapon, "weapon_coujaf") || equal( szWeapon, "weapon_couteau") )
		{
		
			if ( get_user_team(id) == 1 ) //tauri
			{
				new iChance = random_num(0, 4);
				if (iChance == 0)
				{
				   give_item(id, "weapon_mp5")
				}
				else if (iChance == 1)
				{
				   give_item(id, "weapon_psg1")
				}
				else if (iChance == 2)
				{
				   give_item(id, "weapon_psg1")
				}
				else if (iChance == 3)
				{
				   give_item(id, "weapon_m16")
				}
				else
				{
				   give_item(id, "weapon_p90")
				}
	
			}
			else // goauld
			{
				new iChance = random_num(0, 4);
				if (iChance == 0)
				{
				   give_item(id, "weapon_reetou")
				}
				else if (iChance == 1)
				{
				   give_item(id, "weapon_glstaff")
				}
				else if (iChance == 2)
				{
				   give_item(id, "weapon_zatarc")
				}
				else if (iChance == 3)
				{
				   give_item(id, "weapon_lance")
				}
				else
				{
				   give_item(id, "weapon_main")
				}		
			}
			
			
		}
		else
		{
			//log_amx( "[SGTC Weapons] (dont give a wep) %s has weapon: %s.", szUsername,  szWeapon);
			
		}
	
	}
	
}



public checkPlayers() {
	


	new realPlayers = 0;

	
	log_amx( "[SGTC Weapons]  checkPlayers.");
	for (new i = 1; i <= get_maxplayers(); i++) {
		if ( !is_user_bot(i) && is_user_alive(i) ) {
			realPlayers = realPlayers + 1;
		}
	
		if (is_user_alive(i) && is_user_connected(i)  ) {
			make_sure_has_gun(i) ;	
		}
		
		if (is_user_bot(i) && get_user_team(i) == 0 )
		{
			log_amx( "[SGTC Weapons]  force spectating bot to join.");
			new iChance = random_num(0, 1);
			if (iChance == 0)
				client_cmd(i,"jointeam 1;classe 1 1") ;
			else
				client_cmd(i,"jointeam 2;classe 2 2") ;
				
		}	
	}

	
	
	
		if (/*realPlayers < 1 &&*/ get_cvar_num("mp_timeleft")   < 0)
		{
			log_amx( "[SGTC ]  killbots.");
			/*for (new i = 1; i <= get_maxplayers(); i++) {
			user_kill(i);*/
			
			new szNextMap[ 32 ];
			new szcmd[ 64 ];
			get_cvar_string( "amx_nextmap", szNextMap, 31);
			
			format(szcmd,64,"changelevel %s", szNextMap);
			
			server_cmd(szcmd);
			
		//}
		}	  
	
	return PLUGIN_HANDLED;
}
