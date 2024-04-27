local oldPick = dwarf_pick_carddef()

function dwarf_pick_carddef()
	local choiceTable = {}
	choiceTable[1] = {
		effect = gainCombatEffect(2),                  
		layout = layoutCard({
			title = "Pick",
			art = "art/ancestry/pick",
			text = "<size=200%><sprite name=\"combat_2\">"
		})
	}
	choiceTable[2] = {
		effect = acquireForFreeTarget().apply(selectLoc(fireGemsLoc).take(1)),
		layout = layoutCard({
			title = "Pick",
			art = "art/ancestry/pick",
			text = "Acquire a Fuel Stockpile for free."
		})
	}
	
	return createItemDef({
		id = "dwarf_pick",
		name = "Pick",
		types = { itemType, dwarfType, meleeWeaponType, weaponType },
		acquireCost = 0,
		layout = loadLayoutData("layouts/ancestry/dwarf_pick"),
		abilities = {
			createAbility({
				id = "dwarf_pick_ind_1",
				trigger = autoTrigger,
				effect = pushChoiceEffect({
					choices = choiceTable
				}),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		},
		factions = {}
	})
end