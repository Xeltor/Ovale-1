local __exports = LibStub:GetLibrary("ovale/scripts/ovale_warrior")
if not __exports then return end
__exports.registerWarriorArmsXeltor = function(OvaleScripts)
do
	local name = "xeltor_arms"
	local desc = "[Xel][8.2] Warrior: Arms"
	local code = [[
Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_warrior_spells)

# Arms
AddIcon specialization=1 help=main
{
	if InCombat() InterruptActions()

	if target.InRange(mortal_strike) and HasFullControl()
	{
		# Cooldowns
		if Boss() ArmsDefaultCdActions()
		
		# Short Cooldowns
		ArmsDefaultShortCdActions()
		
		# Lazy about it
		Spell(victory_rush)
		
		# Normal rotation
		ArmsDefaultMainActions()
	}
	# Move to the target!
	if target.InRange(charge) and InCombat() and HasFullControl() Spell(heroic_throw)
	if target.InRange(charge) and InCombat() and HasFullControl() and { TimeInCombat() < 6 or Falling() } Spell(charge)
}

AddFunction InterruptActions
{
	if { target.HasManagedInterrupts() and target.MustBeInterrupted() } or { not target.HasManagedInterrupts() and target.IsInterruptible() }
	{
		if target.InRange(intimidating_shout) and not target.Classification(worldboss) Spell(intimidating_shout)
		if target.Distance(less 5) and not target.Classification(worldboss) Spell(war_stomp)
		if target.InRange(quaking_palm) and not target.Classification(worldboss) Spell(quaking_palm)
		if target.InRange(storm_bolt) and not target.Classification(worldboss) Spell(storm_bolt)
		if target.Distance(less 10) and not target.Classification(worldboss) Spell(shockwave)
		if target.InRange(pummel) and target.IsInterruptible() Spell(pummel)
	}
}

AddFunction ArmsUseItemActions
{
 if Item(Trinket0Slot usable=1) Texture(inv_jewelry_talisman_12)
 if Item(Trinket1Slot usable=1) Texture(inv_jewelry_talisman_12)
}

### actions.default

AddFunction ArmsDefaultMainActions
{
 #potion
 # if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(item_potion_of_unbridled_fury usable=1)
 #sweeping_strikes,if=spell_targets.whirlwind>1&(cooldown.bladestorm.remains>10|cooldown.colossus_smash.remains>8|azerite.test_of_might.enabled)
 if Enemies(tagged=1) > 1 and { SpellCooldown(bladestorm_arms) > 10 or SpellCooldown(colossus_smash) > 8 or HasAzeriteTrait(test_of_might_trait) } Spell(sweeping_strikes)
 #concentrated_flame,if=!debuff.colossus_smash.up&!buff.test_of_might.up&dot.concentrated_flame_burn.remains=0
 if not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and not target.DebuffRemaining(concentrated_flame_burn_debuff) > 0 Spell(concentrated_flame_essence)
 #run_action_list,name=hac,if=raid_event.adds.exists
 if False(raid_event_adds_exists) ArmsHacMainActions()

 unless False(raid_event_adds_exists) and ArmsHacMainPostConditions()
 {
  #run_action_list,name=five_target,if=spell_targets.whirlwind>4
  if Enemies(tagged=1) > 4 ArmsFiveTargetMainActions()

  unless Enemies(tagged=1) > 4 and ArmsFiveTargetMainPostConditions()
  {
   #run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
   if Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 ArmsExecuteMainActions()

   unless { Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 } and ArmsExecuteMainPostConditions()
   {
    #run_action_list,name=single_target
    ArmsSingleTargetMainActions()
   }
  }
 }
}

AddFunction ArmsDefaultMainPostConditions
{
 False(raid_event_adds_exists) and ArmsHacMainPostConditions() or Enemies(tagged=1) > 4 and ArmsFiveTargetMainPostConditions() or { Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 } and ArmsExecuteMainPostConditions() or ArmsSingleTargetMainPostConditions()
}

AddFunction ArmsDefaultShortCdActions
{
 #charge
 # if CheckBoxOn(opt_melee_range) and target.InRange(charge) and not target.InRange(pummel) Spell(charge)
 #auto_attack
 # ArmsGetInMeleeRange()

 unless Enemies(tagged=1) > 1 and { SpellCooldown(bladestorm_arms) > 10 or SpellCooldown(colossus_smash) > 8 or HasAzeriteTrait(test_of_might_trait) } and Spell(sweeping_strikes)
 {
  #purifying_blast,if=!debuff.colossus_smash.up&!buff.test_of_might.up
  if not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) Spell(purifying_blast)
  #ripple_in_space,if=!debuff.colossus_smash.up&!buff.test_of_might.up
  if not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) Spell(ripple_in_space_essence)
  #worldvein_resonance,if=!debuff.colossus_smash.up&!buff.test_of_might.up
  if not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) Spell(worldvein_resonance_essence)

  unless not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and not target.DebuffRemaining(concentrated_flame_burn_debuff) > 0 and Spell(concentrated_flame_essence)
  {
   #the_unbound_force,if=buff.reckless_force.up
   if BuffPresent(reckless_force_buff) Spell(the_unbound_force)
   #run_action_list,name=hac,if=raid_event.adds.exists
   if False(raid_event_adds_exists) ArmsHacShortCdActions()

   unless False(raid_event_adds_exists) and ArmsHacShortCdPostConditions()
   {
    #run_action_list,name=five_target,if=spell_targets.whirlwind>4
    if Enemies(tagged=1) > 4 ArmsFiveTargetShortCdActions()

    unless Enemies(tagged=1) > 4 and ArmsFiveTargetShortCdPostConditions()
    {
     #run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
     if Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 ArmsExecuteShortCdActions()

     unless { Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 } and ArmsExecuteShortCdPostConditions()
     {
      #run_action_list,name=single_target
      ArmsSingleTargetShortCdActions()
     }
    }
   }
  }
 }
}

