local __exports = LibStub:NewLibrary("ovale/scripts/ovale_priest_spells", 80300)
if not __exports then return end
__exports.registerPriestSpells = function(OvaleScripts)
    local name = "ovale_priest_spells"
    local desc = "[9.0] Ovale: Priest spells"
    local code = [[Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you a random secondary stat for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
  SpellAddBuff(ancestral_call ancestral_call=1)
Define(arcane_torrent_0 25046)
# Remove s1 beneficial effect from all enemies within A1 yards and restore m2 Energy.
  SpellInfo(arcane_torrent_0 cd=120 gcd=1 energy=-15)
Define(arcane_torrent_1 28730)
# Remove s1 beneficial effect from all enemies within A1 yards and restore s2 of your Mana.
  SpellInfo(arcane_torrent_1 cd=120)
Define(arcane_torrent_2 50613)
# Remove s1 beneficial effect from all enemies within A1 yards and restore m2/10 Runic Power.
  SpellInfo(arcane_torrent_2 cd=120 runicpower=-20)
Define(arcane_torrent_3 69179)
# Remove s1 beneficial effect from all enemies within A1 yards and increase your Rage by m2/10.rn
  SpellInfo(arcane_torrent_3 cd=120 rage=-15)
Define(arcane_torrent_4 80483)
# Remove s1 beneficial effect from all enemies within A1 yards and restore s2 of your Focus.
  SpellInfo(arcane_torrent_4 cd=120 focus=-15)
Define(arcane_torrent_5 129597)
# Remove s1 beneficial effect from all enemies within A1 yards and restore ?s137025[s2 Chi][]?s137024[s3 of your mana][]?s137023[s4 Energy][].
  SpellInfo(arcane_torrent_5 cd=120 gcd=1 chi=-1 energy=-15)
Define(arcane_torrent_6 155145)
# Remove s1 beneficial effect from all enemies within A1 yards and restore ?s137027[s2 Holy Power][s3 of your mana].
  SpellInfo(arcane_torrent_6 cd=120 holypower=-1)
Define(arcane_torrent_7 202719)
# Remove s1 beneficial effect from all enemies within A1 yards and generate ?s203513[m3/10 Pain][m2 Fury].
  SpellInfo(arcane_torrent_7 cd=120 fury=-15 pain=-15)
Define(arcane_torrent_8 232633)
# Remove s1 beneficial effect from all enemies within A1 yards and restore ?s137033[s3/100 Insanity][s2 of your mana].
  SpellInfo(arcane_torrent_8 cd=120 insanity=-1500)
Define(ascended_blast 325283)
# Blasts the enemy with pure Anima, causing (179 of Spell Power) Arcane damage and healing a nearby ally for s2 of the damage done.rnrnGrants s3 lstack:stacks; of Boon of the Ascended.
  SpellInfo(ascended_blast cd=3 gcd=1)
Define(ascended_nova 325020)
# Release a powerful burst of anima, dealing up to (74 of Spell Power) Arcane damage, based on the number of enemies, and (24 of Spell Power) healing to up to 325041s2 allies within A1 yds.rnrnGrants s3 lstack:stacks; of Boon of the Ascended for each target damaged.
  SpellInfo(ascended_nova gcd=1)

Define(bag_of_tricks 312411)
# Pull your chosen trick from the bag and use it on target enemy or ally. Enemies take <damage> damage, while allies are healed for <healing>. 
  SpellInfo(bag_of_tricks cd=90)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
Define(blood_fury_0 20572)
# Increases your attack power by s1 for 15 seconds.
  SpellInfo(blood_fury_0 cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power increased by w1.
  SpellAddBuff(blood_fury_0 blood_fury_0=1)
Define(blood_fury_1 24571)
# Instantly increases your rage by 300/10.
  SpellInfo(blood_fury_1 gcd=0 offgcd=1 rage=-30)
Define(blood_fury_2 33697)
# Increases your attack power and Intellect by s1 for 15 seconds.
  SpellInfo(blood_fury_2 cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power and Intellect increased by w1.
  SpellAddBuff(blood_fury_2 blood_fury_2=1)
Define(blood_fury_3 33702)
# Increases your Intellect by s1 for 15 seconds.
  SpellInfo(blood_fury_3 cd=120 duration=15 gcd=0 offgcd=1)
  # Intellect increased by w1.
  SpellAddBuff(blood_fury_3 blood_fury_3=1)
Define(bloodlust 2825)
# Increases haste by (25 of Spell Power) for all party and raid members for 40 seconds.rnrnAllies receiving this effect will become Sated and unable to benefit from Bloodlust or Time Warp again for 600 seconds.
  SpellInfo(bloodlust cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(bloodlust bloodlust=1)
Define(devouring_plague 335467)
# Afflicts the target with a disease that instantly causes (85 of Spell Power) Shadow damage plus an additional o2 Shadow damage over 6 seconds. Heals you for e2*100 of damage dealt.rnrnIf this effect is reapplied, any remaining damage will be added to the new Devouring Plague.
  SpellInfo(devouring_plague insanity=5000 duration=6 tick=3)
  # Suffering s2 damage every t2 sec.
  SpellAddTargetDebuff(devouring_plague devouring_plague=1)
Define(divine_star_0 110744)
# Throw a Divine Star forward 24 yds, healing allies in its path for (70 of Spell Power) and dealing (40 of Spell Power) Holy damage to enemies. After reaching its destination, the Divine Star returns to you, healing allies and damaging enemies in its path again.
  SpellInfo(divine_star_0 cd=15 duration=15 talent=divine_star_talent)
Define(divine_star_1 110745)
# Throw a Divine Star forward 24 yds, healing allies in its path for (70 of Spell Power) and dealing (40 of Spell Power) Holy damage to enemies. After reaching its destination, the Divine Star returns to you, healing allies and damaging enemies in its path again.
  SpellInfo(divine_star_1 channel=0 gcd=0 offgcd=1)
Define(divine_star_2 122128)
# Throw a Divine Star forward 24 yds, healing allies in its path for (70 of Spell Power) and dealing (40 of Spell Power) Holy damage to enemies. After reaching its destination, the Divine Star returns to you, healing allies and damaging enemies in its path again.
  SpellInfo(divine_star_2 channel=0 gcd=0 offgcd=1)
Define(fireblood_0 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood_0 cd=120 gcd=0 offgcd=1)
Define(fireblood_1 265226)
# Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by s1.
  SpellInfo(fireblood_1 duration=8 max_stacks=6 gcd=0 offgcd=1)
  # Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by w1.
  SpellAddBuff(fireblood_1 fireblood_1=1)
Define(lights_judgment 255647)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards after 3 sec.
  SpellInfo(lights_judgment cd=150)

Define(mind_blast_0 231682)
# Mind Blast prevents the next <shield> damage dealt by the enemy.
  SpellInfo(mind_blast_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(mind_blast_0 mind_blast_0=1)
Define(mind_blast_1 319899)
# Mind Blast's cooldown reduced by 7.5 sec.
  SpellInfo(mind_blast_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(mind_blast_1 mind_blast_1=1)
Define(mind_bomb 205369)
# Inflicts the target with a Mind Bomb.rnrnAfter 2 seconds or if the target dies, it unleashes a psychic explosion, disorienting all enemies within 226943A1 yds of the target for 6 seconds.
  SpellInfo(mind_bomb cd=30 duration=2 talent=mind_bomb_talent)
  # About to unleash a psychic explosion, disorienting all nearby enemies.
  SpellAddTargetDebuff(mind_bomb mind_bomb=1)
Define(mindbender 200174)
# Summons a Mindbender to attack the target for 15 seconds.rnrn|cFFFFFFFFGenerates 200010s1/100 Insanity each time the Mindbender attacks.|r
  SpellInfo(mindbender cd=60 duration=15 talent=mindbender_talent)

Define(penance 47540)
# Launches a volley of holy light at the target, causing ?s193134[(40 of Spell Power)*4][(40 of Spell Power)*3] Holy damage to an enemy or ?s193134[(125 of Spell Power)*4][(125 of Spell Power)*3] healing to an ally over 2 seconds. Castable while moving.
  SpellInfo(penance cd=9 channel=0)
Define(power_infusion 10060)
# Infuses the target with power for 20 seconds, increasing haste by (25 of Spell Power).
  SpellInfo(power_infusion cd=120 duration=20 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(power_infusion power_infusion=1)
Define(power_word_solace 129250)
# Strikes an enemy with heavenly power, dealing (80 of Spell Power) Holy damage and restoring <mana> of your maximum mana.
  SpellInfo(power_word_solace cd=15 talent=power_word_solace_talent)
Define(purge_the_wicked 204197)
# Cleanses the target with fire, causing (24.8 of Spell Power) Fire damage and an additional 204213o1 Fire damage over 20 seconds. Spreads to an additional nearby enemy when you cast Penance on the target.
  SpellInfo(purge_the_wicked talent=purge_the_wicked_talent)
  # w1 Fire damage every t1 seconds.
  SpellAddTargetDebuff(purge_the_wicked purge_the_wicked_debuff=1)
Define(purge_the_wicked_debuff 204213)
# Cleanses the target with fire, causing (24.8 of Spell Power) Fire damage and an additional 204213o1 Fire damage over 20 seconds. Spreads to an additional nearby enemy when you cast Penance on the target.
  SpellInfo(purge_the_wicked_debuff duration=20 gcd=0 offgcd=1 tick=2)
  # w1 Fire damage every t1 seconds.
  SpellAddTargetDebuff(purge_the_wicked_debuff purge_the_wicked_debuff=1)
Define(quaking_palm 107079)
# Strikes the target with lightning speed, incapacitating them for 4 seconds, and turns off your attack.
  SpellInfo(quaking_palm cd=120 duration=4 gcd=1)
  # Incapacitated.
  SpellAddTargetDebuff(quaking_palm quaking_palm=1)
Define(schism 214621)
# Attack the enemy's soul with a surge of Shadow energy, dealing (129 of Spell Power) Shadow damage and increasing your spell damage to the target by s2 for 9 seconds.
  SpellInfo(schism cd=24 duration=9 talent=schism_talent)
  # Taking s2 increased damage from the Priest.
  SpellAddTargetDebuff(schism schism=1)
Define(shadow_covenant 314867)
# Make a shadowy pact, healing the target and s3-1 other injured allies within A2 yds for (150 of Spell Power). For 9 seconds, your Shadow spells deal 322105m2 increased damage and healing, but you cannot cast Holy spells.
  SpellInfo(shadow_covenant cd=30 talent=shadow_covenant_talent)

Define(shadow_word_death 32379)
# A word of dark binding that inflicts (85 of Spell Power) Shadow damage to the target. If the target is not killed by Shadow Word: Death, the caster takes damage equal to the damage inflicted upon the target.rnrnDamage increased by s3 to targets below s2 health.?c3[][]?s81749[rnrnDoes not trigger Atonement.][]
# Rank 2: Shadow Word: Death's cooldown is reduced by m1/-1000 sec.
  SpellInfo(shadow_word_death cd=30)
Define(shadow_word_pain 589)
# A word of darkness that causes (12.920000000000002 of Spell Power) Shadow damage instantly, and an additional o2 Shadow damage over 12 seconds.?a185916[rnrn|cFFFFFFFFGenerates m3/100 Insanity.|r][]
# Rank 2: Increases the duration of Shadow Word: Pain by m1/1000 sec.
  SpellInfo(shadow_word_pain duration=12 insanity=-400 tick=2)
  # Suffering w2 Shadow damage every t2 sec.
  SpellAddTargetDebuff(shadow_word_pain shadow_word_pain=1)
Define(shadowfiend 34433)
# Summons a shadowy fiend to attack the target for 10 seconds.?s319904[rnrn|cFFFFFFFFGenerates 262485s1/100 Insanity each time the Shadowfiend attacks.|r][]?s343726[rnrn|cFFFFFFFFGenerates 343726s1 Mana each time the Shadowfiend attacks.|r][]
# Rank 2: Your Shadowfiend now restores m1 mana to you whenever it attacks.
  SpellInfo(shadowfiend cd=180 duration=10)
  # 343726
  SpellAddBuff(shadowfiend shadowfiend=1)
Define(shadowform 232698)
# Assume a Shadowform, increasing your spell damage dealt by s1.
  SpellInfo(shadowform)
  # Spell damage dealt increased by s1.
  SpellAddBuff(shadowform shadowform=1)
Define(silence 15487)
# Silences the target, preventing them from casting spells for 4 seconds. Against non-players, also interrupts spellcasting and prevents any spell in that school from being cast for 4 seconds.
# Rank 1: Silences an enemy preventing it from casting spells for 6 seconds.
  SpellInfo(silence cd=45 duration=4 gcd=0 offgcd=1)
  # Silenced.
  SpellAddTargetDebuff(silence silence=1)
Define(smite 585)
# Smites an enemy for (47 of Spell Power) Holy damage?s231687[ and has a 231687s1 chance to reset the cooldown of Holy Fire][].
# Rank 2: Smite deals s1 increased damage.
  SpellInfo(smite)
Define(vampiric_touch 34914)
# A touch of darkness that causes 34914o2 Shadow damage over 21 seconds, and heals you for e2*100 of damage dealt.rn?s322116[rnIf Vampiric Touch is dispelled, the dispeller flees in Horror for 3 seconds.rn][]rn|cFFFFFFFFGenerates m3/100 Insanity.|r
# Rank 2: If your Vampiric Touch is dispelled, the dispeller flees in Horror for 3 seconds.
  SpellInfo(vampiric_touch duration=21 insanity=-500 tick=3)
  # Suffering w2 Shadow damage every t2 sec.
  SpellAddTargetDebuff(vampiric_touch vampiric_touch=1)
Define(void_eruption 228260)
# Releases an explosive blast of pure void energy, activating Voidform and causing (64.60000000000001 of Spell Power)*2 Shadow damage to all enemies within a1 yds of your target.rnrnDuring Voidform, this ability is replaced by Void Bolt.
# Rank 2: Void Eruption cast time reduced by m1.
  SpellInfo(void_eruption cd=90)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
SpellList(arcane_torrent arcane_torrent_0 arcane_torrent_1 arcane_torrent_2 arcane_torrent_3 arcane_torrent_4 arcane_torrent_5 arcane_torrent_6 arcane_torrent_7 arcane_torrent_8)
SpellList(blood_fury blood_fury_0 blood_fury_1 blood_fury_2 blood_fury_3)
SpellList(divine_star divine_star_0 divine_star_1 divine_star_2)
SpellList(fireblood fireblood_0 fireblood_1)
SpellList(mind_blast mind_blast_0 mind_blast_1)
Define(divine_star_talent 17) #19760
# Throw a Divine Star forward 24 yds, healing allies in its path for (70 of Spell Power) and dealing (40 of Spell Power) Holy damage to enemies. After reaching its destination, the Divine Star returns to you, healing allies and damaging enemies in its path again.
Define(mind_bomb_talent 11) #23375
# Inflicts the target with a Mind Bomb.rnrnAfter 2 seconds or if the target dies, it unleashes a psychic explosion, disorienting all enemies within 226943A1 yds of the target for 6 seconds.
Define(mindbender_talent 17) #21719
# Summons a Mindbender to attack the target for 15 seconds.rnrn|cFFFFFFFFGenerates 200010s1/100 Insanity each time the Mindbender attacks.|r
Define(power_word_solace_talent 9) #19755
# Strikes an enemy with heavenly power, dealing (80 of Spell Power) Holy damage and restoring <mana> of your maximum mana.
Define(purge_the_wicked_talent 16) #22161
# Cleanses the target with fire, causing (24.8 of Spell Power) Fire damage and an additional 204213o1 Fire damage over 20 seconds. Spreads to an additional nearby enemy when you cast Penance on the target.
Define(schism_talent 3) #22329
# Attack the enemy's soul with a surge of Shadow energy, dealing (129 of Spell Power) Shadow damage and increasing your spell damage to the target by s2 for 9 seconds.
Define(shadow_covenant_talent 15) #19766
# Make a shadowy pact, healing the target and s3-1 other injured allies within A2 yds for (150 of Spell Power). For 9 seconds, your Shadow spells deal 322105m2 increased damage and healing, but you cannot cast Holy spells.
Define(unbridled_fury_item 169299)
    ]]
    OvaleScripts:RegisterScript("PRIEST", nil, name, desc, code, "include")
end
