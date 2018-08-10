import { OvaleScripts } from "../Scripts";
export function register() {
    let name = "ovale_warlock_spells";
    let desc = "[8.0] Ovale: Warlock spells";
    let code = `
# Aliases
SpellList(unstable_affliction_debuff unstable_affliction_1_debuff unstable_affliction_2_debuff unstable_affliction_3_debuff unstable_affliction_4_debuff unstable_affliction_5_debuff)

# Dummy buff
# Warlock.ts
Define(active_havoc_buff -80240)
	SpellInfo(active_havoc_buff duration=10)

# Warlock spells and functions.
Define(agony 980)
	SpellAddTargetDebuff(agony agony_debuff=1)
Define(agony_debuff 980)
	SpellInfo(agony_debuff duration=18 haste=spell max_stacks=10 tick=2)
	SpellInfo(agony_debuff duration=15.3 tick=1.7 talent=creeping_death_talent)
	SpellInfo(agony_debuff max_stacks=15 talent=writhe_in_agony_talent)
Define(backdraft_buff 117828)
	SpellInfo(backdraft_buff duration=10 max_stacks=4)
Define(banish 710)
Define(bilescourge_bombers 267211)
	SpellInfo(bilescourge_bombers soulshards=2 cd=30)
Define(burning_rush 111400)
	SpellAddBuff(burning_rush burning_rush_buff=1)
Define(burning_rush_buff 111400)
Define(call_dreadstalkers 104316)
	SpellInfo(call_dreadstalkers soulshards=2 cd=20)
	SpellRequire(call_dreadstalkers soulshards 1=buff,demonic_calling_buff)
	SpellAddTargetDebuff(call_dreadstalkers from_the_shadows_debuff talent=from_the_shadows_talent)
Define(cataclysm 152108)
	SpellInfo(cataclysm cd=30)
	SpellAddTargetDebuff(cataclysm immolate_debuff=1)
Define(channel_demonfire 196447)
	SpellInfo(channel_demonfire cd=25 channel=3 unusable=1)
	SpellRequire(channel_demonfire unusable 0=target_debuff,immolate_debuff)
Define(chaos_bolt 116858)
	SpellInfo(chaos_bolt soulshards=2 travel_time=1)
	SpellAddBuff(chaos_bolt backdraft_buff=-1)
	SpellAddTargetDebuff(chaos_bolt eradication_debuff=1 talent=eradication_talent)
Define(command_demon 119898)
Define(conflagrate 17962)
	SpellInfo(conflagrate soulshards=-0.5)
	SpellAddBuff(conflagrate backdraft_buff=1)
	SpellAddBuff(conflagrate backdraft_buff=2 talent=flashover_talent)
Define(corruption 172)
	SpellAddTargetDebuff(corruption corruption_debuff=1)
Define(corruption_debuff 146739)
	SpellInfo(corruption_debuff duration=14 haste=spell tick=2)
	SpellInfo(corruption_debuff duration=11.9 tick=1.7 talent=creeping_death_talent)
	#SpellInfo(corruption_debuff duration=3600 talent=absolute_corruption_talent)
Define(create_healthstone 6201)
Define(create_soulwell 29893)
Define(dark_pact 108416)
Define(dark_soul_instability 113858)
	SpellInfo(dark_soul_instability cd=120)
	SpellAddBuff(dark_soul_instability dark_soul_instability_buff=1)
Define(dark_soul_instability_buff 113858)
	SpellInfo(dark_soul_instability_buff duration=20)
Define(dark_soul_misery 113860)
	SpellInfo(dark_soul_misery cd=120)
	SpellAddBuff(dark_soul_misery dark_soul_misery_buff=1)
Define(dark_soul_misery_buff 113860)
	SpellInfo(dark_soul_misery_buff duration=20)
Define(deathbolt 264106)
	SpellInfo(deathbolt cd=30)
Define(demonbolt 264178)
	SpellInfo(demonbolt soulshards=-2)
	SpellAddBuff(demonbolt demonic_core_buff=-1)
Define(demonic_calling_buff 205146)
	SpellInfo(demonic_calling_buff duration=20)
Define(demonic_circle 48018)
Define(demonic_circle_teleport 48020)
Define(demonic_core_buff 264173)
	SpellInfo(demonic_core_buff duration=20 max_stacks=4)
Define(demonic_gateway 111771)
Define(demonic_power 265273)
	SpellInfo(demonic_power duration=15)
Define(demonic_strength 267171)
	SpellInfo(demonic_strength cd=60)
	SpellAddPetBuff(demonic_strength demonic_strength_buff=1)
Define(demonic_strength_buff 267171)
Define(doom 265412)
	#SpellInfo(doom soulshards=-1) #TODO generates 1 soulshard after 30s
	SpellAddTargetDebuff(doom doom_debuff=1)
Define(doom_debuff 603)
	SpellInfo(doom_debuff duration=30)
Define(drain_life 234153)
Define(drain_soul 198590)
	SpellInfo(drain_soul channel=4 haste=spell)
	SpellInfo(drain_soul replace=shadow_bolt_affliction talent=!drain_soul_talent)
	SpellAddBuff(drain_soul shadow_embrace_debuff=1 talent=shadow_embrace_talent)
Define(enslave_demon 1098)
Define(eradication_debuff 196414)
	SpellInfo(eradication_debuff duration=7)
Define(eye_of_kilrogg 126)
Define(fear 5782)
Define(felguard_felstorm 89751)
	SpellInfo(felguard_felstorm cd=30 gcd=0 offgcd=1)
Define(from_the_shadows_debuff 270569)
	SpellInfo(from_the_shadows_debuff duration=12)
Define(grimoire_felguard 111898)
	SpellInfo(grimoire_felguard soulshards=1 cd=120)
Define(grimoire_of_sacrifice 108503)
	SpellInfo(grimoire_of_sacrifice cd=30 gcd=0)
	SpellAddBuff(grimoire_of_sacrifice grimoire_of_sacrifice_buff=1)
Define(grimoire_of_sacrifice_buff 196099)
	SpellInfo(grimoire_of_sacrifice_buff duration=3600)
Define(grimoire_of_supremacy_buff 266091)
Define(hand_of_guldan 105174)
	SpellInfo(hand_of_guldan max_travel_time=1.5 soulshards=1 max_soulshards=3) # maximum observed travel time with a bit of padding
Define(haunt 48181)
	SpellInfo(haunt cd=15 travel_time=2.3) # maximum observed travel time with a bit of padding
	SpellAddTargetDebuff(haunt haunt_debuff=1)
Define(haunt_debuff 48181)
	SpellInfo(haunt_debuff duration=15)
Define(havoc 80240)
	SpellInfo(havoc cd=30)
	SpellAddTargetDebuff(havoc havoc_debuff=1)
Define(havoc_debuff 80240)
	SpellInfo(havoc_debuff duration=10)
Define(health_funnel 755)
Define(immolate 348)
	SpellAddTargetDebuff(immolate immolate_debuff=1)
Define(immolate_debuff 157736)
	SpellInfo(immolate_debuff duration=18 haste=spell tick=3)
Define(implosion 196277)
Define(incinerate 29722)
	SpellInfo(incinerate travel_time=1 soulshards=-0.2)
	SpellAddBuff(incinerate backdraft_buff=-1)
Define(mortal_coil 6789)
Define(nether_portal 267217)
	SpellInfo(nether_portal cd=180 soulshards=3)
	SpellAddBuff(nether_portal nether_portal_buff=1)
Define(nether_portal_buff 267218)
	SpellInfo(nether_portal_buff duration=20)
Define(nightfall_buff 264571)
	SpellInfo(nightfall_buff duration=1)
Define(phantom_singularity 205179)
	SpellInfo(phantom_singularity cd=45)
Define(power_siphon 264130) # TODO usabe with 2+ wilds imps
	SpellAddBuff(power_siphon demonic_core_buff=2)
Define(rain_of_fire 5740)
	SpellInfo(rain_of_fire soulshards=3)
Define(reverse_entropy_buff 266030)
	SpellInfo(reverse_entropy_buff duration=8)
Define(ritual_of_summoning 698)
Define(roaring_blaze_debuff 265931)
	SpellInfo(roaring_blaze_debuff duration=6 tick=2 haste=spell)
Define(seed_of_corruption 27243)
	SpellInfo(seed_of_corruption soulshards=1)
	SpellAddTargetDebuff(seed_of_corruption seed_of_corruption_debuff=1)
Define(seed_of_corruption_debuff 27243)
	SpellInfo(seed_of_corruption_debuff duration=12)
Define(shadow_bolt 686)
	SpellInfo(shadow_bolt soulshards=-1 travel_time=2.2)
Define(shadow_bolt_affliction 232670)
	SpellInfo(shadow_bolt_affliction travel_time=2.2)
	SpellInfo(shadow_bolt_affliction replace=drain_soul talent=drain_soul_talent)
	SpellAddBuff(shadow_bolt_affliction nightfall_buff=-1)
	SpellAddBuff(shadow_bolt_affliction shadow_embrace_debuff=1 talent=shadow_embrace_talent)
Define(shadow_embrace_debuff 32390)
	SpellInfo(shadow_embrace_debuff duration=10 max_stacks=3)
Define(shadowburn 17877)
	SpellInfo(shadowburn soulshards=-0.3 charges=2 cd=12)
Define(siphon_life 63106)
	SpellAddTargetDebuff(siphon_life siphon_life_debuff=1)
Define(siphon_life_debuff 63106)
	SpellInfo(siphon_life_debuff duration=15 tick=3 haste=spell)
	SpellInfo(siphon_life_debuff duration=12.8 tick=2.5 haste=spell talent=creeping_death_talent)
Define(soul_fire 6353)
	SpellInfo(soul_fire soulshards=-0.4 cd=20 travel_time=1)
Define(soul_leech 108370)
Define(soul_link 108415)
Define(soul_shards 246985)
Define(soul_strike 264057)
	SpellInfo(soul_strike soulshards=-1 cd=10)
Define(soulstone 20707)
Define(summon_darkglare 205180)
	SpellInfo(summon_darkglare cd=180)
Define(summon_demonic_tyrant 265187)
	SpellInfo(summon_demonic_tyrant cd=90)
Define(summon_felguard 30146)
	SpellInfo(summon_felguard soulshards=1)
Define(summon_felhunter 691)
	SpellInfo(summon_felhunter soulshards=1)
Define(summon_imp 688)
	SpellInfo(summon_imp soulshards=1)
Define(summon_infernal 1122)
	SpellInfo(summon_infernal cd=180)
Define(summon_succubus 712)
	SpellInfo(summon_succubus soulshards=1)
Define(summon_vilefiend 264119)
	SpellInfo(summon_vilefiend soulshards=1 cd=45)
Define(summon_voidwalker 697)
	SpellInfo(summon_voidwalker soulshards=1)
Define(unending_breath 5697)
Define(unending_resolve 104773)
	SpellInfo(unending_resolve cd=180)
	SpellAddBuff(unending_resolve unending_resolve_buff=1)
Define(unending_resolve_buff 104773)
	SpellInfo(unending_resolve_buff duration=8)
Define(unstable_affliction 30108)
	SpellInfo(unstable_affliction soulshards=1)
	# TODO apply affliction debuff
Define(unstable_affliction_1_debuff 233940)
	SpellInfo(unstable_affliction_1_debuff duration=8 tick=2)
	SpellInfo(unstable_affliction_1_debuff duration=6.8 tick=1.7 talent=creeping_death_talent)
Define(unstable_affliction_2_debuff 233946)
	SpellInfo(unstable_affliction_2_debuff duration=8 tick=2)
	SpellInfo(unstable_affliction_2_debuff duration=6.8 tick=1.7 talent=creeping_death_talent)
Define(unstable_affliction_3_debuff 233947)
	SpellInfo(unstable_affliction_3_debuff duration=8 tick=2)
	SpellInfo(unstable_affliction_3_debuff duration=6.8 tick=1.7 talent=creeping_death_talent)
Define(unstable_affliction_4_debuff 233948)
	SpellInfo(unstable_affliction_4_debuff duration=8 tick=2)
	SpellInfo(unstable_affliction_4_debuff duration=6.8 tick=1.7 talent=creeping_death_talent)
Define(unstable_affliction_5_debuff 233949)
	SpellInfo(unstable_affliction_5_debuff duration=8 tick=2)
	SpellInfo(unstable_affliction_5_debuff duration=6.8 tick=1.7 talent=creeping_death_talent)
Define(vile_taint 278350)
	SpellInfo(vile_taint soulshards=1 cd=20)
Define(vile_taint_debuff 278350)
	SpellInfo(vile_taint_debuff duration=10)

# Azerite Traits
Define(cascading_calamity_trait 275376)
Define(cascading_calamity_buff 275376) #TODO verify buff id
Define(forbidden_knowledge_trait 278738)
Define(forbidden_knowledge_buff 278738) #TODO verify buff id
Define(inevitable_demise_trait 273521)
Define(inevitable_demise_buff 273521) #TODO verify buff id

# Talents
Define(absolute_corruption_talent 5)
Define(bilescourge_bombers_talent 3)
Define(burning_rush_talent 8)
Define(cataclysm_talent 12)
Define(channel_demonfire_talent 20)
Define(creeping_death_talent 20)
Define(dark_pact_talent 9)
Define(dark_soul_instability_talent 21)
Define(dark_soul_misery_talent 21)
Define(darkfury_talent 13)
Define(deathbolt_talent 3)
Define(demon_skin_talent 7)
Define(demonic_calling_talent 4)
Define(demonic_circle_talent 15)
Define(demonic_consumption_talent 20)
Define(demonic_strength_talent 2)
Define(doom_talent 6)
Define(drain_soul_talent 2)
Define(dreadlash_talent 1)
Define(eradication_talent 2)
Define(fire_and_brimstone_talent 11)
Define(flashover_talent 1)
Define(from_the_shadows_talent 10)
Define(grimoire_felguard_talent 18)
Define(grimoire_of_sacrifice_talent 18)
Define(grimoire_of_supremacy_talent 17)
Define(haunt_talent 17)
Define(inferno_talent 10)
Define(inner_demons_talent 17)
Define(internal_combustion_talent 5)
Define(mortal_coil_talent 14)
Define(nether_portal_talent 21)
Define(nightfall_talent 1)
Define(phantom_singularity_talent 11)
Define(power_siphon_talent 5)
Define(reverse_entropy_talent 4)
Define(roaring_blaze_talent 16)
Define(sacrificed_souls_talent 19)
Define(shadow_embrace_talent 16)
Define(shadowburn_talent 6)
Define(siphon_life_talent 6)
Define(demo_soul_conduit_talent 16)
Define(soul_conduit_talent 19)
Define(soul_fire_talent 3)
Define(soul_strike_talent 11)
Define(sow_the_seeds_talent 10)
Define(summon_vilefiend_talent 12)
Define(vile_taint_talent 12)
Define(writhe_in_agony_talent 4)

# Legendary items
Define(deadwind_harvester_buff 216708)
Define(sindorei_spite_icd 208871) # TODO should be the internal cooldown of the spell
Define(tormented_souls_buff 216695)
Define(wilfreds_sigil_of_superior_summoning_item 132369)

# Pets
Define(demonic_tyrant 135002)
Define(wild_imp 55659)
Define(dreadstalker 98035)
Define(darkglare 103673)
Define(infernal 89)
Define(felguard 17252)

# Non-default tags for OvaleSimulationCraft.
	SpellInfo(dark_soul_instability tag=cd)
	SpellInfo(dark_soul_knowledge tag=cd)
	SpellInfo(dark_soul_misery tag=cd)
	SpellInfo(grimoire_of_sacrifice tag=main)
	SpellInfo(havoc tag=shortcd)
	SpellInfo(metamorphosis tag=main)
	SpellInfo(service_doomguard tag=shortcd)
	SpellInfo(service_felguard tag=shortcd)
	SpellInfo(service_felhunter tag=shortcd)
	SpellInfo(service_imp tag=shortcd)
	SpellInfo(service_infernal tag=shortcd)
	SpellInfo(service_succubus tag=shortcd)
	SpellInfo(service_voidwalker tag=shortcd)
	SpellInfo(summon_felguard tag=shortcd)
	SpellInfo(summon_felhunter tag=shortcd)
	SpellInfo(summon_imp tag=shortcd)
	SpellInfo(summon_succubus tag=shortcd)
	SpellInfo(summon_voidwalker tag=shortcd)
`;
    OvaleScripts.RegisterScript("WARLOCK", undefined, name, desc, code, "include");
}