AddFunction ArmsDefaultShortCdPostConditions
{
 Enemies(tagged=1) > 1 and { SpellCooldown(bladestorm_arms) > 10 or SpellCooldown(colossus_smash) > 8 or HasAzeriteTrait(test_of_might_trait) } and Spell(sweeping_strikes) or not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and not target.DebuffRemaining(concentrated_flame_burn_debuff) > 0 and Spell(concentrated_flame_essence) or False(raid_event_adds_exists) and ArmsHacShortCdPostConditions() or Enemies(tagged=1) > 4 and ArmsFiveTargetShortCdPostConditions() or { Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 } and ArmsExecuteShortCdPostConditions() or ArmsSingleTargetShortCdPostConditions()
}

AddFunction ArmsDefaultCdActions
{
 # ArmsInterruptActions()

 # unless CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) and Item(item_potion_of_unbridled_fury usable=1)
 # {
  #blood_fury,if=debuff.colossus_smash.up
  if target.DebuffPresent(colossus_smash_debuff) Spell(blood_fury_ap)
  #berserking,if=debuff.colossus_smash.up
  if target.DebuffPresent(colossus_smash_debuff) Spell(berserking)
  #arcane_torrent,if=debuff.colossus_smash.down&cooldown.mortal_strike.remains>1.5&rage<50
  if target.DebuffExpires(colossus_smash_debuff) and SpellCooldown(mortal_strike) > 1.5 and Rage() < 50 Spell(arcane_torrent_rage)
  #lights_judgment,if=debuff.colossus_smash.down
  if target.DebuffExpires(colossus_smash_debuff) Spell(lights_judgment)
  #fireblood,if=debuff.colossus_smash.up
  if target.DebuffPresent(colossus_smash_debuff) Spell(fireblood)
  #ancestral_call,if=debuff.colossus_smash.up
  if target.DebuffPresent(colossus_smash_debuff) Spell(ancestral_call)
  #use_item,name=vision_of_demise
  ArmsUseItemActions()
  #avatar,if=cooldown.colossus_smash.remains<8|(talent.warbreaker.enabled&cooldown.warbreaker.remains<8)
  if SpellCooldown(colossus_smash) < 8 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 8 Spell(avatar)

  unless Enemies(tagged=1) > 1 and { SpellCooldown(bladestorm_arms) > 10 or SpellCooldown(colossus_smash) > 8 or HasAzeriteTrait(test_of_might_trait) } and Spell(sweeping_strikes)
  {
   #blood_of_the_enemy,if=buff.test_of_might.up|(debuff.colossus_smash.up&!azerite.test_of_might.enabled)
   if BuffPresent(test_of_might_buff) or target.DebuffPresent(colossus_smash_debuff) and not HasAzeriteTrait(test_of_might_trait) Spell(blood_of_the_enemy)

   unless not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and Spell(purifying_blast) or not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and Spell(ripple_in_space_essence) or not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and Spell(worldvein_resonance_essence)
   {
    #focused_azerite_beam,if=!debuff.colossus_smash.up&!buff.test_of_might.up
    if not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) Spell(focused_azerite_beam)

    unless not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and not target.DebuffRemaining(concentrated_flame_burn_debuff) > 0 and Spell(concentrated_flame_essence) or BuffPresent(reckless_force_buff) and Spell(the_unbound_force)
    {
     #guardian_of_azeroth,if=cooldown.colossus_smash.remains<10
     if SpellCooldown(colossus_smash) < 10 Spell(guardian_of_azeroth)
     #memory_of_lucid_dreams,if=cooldown.colossus_smash.remains<3
     if SpellCooldown(colossus_smash) < 3 Spell(memory_of_lucid_dreams_essence)
     #run_action_list,name=hac,if=raid_event.adds.exists
     if False(raid_event_adds_exists) ArmsHacCdActions()

     unless False(raid_event_adds_exists) and ArmsHacCdPostConditions()
     {
      #run_action_list,name=five_target,if=spell_targets.whirlwind>4
      if Enemies(tagged=1) > 4 ArmsFiveTargetCdActions()

      unless Enemies(tagged=1) > 4 and ArmsFiveTargetCdPostConditions()
      {
       #run_action_list,name=execute,if=(talent.massacre.enabled&target.health.pct<35)|target.health.pct<20
       if Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 ArmsExecuteCdActions()

       unless { Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 } and ArmsExecuteCdPostConditions()
       {
        #run_action_list,name=single_target
        ArmsSingleTargetCdActions()
       }
      }
     }
    }
   }
  }
 # }
}

