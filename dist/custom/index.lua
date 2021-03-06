local __exports = LibStub:NewLibrary("ovale/custom/index", 80201)
if not __exports then return end
local __ovale_deathknight = LibStub:GetLibrary("ovale/scripts/ovale_deathknight")
local __ovale_demonhunter = LibStub:GetLibrary("ovale/scripts/ovale_demonhunter")
local __ovale_druid = LibStub:GetLibrary("ovale/scripts/ovale_druid")
local __ovale_hunter = LibStub:GetLibrary("ovale/scripts/ovale_hunter")
local __ovale_mage = LibStub:GetLibrary("ovale/scripts/ovale_mage")
local __ovale_monk = LibStub:GetLibrary("ovale/scripts/ovale_monk")
local __ovale_paladin = LibStub:GetLibrary("ovale/scripts/ovale_paladin")
local __ovale_priest = LibStub:GetLibrary("ovale/scripts/ovale_priest")
local __ovale_rogue = LibStub:GetLibrary("ovale/scripts/ovale_rogue")
local __ovale_shaman = LibStub:GetLibrary("ovale/scripts/ovale_shaman")
local __ovale_warlock = LibStub:GetLibrary("ovale/scripts/ovale_warlock")
local __ovale_warrior = LibStub:GetLibrary("ovale/scripts/ovale_warrior")
local registerDeathKnightBloodXeltor = __ovale_deathknight.registerDeathKnightBloodXeltor
local registerDeathKnightFrostXeltor = __ovale_deathknight.registerDeathKnightFrostXeltor
local registerDeathKnightUnholyXeltor = __ovale_deathknight.registerDeathKnightUnholyXeltor
local registerDemonHunterHavocXeltor = __ovale_demonhunter.registerDemonHunterHavocXeltor
local registerDemonHunterVengeanceXeltor = __ovale_demonhunter.registerDemonHunterVengeanceXeltor
local registerDruidCommonXeltor = __ovale_druid.registerDruidCommonXeltor
local registerDruidBalanceXeltor = __ovale_druid.registerDruidBalanceXeltor
local registerDruidFeralXeltor = __ovale_druid.registerDruidFeralXeltor
local registerDruidGuardianXeltor = __ovale_druid.registerDruidGuardianXeltor
local registerDruidRestorationXeltor = __ovale_druid.registerDruidRestorationXeltor
local registerHunterBeastMasteryXeltor = __ovale_hunter.registerHunterBeastMasteryXeltor
local registerHunterMarksmanshipXeltor = __ovale_hunter.registerHunterMarksmanshipXeltor
local registerHunterSurvivalXeltor = __ovale_hunter.registerHunterSurvivalXeltor
local registerMageFireXeltor = __ovale_mage.registerMageFireXeltor
local registerMageFrostXeltor = __ovale_mage.registerMageFrostXeltor
local registerMageArcaneXeltor = __ovale_mage.registerMageArcaneXeltor
local registerMonkBrewmasterXeltor = __ovale_monk.registerMonkBrewmasterXeltor
local registerMonkMistweaverXeltor = __ovale_monk.registerMonkMistweaverXeltor
local registerMonkWindwalkerXeltor = __ovale_monk.registerMonkWindwalkerXeltor
local registerPaladinProtectionXeltor = __ovale_paladin.registerPaladinProtectionXeltor
local registerPaladinRetributionXeltor = __ovale_paladin.registerPaladinRetributionXeltor
local registerPriestDisciplineXeltor = __ovale_priest.registerPriestDisciplineXeltor
local registerPriestShadowXeltor = __ovale_priest.registerPriestShadowXeltor
local registerRogueAssassinationXeltor = __ovale_rogue.registerRogueAssassinationXeltor
local registerRogueOutlawXeltor = __ovale_rogue.registerRogueOutlawXeltor
local registerRogueSubtletyXeltor = __ovale_rogue.registerRogueSubtletyXeltor
local registerShamanElementalXeltor = __ovale_shaman.registerShamanElementalXeltor
local registerShamanEnhancementXeltor = __ovale_shaman.registerShamanEnhancementXeltor
local registerShamanRestorationXeltor = __ovale_shaman.registerShamanRestorationXeltor
local registerWarlockAfflictionXeltor = __ovale_warlock.registerWarlockAfflictionXeltor
local registerWarlockDemonologyXeltor = __ovale_warlock.registerWarlockDemonologyXeltor
local registerWarlockDestructionXeltor = __ovale_warlock.registerWarlockDestructionXeltor
local registerWarriorArmsXeltor = __ovale_warrior.registerWarriorArmsXeltor
local registerWarriorFuryXeltor = __ovale_warrior.registerWarriorFuryXeltor
local registerWarriorProtectionXeltor = __ovale_warrior.registerWarriorProtectionXeltor
__exports.registerScripts = function(ovaleScripts)
	registerDeathKnightBloodXeltor(ovaleScripts)
	registerDeathKnightFrostXeltor(ovaleScripts)
	registerDeathKnightUnholyXeltor(ovaleScripts)
	registerDemonHunterHavocXeltor(ovaleScripts)
	registerDemonHunterVengeanceXeltor(ovaleScripts)
	registerDruidCommonXeltor(ovaleScripts)
	registerDruidBalanceXeltor(ovaleScripts)
	registerDruidFeralXeltor(ovaleScripts)
	registerDruidGuardianXeltor(ovaleScripts)
	registerDruidRestorationXeltor(ovaleScripts)
	registerHunterBeastMasteryXeltor(ovaleScripts)
	registerHunterMarksmanshipXeltor(ovaleScripts)
	registerHunterSurvivalXeltor(ovaleScripts)
	registerMageFireXeltor(ovaleScripts)
	registerMageFrostXeltor(ovaleScripts)
	registerMageArcaneXeltor(ovaleScripts)
	registerMonkBrewmasterXeltor(ovaleScripts)
	registerMonkMistweaverXeltor(ovaleScripts)
	registerMonkWindwalkerXeltor(ovaleScripts)
	registerPaladinProtectionXeltor(ovaleScripts)
	registerPaladinRetributionXeltor(ovaleScripts)
	registerPriestDisciplineXeltor(ovaleScripts)
	registerPriestShadowXeltor(ovaleScripts)
	registerRogueAssassinationXeltor(ovaleScripts)
	registerRogueOutlawXeltor(ovaleScripts)
	registerRogueSubtletyXeltor(ovaleScripts)
	registerShamanElementalXeltor(ovaleScripts)
	registerShamanEnhancementXeltor(ovaleScripts)
	registerShamanRestorationXeltor(ovaleScripts)
	registerWarlockAfflictionXeltor(ovaleScripts)
	registerWarlockDemonologyXeltor(ovaleScripts)
	registerWarlockDestructionXeltor(ovaleScripts)
	registerWarriorArmsXeltor(ovaleScripts)
	registerWarriorFuryXeltor(ovaleScripts)
	registerWarriorProtectionXeltor(ovaleScripts)
end
