local __exports = LibStub:GetLibrary("ovale/scripts/ovale_rogue")
if not __exports then return end
__exports.registerRogueSubtletyXeltor = function(OvaleScripts)
do
	local name = "xeltor_shanky"
	local desc = "[Xel][8.2] Blush: Shanky"
	local code = [[
Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_rogue_spells)

# Subtlety (Shanky)
AddIcon specialization=3 help=main
{
	if not mounted() and not Stealthed() and not InCombat() and not Dead() and not PlayerIsResting()
	{
		unless target.Present() and target.Distance(less 5)
		{
			if Speed() > 0 Spell(stealth)
		}
	}
	if not InCombat() and target.Present() and target.Exists() and not target.IsFriend() and not mounted() and not Dead()
	{
		if target.InRange(marked_for_death) and Stealthed() and not BuffPresent(cold_blood) Spell(cold_blood)
		#marked_for_death
		if target.InRange(marked_for_death) and ComboPoints() < 5 Spell(marked_for_death)
	}
	
	if InCombat() InterruptActions()
	if { HealthPercent() <= 25 or HealthPercent() < 70 and not InCombat() and not mounted() } and not Dead() and Energy() > 24 Spell(crimson_vial)
	
	if target.InRange(backstab)
	{
		# Cooldowns
		SubtletyDefaultCdActions()
		
		# Short Cooldowns
		SubtletyDefaultShortCdActions()
		
		# Default Actions
		SubtletyDefaultMainActions()
	}
	
	if InCombat() and not target.IsDead() and not target.IsFriend() and Falling() and { target.HealthPercent() < 100 or target.istargetingplayer() } GetInMeleeRange()
}

AddFunction GetInMeleeRange
{
	if not target.InRange(kick)
	{
		if target.InRange(shadowstrike) and Stealthed() Spell(shadowstrike)
		if target.InRange(shadowstrike) and { Energy() >= 32 and Talent(shadow_focus_talent) or Energy() >= 40 } and not Stealthed() AcquireStealth()
		if target.InRange(shadowstep) Spell(shadowstep)
	}
}

AddFunction InterruptActions
{
	if { target.HasManagedInterrupts() and target.MustBeInterrupted() } or { not target.HasManagedInterrupts() and target.IsInterruptible() }
	{
		if target.InRange(kick) and target.IsInterruptible() Spell(kick)
		if target.InRange(quaking_palm) and not target.Classification(worldboss) Spell(quaking_palm)
		if target.InRange(kidney_shot) and not target.Classification(worldboss) and ComboPoints() >= 1 Spell(kidney_shot)
		if target.InRange(cheap_shot) and not target.Classification(worldboss) Spell(cheap_shot)
	}
}

AddFunction AcquireStealth
{
	if not InCombat() Spell(stealth)
	if VanishAllowed() and InCombat() Spell(vanish)
}

AddFunction VanishAllowed
{
	{ not target.istargetingplayer() or { unitinparty() and PartyMemberCount() >= 5 } or unitinraid() }
}

AddFunction SubtletyUseItemActions
{
 if Item(Trinket0Slot usable=1) Texture(inv_jewelry_talisman_12)
 if Item(Trinket1Slot usable=1) Texture(inv_jewelry_talisman_12)
}

AddFunction shd_threshold
{
 SpellCharges(shadow_dance count=0) >= 1.75
}

AddFunction shd_combo_points
{
 if use_priority_rotation() and { Talent(nightstalker_talent) or Talent(dark_shadow_talent) } ComboPointsDeficit() <= 1 + 2 * HasAzeriteTrait(the_first_dance_trait)
 ComboPointsDeficit() >= 4
}

AddFunction use_priority_rotation
{
 Enemies(tagged=1) >= 2
}

AddFunction stealth_threshold
{
 25 + TalentPoints(vigor_talent) * 35 + TalentPoints(master_of_shadows_talent) * 25 + TalentPoints(shadow_focus_talent) * 20 + TalentPoints(alacrity_talent) * 10 + 15 * { Enemies(tagged=1) >= 3 }
}

### actions.default

AddFunction SubtletyDefaultMainActions
{
 #call_action_list,name=cds
 SubtletyCdsMainActions()

 unless SubtletyCdsMainPostConditions()
 {
  #run_action_list,name=stealthed,if=stealthed.all
  if Stealthed() SubtletyStealthedMainActions()

  unless Stealthed() and SubtletyStealthedMainPostConditions()
  {
   #nightblade,if=target.time_to_die>6&remains<gcd.max&combo_points>=4-(time<10)*2
   if target.TimeToDie() > 6 and target.DebuffRemaining(nightblade_debuff) < GCD() and ComboPoints() >= 4 - { TimeInCombat() < 10 } * 2 and target.InRange(nightblade) Spell(nightblade)
   #variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
   #call_action_list,name=stealth_cds,if=variable.use_priority_rotation
   if use_priority_rotation() SubtletyStealthCdsMainActions()

   unless use_priority_rotation() and SubtletyStealthCdsMainPostConditions()
   {
    #variable,name=stealth_threshold,value=25+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+talent.shadow_focus.enabled*20+talent.alacrity.enabled*10+15*(spell_targets.shuriken_storm>=3)
    #call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
    if EnergyDeficit() <= stealth_threshold() SubtletyStealthCdsMainActions()

    unless EnergyDeficit() <= stealth_threshold() and SubtletyStealthCdsMainPostConditions()
    {
     #nightblade,if=azerite.nights_vengeance.enabled&!buff.nights_vengeance.up&combo_points>=2&(spell_targets.shuriken_storm<2|variable.use_priority_rotation)&(cooldown.symbols_of_death.remains<=3|(azerite.nights_vengeance.rank>=2&buff.symbols_of_death.remains>3&!stealthed.all&cooldown.shadow_dance.charges_fractional>=0.9))
     if HasAzeriteTrait(nights_vengeance_trait) and not BuffPresent(nights_vengeance_buff) and ComboPoints() >= 2 and { Enemies(tagged=1) < 2 or use_priority_rotation() } and { SpellCooldown(symbols_of_death) <= 3 or AzeriteTraitRank(nights_vengeance_trait) >= 2 and BuffRemaining(symbols_of_death_buff) > 3 and not Stealthed() and SpellCharges(shadow_dance count=0) >= 0.9 } and target.InRange(nightblade) Spell(nightblade)
     #call_action_list,name=finish,if=combo_points.deficit<=1|target.time_to_die<=1&combo_points>=3
     if ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 SubtletyFinishMainActions()

     unless { ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 } and SubtletyFinishMainPostConditions()
     {
      #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
      if Enemies(tagged=1) == 4 and ComboPoints() >= 4 SubtletyFinishMainActions()

      unless Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishMainPostConditions()
      {
       #call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
       if EnergyDeficit() <= stealth_threshold() SubtletyBuildMainActions()
      }
     }
    }
   }
  }
 }
}

AddFunction SubtletyDefaultMainPostConditions
{
 SubtletyCdsMainPostConditions() or Stealthed() and SubtletyStealthedMainPostConditions() or use_priority_rotation() and SubtletyStealthCdsMainPostConditions() or EnergyDeficit() <= stealth_threshold() and SubtletyStealthCdsMainPostConditions() or { ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 } and SubtletyFinishMainPostConditions() or Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishMainPostConditions() or EnergyDeficit() <= stealth_threshold() and SubtletyBuildMainPostConditions()
}

AddFunction SubtletyDefaultShortCdActions
{
 #stealth
 if target.InRange(shadowstep) Spell(stealth)
 #call_action_list,name=cds
 SubtletyCdsShortCdActions()

 unless SubtletyCdsShortCdPostConditions()
 {
  #run_action_list,name=stealthed,if=stealthed.all
  if Stealthed() SubtletyStealthedShortCdActions()

  unless Stealthed() and SubtletyStealthedShortCdPostConditions() or target.TimeToDie() > 6 and target.DebuffRemaining(nightblade_debuff) < GCD() and ComboPoints() >= 4 - { TimeInCombat() < 10 } * 2 and target.InRange(nightblade) and Spell(nightblade)
  {
   #variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
   #call_action_list,name=stealth_cds,if=variable.use_priority_rotation
   if use_priority_rotation() SubtletyStealthCdsShortCdActions()

   unless use_priority_rotation() and SubtletyStealthCdsShortCdPostConditions()
   {
    #variable,name=stealth_threshold,value=25+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+talent.shadow_focus.enabled*20+talent.alacrity.enabled*10+15*(spell_targets.shuriken_storm>=3)
    #call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
    if EnergyDeficit() <= stealth_threshold() SubtletyStealthCdsShortCdActions()

    unless EnergyDeficit() <= stealth_threshold() and SubtletyStealthCdsShortCdPostConditions() or HasAzeriteTrait(nights_vengeance_trait) and not BuffPresent(nights_vengeance_buff) and ComboPoints() >= 2 and { Enemies(tagged=1) < 2 or use_priority_rotation() } and { SpellCooldown(symbols_of_death) <= 3 or AzeriteTraitRank(nights_vengeance_trait) >= 2 and BuffRemaining(symbols_of_death_buff) > 3 and not Stealthed() and SpellCharges(shadow_dance count=0) >= 0.9 } and target.InRange(nightblade) and Spell(nightblade)
    {
     #call_action_list,name=finish,if=combo_points.deficit<=1|target.time_to_die<=1&combo_points>=3
     if ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 SubtletyFinishShortCdActions()

     unless { ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 } and SubtletyFinishShortCdPostConditions()
     {
      #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
      if Enemies(tagged=1) == 4 and ComboPoints() >= 4 SubtletyFinishShortCdActions()

      unless Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishShortCdPostConditions()
      {
       #call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
       if EnergyDeficit() <= stealth_threshold() SubtletyBuildShortCdActions()
      }
     }
    }
   }
  }
 }
}

AddFunction SubtletyDefaultShortCdPostConditions
{
 SubtletyCdsShortCdPostConditions() or Stealthed() and SubtletyStealthedShortCdPostConditions() or target.TimeToDie() > 6 and target.DebuffRemaining(nightblade_debuff) < GCD() and ComboPoints() >= 4 - { TimeInCombat() < 10 } * 2 and target.InRange(nightblade) and Spell(nightblade) or use_priority_rotation() and SubtletyStealthCdsShortCdPostConditions() or EnergyDeficit() <= stealth_threshold() and SubtletyStealthCdsShortCdPostConditions() or HasAzeriteTrait(nights_vengeance_trait) and not BuffPresent(nights_vengeance_buff) and ComboPoints() >= 2 and { Enemies(tagged=1) < 2 or use_priority_rotation() } and { SpellCooldown(symbols_of_death) <= 3 or AzeriteTraitRank(nights_vengeance_trait) >= 2 and BuffRemaining(symbols_of_death_buff) > 3 and not Stealthed() and SpellCharges(shadow_dance count=0) >= 0.9 } and target.InRange(nightblade) and Spell(nightblade) or { ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 } and SubtletyFinishShortCdPostConditions() or Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishShortCdPostConditions() or EnergyDeficit() <= stealth_threshold() and SubtletyBuildShortCdPostConditions()
}

AddFunction SubtletyDefaultCdActions
{
 # SubtletyInterruptActions()
 #call_action_list,name=cds
 SubtletyCdsCdActions()

 unless SubtletyCdsCdPostConditions()
 {
  #run_action_list,name=stealthed,if=stealthed.all
  if Stealthed() SubtletyStealthedCdActions()

  unless Stealthed() and SubtletyStealthedCdPostConditions() or target.TimeToDie() > 6 and target.DebuffRemaining(nightblade_debuff) < GCD() and ComboPoints() >= 4 - { TimeInCombat() < 10 } * 2 and target.InRange(nightblade) and Spell(nightblade)
  {
   #variable,name=use_priority_rotation,value=priority_rotation&spell_targets.shuriken_storm>=2
   #call_action_list,name=stealth_cds,if=variable.use_priority_rotation
   if use_priority_rotation() SubtletyStealthCdsCdActions()

   unless use_priority_rotation() and SubtletyStealthCdsCdPostConditions()
   {
    #variable,name=stealth_threshold,value=25+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+talent.shadow_focus.enabled*20+talent.alacrity.enabled*10+15*(spell_targets.shuriken_storm>=3)
    #call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold
    if EnergyDeficit() <= stealth_threshold() SubtletyStealthCdsCdActions()

    unless EnergyDeficit() <= stealth_threshold() and SubtletyStealthCdsCdPostConditions() or HasAzeriteTrait(nights_vengeance_trait) and not BuffPresent(nights_vengeance_buff) and ComboPoints() >= 2 and { Enemies(tagged=1) < 2 or use_priority_rotation() } and { SpellCooldown(symbols_of_death) <= 3 or AzeriteTraitRank(nights_vengeance_trait) >= 2 and BuffRemaining(symbols_of_death_buff) > 3 and not Stealthed() and SpellCharges(shadow_dance count=0) >= 0.9 } and target.InRange(nightblade) and Spell(nightblade)
    {
     #call_action_list,name=finish,if=combo_points.deficit<=1|target.time_to_die<=1&combo_points>=3
     if ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 SubtletyFinishCdActions()

     unless { ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 } and SubtletyFinishCdPostConditions()
     {
      #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
      if Enemies(tagged=1) == 4 and ComboPoints() >= 4 SubtletyFinishCdActions()

      unless Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishCdPostConditions()
      {
       #call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
       if EnergyDeficit() <= stealth_threshold() SubtletyBuildCdActions()

       unless EnergyDeficit() <= stealth_threshold() and SubtletyBuildCdPostConditions()
       {
        #arcane_torrent,if=energy.deficit>=15+energy.regen
        if EnergyDeficit() >= 15 + EnergyRegenRate() Spell(arcane_torrent_energy)
        #arcane_pulse
        Spell(arcane_pulse)
        #lights_judgment
        Spell(lights_judgment)
       }
      }
     }
    }
   }
  }
 }
}

AddFunction SubtletyDefaultCdPostConditions
{
 SubtletyCdsCdPostConditions() or Stealthed() and SubtletyStealthedCdPostConditions() or target.TimeToDie() > 6 and target.DebuffRemaining(nightblade_debuff) < GCD() and ComboPoints() >= 4 - { TimeInCombat() < 10 } * 2 and target.InRange(nightblade) and Spell(nightblade) or use_priority_rotation() and SubtletyStealthCdsCdPostConditions() or EnergyDeficit() <= stealth_threshold() and SubtletyStealthCdsCdPostConditions() or HasAzeriteTrait(nights_vengeance_trait) and not BuffPresent(nights_vengeance_buff) and ComboPoints() >= 2 and { Enemies(tagged=1) < 2 or use_priority_rotation() } and { SpellCooldown(symbols_of_death) <= 3 or AzeriteTraitRank(nights_vengeance_trait) >= 2 and BuffRemaining(symbols_of_death_buff) > 3 and not Stealthed() and SpellCharges(shadow_dance count=0) >= 0.9 } and target.InRange(nightblade) and Spell(nightblade) or { ComboPointsDeficit() <= 1 or target.TimeToDie() <= 1 and ComboPoints() >= 3 } and SubtletyFinishCdPostConditions() or Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishCdPostConditions() or EnergyDeficit() <= stealth_threshold() and SubtletyBuildCdPostConditions()
}

### actions.build

AddFunction SubtletyBuildMainActions
{
 #shuriken_storm,if=spell_targets>=2+(talent.gloomblade.enabled&azerite.perforate.rank>=2&position_back)
 if Enemies(tagged=1) >= 2 + { Talent(gloomblade_talent) and AzeriteTraitRank(perforate_trait) >= 2 and True(position_back) } and target.InRange(backstab) Spell(shuriken_storm)
 #gloomblade
 Spell(gloomblade)
 #backstab
 if target.InRange(backstab) Spell(backstab)
}

AddFunction SubtletyBuildMainPostConditions
{
}

AddFunction SubtletyBuildShortCdActions
{
}

AddFunction SubtletyBuildShortCdPostConditions
{
 Enemies(tagged=1) >= 2 + { Talent(gloomblade_talent) and AzeriteTraitRank(perforate_trait) >= 2 and True(position_back) } and target.InRange(backstab) and Spell(shuriken_storm) or Spell(gloomblade) or target.InRange(backstab) and Spell(backstab)
}

AddFunction SubtletyBuildCdActions
{
}

AddFunction SubtletyBuildCdPostConditions
{
 Enemies(tagged=1) >= 2 + { Talent(gloomblade_talent) and AzeriteTraitRank(perforate_trait) >= 2 and True(position_back) } and target.InRange(backstab) and Spell(shuriken_storm) or Spell(gloomblade) or target.InRange(backstab) and Spell(backstab)
}

### actions.cds

AddFunction SubtletyCdsMainActions
{
 #call_action_list,name=essences,if=!stealthed.all&dot.nightblade.ticking
 if not Stealthed() and target.DebuffPresent(nightblade_debuff) SubtletyEssencesMainActions()
}

AddFunction SubtletyCdsMainPostConditions
{
 not Stealthed() and target.DebuffPresent(nightblade_debuff) and SubtletyEssencesMainPostConditions()
}

AddFunction SubtletyCdsShortCdActions
{
 #shadow_dance,use_off_gcd=1,if=!buff.shadow_dance.up&buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
 if not BuffPresent(shadow_dance_buff) and BuffPresent(shuriken_tornado) and BuffRemaining(shuriken_tornado) <= 3.5 and target.InRange(shadowstep) Spell(shadow_dance)
 #symbols_of_death,use_off_gcd=1,if=buff.shuriken_tornado.up&buff.shuriken_tornado.remains<=3.5
 if BuffPresent(shuriken_tornado) and BuffRemaining(shuriken_tornado) <= 3.5 Spell(symbols_of_death)
 #call_action_list,name=essences,if=!stealthed.all&dot.nightblade.ticking
 if not Stealthed() and target.DebuffPresent(nightblade_debuff) SubtletyEssencesShortCdActions()

 unless not Stealthed() and target.DebuffPresent(nightblade_debuff) and SubtletyEssencesShortCdPostConditions()
 {
  #pool_resource,for_next=1,if=!talent.shadow_focus.enabled
  unless not Talent(shadow_focus_talent)
  {
   #shuriken_tornado,if=energy>=60&dot.nightblade.ticking&cooldown.symbols_of_death.up&cooldown.shadow_dance.charges>=1
   if Energy() >= 60 and target.DebuffPresent(nightblade_debuff) and not SpellCooldown(symbols_of_death) > 0 and SpellCharges(shadow_dance) >= 1 and target.InRange(backstab) Spell(shuriken_tornado)
   #symbols_of_death,if=dot.nightblade.ticking&(!talent.shuriken_tornado.enabled|talent.shadow_focus.enabled|cooldown.shuriken_tornado.remains>2)&(!essence.blood_of_the_enemy.major|cooldown.blood_of_the_enemy.remains>2)
   if target.DebuffPresent(nightblade_debuff) and { not Talent(shuriken_tornado_talent) or Talent(shadow_focus_talent) or SpellCooldown(shuriken_tornado) > 2 } and { not AzeriteEssenceIsMajor(blood_of_the_enemy_essence_id) or SpellCooldown(blood_of_the_enemy) > 2 } Spell(symbols_of_death)
   #marked_for_death,target_if=min:target.time_to_die,if=raid_event.adds.up&(target.time_to_die<combo_points.deficit|!stealthed.all&combo_points.deficit>=cp_max_spend)
   if False(raid_event_adds_exists) and { target.TimeToDie() < ComboPointsDeficit() or not Stealthed() and ComboPointsDeficit() >= MaxComboPoints() } Spell(marked_for_death)
   #marked_for_death,if=raid_event.adds.in>30-raid_event.adds.duration&!stealthed.all&combo_points.deficit>=cp_max_spend
   if 600 > 30 - 10 and not Stealthed() and ComboPointsDeficit() >= MaxComboPoints() Spell(marked_for_death)
   #shuriken_tornado,if=talent.shadow_focus.enabled&dot.nightblade.ticking&buff.symbols_of_death.up
   if Talent(shadow_focus_talent) and target.DebuffPresent(nightblade_debuff) and BuffPresent(symbols_of_death_buff) and target.InRange(backstab) Spell(shuriken_tornado)
   #shadow_dance,if=!buff.shadow_dance.up&target.time_to_die<=5+talent.subterfuge.enabled&!raid_event.adds.up
   if not BuffPresent(shadow_dance_buff) and target.TimeToDie() <= 5 + TalentPoints(subterfuge_talent) and not False(raid_event_adds_exists) and target.InRange(shadowstep) Spell(shadow_dance)
  }
 }
}

AddFunction SubtletyCdsShortCdPostConditions
{
 not Stealthed() and target.DebuffPresent(nightblade_debuff) and SubtletyEssencesShortCdPostConditions()
}

AddFunction SubtletyCdsCdActions
{
 #call_action_list,name=essences,if=!stealthed.all&dot.nightblade.ticking
 if not Stealthed() and target.DebuffPresent(nightblade_debuff) SubtletyEssencesCdActions()

 unless not Stealthed() and target.DebuffPresent(nightblade_debuff) and SubtletyEssencesCdPostConditions()
 {
  #pool_resource,for_next=1,if=!talent.shadow_focus.enabled
  unless not Talent(shadow_focus_talent)
  {
   unless Energy() >= 60 and target.DebuffPresent(nightblade_debuff) and not SpellCooldown(symbols_of_death) > 0 and SpellCharges(shadow_dance) >= 1 and target.InRange(backstab) and Spell(shuriken_tornado)
   {
    #shadow_blades,if=combo_points.deficit>=2+stealthed.all
    if ComboPointsDeficit() >= 2 + Stealthed() and target.InRange(backstab) Spell(shadow_blades)

    unless Talent(shadow_focus_talent) and target.DebuffPresent(nightblade_debuff) and BuffPresent(symbols_of_death_buff) and target.InRange(backstab) and Spell(shuriken_tornado)
    {
     #potion,if=buff.bloodlust.react|buff.symbols_of_death.up&(buff.shadow_blades.up|cooldown.shadow_blades.remains<=10)
     # if { BuffPresent(bloodlust) or BuffPresent(symbols_of_death_buff) and { BuffPresent(shadow_blades_buff) or SpellCooldown(shadow_blades) <= 10 } } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(item_potion_of_unbridled_fury usable=1)
     #blood_fury,if=buff.symbols_of_death.up
     if BuffPresent(symbols_of_death_buff) Spell(blood_fury_ap)
     #berserking,if=buff.symbols_of_death.up
     if BuffPresent(symbols_of_death_buff) Spell(berserking)
     #fireblood,if=buff.symbols_of_death.up
     if BuffPresent(symbols_of_death_buff) Spell(fireblood)
     #ancestral_call,if=buff.symbols_of_death.up
     if BuffPresent(symbols_of_death_buff) Spell(ancestral_call)
     #use_item,effect_name=cyclotronic_blast,if=!stealthed.all&dot.nightblade.ticking&!buff.symbols_of_death.up&energy.deficit>=30
     if not Stealthed() and target.DebuffPresent(nightblade_debuff) and not BuffPresent(symbols_of_death_buff) and EnergyDeficit() >= 30 SubtletyUseItemActions()
     #use_item,name=azsharas_font_of_power,if=!buff.shadow_dance.up&cooldown.symbols_of_death.remains<10
     if not BuffPresent(shadow_dance_buff) and SpellCooldown(symbols_of_death) < 10 SubtletyUseItemActions()
     #use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down|debuff.conductive_ink_debuff.up&target.health.pct<32&target.health.pct>=30|!debuff.conductive_ink_debuff.up&(debuff.razor_coral_debuff.stack>=25-10*debuff.blood_of_the_enemy.up|target.time_to_die<40)&buff.symbols_of_death.remains>8
     if target.DebuffExpires(razor_coral) or target.DebuffPresent(conductive_ink) and target.HealthPercent() < 32 and target.HealthPercent() >= 30 or not target.DebuffPresent(conductive_ink) and { target.DebuffStacks(razor_coral) >= 25 - 10 * target.DebuffPresent(blood_of_the_enemy) or target.TimeToDie() < 40 } and BuffRemaining(symbols_of_death_buff) > 8 SubtletyUseItemActions()
     #use_item,name=mydas_talisman
     SubtletyUseItemActions()
     #use_items,if=buff.symbols_of_death.up|target.time_to_die<20
     if BuffPresent(symbols_of_death_buff) or target.TimeToDie() < 20 SubtletyUseItemActions()
    }
   }
  }
 }
}

AddFunction SubtletyCdsCdPostConditions
{
 not Stealthed() and target.DebuffPresent(nightblade_debuff) and SubtletyEssencesCdPostConditions() or not { not Talent(shadow_focus_talent) } and { Energy() >= 60 and target.DebuffPresent(nightblade_debuff) and not SpellCooldown(symbols_of_death) > 0 and SpellCharges(shadow_dance) >= 1 and target.InRange(backstab) and Spell(shuriken_tornado) or Talent(shadow_focus_talent) and target.DebuffPresent(nightblade_debuff) and BuffPresent(symbols_of_death_buff) and target.InRange(backstab) and Spell(shuriken_tornado) }
}

### actions.essences

AddFunction SubtletyEssencesMainActions
{
 #concentrated_flame,if=energy.time_to_max>1&!buff.symbols_of_death.up&(!dot.concentrated_flame_burn.ticking&!action.concentrated_flame.in_flight|full_recharge_time<gcd.max)
 if TimeToMaxEnergy() > 1 and not BuffPresent(symbols_of_death_buff) and { not target.DebuffPresent(concentrated_flame_burn_debuff) and not InFlightToTarget(concentrated_flame_essence) or SpellFullRecharge(concentrated_flame_essence) < GCD() } Spell(concentrated_flame_essence)
}

AddFunction SubtletyEssencesMainPostConditions
{
}

AddFunction SubtletyEssencesShortCdActions
{
 unless TimeToMaxEnergy() > 1 and not BuffPresent(symbols_of_death_buff) and { not target.DebuffPresent(concentrated_flame_burn_debuff) and not InFlightToTarget(concentrated_flame_essence) or SpellFullRecharge(concentrated_flame_essence) < GCD() } and Spell(concentrated_flame_essence)
 {
  #focused_azerite_beam,if=(spell_targets.shuriken_storm>=2|raid_event.adds.in>60)&!cooldown.symbols_of_death.up&!buff.symbols_of_death.up&energy.deficit>=30
  if { Enemies(tagged=1) >= 2 or 600 > 60 } and not { not SpellCooldown(symbols_of_death) > 0 } and not BuffPresent(symbols_of_death_buff) and EnergyDeficit() >= 30 Spell(focused_azerite_beam)
  #purifying_blast,if=spell_targets.shuriken_storm>=2|raid_event.adds.in>60
  if Enemies(tagged=1) >= 2 or 600 > 60 Spell(purifying_blast)
  #the_unbound_force,if=buff.reckless_force.up|buff.reckless_force_counter.stack<10
  if BuffPresent(reckless_force_buff) or BuffStacks(reckless_force_counter) < 10 Spell(the_unbound_force)
  #ripple_in_space
  Spell(ripple_in_space_essence)
  #worldvein_resonance,if=buff.lifeblood.stack<3
  if BuffStacks(lifeblood_buff) < 3 Spell(worldvein_resonance_essence)
 }
}

AddFunction SubtletyEssencesShortCdPostConditions
{
 TimeToMaxEnergy() > 1 and not BuffPresent(symbols_of_death_buff) and { not target.DebuffPresent(concentrated_flame_burn_debuff) and not InFlightToTarget(concentrated_flame_essence) or SpellFullRecharge(concentrated_flame_essence) < GCD() } and Spell(concentrated_flame_essence)
}

AddFunction SubtletyEssencesCdActions
{
 unless TimeToMaxEnergy() > 1 and not BuffPresent(symbols_of_death_buff) and { not target.DebuffPresent(concentrated_flame_burn_debuff) and not InFlightToTarget(concentrated_flame_essence) or SpellFullRecharge(concentrated_flame_essence) < GCD() } and Spell(concentrated_flame_essence)
 {
  #blood_of_the_enemy,if=cooldown.symbols_of_death.up|target.time_to_die<=10
  if not SpellCooldown(symbols_of_death) > 0 or target.TimeToDie() <= 10 Spell(blood_of_the_enemy)
  #guardian_of_azeroth
  Spell(guardian_of_azeroth)

  unless { Enemies(tagged=1) >= 2 or 600 > 60 } and not { not SpellCooldown(symbols_of_death) > 0 } and not BuffPresent(symbols_of_death_buff) and EnergyDeficit() >= 30 and Spell(focused_azerite_beam) or { Enemies(tagged=1) >= 2 or 600 > 60 } and Spell(purifying_blast) or { BuffPresent(reckless_force_buff) or BuffStacks(reckless_force_counter) < 10 } and Spell(the_unbound_force) or Spell(ripple_in_space_essence) or BuffStacks(lifeblood_buff) < 3 and Spell(worldvein_resonance_essence)
  {
   #memory_of_lucid_dreams,if=energy<40&buff.symbols_of_death.up
   if Energy() < 40 and BuffPresent(symbols_of_death_buff) Spell(memory_of_lucid_dreams_essence)
  }
 }
}

AddFunction SubtletyEssencesCdPostConditions
{
 TimeToMaxEnergy() > 1 and not BuffPresent(symbols_of_death_buff) and { not target.DebuffPresent(concentrated_flame_burn_debuff) and not InFlightToTarget(concentrated_flame_essence) or SpellFullRecharge(concentrated_flame_essence) < GCD() } and Spell(concentrated_flame_essence) or { Enemies(tagged=1) >= 2 or 600 > 60 } and not { not SpellCooldown(symbols_of_death) > 0 } and not BuffPresent(symbols_of_death_buff) and EnergyDeficit() >= 30 and Spell(focused_azerite_beam) or { Enemies(tagged=1) >= 2 or 600 > 60 } and Spell(purifying_blast) or { BuffPresent(reckless_force_buff) or BuffStacks(reckless_force_counter) < 10 } and Spell(the_unbound_force) or Spell(ripple_in_space_essence) or BuffStacks(lifeblood_buff) < 3 and Spell(worldvein_resonance_essence)
}

### actions.finish

AddFunction SubtletyFinishMainActions
{
 #pool_resource,for_next=1
 #eviscerate,if=buff.nights_vengeance.up
 if BuffPresent(nights_vengeance_buff) and target.InRange(eviscerate) Spell(eviscerate)
 unless BuffPresent(nights_vengeance_buff) and target.InRange(eviscerate) and SpellUsable(eviscerate) and SpellCooldown(eviscerate) < TimeToEnergyFor(eviscerate)
 {
  #nightblade,if=(!talent.dark_shadow.enabled|!buff.shadow_dance.up)&target.time_to_die-remains>6&remains<tick_time*2
  if { not Talent(dark_shadow_talent) or not BuffPresent(shadow_dance_buff) } and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > 6 and target.DebuffRemaining(nightblade_debuff) < target.CurrentTickTime(nightblade_debuff) * 2 and target.InRange(nightblade) Spell(nightblade)
  #nightblade,cycle_targets=1,if=!variable.use_priority_rotation&spell_targets.shuriken_storm>=2&(azerite.nights_vengeance.enabled|!azerite.replicating_shadows.enabled|spell_targets.shuriken_storm-active_dot.nightblade>=2)&!buff.shadow_dance.up&target.time_to_die>=(5+(2*combo_points))&refreshable
  if not use_priority_rotation() and Enemies(tagged=1) >= 2 and { HasAzeriteTrait(nights_vengeance_trait) or not HasAzeriteTrait(replicating_shadows_trait) or Enemies(tagged=1) - DebuffCountOnAny(nightblade_debuff) >= 2 } and not BuffPresent(shadow_dance_buff) and target.TimeToDie() >= 5 + 2 * ComboPoints() and target.Refreshable(nightblade_debuff) and target.InRange(nightblade) Spell(nightblade)
  #nightblade,if=remains<cooldown.symbols_of_death.remains+10&cooldown.symbols_of_death.remains<=5&target.time_to_die-remains>cooldown.symbols_of_death.remains+5
  if target.DebuffRemaining(nightblade_debuff) < SpellCooldown(symbols_of_death) + 10 and SpellCooldown(symbols_of_death) <= 5 and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > SpellCooldown(symbols_of_death) + 5 and target.InRange(nightblade) Spell(nightblade)
  #eviscerate
  if target.InRange(eviscerate) Spell(eviscerate)
 }
}

AddFunction SubtletyFinishMainPostConditions
{
}

AddFunction SubtletyFinishShortCdActions
{
 #pool_resource,for_next=1
 #eviscerate,if=buff.nights_vengeance.up
 unless BuffPresent(nights_vengeance_buff) and target.InRange(eviscerate) and SpellUsable(eviscerate) and SpellCooldown(eviscerate) < TimeToEnergyFor(eviscerate)
 {
  unless { not Talent(dark_shadow_talent) or not BuffPresent(shadow_dance_buff) } and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > 6 and target.DebuffRemaining(nightblade_debuff) < target.CurrentTickTime(nightblade_debuff) * 2 and target.InRange(nightblade) and Spell(nightblade) or not use_priority_rotation() and Enemies(tagged=1) >= 2 and { HasAzeriteTrait(nights_vengeance_trait) or not HasAzeriteTrait(replicating_shadows_trait) or Enemies(tagged=1) - DebuffCountOnAny(nightblade_debuff) >= 2 } and not BuffPresent(shadow_dance_buff) and target.TimeToDie() >= 5 + 2 * ComboPoints() and target.Refreshable(nightblade_debuff) and target.InRange(nightblade) and Spell(nightblade) or target.DebuffRemaining(nightblade_debuff) < SpellCooldown(symbols_of_death) + 10 and SpellCooldown(symbols_of_death) <= 5 and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > SpellCooldown(symbols_of_death) + 5 and target.InRange(nightblade) and Spell(nightblade)
  {
   #secret_technique,if=buff.symbols_of_death.up&(!talent.dark_shadow.enabled|buff.shadow_dance.up)
   if BuffPresent(symbols_of_death_buff) and { not Talent(dark_shadow_talent) or BuffPresent(shadow_dance_buff) } and target.InRange(secret_technique) Spell(secret_technique)
   #secret_technique,if=spell_targets.shuriken_storm>=2+talent.dark_shadow.enabled+talent.nightstalker.enabled
   if Enemies(tagged=1) >= 2 + TalentPoints(dark_shadow_talent) + TalentPoints(nightstalker_talent) and target.InRange(secret_technique) Spell(secret_technique)
  }
 }
}

AddFunction SubtletyFinishShortCdPostConditions
{
 not { BuffPresent(nights_vengeance_buff) and target.InRange(eviscerate) and SpellUsable(eviscerate) and SpellCooldown(eviscerate) < TimeToEnergyFor(eviscerate) } and { { not Talent(dark_shadow_talent) or not BuffPresent(shadow_dance_buff) } and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > 6 and target.DebuffRemaining(nightblade_debuff) < target.CurrentTickTime(nightblade_debuff) * 2 and target.InRange(nightblade) and Spell(nightblade) or not use_priority_rotation() and Enemies(tagged=1) >= 2 and { HasAzeriteTrait(nights_vengeance_trait) or not HasAzeriteTrait(replicating_shadows_trait) or Enemies(tagged=1) - DebuffCountOnAny(nightblade_debuff) >= 2 } and not BuffPresent(shadow_dance_buff) and target.TimeToDie() >= 5 + 2 * ComboPoints() and target.Refreshable(nightblade_debuff) and target.InRange(nightblade) and Spell(nightblade) or target.DebuffRemaining(nightblade_debuff) < SpellCooldown(symbols_of_death) + 10 and SpellCooldown(symbols_of_death) <= 5 and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > SpellCooldown(symbols_of_death) + 5 and target.InRange(nightblade) and Spell(nightblade) or target.InRange(eviscerate) and Spell(eviscerate) }
}

AddFunction SubtletyFinishCdActions
{
}

AddFunction SubtletyFinishCdPostConditions
{
 BuffPresent(nights_vengeance_buff) and target.InRange(eviscerate) and Spell(eviscerate) or not { BuffPresent(nights_vengeance_buff) and target.InRange(eviscerate) and SpellUsable(eviscerate) and SpellCooldown(eviscerate) < TimeToEnergyFor(eviscerate) } and { { not Talent(dark_shadow_talent) or not BuffPresent(shadow_dance_buff) } and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > 6 and target.DebuffRemaining(nightblade_debuff) < target.CurrentTickTime(nightblade_debuff) * 2 and target.InRange(nightblade) and Spell(nightblade) or not use_priority_rotation() and Enemies(tagged=1) >= 2 and { HasAzeriteTrait(nights_vengeance_trait) or not HasAzeriteTrait(replicating_shadows_trait) or Enemies(tagged=1) - DebuffCountOnAny(nightblade_debuff) >= 2 } and not BuffPresent(shadow_dance_buff) and target.TimeToDie() >= 5 + 2 * ComboPoints() and target.Refreshable(nightblade_debuff) and target.InRange(nightblade) and Spell(nightblade) or target.DebuffRemaining(nightblade_debuff) < SpellCooldown(symbols_of_death) + 10 and SpellCooldown(symbols_of_death) <= 5 and target.TimeToDie() - target.DebuffRemaining(nightblade_debuff) > SpellCooldown(symbols_of_death) + 5 and target.InRange(nightblade) and Spell(nightblade) or BuffPresent(symbols_of_death_buff) and { not Talent(dark_shadow_talent) or BuffPresent(shadow_dance_buff) } and target.InRange(secret_technique) and Spell(secret_technique) or Enemies(tagged=1) >= 2 + TalentPoints(dark_shadow_talent) + TalentPoints(nightstalker_talent) and target.InRange(secret_technique) and Spell(secret_technique) or target.InRange(eviscerate) and Spell(eviscerate) }
}

### actions.precombat

AddFunction SubtletyPrecombatMainActions
{
}

AddFunction SubtletyPrecombatMainPostConditions
{
}

AddFunction SubtletyPrecombatShortCdActions
{
 #flask
 #augmentation
 #food
 #snapshot_stats
 #stealth
 if target.InRange(shadowstep) Spell(stealth)
 #marked_for_death,precombat_seconds=15
 Spell(marked_for_death)
}

AddFunction SubtletyPrecombatShortCdPostConditions
{
}

AddFunction SubtletyPrecombatCdActions
{
 #shadow_blades,precombat_seconds=1
 if target.InRange(backstab) Spell(shadow_blades)
 #potion
 # if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(item_potion_of_unbridled_fury usable=1)
 #use_item,name=azsharas_font_of_power
 SubtletyUseItemActions()
}

AddFunction SubtletyPrecombatCdPostConditions
{
}

### actions.stealth_cds

AddFunction SubtletyStealthCdsMainActions
{
}

AddFunction SubtletyStealthCdsMainPostConditions
{
}

AddFunction SubtletyStealthCdsShortCdActions
{
 #variable,name=shd_threshold,value=cooldown.shadow_dance.charges_fractional>=1.75
 #vanish,if=!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
 if not shd_threshold() and ComboPointsDeficit() > 1 and target.DebuffRemaining(find_weakness_debuff) < 1 and VanishAllowed() Spell(vanish)
 #pool_resource,for_next=1,extra_amount=40
 #shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
 unless True(pool_energy 40) and EnergyDeficit() >= 10 and not shd_threshold() and ComboPointsDeficit() > 1 and target.DebuffRemaining(find_weakness_debuff) < 1 and VanishAllowed() and SpellUsable(shadowmeld) and SpellCooldown(shadowmeld) < TimeToEnergy(40)
 {
  #variable,name=shd_combo_points,value=combo_points.deficit>=4
  #variable,name=shd_combo_points,value=combo_points.deficit<=1+2*azerite.the_first_dance.enabled,if=variable.use_priority_rotation&(talent.nightstalker.enabled|talent.dark_shadow.enabled)
  #shadow_dance,if=variable.shd_combo_points&(!talent.dark_shadow.enabled|dot.nightblade.remains>=5+talent.subterfuge.enabled)&(variable.shd_threshold|buff.symbols_of_death.remains>=1.2|spell_targets.shuriken_storm>=4&cooldown.symbols_of_death.remains>10)&(azerite.nights_vengeance.rank<2|buff.nights_vengeance.up)
  if shd_combo_points() and { not Talent(dark_shadow_talent) or target.DebuffRemaining(nightblade_debuff) >= 5 + TalentPoints(subterfuge_talent) } and { shd_threshold() or BuffRemaining(symbols_of_death_buff) >= 1.2 or Enemies(tagged=1) >= 4 and SpellCooldown(symbols_of_death) > 10 } and { AzeriteTraitRank(nights_vengeance_trait) < 2 or BuffPresent(nights_vengeance_buff) } and target.InRange(shadowstep) and not BuffPresent(shadow_dance_buff) Spell(shadow_dance)
  #shadow_dance,if=variable.shd_combo_points&target.time_to_die<cooldown.symbols_of_death.remains&!raid_event.adds.up
  if shd_combo_points() and target.TimeToDie() < SpellCooldown(symbols_of_death) and not False(raid_event_adds_exists) and target.InRange(shadowstep) and not BuffPresent(shadow_dance_buff) Spell(shadow_dance)
 }
}

AddFunction SubtletyStealthCdsShortCdPostConditions
{
}

AddFunction SubtletyStealthCdsCdActions
{
 #pool_resource,for_next=1,extra_amount=40
 #shadowmeld,if=energy>=40&energy.deficit>=10&!variable.shd_threshold&combo_points.deficit>1&debuff.find_weakness.remains<1
 if Energy() >= 40 and EnergyDeficit() >= 10 and not shd_threshold() and ComboPointsDeficit() > 1 and target.DebuffRemaining(find_weakness_debuff) < 1 and VanishAllowed() Spell(shadowmeld)
}

AddFunction SubtletyStealthCdsCdPostConditions
{
}

### actions.stealthed

AddFunction SubtletyStealthedMainActions
{
 #shadowstrike,if=(talent.find_weakness.enabled|spell_targets.shuriken_storm<3)&(buff.stealth.up|buff.vanish.up)
 if { Talent(find_weakness_talent) or Enemies(tagged=1) < 3 } and { BuffPresent(stealthed_buff any=1) or BuffPresent(vanish_buff) } and target.InRange(shadowstrike) Spell(shadowstrike)
 #call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
 if BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 SubtletyFinishMainActions()

 unless BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 and SubtletyFinishMainPostConditions()
 {
  #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
  if Enemies(tagged=1) == 4 and ComboPoints() >= 4 SubtletyFinishMainActions()

  unless Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishMainPostConditions()
  {
   #call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&(buff.vanish.up|azerite.the_first_dance.enabled&!talent.dark_shadow.enabled&!talent.subterfuge.enabled&spell_targets.shuriken_storm<3))
   if ComboPointsDeficit() <= 1 - { Talent(deeper_stratagem_talent) and { BuffPresent(vanish_buff) or HasAzeriteTrait(the_first_dance_trait) and not Talent(dark_shadow_talent) and not Talent(subterfuge_talent) and Enemies(tagged=1) < 3 } } SubtletyFinishMainActions()

   unless ComboPointsDeficit() <= 1 - { Talent(deeper_stratagem_talent) and { BuffPresent(vanish_buff) or HasAzeriteTrait(the_first_dance_trait) and not Talent(dark_shadow_talent) and not Talent(subterfuge_talent) and Enemies(tagged=1) < 3 } } and SubtletyFinishMainPostConditions()
   {
    #gloomblade,if=azerite.perforate.rank>=2&spell_targets.shuriken_storm<=2&position_back
    if AzeriteTraitRank(perforate_trait) >= 2 and Enemies(tagged=1) <= 2 and True(position_back) Spell(gloomblade)
    #shadowstrike,cycle_targets=1,if=talent.secret_technique.enabled&talent.find_weakness.enabled&debuff.find_weakness.remains<1&spell_targets.shuriken_storm=2&target.time_to_die-remains>6
    if Talent(secret_technique_talent) and Talent(find_weakness_talent) and target.DebuffRemaining(find_weakness_debuff) < 1 and Enemies(tagged=1) == 2 and target.TimeToDie() - BuffRemaining(shadowstrike) > 6 and target.InRange(shadowstrike) Spell(shadowstrike)
    #shadowstrike,if=!talent.deeper_stratagem.enabled&azerite.blade_in_the_shadows.rank=3&spell_targets.shuriken_storm=3
    if not Talent(deeper_stratagem_talent) and AzeriteTraitRank(blade_in_the_shadows_trait) == 3 and Enemies(tagged=1) == 3 and target.InRange(shadowstrike) Spell(shadowstrike)
    #shadowstrike,if=variable.use_priority_rotation&(talent.find_weakness.enabled&debuff.find_weakness.remains<1|talent.weaponmaster.enabled&spell_targets.shuriken_storm<=4|azerite.inevitability.enabled&buff.symbols_of_death.up&spell_targets.shuriken_storm<=3+azerite.blade_in_the_shadows.enabled)
    if use_priority_rotation() and { Talent(find_weakness_talent) and target.DebuffRemaining(find_weakness_debuff) < 1 or Talent(weaponmaster_talent) and Enemies(tagged=1) <= 4 or HasAzeriteTrait(inevitability_trait) and BuffPresent(symbols_of_death_buff) and Enemies(tagged=1) <= 3 + HasAzeriteTrait(blade_in_the_shadows_trait) } and target.InRange(shadowstrike) Spell(shadowstrike)
    #shuriken_storm,if=spell_targets>=3
    if Enemies(tagged=1) >= 3 and target.InRange(backstab) Spell(shuriken_storm)
    #shadowstrike
    if target.InRange(shadowstrike) Spell(shadowstrike)
   }
  }
 }
}

AddFunction SubtletyStealthedMainPostConditions
{
 BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 and SubtletyFinishMainPostConditions() or Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishMainPostConditions() or ComboPointsDeficit() <= 1 - { Talent(deeper_stratagem_talent) and { BuffPresent(vanish_buff) or HasAzeriteTrait(the_first_dance_trait) and not Talent(dark_shadow_talent) and not Talent(subterfuge_talent) and Enemies(tagged=1) < 3 } } and SubtletyFinishMainPostConditions()
}

AddFunction SubtletyStealthedShortCdActions
{
 unless { Talent(find_weakness_talent) or Enemies(tagged=1) < 3 } and { BuffPresent(stealthed_buff any=1) or BuffPresent(vanish_buff) } and target.InRange(shadowstrike) and Spell(shadowstrike)
 {
  #call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
  if BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 SubtletyFinishShortCdActions()

  unless BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 and SubtletyFinishShortCdPostConditions()
  {
   #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
   if Enemies(tagged=1) == 4 and ComboPoints() >= 4 SubtletyFinishShortCdActions()

   unless Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishShortCdPostConditions()
   {
    #call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&(buff.vanish.up|azerite.the_first_dance.enabled&!talent.dark_shadow.enabled&!talent.subterfuge.enabled&spell_targets.shuriken_storm<3))
    if ComboPointsDeficit() <= 1 - { Talent(deeper_stratagem_talent) and { BuffPresent(vanish_buff) or HasAzeriteTrait(the_first_dance_trait) and not Talent(dark_shadow_talent) and not Talent(subterfuge_talent) and Enemies(tagged=1) < 3 } } SubtletyFinishShortCdActions()
   }
  }
 }
}

AddFunction SubtletyStealthedShortCdPostConditions
{
 { Talent(find_weakness_talent) or Enemies(tagged=1) < 3 } and { BuffPresent(stealthed_buff any=1) or BuffPresent(vanish_buff) } and target.InRange(shadowstrike) and Spell(shadowstrike) or BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 and SubtletyFinishShortCdPostConditions() or Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishShortCdPostConditions() or ComboPointsDeficit() <= 1 - { Talent(deeper_stratagem_talent) and { BuffPresent(vanish_buff) or HasAzeriteTrait(the_first_dance_trait) and not Talent(dark_shadow_talent) and not Talent(subterfuge_talent) and Enemies(tagged=1) < 3 } } and SubtletyFinishShortCdPostConditions() or AzeriteTraitRank(perforate_trait) >= 2 and Enemies(tagged=1) <= 2 and True(position_back) and Spell(gloomblade) or Talent(secret_technique_talent) and Talent(find_weakness_talent) and target.DebuffRemaining(find_weakness_debuff) < 1 and Enemies(tagged=1) == 2 and target.TimeToDie() - BuffRemaining(shadowstrike) > 6 and target.InRange(shadowstrike) and Spell(shadowstrike) or not Talent(deeper_stratagem_talent) and AzeriteTraitRank(blade_in_the_shadows_trait) == 3 and Enemies(tagged=1) == 3 and target.InRange(shadowstrike) and Spell(shadowstrike) or use_priority_rotation() and { Talent(find_weakness_talent) and target.DebuffRemaining(find_weakness_debuff) < 1 or Talent(weaponmaster_talent) and Enemies(tagged=1) <= 4 or HasAzeriteTrait(inevitability_trait) and BuffPresent(symbols_of_death_buff) and Enemies(tagged=1) <= 3 + HasAzeriteTrait(blade_in_the_shadows_trait) } and target.InRange(shadowstrike) and Spell(shadowstrike) or Enemies(tagged=1) >= 3 and target.InRange(backstab) and Spell(shuriken_storm) or target.InRange(shadowstrike) and Spell(shadowstrike)
}

AddFunction SubtletyStealthedCdActions
{
 unless { Talent(find_weakness_talent) or Enemies(tagged=1) < 3 } and { BuffPresent(stealthed_buff any=1) or BuffPresent(vanish_buff) } and target.InRange(shadowstrike) and Spell(shadowstrike)
 {
  #call_action_list,name=finish,if=buff.shuriken_tornado.up&combo_points.deficit<=2
  if BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 SubtletyFinishCdActions()

  unless BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 and SubtletyFinishCdPostConditions()
  {
   #call_action_list,name=finish,if=spell_targets.shuriken_storm=4&combo_points>=4
   if Enemies(tagged=1) == 4 and ComboPoints() >= 4 SubtletyFinishCdActions()

   unless Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishCdPostConditions()
   {
    #call_action_list,name=finish,if=combo_points.deficit<=1-(talent.deeper_stratagem.enabled&(buff.vanish.up|azerite.the_first_dance.enabled&!talent.dark_shadow.enabled&!talent.subterfuge.enabled&spell_targets.shuriken_storm<3))
    if ComboPointsDeficit() <= 1 - { Talent(deeper_stratagem_talent) and { BuffPresent(vanish_buff) or HasAzeriteTrait(the_first_dance_trait) and not Talent(dark_shadow_talent) and not Talent(subterfuge_talent) and Enemies(tagged=1) < 3 } } SubtletyFinishCdActions()
   }
  }
 }
}

AddFunction SubtletyStealthedCdPostConditions
{
 { Talent(find_weakness_talent) or Enemies(tagged=1) < 3 } and { BuffPresent(stealthed_buff any=1) or BuffPresent(vanish_buff) } and target.InRange(shadowstrike) and Spell(shadowstrike) or BuffPresent(shuriken_tornado) and ComboPointsDeficit() <= 2 and SubtletyFinishCdPostConditions() or Enemies(tagged=1) == 4 and ComboPoints() >= 4 and SubtletyFinishCdPostConditions() or ComboPointsDeficit() <= 1 - { Talent(deeper_stratagem_talent) and { BuffPresent(vanish_buff) or HasAzeriteTrait(the_first_dance_trait) and not Talent(dark_shadow_talent) and not Talent(subterfuge_talent) and Enemies(tagged=1) < 3 } } and SubtletyFinishCdPostConditions() or AzeriteTraitRank(perforate_trait) >= 2 and Enemies(tagged=1) <= 2 and True(position_back) and Spell(gloomblade) or Talent(secret_technique_talent) and Talent(find_weakness_talent) and target.DebuffRemaining(find_weakness_debuff) < 1 and Enemies(tagged=1) == 2 and target.TimeToDie() - BuffRemaining(shadowstrike) > 6 and target.InRange(shadowstrike) and Spell(shadowstrike) or not Talent(deeper_stratagem_talent) and AzeriteTraitRank(blade_in_the_shadows_trait) == 3 and Enemies(tagged=1) == 3 and target.InRange(shadowstrike) and Spell(shadowstrike) or use_priority_rotation() and { Talent(find_weakness_talent) and target.DebuffRemaining(find_weakness_debuff) < 1 or Talent(weaponmaster_talent) and Enemies(tagged=1) <= 4 or HasAzeriteTrait(inevitability_trait) and BuffPresent(symbols_of_death_buff) and Enemies(tagged=1) <= 3 + HasAzeriteTrait(blade_in_the_shadows_trait) } and target.InRange(shadowstrike) and Spell(shadowstrike) or Enemies(tagged=1) >= 3 and target.InRange(backstab) and Spell(shuriken_storm) or target.InRange(shadowstrike) and Spell(shadowstrike)
}
]]

		OvaleScripts:RegisterScript("ROGUE", "subtlety", name, desc, code, "script")
	end
end