AddFunction ArmsDefaultCdPostConditions
{
 Enemies(tagged=1) > 1 and { SpellCooldown(bladestorm_arms) > 10 or SpellCooldown(colossus_smash) > 8 or HasAzeriteTrait(test_of_might_trait) } and Spell(sweeping_strikes) or not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and Spell(purifying_blast) or not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and Spell(ripple_in_space_essence) or not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and Spell(worldvein_resonance_essence) or not target.DebuffPresent(colossus_smash_debuff) and not BuffPresent(test_of_might_buff) and not target.DebuffRemaining(concentrated_flame_burn_debuff) > 0 and Spell(concentrated_flame_essence) or BuffPresent(reckless_force_buff) and Spell(the_unbound_force) or False(raid_event_adds_exists) and ArmsHacCdPostConditions() or Enemies(tagged=1) > 4 and ArmsFiveTargetCdPostConditions() or { Talent(massacre_talent) and target.HealthPercent() < 35 or target.HealthPercent() < 20 } and ArmsExecuteCdPostConditions() or ArmsSingleTargetCdPostConditions()
}

### actions.execute

AddFunction ArmsExecuteMainActions
{
 #skullsplitter,if=rage<60&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
 if Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) Spell(skullsplitter)
 #colossus_smash,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
 if not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 Spell(colossus_smash)
 #warbreaker,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
 if not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 Spell(warbreaker)
 #cleave,if=spell_targets.whirlwind>2
 if Enemies(tagged=1) > 2 Spell(cleave)
 #slam,if=buff.crushing_assault.up&buff.memory_of_lucid_dreams.down
 if BuffPresent(crushing_assault_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) Spell(slam)
 #mortal_strike,if=buff.overpower.stack=2&talent.dreadnaught.enabled|buff.executioners_precision.stack=2
 if BuffStacks(overpower_buff) == 2 and Talent(dreadnaught_talent) or 0 == 2 Spell(mortal_strike)
 #execute,if=buff.memory_of_lucid_dreams.up|buff.deadly_calm.up
 if BuffPresent(memory_of_lucid_dreams_essence_buff) or BuffPresent(deadly_calm_buff) Spell(execute_arms)
 #overpower
 Spell(overpower)
 #execute
 Spell(execute_arms)
}

AddFunction ArmsExecuteMainPostConditions
{
}

