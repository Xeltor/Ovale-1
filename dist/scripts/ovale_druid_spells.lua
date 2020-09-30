local __exports = LibStub:NewLibrary("ovale/scripts/ovale_druid_spells", 80300)
if not __exports then return end
__exports.registerDruidSpells = function(OvaleScripts)
    local name = "ovale_druid_spells"
    local desc = "[9.0] Ovale: Druid baseline spells"
    local code = [[Define(adaptive_swarm 325748)
# Command a swarm that heals 325748o1 or deals 325733o1 Shadow damage over 12 seconds to a target, and increases the effectiveness of your periodic effects on them by 325748s2.rnrnUpon expiration, jumps to a target within s2 yards, alternating between friend and foe up to s1 times.
  SpellInfo(adaptive_swarm duration=12 channel=12 max_stacks=5 gcd=0 offgcd=1 tick=2)
  # Restoring w1 health every t1 sec and healing over time from the caster increased by w2.
  SpellAddTargetDebuff(adaptive_swarm adaptive_swarm=1)
Define(bear_form 5487)
# Shapeshift into Bear Form, increasing armor by m4 and Stamina by 1178s2, granting protection from Polymorph effects, and increasing threat generation.rnrnThe act of shapeshifting frees you from movement impairing effects.
# Rank 2: Bear Form gives an additional s1 Stamina.rn
  SpellInfo(bear_form)
  # Armor increased by w4.rnStamina increased by 1178s2.rnImmune to Polymorph effects.
  SpellAddBuff(bear_form bear_form=1)
  # Armor increased by w4.rnStamina increased by 1178s2.rnImmune to Polymorph effects.
  SpellAddTargetDebuff(bear_form bear_form=1)
Define(cat_form 768)
# Shapeshift into Cat Form, increasing auto-attack damage by (25 of Spell Power), movement speed by 113636s1, granting protection from Polymorph effects, and reducing falling damage.rnrnThe act of shapeshifting frees you from movement impairing effects.
  SpellInfo(cat_form)
  # Autoattack damage increased by w4.rnImmune to Polymorph effects.rnMovement speed increased by 113636s1 and falling damage reduced.
  SpellAddBuff(cat_form cat_form=1)
Define(empower_bond_0 326446)
# Empower the bond for 10 seconds:rnrn?c3[|cFFFFFFFFTank|rrnProtect your bonded partner, redirecting s1 of damage they take to you, unless you fall below s3 health.]?c4[|cFFFFFFFFHealer|rrnFocus on your bonded partner, replicating 327148s1 of all healing you deal onto them.][|cFFFFFFFFDamager|rrnEnergize your bonded partner, granting them 327139s1 of your damage as additional Arcane damage, healing, or absorption.]rnrn|cFFFFFFFFDamager Partner|rrnThey energize you, granting you 327139s1 of their damage as additional Arcane damage, healing, or absorption.
  SpellInfo(empower_bond_0 cd=60 gcd=0 offgcd=1)
Define(empower_bond_1 326462)
# Empower the bond for 10 seconds:rnrn?c3[|cFFFFFFFFTank|rrnProtect your bonded partner, redirecting s1 of damage they take to you, unless you fall below s3 health.]?c4[|cFFFFFFFFHealer|rrnFocus on your bonded partner, replicating 327148s1 of all healing you deal onto them.][|cFFFFFFFFDamager|rrnEnergize your bonded partner, granting them 327139s1 of your damage as additional Arcane damage, healing, or absorption.]rnrn|cFFFFFFFFTank Partner|rrnThey protect you, redirecting 327037s1 of damage you take to them, for 10 seconds or until they fall below 327037s3 health.
  SpellInfo(empower_bond_1 cd=60 gcd=0 offgcd=1)
Define(empower_bond_2 326647)
# Empower the bond for 10 seconds:rnrn?c3[|cFFFFFFFFTank|rrnProtect your bonded partner, redirecting s1 of damage they take to you, unless you fall below s3 health.]?c4[|cFFFFFFFFHealer|rrnFocus on your bonded partner, replicating 327148s1 of all healing you deal onto them.][|cFFFFFFFFDamager|rrnEnergize your bonded partner, granting them 327139s1 of your damage as additional Arcane damage, healing, or absorption.]rnrn|cFFFFFFFFHealer Partner|rrnThey focus on you, replicating 327148s2 of all healing they deal onto you.
  SpellInfo(empower_bond_2 cd=60 gcd=0 offgcd=1)
Define(galactic_guardian 203964)
# Your damage has a h chance to trigger a free automatic Moonfire on that target. rnrnWhen this occurs, the next Moonfire you cast generates 213708m1/10 Rage, and deals 213708s3 increased direct damage.
  SpellInfo(galactic_guardian channel=0 gcd=0 offgcd=1 talent=galactic_guardian_talent)
  SpellAddBuff(galactic_guardian galactic_guardian=1)
Define(incapacitating_roar 99)
# Shift into Bear Form and invoke the spirit of Ursol to let loose a deafening roar, incapacitating all enemies within A1 yards for 3 seconds. Damage will cancel the effect.
  SpellInfo(incapacitating_roar cd=30 duration=3)
  # Incapacitated.
  SpellAddTargetDebuff(incapacitating_roar incapacitating_roar=1)
Define(incarnation 117679)
# Activates a superior shapeshifting form appropriate to your specialization for 30 seconds.  You may freely shapeshift in and out of this form for its duration.
  SpellInfo(incarnation duration=30 gcd=0 offgcd=1)
  # Incarnation: Tree of Life activated.
  SpellAddBuff(incarnation incarnation=1)
Define(incarnation_guardian_of_ursoc 102558)
# An improved Bear Form that grants the benefits of Berserk, causes Mangle to hit up to (25 of Spell Power) targets, and increases maximum health by s5.rnrnLasts 30 seconds. You may freely shapeshift in and out of this improved Bear Form for its duration.
  SpellInfo(incarnation_guardian_of_ursoc cd=180 duration=30 gcd=0 offgcd=1 talent=incarnation_guardian_of_ursoc_talent)
  # Cooldowns of Mangle, Thrash, Growl, and Frenzied Regeneration are reduced by w1.rnIronfur cost reduced by w3.rnMangle hits up to w6 targets.rnHealth increased by w5.
  SpellAddBuff(incarnation_guardian_of_ursoc incarnation_guardian_of_ursoc=1)
Define(maim 22570)
# Finishing move that causes Physical damage and stuns the target. Damage and duration increased per combo point:rnrn   1 point  : s2*1 damage, 1 secrn   2 points: s2*2 damage, 2 secrn   3 points: s2*3 damage, 3 secrn   4 points: s2*4 damage, 4 secrn   5 points: s2*5 damage, 5 sec
  SpellInfo(maim energy=30 combopoints=1 cd=20 gcd=1)
  # Stunned.
  SpellAddBuff(maim maim=1)
Define(mangle 33917)
# Mangle the target for s2 Physical damage.?a231064[ Deals s3 additional damage against bleeding targets.][]rnrn|cFFFFFFFFGenerates m4/10 Rage.|r
# Rank 2: Mangle deals 33917s3 additional damage against bleeding targets.
  SpellInfo(mangle cd=6 rage=-10)
Define(maul 6807)
# Maul the target for s2 Physical damage.
  SpellInfo(maul rage=40)
Define(mighty_bash 5211)
# Invokes the spirit of Ursoc to stun the target for 4 seconds. Usable in all shapeshift forms.
  SpellInfo(mighty_bash cd=60 duration=4 talent=mighty_bash_talent)
  # Stunned.
  SpellAddTargetDebuff(mighty_bash mighty_bash=1)
Define(moonfire 8921)
# A quick beam of lunar light burns the enemy for (20 of Spell Power) Arcane damage and then an additional 164812o2 Arcane damage over 12 seconds.?s197911[rnrn|cFFFFFFFFGenerates m3/10 Astral Power.|r][]
# Rank 3: Moonfire and Sunfire duration increased by s1/1000 sec.
  SpellInfo(moonfire rage=0 lunarpower=0)
Define(moonkin_form 24858)
# Shapeshift into ?s114301[Astral Form][Moonkin Form], increasing the damage of your spells by s9 and your armor by m3, and granting protection from Polymorph effects.?a231042[rnrnWhile in this form, single-target attacks against you have a h chance to make your next Starfire instant.][]rnrnThe act of shapeshifting frees you from movement impairing effects.
# Rank 2: While in Moonkin Form, single-target attacks against you have a s1 chance make your next Starfire instant.rn
  SpellInfo(moonkin_form)
  # Spell damage increased by s9.rnImmune to Polymorph effects.?w3>0[rnArmor increased by w3.][]
  SpellAddBuff(moonkin_form moonkin_form=1)
Define(pulverize 80313)
# A devastating blow that consumes s3 stacks of your Thrash on the target to deal s1 Physical damage and reduce the damage they deal to you by s2 for 10 seconds.
  SpellInfo(pulverize cd=30 duration=10 talent=pulverize_talent)
  # Dealing w2 reduced damage to @auracaster.
  SpellAddTargetDebuff(pulverize pulverize=1)
Define(ravenous_frenzy_0 323546)
# For 20 seconds, Druid spells you cast increase your damage, healing, and haste by s1, stacking.rnrnIf you spend s9/10.1 sec idle, the Frenzy overcomes you, consuming s3 of your health per stack, stunning you for 1 second, and ending.
  SpellInfo(ravenous_frenzy_0 cd=180 duration=20 max_stacks=99 gcd=0 offgcd=1 tick=0.1)
  # Damage, healing, and haste increased by ?<w6<1>[w1.rnrnIf you spend s9~/10.1 sec idle, the Frenzy consumes w3 of your health and ends.][w6.]
  SpellAddBuff(ravenous_frenzy_0 ravenous_frenzy_0=1)
  # Damage, healing, and haste increased by ?<w6<1>[w1.rnrnIf you spend s9~/10.1 sec idle, the Frenzy consumes w3 of your health and ends.][w6.]
  SpellAddTargetDebuff(ravenous_frenzy_0 ravenous_frenzy_0=1)
Define(ravenous_frenzy_1 323557)
# For 20 seconds, Druid spells you cast increase your damage, healing, and haste by s1, stacking.rnrnIf you spend s9/10.1 sec idle, the Frenzy overcomes you, consuming s3 of your health per stack, stunning you for 1 second, and ending.
  SpellInfo(ravenous_frenzy_1 duration=1 gcd=0 offgcd=1)
  # Stunned.
  SpellAddBuff(ravenous_frenzy_1 ravenous_frenzy_1=1)
Define(shred_0 231057)
# While stealthed, Shred deals 5221s3 increased damage, and has double the chance to critically strike.
  SpellInfo(shred_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(shred_0 shred_0=1)
Define(shred_1 231063)
# Shred deals 5221s4 increased damage against bleeding targets.
  SpellInfo(shred_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(shred_1 shred_1=1)
Define(shred_2 343232)
# While stealthed, Shred generates s1 additional combo lpoint:points;.
  SpellInfo(shred_2 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(shred_2 shred_2=1)
Define(skull_bash 106839)
# You charge and bash the target's skull, interrupting spellcasting and preventing any spell in that school from being cast for 4 seconds.
  SpellInfo(skull_bash cd=15 gcd=0 offgcd=1)
Define(solar_beam 78675)
# Summons a beam of solar light over an enemy target's location, interrupting the target and silencing all enemies within the beam.  Lasts 8 seconds.
  SpellInfo(solar_beam cd=60 duration=8 gcd=0 offgcd=1)
  # Silenced.
  SpellAddBuff(solar_beam solar_beam=1)

Define(tooth_and_claw_buff 135286)
# Autoattacks have a s1 chance to empower your next Maul, stacking up to 135286u times.rnrnEmpowered Maul deals 135286s1 increased damage and reduces the target's damage to you by 135601s2 for 6 seconds.
  SpellInfo(tooth_and_claw_buff duration=15 channel=15 max_stacks=2 gcd=0 offgcd=1)
  # Your next Maul deals s1 more damage and reduces the target's damage to you by 135601s1~ for 135601d.
  SpellAddBuff(tooth_and_claw_buff tooth_and_claw_buff=1)
Define(typhoon 132469)
# Blasts targets within 61391a1 yards in front of you with a violent Typhoon, knocking them back and dazing them for 6 seconds. Usable in all shapeshift forms.
  SpellInfo(typhoon cd=30)

Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(wild_charge_0 16979)
# Charge to an enemy, immobilizing them for 4 seconds.
  SpellInfo(wild_charge_0 cd=15 gcd=0 offgcd=1)
  # Immobilized.
  SpellAddBuff(wild_charge_0 wild_charge_0=1)

Define(wild_charge_1 49376)
# Leap behind an enemy, dazing them for 3 seconds.
  SpellInfo(wild_charge_1 cd=15 channel=0 gcd=0 offgcd=1)
  # Dazed.
  SpellAddBuff(wild_charge_1 wild_charge_1=1)

Define(wild_charge_2 102383)
# Bound backward away from your enemies.
  SpellInfo(wild_charge_2 cd=15 gcd=0 offgcd=1)
Define(wild_charge_3 102417)
# Leap forward s2 yards.
  SpellInfo(wild_charge_3 cd=15 channel=0 gcd=0 offgcd=1)
Define(wrath 190984)
# Hurl a ball of energy at the target, dealing (60 of Spell Power) Nature damage.?a197911[rnrn|cFFFFFFFFGenerates m2/10 Astral Power.|r][]
  SpellInfo(wrath lunarpower=0)
SpellList(shred shred_0 shred_1 shred_2)
SpellList(wild_charge wild_charge_0 wild_charge_1 wild_charge_2 wild_charge_3)
SpellList(empower_bond empower_bond_0 empower_bond_1 empower_bond_2)
SpellList(ravenous_frenzy ravenous_frenzy_0 ravenous_frenzy_1)
Define(galactic_guardian_talent 14) #21707
# Your damage has a h chance to trigger a free automatic Moonfire on that target. rnrnWhen this occurs, the next Moonfire you cast generates 213708m1/10 Rage, and deals 213708s3 increased direct damage.
Define(incarnation_guardian_of_ursoc_talent 15) #22388
# An improved Bear Form that grants the benefits of Berserk, causes Mangle to hit up to (25 of Spell Power) targets, and increases maximum health by s5.rnrnLasts 30 seconds. You may freely shapeshift in and out of this improved Bear Form for its duration.
Define(mighty_bash_talent 10) #21778
# Invokes the spirit of Ursoc to stun the target for 4 seconds. Usable in all shapeshift forms.
Define(pulverize_talent 21) #22425
# A devastating blow that consumes s3 stacks of your Thrash on the target to deal s1 Physical damage and reduce the damage they deal to you by s2 for 10 seconds.
Define(soul_of_the_forest_talent_guardian 13) #21709
# Mangle generates m1/10 more Rage and deals s2 more damage.
    ]]
    OvaleScripts:RegisterScript("DRUID", nil, name, desc, code, "include")
end
