import { OvaleScripts } from "../Scripts";
export function register() {
    let name = "ovale_warrior_spells";
    let desc = "[8.0.1] Ovale: Warrior spells";
    let code = `
ItemRequire(shifting_cosmic_sliver unusable 1=oncooldown,!shield_wall,buff,!shield_wall_buff)	
	
# Warrior spells and functions.

# Learned spells.
Define(avatar 107574)
	SpellInfo(avatar rage=-20 cd=90)
	SpellAddBuff(avatar avatar_buff=1)
Define(avatar_buff 107574)
	SpellInfo(avatar_buff duration=20)
Define(battle_shout 6673)
	SpellAddBuff(battle_shout battle_shout_buff=1)
Define(battle_shout_buff 6673)
Define(berserker_rage 18499)
	SpellInfo(berserker_rage cd=60 gcd=0)
	SpellInfo(berserker_rage rage=-20 itemset=T20 itemcount=2 specialization=protection)
	SpellAddBuff(berserker_rage berserker_rage_buff=1)
Define(berserker_rage_buff 18499)
	SpellInfo(berserker_rage_buff duration=6)
Define(bladestorm_arms 227847)
	SpellInfo(bladestorm_arms cd=90 channel=6 haste=melee replace=ravager)
Define(bladestorm_fury 46924)
	SpellInfo(bladestorm_fury cd=60 channel=4 haste=melee)
Define(bloodthirst 23881)
	SpellInfo(bloodthirst cd=4.5 rage=-8 cd_haste=melee)
	SpellAddBuff(bloodthirst whirlwind_buff=-1)
Define(charge 100) 
	SpellInfo(charge cd=20 gcd=0 offgcd=1 rage=-25 travel_time=1 charges=1)
	SpellInfo(charge add_cd=-3 charges=2 talent=double_time_talent)
	SpellAddTargetDebuff(charge charge_debuff=1)
Define(charge_debuff 105771)
Define(cleave 845)
	SpellInfo(cleave cd=9 cd_haste=melee rage=20)
	SpellRequire(cleave rage_percent 0=buff,deadly_calm_buff talent=deadly_calm_talent specialization=arms)
Define(colossus_smash 167105)
	SpellInfo(colossus_smash cd=45)
	SpellInfo(colossus_smash replace=warbreaker talent=warbreaker_talent)
	SpellAddTargetDebuff(colossus_smash colossus_smash_debuff=1)
	SpellAddBuff(colossus_smash in_for_the_kill_buff=1 talent=in_for_the_kill_talent)
Define(colossus_smash_debuff 208086)
	SpellInfo(colossus_smash_debuff duration=10)
Define(deadly_calm 262228)
	SpellInfo(deadly_calm cd=60)
    SpellAddBuff(deadly_calm deadly_calm_buff=1)
Define(deadly_calm_buff 262228)
    SpellInfo(deadly_calm_buff duration=6)
Define(deep_wounds_prot_debuff 115767)
	SpellInfo(deep_wounds_prot_debuff duration=15 tick=3 haste=meleen)
Define(deep_wounds_arms_debuff 262115)
	SpellInfo(deep_wounds_arms_debuff duration=6 tick=2 haste=meleen)
Define(defensive_stance 197690)
	SpellInfo(defensive_stance cd=6)
	SpellAddBuff(defensive_stance defensive_stance_buff=1)
Define(defensive_stance_buff 197690)
Define(demoralizing_shout 1160)
	SpellInfo(demoralizing_shout cd=45)
	SpellInfo(demoralizing_shout add_rage=-40 talent=booming_voice_talent)
	SpellAddTargetDebuff(demoralizing_shout demoralizing_shout_debuff=1)
Define(demoralizing_shout_debuff 1160)
	SpellInfo(demoralizing_shout_debuff duration=8)
Define(devastate 20243)
	SpellInfo(devastate unusable=1 talent=devastator_talent)
	SpellAddTargetDebuff(devastate deep_wounds_prot_debuff=1 specialization=protection)
Define(die_by_the_sword 118038)
	SpellInfo(die_by_the_sword cd=180 gcd=0 offgcd=1)
	SpellAddBuff(die_by_the_sword die_by_the_sword_buff=1)
Define(die_by_the_sword_buff 118038)
	SpellInfo(die_by_the_sword_buff duration=8)
Define(dragon_roar 118000)
	SpellInfo(dragon_roar cd=35 rage=-10)
	SpellAddBuff(dragon_roar dragon_roar_buff=1)
Define(dragon_roar_buff 118000)
	SpellInfo(dragon_roar_buff duration=6)
Define(enrage_buff 184362)
	SpellInfo(enrage_buff duration=4 enrage=1)
Define(enraged_regeneration 184364)
	SpellInfo(enraged_regeneration cd=120 gcd=0 offgcd=1)
	SpellAddBuff(enraged_regeneration enraged_regeneration_buff=1)
Define(enraged_regeneration_buff 184364)
	SpellInfo(enraged_regeneration_buff duration=8)
Define(execute_arms 163201)
	SpellInfo(execute_arms rage=20 max_rage=40 target_health_pct=20)
	SpellInfo(execute_arms target_health_pct=35 talent=arms_massacre_talent)
	SpellRequire(execute_arms rage_percent 0=buff,execute_arms_norage)
	SpellRequire(execute_arms target_health_pct 100=buff,execute_arms_nohp)
SpellList(execute_arms_norage sudden_death_arms_buff stone_heart_buff deadly_calm_buff)
SpellList(execute_arms_nohp sudden_death_arms_buff stone_heart_buff)
Define(execute 5308)
	SpellInfo(execute rage=-20 target_health_pct=20)
	SpellInfo(execute target_health_pct=35 talent=massacre_talent)
	SpellRequire(execute target_health_pct 100=buff,execute_free)
	SpellRequire(execute cd_percent 0=buff,execute_free)
SpellList(execute_free sudden_death_fury_buff stone_heart_buff)
Define(frothing_berserker_buff 215572)
	SpellInfo(frothing_berserker_buff duration=6)
Define(frenzy_buff 202539)
	SpellInfo(frenzy_buff duration=15 max_stacks=3)
Define(furious_slash 100130)
	SpellAddBuff(furious_slash frenzy_buff=1)
Define(hamstring 1715)
	SpellInfo(hamstring cd=1 rage=10)
	SpellAddTargetDebuff(hamstring hamstring_debuff=1)
Define(hamstring_debuff 1715)
	SpellInfo(hamstring_debuff duration=15)
Define(heroic_leap 6544)
	SpellInfo(heroic_leap cd=45 gcd=0 offgcd=1 travel_time=1)
	SpellInfo(heroic_leap add_cd=-15 talent=bounding_stride_talent specialization=!protection)
	SpellInfo(heroic_leap add_cd=-15 talent=prot_bounding_stride_talent specialization=protection)
	SpellAddBuff(heroic_leap heroic_leap_buff=1 talent=bounding_stride_talent specialization=!protection)
	SpellAddBuff(heroic_leap heroic_leap_buff=1 talent=prot_bounding_stride_talent specialization=protection)
Define(heroic_leap_buff 202164)
Define(heroic_throw 57755)
	SpellInfo(heroic_throw cd=6 travel_time=1)
	SpellInfo(heroic_throw add_cd=-6 specialization=protection)
Define(ignore_pain 190456)
	SpellInfo(ignore_pain rage=40)
	SpellAddBuff(ignore_pain ignore_pain_buff=1)
	SpellAddBuff(ignore_pain vengeance_ignore_pain_buff=0 talent=vengeance_talent)
	SpellAddBuff(ignore_pain vengeance_revenge_buff=1 talent=vengeance_talent)
Define(ignore_pain_buff 190456)
	SpellInfo(ignore_pain duration=12)
Define(impending_victory 202168)
	SpellInfo(impending_victory rage=10 cd=30)
	SpellRequire(impending_victory cd_percent 0=victorious_buff)
	SpellAddBuff(impending_victory victorious_buff=0)
Define(in_for_the_kill_buff 248622)
	SpellInfo(in_for_the_kill_buff duration=8)
Define(intercept 198304)
	SpellInfo(intercept cd=15 rage=-20 charges=2)
	SpellAddTargetDebuff(intercept charge_debuff=1)
	SpellAddTargetBuff(intercept safeguard_buff=1)
Define(intimidating_shout 5246)
Define(into_the_fray_buff 202602)
Define(last_stand 12975)
	SpellInfo(last_stand cd=180)
	SpellInfo(last_stand add_cd=-60 talent=bolster_talent)
	SpellAddBuff(last_stand last_stand_buff=1)
Define(last_stand_buff 12975)
	SpellInfo(last_stand_buff duration=15)
Define(mortal_strike 12294)
	SpellInfo(mortal_strike cd=6 cd_haste=melee rage=30)
	SpellRequire(mortal_strike rage_percent 0=buff,deadly_calm_buff talent=deadly_calm_talent specialization=arms)
	SpellAddTargetDebuff(mortal_strike mortal_wounds_debuff=1)
	SpellAddBuff(mortal_strike overpower_buff=0)
Define(mortal_wounds_debuff 115804)
	SpellInfo(mortal_wounds_debuff duration=10)
Define(overpower 7384)
	SpellInfo(overpower cd=12)
	SpellInfo(overpower charges=2 talent=dreadnaught_talent)
	SpellAddBuff(overpower overpower_buff=1)
Define(overpower_buff 7384)
	SpellInfo(overpower_buff duration=15 max_stacks=2)
Define(piercing_howl 12323)
	SpellInfo(piercing_howl rag=10)
	SpellAddBuff(piercing_howl piercing_howl_debuff=1)
Define(piercing_howl_debuff 12323)
	SpellInfo(piercing_howl_debuff duration=15)
Define(pummel 6552)
	SpellInfo(pummel cd=15 gcd=0 interrupt=1 offgcd=1)
Define(punish_debuff 275335)
	SpellInfo(punish_debuff duration=9)
Define(raging_blow 85288)
	SpellInfo(raging_blow rage=-12 cd=7 charges=2 cd_haste=melee)
	SpellInfo(raging_blow add_cd=-1 talent=inner_rage_talent)
Define(rallying_cry 97462)
	SpellInfo(rallying_cry cd=180)
	SpellAddBuff(rallying_cry rallying_cry_buff=1)
Define(rallying_cry_buff 97462)
	SpellInfo(rallying_cry_buff duration=10)
Define(rampage 184367)
	SpellInfo(rampage gcd=1.5 cd_haste=none rage=85)
	SpellInfo(rampage add_rage=-15 talent=carnage_talent)
	SpellInfo(rampage add_rage=15 talent=frothing_berserker_talent)
	SpellAddBuff(rampage enrage_buff=1)
	SpellAddBuff(rampage frothing_berserker_buff=1 talent=frothing_berserker_talent)
	SpellAddBuff(rampage whirlwind_buff=-1)
Define(ravager 152277)
	SpellInfo(ravager cd=60)
	SpellInfo(ravager ravager_buff=1)
	SpellAddTargetDebuff(ravager deep_wounds_arms_debuff=1)
Define(ravager_prot 228920)
	SpellInfo(ravager_prot cd=60)
	SpellAddBuff(ravager_prot ravager_prot_buff=1)
Define(ravager_prot_buff 227744)
	SpellInfo(ravager_prot_buff duration=12)
Define(recklessness 1719)
	SpellInfo(recklessness cd=90 tag=cd)
	SpellAddBuff(recklessness recklessness_buff=1)
Define(recklessness_buff 1719)
	SpellInfo(recklessness_buff duration=10)
	SpellInfo(recklessness_buff add_rage=-100 add_duration=4 talent=reckless_abandon_talent)
Define(rend 772)
	SpellInfo(rend rage=30)
	SpellRequire(rend rage_percent 0=buff,deadly_calm_buff talent=deadly_calm_talent specialization=arms)
Define(rend_debuff 772)
	SpellInfo(rend_debuff duration=12 tick=3)
Define(revenge 6572)
	SpellInfo(revenge cd=3 rage=30 cd_haste=melee)
	SpellRequire(revenge rage_percent 0=buff,revenge_buff)
	SpellAddTargetDebuff(revenge deep_wounds_prot_debuff=1)
	SpellAddBuff(revenge revenge_buff=0)
	SpellAddBuff(revenge vengeance_ignore_pain_buff=1 talent=vengeance_talent)
	SpellAddBuff(revenge vengeance_revenge_buff=0 talent=vengeance_talent)
Define(revenge_buff 5302)
	SpellInfo(revenge_buff duration=6)
Define(safeguard_buff 223658)
	SpellInfo(safeguard_buff duration=6)
Define(shield_block 2565)
	SpellInfo(shield_block cd=18 cd_haste=melee gcd=0 offgcd=1 rage=30)
	SpellAddBuff(shield_block shield_block_buff=1)
Define(shield_block_buff 132404)
	SpellInfo(shield_block_buff duration=6)
Define(shield_slam 23922)
	SpellInfo(shield_slam cd=9 cd_haste=melee rage=-15)
	SpellAddTargetDebuff(shield_slam punish_debuff=1 talent=punish_talent)
Define(shield_wall 871)
	SpellInfo(shield_wall cd=240 gcd=0 offgcd=1)
	SpellAddBuff(shield_wall shield_wall_buff=1)
Define(shield_wall_buff 871)
	SpellInfo(shield_wall duration=8)
Define(shockwave 46968)
	SpellInfo(shockwave cd=40)
Define(siegebreaker 280772)
	SpellInfo(siegebreaker cd=30 rage=-10)
	SpellAddTargetDebuff(siegebreaker siegebreaker_debuff=1)
Define(siegebreaker_debuff 280773)
	SpellInfo(siegebreaker_debuff duration=10)
Define(skullsplitter 260643)
	SpellInfo(skullsplitter cd=21 rage=-20 cd_haste=melee)
Define(slam 1464)
	SpellInfo(slam rage=20)
	SpellRequire(slam rage_percent 0=buff,deadly_calm_buff talent=deadly_calm_talent specialization=arms)
Define(spell_reflection 23920)
	SpellInfo(spell_reflection cd=25)
	SpellAddBuff(spell_reflection spell_reflection_buff=1)
Define(spell_reflection_buff 23920)
Define(storm_bolt 107570)
	SpellInfo(storm_bolt cd=30)
Define(sudden_death_arms_buff 52437)
	SpellInfo(sudden_death_arms_buff duration=10)
Define(sudden_death_fury_buff 280776)
	SpellInfo(sudden_death_fury_buff duration=10)
Define(sweeping_strikes 260708)
	SpellInfo(sweeping_strikes cd=25)
	SpellAddBuff(sweeping_strikes sweeping_strikes_buff=1)
Define(sweeping_strikes_buff 260708)
	SpellInfo(sweeping_strikes_buff duration=12)
Define(taunt 355)
	SpellInfo(taunt cd=8)
Define(thunder_clap 6343)
	SpellInfo(thunder_clap cd=6 rage=-5 cd_haste=melee)
	SpellRequire(thunder_clap cd_percent 50=buff,avatar_buff)
Define(vengeance_ignore_pain_buff 202574)
	SpellInfo(vengeance_ignore_pain_buff duration=15)
Define(vengeance_revenge_buff 202573)
	SpellInfo(vengeance_revenge_buff duration=15)
Define(victorious_buff 32216)
	SpellInfo(victorious_buff duration=20)
Define(victory_rush 34428)
	SpellRequire(victory_rush unusable 1=buff,!victorious_buff)
	SpellAddBuff(victory_rush victorious_buff=0)
Define(warbreaker 262161)
	SpellInfo(warbreaker cd=45 tag=main)
	SpellAddTargetDebuff(warbreaker colossus_smash_debuff=1)
	SpellAddBuff(warbreaker in_for_the_kill_buff=1 talent=in_for_the_kill_talent)
Define(whirlwind 190411)
	SpellAddBuff(whirlwind whirlwind_buff=2)
Define(whirlwind_arms 1680)
	SpellInfo(whirlwind_arms rage=30)
Define(whirlwind_buff 85739)
	SpellInfo(whirlwind_buff duration=20)

# Legion legendary items
Define(archavons_heavy_hand_item 137060)
Define(archavons_heavy_hand_spell 205144)
	# TODO Mortal strike refunds 15 rage
Define(kazzalax_fujiedas_fury_item 137053)
	SpellAddBuff(bloodthirst fujiedas_fury_buff=1 if_spell=fujiedas_fury_buff)
Define(fujiedas_fury_buff 207776)
Define(ayalas_stone_heart_item 137052)
Define(stone_heart_buff 225947)
	SpellAddBuff(execute_arms stone_heart_buff=0)
	SpellAddBuff(execute stone_heart_buff=0)
Define(the_great_storms_eye_item 151823)
Define(weight_of_the_earth_item 137077)

# Talents
Define(anger_management_talent 19)
Define(arms_massacre_talent 7)
Define(avatar_talent 17)
Define(best_served_cold_talent 7)
Define(bladestorm_talent 18)
Define(bolster_talent 12)
Define(booming_voice_talent 16)
Define(bounding_stride_talent 11)
Define(carnage_talent 13)
Define(cleave_talent 15)
Define(collateral_damage_talent 13)
Define(crackling_thunder_talent 4)
Define(deadly_calm_talent 18)
Define(defensive_stance_talent 12)
Define(devastator_talent 18)
Define(double_time_talent 4)
Define(dragon_roar_talent 17)
Define(dreadnaught_talent 20)
Define(endless_rage_talent 2)
Define(fervor_of_battle_talent 8)
Define(fresh_meat_talent 3)
Define(frothing_berserker_talent 15)
Define(furious_charge_talent 10)
Define(furious_slash_talent 9)
Define(fury_anger_management_talent 20)
Define(fury_sudden_death_talent 8)
Define(heavy_repercussions_talent 20)
Define(impending_victory_talent 3)
Define(impending_victory_talent 5)
Define(in_for_the_kill_talent 16)
Define(indomitable_talent 10)
Define(inner_rage_talent 7)
Define(into_the_fray_talent 1)
Define(massacre_talent 14)
Define(meat_cleaver_talent 16)
Define(menace_talent 13)
Define(never_surrender_talent 11)
Define(prot_bounding_stride_talent 5)
Define(prot_dragon_roar_talent 9)
Define(prot_storm_bolt_talent 15)
Define(punish_talent 2)
Define(ravager_talent 21)
Define(reckless_abandon_talent 19)
Define(rend_talent 9)
Define(rumbling_earth_talent 14)
Define(safeguard_talent 6)
Define(second_wind_talent 10)
Define(siegebreaker_talent 21)
Define(skullsplitter_talent 3)
Define(storm_bolt_talent 6)
Define(sudden_death_talent 2)
Define(unstoppable_force_talent 8)
Define(vengeance_talent 17)
Define(war_machine_talent 1)
Define(warbreaker_talent 14)
Define(warpaint_talent 12)

# Non-default tags for OvaleSimulationCraft.
	SpellInfo(heroic_throw tag=main)
	SpellInfo(impending_victory tag=main)
	SpellInfo(colossus_smash tag=main)
	SpellInfo(hamstring tag=shortcd)
	SpellInfo(avatar tag=cd)
	SpellInfo(intercept tag=misc)
`;
    OvaleScripts.RegisterScript("WARRIOR", undefined, name, desc, code, "include");
}