AddFunction ArmsExecuteShortCdActions
{
 unless Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(skullsplitter)
 {
  #ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
  if not BuffPresent(deadly_calm_buff) and { SpellCooldown(colossus_smash) < 2 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 2 } Spell(ravager)

  unless { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(colossus_smash) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(warbreaker)
  {
   #deadly_calm
   Spell(deadly_calm)
   #bladestorm,if=!buff.memory_of_lucid_dreams.up&buff.test_of_might.up&rage<30&!buff.deadly_calm.up
   if not BuffPresent(memory_of_lucid_dreams_essence_buff) and BuffPresent(test_of_might_buff) and Rage() < 30 and not BuffPresent(deadly_calm_buff) Spell(bladestorm_arms)
  }
 }
}

AddFunction ArmsExecuteShortCdPostConditions
{
 Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(skullsplitter) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(colossus_smash) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(warbreaker) or Enemies(tagged=1) > 2 and Spell(cleave) or BuffPresent(crushing_assault_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(slam) or { BuffStacks(overpower_buff) == 2 and Talent(dreadnaught_talent) or 0 == 2 } and Spell(mortal_strike) or { BuffPresent(memory_of_lucid_dreams_essence_buff) or BuffPresent(deadly_calm_buff) } and Spell(execute_arms) or Spell(overpower) or Spell(execute_arms)
}

AddFunction ArmsExecuteCdActions
{
}

AddFunction ArmsExecuteCdPostConditions
{
 Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(skullsplitter) or not BuffPresent(deadly_calm_buff) and { SpellCooldown(colossus_smash) < 2 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 2 } and Spell(ravager) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(colossus_smash) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(warbreaker) or not BuffPresent(memory_of_lucid_dreams_essence_buff) and BuffPresent(test_of_might_buff) and Rage() < 30 and not BuffPresent(deadly_calm_buff) and Spell(bladestorm_arms) or Enemies(tagged=1) > 2 and Spell(cleave) or BuffPresent(crushing_assault_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(slam) or { BuffStacks(overpower_buff) == 2 and Talent(dreadnaught_talent) or 0 == 2 } and Spell(mortal_strike) or { BuffPresent(memory_of_lucid_dreams_essence_buff) or BuffPresent(deadly_calm_buff) } and Spell(execute_arms) or Spell(overpower) or Spell(execute_arms)
}

### actions.five_target

AddFunction ArmsFiveTargetMainActions
{
 #skullsplitter,if=rage<60&(!talent.deadly_calm.enabled|buff.deadly_calm.down)
 if Rage() < 60 and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } Spell(skullsplitter)
 #colossus_smash,if=debuff.colossus_smash.down
 if target.DebuffExpires(colossus_smash_debuff) Spell(colossus_smash)
 #warbreaker,if=debuff.colossus_smash.down
 if target.DebuffExpires(colossus_smash_debuff) Spell(warbreaker)
 #cleave
 Spell(cleave)
 #execute,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|(buff.sudden_death.react|buff.stone_heart.react)&(buff.sweeping_strikes.up|cooldown.sweeping_strikes.remains>8)
 if not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or { BuffPresent(sudden_death) or BuffPresent(stone_heart_buff) } and { BuffPresent(sweeping_strikes_buff) or SpellCooldown(sweeping_strikes) > 8 } Spell(execute_arms)
 #mortal_strike,if=(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sweeping_strikes.up&buff.overpower.stack=2&(talent.dreadnaught.enabled|buff.executioners_precision.stack=2)
 if not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or BuffPresent(sweeping_strikes_buff) and BuffStacks(overpower_buff) == 2 and { Talent(dreadnaught_talent) or 0 == 2 } Spell(mortal_strike)
 #whirlwind,if=debuff.colossus_smash.up|(buff.crushing_assault.up&talent.fervor_of_battle.enabled)
 if target.DebuffPresent(colossus_smash_debuff) or BuffPresent(crushing_assault_buff) and Talent(fervor_of_battle_talent) Spell(whirlwind_arms)
 #whirlwind,if=buff.deadly_calm.up|rage>60
 if BuffPresent(deadly_calm_buff) or Rage() > 60 Spell(whirlwind_arms)
 #overpower
 Spell(overpower)
 #whirlwind
 Spell(whirlwind_arms)
}

AddFunction ArmsFiveTargetMainPostConditions
{
}

AddFunction ArmsFiveTargetShortCdActions
{
 unless Rage() < 60 and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } and Spell(skullsplitter)
 {
  #ravager,if=(!talent.warbreaker.enabled|cooldown.warbreaker.remains<2)
  if not Talent(warbreaker_talent) or SpellCooldown(warbreaker) < 2 Spell(ravager)

  unless target.DebuffExpires(colossus_smash_debuff) and Spell(colossus_smash) or target.DebuffExpires(colossus_smash_debuff) and Spell(warbreaker)
  {
   #bladestorm,if=buff.sweeping_strikes.down&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
   if BuffExpires(sweeping_strikes_buff) and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } and { target.DebuffRemaining(colossus_smash_debuff) > 4.5 and not HasAzeriteTrait(test_of_might_trait) or BuffPresent(test_of_might_buff) } Spell(bladestorm_arms)
   #deadly_calm
   Spell(deadly_calm)
  }
 }
}

AddFunction ArmsFiveTargetShortCdPostConditions
{
 Rage() < 60 and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } and Spell(skullsplitter) or target.DebuffExpires(colossus_smash_debuff) and Spell(colossus_smash) or target.DebuffExpires(colossus_smash_debuff) and Spell(warbreaker) or Spell(cleave) or { not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or { BuffPresent(sudden_death) or BuffPresent(stone_heart_buff) } and { BuffPresent(sweeping_strikes_buff) or SpellCooldown(sweeping_strikes) > 8 } } and Spell(execute_arms) or { not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or BuffPresent(sweeping_strikes_buff) and BuffStacks(overpower_buff) == 2 and { Talent(dreadnaught_talent) or 0 == 2 } } and Spell(mortal_strike) or { target.DebuffPresent(colossus_smash_debuff) or BuffPresent(crushing_assault_buff) and Talent(fervor_of_battle_talent) } and Spell(whirlwind_arms) or { BuffPresent(deadly_calm_buff) or Rage() > 60 } and Spell(whirlwind_arms) or Spell(overpower) or Spell(whirlwind_arms)
}

AddFunction ArmsFiveTargetCdActions
{
}

AddFunction ArmsFiveTargetCdPostConditions
{
 Rage() < 60 and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } and Spell(skullsplitter) or { not Talent(warbreaker_talent) or SpellCooldown(warbreaker) < 2 } and Spell(ravager) or target.DebuffExpires(colossus_smash_debuff) and Spell(colossus_smash) or target.DebuffExpires(colossus_smash_debuff) and Spell(warbreaker) or BuffExpires(sweeping_strikes_buff) and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } and { target.DebuffRemaining(colossus_smash_debuff) > 4.5 and not HasAzeriteTrait(test_of_might_trait) or BuffPresent(test_of_might_buff) } and Spell(bladestorm_arms) or Spell(cleave) or { not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or { BuffPresent(sudden_death) or BuffPresent(stone_heart_buff) } and { BuffPresent(sweeping_strikes_buff) or SpellCooldown(sweeping_strikes) > 8 } } and Spell(execute_arms) or { not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or BuffPresent(sweeping_strikes_buff) and BuffStacks(overpower_buff) == 2 and { Talent(dreadnaught_talent) or 0 == 2 } } and Spell(mortal_strike) or { target.DebuffPresent(colossus_smash_debuff) or BuffPresent(crushing_assault_buff) and Talent(fervor_of_battle_talent) } and Spell(whirlwind_arms) or { BuffPresent(deadly_calm_buff) or Rage() > 60 } and Spell(whirlwind_arms) or Spell(overpower) or Spell(whirlwind_arms)
}

### actions.hac

AddFunction ArmsHacMainActions
{
 #rend,if=remains<=duration*0.3&(!raid_event.adds.up|buff.sweeping_strikes.up)
 if target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and { not False(raid_event_adds_exists) or BuffPresent(sweeping_strikes_buff) } Spell(rend)
 #skullsplitter,if=rage<60&(cooldown.deadly_calm.remains>3|!talent.deadly_calm.enabled)
 if Rage() < 60 and { SpellCooldown(deadly_calm) > 3 or not Talent(deadly_calm_talent) } Spell(skullsplitter)
 #colossus_smash,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
 if False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) Spell(colossus_smash)
 #warbreaker,if=raid_event.adds.up|raid_event.adds.in>40|(raid_event.adds.in>20&talent.anger_management.enabled)
 if False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) Spell(warbreaker)
 #overpower,if=!raid_event.adds.up|(raid_event.adds.up&azerite.seismic_wave.enabled)
 if not False(raid_event_adds_exists) or False(raid_event_adds_exists) and HasAzeriteTrait(seismic_wave_trait) Spell(overpower)
 #cleave,if=spell_targets.whirlwind>2
 if Enemies(tagged=1) > 2 Spell(cleave)
 #execute,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)|buff.sudden_death.react
 if not False(raid_event_adds_exists) or not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or BuffPresent(sudden_death) Spell(execute_arms)
 #mortal_strike,if=!raid_event.adds.up|(!talent.cleave.enabled&dot.deep_wounds.remains<2)
 if not False(raid_event_adds_exists) or not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 Spell(mortal_strike)
 #whirlwind,if=raid_event.adds.up
 if False(raid_event_adds_exists) Spell(whirlwind_arms)
 #overpower
 Spell(overpower)
 #whirlwind,if=talent.fervor_of_battle.enabled
 if Talent(fervor_of_battle_talent) Spell(whirlwind_arms)
 #slam,if=!talent.fervor_of_battle.enabled&!raid_event.adds.up
 if not Talent(fervor_of_battle_talent) and not False(raid_event_adds_exists) Spell(slam)
}

AddFunction ArmsHacMainPostConditions
{
}

AddFunction ArmsHacShortCdActions
{
 unless target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and { not False(raid_event_adds_exists) or BuffPresent(sweeping_strikes_buff) } and Spell(rend) or Rage() < 60 and { SpellCooldown(deadly_calm) > 3 or not Talent(deadly_calm_talent) } and Spell(skullsplitter)
 {
  #deadly_calm,if=(cooldown.bladestorm.remains>6|talent.ravager.enabled&cooldown.ravager.remains>6)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
  if { SpellCooldown(bladestorm_arms) > 6 or Talent(ravager_talent) and SpellCooldown(ravager) > 6 } and { SpellCooldown(colossus_smash) < 2 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 2 } Spell(deadly_calm)
  #ravager,if=(raid_event.adds.up|raid_event.adds.in>target.time_to_die)&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
  if { False(raid_event_adds_exists) or 600 > target.TimeToDie() } and { SpellCooldown(colossus_smash) < 2 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 2 } Spell(ravager)

  unless { False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) } and Spell(colossus_smash) or { False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) } and Spell(warbreaker)
  {
   #bladestorm,if=(debuff.colossus_smash.up&raid_event.adds.in>target.time_to_die)|raid_event.adds.up&((debuff.colossus_smash.remains>4.5&!azerite.test_of_might.enabled)|buff.test_of_might.up)
   if target.DebuffPresent(colossus_smash_debuff) and 600 > target.TimeToDie() or False(raid_event_adds_exists) and { target.DebuffRemaining(colossus_smash_debuff) > 4.5 and not HasAzeriteTrait(test_of_might_trait) or BuffPresent(test_of_might_buff) } Spell(bladestorm_arms)
  }
 }
}

AddFunction ArmsHacShortCdPostConditions
{
 target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and { not False(raid_event_adds_exists) or BuffPresent(sweeping_strikes_buff) } and Spell(rend) or Rage() < 60 and { SpellCooldown(deadly_calm) > 3 or not Talent(deadly_calm_talent) } and Spell(skullsplitter) or { False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) } and Spell(colossus_smash) or { False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) } and Spell(warbreaker) or { not False(raid_event_adds_exists) or False(raid_event_adds_exists) and HasAzeriteTrait(seismic_wave_trait) } and Spell(overpower) or Enemies(tagged=1) > 2 and Spell(cleave) or { not False(raid_event_adds_exists) or not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or BuffPresent(sudden_death) } and Spell(execute_arms) or { not False(raid_event_adds_exists) or not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 } and Spell(mortal_strike) or False(raid_event_adds_exists) and Spell(whirlwind_arms) or Spell(overpower) or Talent(fervor_of_battle_talent) and Spell(whirlwind_arms) or not Talent(fervor_of_battle_talent) and not False(raid_event_adds_exists) and Spell(slam)
}

AddFunction ArmsHacCdActions
{
}

AddFunction ArmsHacCdPostConditions
{
 target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and { not False(raid_event_adds_exists) or BuffPresent(sweeping_strikes_buff) } and Spell(rend) or Rage() < 60 and { SpellCooldown(deadly_calm) > 3 or not Talent(deadly_calm_talent) } and Spell(skullsplitter) or { False(raid_event_adds_exists) or 600 > target.TimeToDie() } and { SpellCooldown(colossus_smash) < 2 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 2 } and Spell(ravager) or { False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) } and Spell(colossus_smash) or { False(raid_event_adds_exists) or 600 > 40 or 600 > 20 and Talent(anger_management_talent) } and Spell(warbreaker) or { target.DebuffPresent(colossus_smash_debuff) and 600 > target.TimeToDie() or False(raid_event_adds_exists) and { target.DebuffRemaining(colossus_smash_debuff) > 4.5 and not HasAzeriteTrait(test_of_might_trait) or BuffPresent(test_of_might_buff) } } and Spell(bladestorm_arms) or { not False(raid_event_adds_exists) or False(raid_event_adds_exists) and HasAzeriteTrait(seismic_wave_trait) } and Spell(overpower) or Enemies(tagged=1) > 2 and Spell(cleave) or { not False(raid_event_adds_exists) or not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 or BuffPresent(sudden_death) } and Spell(execute_arms) or { not False(raid_event_adds_exists) or not Talent(cleave_talent) and target.DebuffRemaining(deep_wounds_arms_debuff) < 2 } and Spell(mortal_strike) or False(raid_event_adds_exists) and Spell(whirlwind_arms) or Spell(overpower) or Talent(fervor_of_battle_talent) and Spell(whirlwind_arms) or not Talent(fervor_of_battle_talent) and not False(raid_event_adds_exists) and Spell(slam)
}

### actions.precombat

AddFunction ArmsPrecombatMainActions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 # if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(item_potion_of_unbridled_fury usable=1)
}

AddFunction ArmsPrecombatMainPostConditions
{
}

AddFunction ArmsPrecombatShortCdActions
{
}

AddFunction ArmsPrecombatShortCdPostConditions
{
 # CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) and Item(item_potion_of_unbridled_fury usable=1)
}

AddFunction ArmsPrecombatCdActions
{
 # unless CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) and Item(item_potion_of_unbridled_fury usable=1)
 # {
  #memory_of_lucid_dreams
  Spell(memory_of_lucid_dreams_essence)
  #guardian_of_azeroth
  Spell(guardian_of_azeroth)
 # }
}

AddFunction ArmsPrecombatCdPostConditions
{
 # CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) and Item(item_potion_of_unbridled_fury usable=1)
}

### actions.single_target

AddFunction ArmsSingleTargetMainActions
{
 #rend,if=remains<=duration*0.3&debuff.colossus_smash.down
 if target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and target.DebuffExpires(colossus_smash_debuff) Spell(rend)
 #skullsplitter,if=rage<60&buff.deadly_calm.down&buff.memory_of_lucid_dreams.down
 if Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) Spell(skullsplitter)
 #colossus_smash,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
 if not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 Spell(colossus_smash)
 #warbreaker,if=!essence.memory_of_lucid_dreams.major|(buff.memory_of_lucid_dreams.up|cooldown.memory_of_lucid_dreams.remains>10)
 if not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 Spell(warbreaker)
 #execute,if=buff.sudden_death.react
 if BuffPresent(sudden_death) Spell(execute_arms)
 #cleave,if=spell_targets.whirlwind>2
 if Enemies(tagged=1) > 2 Spell(cleave)
 #overpower,if=rage<30&buff.memory_of_lucid_dreams.up&debuff.colossus_smash.up
 if Rage() < 30 and BuffPresent(memory_of_lucid_dreams_essence_buff) and target.DebuffPresent(colossus_smash_debuff) Spell(overpower)
 #mortal_strike
 Spell(mortal_strike)
 #whirlwind,if=talent.fervor_of_battle.enabled&(buff.memory_of_lucid_dreams.up|buff.deadly_calm.up)
 if Talent(fervor_of_battle_talent) and { BuffPresent(memory_of_lucid_dreams_essence_buff) or BuffPresent(deadly_calm_buff) } Spell(whirlwind_arms)
 #overpower
 Spell(overpower)
 #whirlwind,if=talent.fervor_of_battle.enabled
 if Talent(fervor_of_battle_talent) Spell(whirlwind_arms)
 #slam,if=!talent.fervor_of_battle.enabled
 if not Talent(fervor_of_battle_talent) Spell(slam)
}

AddFunction ArmsSingleTargetMainPostConditions
{
}

AddFunction ArmsSingleTargetShortCdActions
{
 unless target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and target.DebuffExpires(colossus_smash_debuff) and Spell(rend) or Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(skullsplitter)
 {
  #ravager,if=!buff.deadly_calm.up&(cooldown.colossus_smash.remains<2|(talent.warbreaker.enabled&cooldown.warbreaker.remains<2))
  if not BuffPresent(deadly_calm_buff) and { SpellCooldown(colossus_smash) < 2 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 2 } Spell(ravager)

  unless { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(colossus_smash) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(warbreaker)
  {
   #deadly_calm
   Spell(deadly_calm)

   unless BuffPresent(sudden_death) and Spell(execute_arms)
   {
    #bladestorm,if=cooldown.mortal_strike.remains&(!talent.deadly_calm.enabled|buff.deadly_calm.down)&((debuff.colossus_smash.up&!azerite.test_of_might.enabled)|buff.test_of_might.up)&buff.memory_of_lucid_dreams.down
    if SpellCooldown(mortal_strike) > 0 and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } and { target.DebuffPresent(colossus_smash_debuff) and not HasAzeriteTrait(test_of_might_trait) or BuffPresent(test_of_might_buff) } and BuffExpires(memory_of_lucid_dreams_essence_buff) Spell(bladestorm_arms)
   }
  }
 }
}

AddFunction ArmsSingleTargetShortCdPostConditions
{
 target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and target.DebuffExpires(colossus_smash_debuff) and Spell(rend) or Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(skullsplitter) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(colossus_smash) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(warbreaker) or BuffPresent(sudden_death) and Spell(execute_arms) or Enemies(tagged=1) > 2 and Spell(cleave) or Rage() < 30 and BuffPresent(memory_of_lucid_dreams_essence_buff) and target.DebuffPresent(colossus_smash_debuff) and Spell(overpower) or Spell(mortal_strike) or Talent(fervor_of_battle_talent) and { BuffPresent(memory_of_lucid_dreams_essence_buff) or BuffPresent(deadly_calm_buff) } and Spell(whirlwind_arms) or Spell(overpower) or Talent(fervor_of_battle_talent) and Spell(whirlwind_arms) or not Talent(fervor_of_battle_talent) and Spell(slam)
}

AddFunction ArmsSingleTargetCdActions
{
}

AddFunction ArmsSingleTargetCdPostConditions
{
 target.DebuffRemaining(rend_debuff) <= BaseDuration(rend_debuff) * 0.3 and target.DebuffExpires(colossus_smash_debuff) and Spell(rend) or Rage() < 60 and BuffExpires(deadly_calm_buff) and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(skullsplitter) or not BuffPresent(deadly_calm_buff) and { SpellCooldown(colossus_smash) < 2 or Talent(warbreaker_talent) and SpellCooldown(warbreaker) < 2 } and Spell(ravager) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(colossus_smash) or { not AzeriteEssenceIsMajor(memory_of_lucid_dreams_essence_id) or BuffPresent(memory_of_lucid_dreams_essence_buff) or SpellCooldown(memory_of_lucid_dreams_essence) > 10 } and Spell(warbreaker) or BuffPresent(sudden_death) and Spell(execute_arms) or SpellCooldown(mortal_strike) > 0 and { not Talent(deadly_calm_talent) or BuffExpires(deadly_calm_buff) } and { target.DebuffPresent(colossus_smash_debuff) and not HasAzeriteTrait(test_of_might_trait) or BuffPresent(test_of_might_buff) } and BuffExpires(memory_of_lucid_dreams_essence_buff) and Spell(bladestorm_arms) or Enemies(tagged=1) > 2 and Spell(cleave) or Rage() < 30 and BuffPresent(memory_of_lucid_dreams_essence_buff) and target.DebuffPresent(colossus_smash_debuff) and Spell(overpower) or Spell(mortal_strike) or Talent(fervor_of_battle_talent) and { BuffPresent(memory_of_lucid_dreams_essence_buff) or BuffPresent(deadly_calm_buff) } and Spell(whirlwind_arms) or Spell(overpower) or Talent(fervor_of_battle_talent) and Spell(whirlwind_arms) or not Talent(fervor_of_battle_talent) and Spell(slam)
}
]]

		OvaleScripts:RegisterScript("WARRIOR", "arms", name, desc, code, "script")
	end
end