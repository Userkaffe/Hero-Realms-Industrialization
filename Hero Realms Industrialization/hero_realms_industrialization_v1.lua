require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

--NOTICE:
--	I currently don't know a way to import library files so that Hero Realms app would accept them.
--	At the moment the only way to use these functions is to copy-and-paste them into your lua-file.

-- To access layouts of existing cards: darian__war_mage_carddef().generate().layout

--for quick card creation
function quickCreateAction(input)
	-- Required fields: name, cost, faction, text, abilities
	-- Optional fields: art, types
	
	-- faction: 0 = none, 1 = imperial, 2 = guild, 3 = wild, 4 = necros
	-- text uses xmlText
	
	--check that input data is valid
	if type(input) ~= "table" then
        error("quickCreateAction: Argument must be a table")
    end
	if input.name == nil then
        error("quickCreateAction: Missing input data: name")
    end
	if input.cost == nil then
        error("quickCreateAction: Missing input data: cost")
    end
	if input.faction == nil then
        error("quickCreateAction: Missing input data: faction")
    end
	if input.text == nil then
        error("quickCreateAction: Missing input data: text")
    end
	if input.abilities == nil then
        error("quickCreateAction: Missing input data: abilities")
    end
	local art = ""
	if input.art == nil then art = "art/T_Set_Sail"
	else art = input.art
	end
	local types = {}
	if input.types == nil then types = {}
	else types = input.types
	end
	
	
	local function makeId(str)
		--remove everything except card code
		local pos = string.find(str, " ")
		if pos then
			str = string.sub(str, 1, pos - 1)
		end
		
		-- Convert the string to lowercase
		str = string.lower(str)
		
		-- Replace all spaces
		str = string.gsub(str, " ", "_")
		
		-- Return the modified string
		return str
	end
	
	local function makeName(str)
		-- Find the first space character
		local _, index = string.find(str, "%s")
		
		-- If no space is found, return an empty string
		if index == nil then
			return ""
		end
		
		-- Extract and return the substring after the first space
		return string.sub(str, index + 1)
	end
	
	local function getFrame(int)
		if (int == 1) then return "frames/Imperial_Action_CardFrame"
		elseif (int == 2) then return "frames/Guild_Action_CardFrame"
		elseif (int == 3) then return "frames/Wild_Action_CardFrame"
		elseif (int == 4) then return "frames/Necros_Action_CardFrame"
		else return "frames/Coop_Campaign_CardFrame"
		end
	end
	
	local function getFactions(int)
		if (int == 1) then return { imperialFaction }
		elseif (int == 2) then return { guildFaction }
		elseif (int == 3) then return { wildFaction }
		elseif (int == 4) then return { necrosFaction }
		else return {}
		end
	end
	
	local cardLayout = createLayout({
		name = makeName(input.name),
		art = art,
		frame = getFrame(input.faction),
		xmlText = input.text,
		cost = input.cost,
	})
	
	return createActionDef({
		id = makeId(input.name),
		name = makeName(input.name),
		types = types,
		acquireCost = input.cost,
		layout = cardLayout,
		abilities = input.abilities,
		factions = getFactions(input.faction)
	})
end

function quickCreateChampion(input)
	-- Required fields: name, cost, health, isGuard, faction, text, abilities
	-- Optional fields: art, types
	
	-- faction: 0 = none, 1 = imperial, 2 = guild, 3 = wild, 4 = necros
	-- text uses xmlText
	
	--check that input data is valid
	if type(input) ~= "table" then
        error("quickCreateAction: Argument must be a table")
    end
	if input.name == nil then
        error("quickCreateAction: Missing input data: name")
    end
	if input.cost == nil then
        error("quickCreateAction: Missing input data: cost")
    end
	if input.health == nil then
        error("quickCreateAction: Missing input data: health")
    end
	if input.isGuard == nil then
        error("quickCreateAction: Missing input data: isGuard")
    end
	if input.faction == nil then
        error("quickCreateAction: Missing input data: faction")
    end
	if input.text == nil then
        error("quickCreateAction: Missing input data: text")
    end
	if input.abilities == nil then
        error("quickCreateAction: Missing input data: abilities")
    end
	local art = ""
	if input.art == nil then art = "art/T_Fighter_Male"
	else art = input.art
	end
	local types = {}
	if input.types == nil then types = {}
	else types = input.types
	end
	
	
	local function makeId(str)
		--remove everything except card code
		local pos = string.find(str, " ")
		if pos then
			str = string.sub(str, 1, pos - 1)
		end
		
		-- Convert the string to lowercase
		str = string.lower(str)
		
		-- Replace all spaces
		str = string.gsub(str, " ", "_")
		
		-- Return the modified string
		return str
	end
	
	local function makeName(str)
		-- Find the first space character
		local _, index = string.find(str, "%s")
		
		-- If no space is found, return an empty string
		if index == nil then
			return ""
		end
		
		-- Extract and return the substring after the first space
		return string.sub(str, index + 1)
	end
	
	local function getFrame(int)
		if (int == 1) then return "frames/Imperial_Champion_CardFrame"
		elseif (int == 2) then return "frames/Guild_Champion_CardFrame"
		elseif (int == 3) then return "frames/Wild_Champion_CardFrame"
		elseif (int == 4) then return "frames/Necros_Champion_CardFrame"
		else return "frames/Coop_Campaign_CardFrame"
		end
	end
	
	local function getFactions(int)
		if (int == 1) then return { imperialFaction }
		elseif (int == 2) then return { guildFaction }
		elseif (int == 3) then return { wildFaction }
		elseif (int == 4) then return { necrosFaction }
		else return {}
		end
	end
	
	local cardLayout = createLayout({
		name = makeName(input.name),
		art = art,
		frame = getFrame(input.faction),
		xmlText = input.text,
		health = input.health,
		isGuard = input.isGuard,
		cost = input.cost,
		
	})
	
	return createChampionDef({
		id = makeId(input.name),
		name = makeName(input.name),
		acquireCost = input.cost,
		types = types,
		layout = cardLayout,
		health = input.health,
		isGuard = input.isGuard,
		abilities = input.abilities,
		factions = getFactions(input.faction)
	})
end

function quickCreateItem(input)
	-- Required fields: name, cost, faction, text, abilities
	-- Optional fields: art, types
	
	-- faction: 0 = none, 1 = imperial, 2 = guild, 3 = wild, 4 = necros
	-- text uses xmlText
	
	--check that input data is valid
	if type(input) ~= "table" then
        error("quickCreateAction: Argument must be a table")
    end
	if input.name == nil then
        error("quickCreateAction: Missing input data: name")
    end
	if input.cost == nil then
        error("quickCreateAction: Missing input data: cost")
    end
	if input.faction == nil then
        error("quickCreateAction: Missing input data: faction")
    end
	if input.text == nil then
        error("quickCreateAction: Missing input data: text")
    end
	if input.abilities == nil then
        error("quickCreateAction: Missing input data: abilities")
    end
	local art = ""
	if input.art == nil then art = "art/dark_sign"
	else art = input.art
	end
	local types = {}
	if input.types == nil then types = {}
	else types = input.types
	end
	
	
	local function makeId(str)
		--remove everything except card code
		local pos = string.find(str, " ")
		if pos then
			str = string.sub(str, 1, pos - 1)
		end
		
		-- Convert the string to lowercase
		str = string.lower(str)
		
		-- Replace all spaces
		str = string.gsub(str, " ", "_")
		
		-- Return the modified string
		return str
	end
	
	local function makeName(str)
		-- Find the first space character
		local _, index = string.find(str, "%s")
		
		-- If no space is found, return an empty string
		if index == nil then
			return ""
		end
		
		-- Extract and return the substring after the first space
		return string.sub(str, index + 1)
	end
	
	local function getFrame(int)
		if (int == 1) then return "frames/Imperial_Action_CardFrame"
		elseif (int == 2) then return "frames/Guild_Action_CardFrame"
		elseif (int == 3) then return "frames/Wild_Action_CardFrame"
		elseif (int == 4) then return "frames/Necros_Action_CardFrame"
		else return "frames/Generic_CardFrame"
		end
	end
	
	local function getFactions(int)
		if (int == 1) then return { imperialFaction }
		elseif (int == 2) then return { guildFaction }
		elseif (int == 3) then return { wildFaction }
		elseif (int == 4) then return { necrosFaction }
		else return {}
		end
	end
	
	local cardLayout = createLayout({
		name = makeName(input.name),
		art = art,
		frame = getFrame(input.faction),
		xmlText = input.text,
		cost = input.cost,
		
	})
	
	return createItemDef({
		id = makeId(input.name),
		name = makeName(input.name),
		types = types,
		acquireCost = input.cost,
		layout = cardLayout,
		abilities = input.abilities,
		factions = getFactions(input.faction)
	})
end


function draw_card_buff_def()
	-- For oppDrawCardsEffect
	return createBuffDef({
		id = "draw_card_buff_custom",
		name = "Delayed card draw",
		abilities = {
			createAbility({
				id = "draw_card_buff_ability",
				trigger = startOfTurnTrigger,
				effect = showTextEffect("Resolving draw from previous turn.").seq(drawCardsEffect(1)),
				cost = sacrificeSelfCost,
				activations = singleActivation,
				promptType = noPrompt,
				priority = 100
			})
		},
		buffDetails = createBuffDetails({
            art = "art/T_Expansion",
            name = "Drawing card",
            text = "Drawign a card at start of next turn."
        }),
		layout = createLayout({
			name = "Drawing card",
			art = "art/T_Expansion",
			frame = "frames/Coop_Campaign_CardFrame",
			text = "Drawing a card at start of next turn."
        })
	})
end


--for abilities
function cycleCardsEffect(num)
-- This function returns an effect that lets the player to discard up to 'num' cards, then draw that many cards.
-- There is no prompt here, the game will just ask the player to discard, and the draw will be based on number of cards selected.
	return pushTargetedEffect({
		desc = "Discard up to " .. tostring(num) .. " cards. Then draw that many cards.",
		min = 0,
		max = num,
		validTargets = selectLoc(currentHandLoc),
		targetEffect = discardTarget().seq(drawCardsEffect(selectTargets().count()))
	})
end

function redrawCardsEffect(num)
-- This function returns an effect that lets the player to draw up to 'num' cards, then discard that many cards.
-- Player will be prompted about how many cards they want to draw and discard.
-- If 'num' is 4 or more, only options for drawing 0, 1, 2 and 'num' cards will be available, because the in-game prompt can only handle four entries.
	local choiceTable = {}	
		
	choiceTable[1] = {
		effect = nullEffect(),                  
		layout = layoutCard({
			title = "Do nothing.",
			art = "art/T_Wind_Storm",
			text = "<size=120%>Do nothing."
		})
	}
	
	if (num > 0) then
		choiceTable[2] = {
			effect = drawCardsEffect(1).seq(pushTargetedEffect({
				desc = "Discard a card.",
				min = 1,
				max = 1,
				validTargets = selectLoc(currentHandLoc),
				targetEffect = discardTarget()
			})),                  
			layout = layoutCard({
				title = "Redraw 1.",
				art = "art/T_Wind_Storm",
				text = "<size=120%>Draw a card, then discard a card."
			})
		}
	end
	
	if (num > 1) then
	choiceTable[3] = {
			effect = drawCardsEffect(2).seq(pushTargetedEffect({
				desc = "Discard two cards.",
				min = 2,
				max = 2,
				validTargets = selectLoc(currentHandLoc),
				targetEffect = discardTarget()
			})),                  
			layout = layoutCard({
				title = "Redraw 2.",
				art = "art/T_Wind_Storm",
				text = "<size=120%>Draw up to two cards, then discard two cards."
			})
		}
	end
	
	if (num > 2) then
	choiceTable[4] = {
			effect = drawCardsEffect(num).seq(pushTargetedEffect({
				desc = "Discard " .. tostring(num) .. " cards.",
				min = num,
				max = num,
				validTargets = selectLoc(currentHandLoc),
				targetEffect = discardTarget()
			})),                  
			layout = layoutCard({
				title = "Redraw " .. tostring(num) .. ".",
				art = "art/T_Wind_Storm",
				text = "<size=120%>Draw " .. tostring(num) .. " cards, then discard " .. tostring(num) .. " cards."
			})
		}
	end
	
	return pushChoiceEffect({
		choices = choiceTable
	})
end

function sacrificeCardsEffect(num)
-- This function returns an effect that allows player to sacrifice up to 'num' cards from their hand or discard pile.
	return pushTargetedEffect({
		desc = "Sacrifice up to " .. tostring(num) .. " cards from your hand or discard pile.",
		min = 0,
		max = num,
		validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
		targetEffect = sacrificeTarget()
	})
end

function sacrificeMarketEffect(num)
	return pushTargetedEffect({
		desc = "Sacrifice up to " .. tostring(num) .. " cards from the Market Row.",
		min = 0,
		max = num,
		validTargets = selectLoc(centerRowLoc),
		targetEffect = sacrificeTarget()
	})
end

function acquireForFreeEffect(num)
	return pushTargetedEffect({
		desc = "Acquire up to " .. tostring(num) .. " cards for free.",
		min = 0,
		max = num,
		validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)),
		targetEffect = acquireForFreeTarget()
	})
end

function stunChampionsEffect(num)
	return pushTargetedEffect({
		desc = "Stun up to " .. tostring(num) .. " champions.",
		min = 0,
		max = num,
		validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
		targetEffect = stunTarget()
	})
end

function prepareChampionsEffect(num)
	return pushTargetedEffect({
		desc = "Prepare up to " .. tostring(num) .. " champions.",
		min = 0,
		max = num,
		validTargets = selectLoc(loc(currentPid, inPlayPloc)).where(isCardExpended()),
		targetEffect = prepareTarget()
	})
end

function prepareOtherChampionsEffect(num)
	return pushTargetedEffect({
		desc = "Prepare up to " .. tostring(num) .. " other champions.",
		min = 0,
		max = num,
		validTargets = selectLoc(loc(currentPid, inPlayPloc)).where(isCardExpended()).exclude(selectSource()),
		targetEffect = prepareTarget()
	})
end

function oppDrawCardsEffect(num)
	-- NOTICE: only draws 1 card even with num > 1
	return showTextEffect("Opponent drawing " .. tostring(num) .. " at start of their turn.").seq(createCardEffect(draw_card_buff_def(), loc(oppPid, buffsPloc)))
end


-- Forced versions, for AI
function forcedStunChampionsEffect(num)
	return pushTargetedEffect({
		desc = "Stun up to " .. tostring(num) .. " cards from your hand or discard pile.",
		min = num,
		max = num,
		validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
		targetEffect = stunTarget()
	})
end
customAcquireTrigger = "customAcquireTrigger"

local ids = {
	"cy01",
	"cy02",
	"cy03",
	"cy04",
	"cy05",
	"cy06",
	"ry01",
	"ry02",
	"ry03",
	"ry04",
	"ry05",
	"ry06",
	"ry07",
	"cu01",
	"cu02",
	"cu03",
	"cu04",
	"cu05",
	"cu06",
	"ru01",
	"ru02",
	"ru03",
	"ru04",
	"ru05",
	"ru06",
	"ru07",
	"cg01",
	"cg02",
	"cg03",
	"cg04",
	"cg05",
	"cg06",
	"rg01",
	"rg02",
	"rg03",
	"rg04",
	"rg05",
	"rg06",
	"rg07",
	"cr01",
	"cr02",
	"cr03",
	"cr04",
	"cr05",
	"cr06",
	"rr01",
	"rr02",
	"rr03",
	"rr04",
	"rr05",
	"rr06",
	"rr07",
	"fire_gem"
}

function acquireCardEffect(carddef, location)
	-- location is optional, will default to discard
	local locToAcq = currentDiscardLoc
	if location then
		locToAcq = location
	end
	
	return createCardEffect(carddef, locToAcq).seq(fireAbilityTriggerEffect(customAcquireTrigger))
end

function oppAcquireCardEffect(carddef, location)
	-- location is optional; will default to discard
	local locToAcq = loc(oppPid, discardPloc)
	if location then
		locToAcq = location
	end
	
	return createCardEffect(carddef, locToAcq)
		.seq(showTextTarget("<sprite name=\"health_3\">").apply(selectLoc(loc(oppPid, inPlayPloc)).where(isCardName("cy03"))))
		.seq(healPlayerEffect(oppPid, const(2)).doRepeat(selectLoc(loc(oppPid, inPlayPloc)).where(isCardName("cy03")).count()))
		.seq(showTextTarget("<sprite name=\"combat_3\">").apply(selectLoc(loc(oppPid, inPlayPloc)).where(isCardName("ru03"))))
		.seq(oppGainCombatEffect().doRepeat(selectLoc(loc(oppPid, inPlayPloc)).where(isCardName("ru03")).count()))
end

function oppAcquireWithId(id)
	local slot = createSlot({
	  id = "customIdentifierSlot",
	  expiresArray = { endOfTurnExpiry }
	})

	return createCardEffect(test_card_carddef(), loc(currentPid, asidePloc))
		.seq(addSlotToTarget(slot).apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("test"))))
		.seq(transformTarget(id).apply(selectLoc(loc(currentPid, asidePloc)).where(isCardWithSlot("customIdentifierSlot"))))
		.seq(moveTarget(loc(oppPid, discardPloc)).apply(selectLoc(loc(currentPid, asidePloc)).where(isCardWithSlot("customIdentifierSlot"))))
end

function acquireSymmetricTarget()
	local ef = nullTarget()
	for i = 1, #ids do
		ef = ef.seq(ifElseTarget(isCardName(ids[i]), acquireForFreeTarget().seq(oppAcquireWithId(ids[i])), nullTarget()))
	end
	return ef
end

function acquireSymmetricEffect(num)
	return pushTargetedEffect({
		desc = "Acquire a card. Each opponent acquires a copy.",
		min = 0,
		max = num,
		validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable()),
		targetEffect = acquireSymmetricTarget()
	})
end

function sacrificeCardsEffect(num)
-- Contains an additional checker for RG05
	return pushTargetedEffect({
		desc = "Sacrifice up to " .. tostring(num) .. " cards from your hand or discard pile.",
		min = 0,
		max = num,
		validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
		targetEffect = cSacTarget()
	})
end

function oppGainCombatEffect()
	return showTextEffect("Opponent gaining <sprite name=\"combat_3\"> at start of their turn.").seq(createCardEffect(gain_combat_3_buff_def(), loc(oppPid, buffsPloc)))
end



function cSacTarget()
	return ifElseTarget(
		isCardName("rg05").And(isCardAtLoc(discardPloc)),
		playTarget(),
		sacrificeTarget()
	)
end

function visual_bug_hotfix_effect()
	local slot = createSlot({
	  id = "customIdentifierSlot2",
	  expiresArray = { endOfTurnExpiry }
	})
	
	return createCardEffect(test_card_carddef(), loc(currentPid, asidePloc))
		.seq(addSlotToTarget(slot).apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("test"))))
		.seq(transformTarget("fire_gem").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardWithSlot("customIdentifierSlot2"))))
		.seq(moveTarget(loc(currentPid, sacrificePloc)).apply(selectLoc(loc(currentPid, asidePloc)).where(isCardWithSlot("customIdentifierSlot2"))))
end


function gain_combat_3_buff_def()
	-- For oppGainCombatEffect
	return createGlobalBuff({
		id = "gain_combat_3_buff_custom",
		name = "Delayed Phoebe trigger",
		abilities = {
			createAbility({
				id = "gain_combat_3_buff_ability",
				trigger = startOfTurnTrigger,
				effect = showTextEffect("Resolving combat gain trigger from previous turn.").seq(gainCombatEffect(3)),
				cost = sacrificeSelfCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		},
		buffDetails = createBuffDetails({
            art = "art/T_Thief_Female",
            name = "Delayed Phoebe trigger",
            text = "At start of turn, you gain 3 <sprite name=\"combat_3\">."
        }),
		layout = createLayout({
			name = "Delayed Phoebe trigger",
			art = "art/T_Thief_Female",
			frame = "frames/Coop_Campaign_CardFrame",
			text = "Gaining <sprite name=\"combat_3\"> at start of turn."
        })
	})
end


function rg06_buff_def()
	local choiceTable = {}	
	choiceTable[1] = {
		effect = pushTargetedEffect({
			desc = "Discard two cards.",
			min = 2,
			max = 2,
			validTargets = selectLoc(currentHandLoc),
			targetEffect = moveTarget(currentRevealLoc)
		}),
		layout = layoutCard({
			title = "Resist",
			art = "art/T_Unify_Apsara",
			text = "<size=120%>Discard two cards."
		})
	}
	choiceTable[2] = {
		effect = acquireCardEffect(gold_carddef(), loc(currentPid, handPloc)).seq(acquireCardEffect(gold_carddef(), loc(currentPid, handPloc))),                  
		layout = layoutCard({
			title = "Capitulate",
			art = "art/ancestry/smallfolk",
			text = "<size=120%>Acquire two Golds to your hand."
		})
	}

	return createGlobalBuff({
		id = "rg06_buff_custom",
		name = "Optional discard",
		abilities = {
			createAbility({
				id = "optional_discard_buff_ability",
				trigger = startOfTurnTrigger,
				effect = pushChoiceEffectWithTitle({ choices = choiceTable, upperTitle = "Workers' Uprising" }),
				cost = noCost,
				priority = 99,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "optional_discard_buff_ability_2",
				trigger = autoTrigger,
				effect = discardTarget().apply(selectLoc(currentRevealLoc)),
				cost = sacrificeSelfCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		},
		buffDetails = createBuffDetails({
            art = "art/T_Unify_Apsara",
            name = "Workers' Uprising",
            text = "At start of turn, you may discard two cards. If you don't, acquire two Golds."
        }),
		layout = createLayout({
			name = "Workers' Uprising",
			art = "art/T_Unify_Apsara",
			frame = "frames/Coop_Campaign_CardFrame",
			text = "At start of turn, you may discard two cards. If you don't, acquire two Golds."
        })
	})
end

function rr01_tracker_def()
	return createBuffDef({
		id = "rr01_tracker_buff_custom",
		name = "Tracking RR01",
		abilities = {
		},
		cardEffectAbilities = {
			createCardEffectAbility({
			  trigger = playedCardTrigger,
			  effect = ifElseTarget(isCardFaction(necrosFaction), ignoreTarget(playTarget().seq(expendTarget()).apply(selectLoc(currentDiscardLoc).where(isCardName("rr01")))), nullTarget())
			})
		},
		layout = createLayout({
			name = "Track RR01",
			art = "art/T_Piracy",
			frame = "frames/Coop_Campaign_CardFrame",
			text = "Makes the universe function better, trust me."
        })
	})
end

function rr03_tracker_def()
	return createBuffDef({
		id = "rr03_tracker_buff_custom",
		name = "Tracking RR03",
		abilities = {
			createAbility({
				id = "rr03_ind_2",
				trigger = onStunGlobalTrigger,
				effect = grantHealthTarget(2, {leavesPlayExpiry}).apply(selectLoc(loc(oppPid, inPlayPloc)).where(isCardName("rr03"))),
				cost = noCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		},
		layout = createLayout({
			name = "Track RR03",
			art = "art/T_Piracy",
			frame = "frames/Coop_Campaign_CardFrame",
			text = "Makes the universe function better, trust me."
        })
	})
end

function track_acquisition_buff_def()
	-- For oppDrawCardsEffect
	return createBuffDef({
		id = "track_acquisition_buff_custom",
		name = "Tracking card acquisition",
		abilities = {
			createAbility({
				id = "acq_event_transmitter",
				trigger = onAcquireGlobalTrigger,
				effect = fireAbilityTriggerEffect(customAcquireTrigger),
				cost = noCost,
				activations = multipleActivations
			}),
			createAbility({
				id = "acq_tracker",
				trigger = abilityTrigger(customAcquireTrigger),
				effect = addSlotToPlayerEffect(currentPid, createPlayerIntExpressionSlot("cards_acquired_count", 1, { endOfTurnExpiry })),
				cost = noCost,
				priority = 100,
				activations = multipleActivations
			})
		},
		layout = createLayout({
			name = "Track acquisition",
			art = "art/T_Piracy",
			frame = "frames/Coop_Campaign_CardFrame",
			text = "Makes the universe function better, trust me."
        })
	})
end

function visual_hotfix_buff_def()
	-- This buff is otherwise completely useless, but it fixed a visual bug in my tests
	local slot = createSlot({
	  id = "customIdentifierSlot2",
	  expiresArray = { endOfTurnExpiry }
	})
	
	return createBuffDef({
		id = "visual_hotfix_buff_custom",
		name = "Visual hotfix",
		abilities = {
			createAbility({
				id = "visual_hotfix_ind_ab",
				trigger = startOfTurnTrigger,
				effect = createCardEffect(test_card_carddef(), loc(currentPid, asidePloc))
					.seq(addSlotToTarget(slot).apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("test"))))
					.seq(transformTarget("fire_gem").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardWithSlot("customIdentifierSlot2"))))
					.seq(moveTarget(loc(currentPid, sacrificePloc)).apply(selectLoc(loc(currentPid, asidePloc)).where(isCardWithSlot("customIdentifierSlot2")))),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		},
		layout = createLayout({
			name = "Visual Hotfix",
			art = "art/T_Piracy",
			frame = "frames/Coop_Campaign_CardFrame",
			text = "Makes the universe function better, trust me."
        })
	})
end

function getStartBuffs()
	return {
		track_acquisition_buff_def(),
		rr01_tracker_def(),
		rr03_tracker_def(),
		--visual_hotfix_buff_def()
	}
end
function test_card_carddef()
	return quickCreateItem({
		name = "Test Visual Bug Info",
		cost = 0,
		types = { orcType },
		faction = 0,
		text = [[<vlayout>
				<icon text="This card face is showing due to a visual bug. Click this to view the actual card. The card will still play correctly, and visual fixes on shuffle." fontsize="24" flexibleheight="2"/>
			</vlayout>]],
		abilities = {
			createAbility({
				id = "test_ability_selfhit",
				trigger = autoTrigger, 
				effect = gainHealthEffect(-20),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt
			})
		}
	})
end


function cy01_ind_carddef()
	local choiceTable = {}	
	choiceTable[1] = {
		effect = acquireCardEffect(ogre_shiny_rock_carddef(), currentHandLoc).seq(oppAcquireCardEffect(ogre_shiny_rock_carddef())),                  
		layout = layoutCard({
			title = "Shiny Rock",
			art = "art/ancestry/shiny_rock",
			text = "<size=300%><sprite name=\"gold_2\">"
		})
	}
	choiceTable[2] = {
		effect = acquireCardEffect(ti05_ind_carddef(), currentHandLoc).seq(oppAcquireCardEffect(ti05_ind_carddef())),                  
		layout = layoutCard({
			title = "Antique Javelin",
			art = "art/T_Fighter_Jagged_Spear",
			text = "<size=200%><sprite name=\"combat_1\">\n<size=100%>You may discard a card. If you do, draw a card."
		})
	}
	choiceTable[3] = {
		effect = acquireCardEffect(ti02_ind_carddef(), currentHandLoc).seq(oppAcquireCardEffect(ti02_ind_carddef())),
		layout = layoutCard({
			title = "Snake Oil",
			art = "art/T_Elixir_Of_Concentration",
			text = "<size=300%><sprite name=\"combat_1\"> <sprite name=\"health_3\">"
		})
	}
	
	return quickCreateChampion({
		name = "CY01 Pushy Merchant",
		cost = 4,
		health = 5,
		isGuard = false,
		art = "art/T_Bribe",
		faction = 1,
		text = [[<hlayout>
			<tmpro text="{expend}" fontsize="58" flexiblewidth="1"/>
			<box flexiblewidth="0.5"/>
			<vlayout flexiblewidth="6">
				<tmpro text="Choose one:" fontsize="17" flexibleheight="0.8" alignment="left"/>
				<tmpro text="• Shiny Rock ({gold_2})" fontsize="17" alignment="left" flexibleheight="0.8"/>
				<tmpro text="• Antique Javelin ({combat_1}, cycle 1)" fontsize="17" alignment="left" flexibleheight="0.8"/>
				<tmpro text="• Snake Oil ({combat_1} {health_3})" fontsize="17" alignment="left" flexibleheight="0.8"/>
				<box flexibleheight="0.4"/>
				<tmpro text="Each player acquires a copy of it. Your copy is acquired to your hand." fontsize="17" alignment="left" flexibleheight="1.6"/>
			</vlayout>
		</hlayout>]],
		abilities = {
			createAbility({
				id = "cy01_ind_1",
				trigger = uiTrigger,
				effect = pushChoiceEffectWithTitle({
					choices = choiceTable,
					upperTitle = "Choose a card. You acquire it to your hand. Other players acquire a copy to their discard pile."
				}),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function cy02_ind_carddef()
	local choiceTable = {}	
	choiceTable[1] = {
		effect = gainCombatEffect(1),                  
		layout = layoutCard({
			title = "Field Herbalist",
			art = "art/T_Nature_s_Bounty",
			text = "<size=300%><sprite name=\"combat_1\">"
		})
	}
	choiceTable[2] = {
		effect = gainHealthEffect(3),                  
		layout = layoutCard({
			title = "Field Herbalist",
			art = "art/T_Nature_s_Bounty",
			text = "<size=300%><sprite name=\"health_3\">"
		})
	}
	
	local prompt1 = createLayout({
		name = "Field Herbalist",
		art = "art/T_Nature_s_Bounty",
		frame = "frames/Imperial_Champion_CardFrame",
		xmlText = [[<vlayout>
			<hlayout flexibleheight="2.2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_1} or {health_3}" fontsize="50" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		cost = 2,
	})
	
	local prompt3 = createLayout({
		name = "Field Herbalist",
		art = "art/T_Nature_s_Bounty",
		frame = "frames/Imperial_Champion_CardFrame",
		xmlText = [[<vlayout>
			<hlayout flexibleheight="2.2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="5">
					<tmpro text="You may discard a card. If you do, draw a card." fontsize="27" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		cost = 2,
	})
	
	return quickCreateChampion({
		name = "CY02 Field Herbalist",
		cost = 2,
		health = 3,
		isGuard = true,
		art = "art/T_Nature_s_Bounty",
		faction = 1,
		text = [[<vlayout>
			<hlayout flexibleheight="2.2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="46" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_1} or {health_3}" fontsize="42" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{imperial}" fontsize="46" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_3}" fontsize="42" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.2"/>
				<tmpro text="{wild}" fontsize="46" flexiblewidth="0.8"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="You may discard a card. If you do, draw a card." fontsize="18" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cy02_ind_1",
				layout = prompt1,
				trigger = uiTrigger, 
				effect = pushChoiceEffect({
					choices = choiceTable
				}),
				cost = expendCost,
				activations = multipleActivations,
				check = constBoolExpression(true),
				promptType = noPrompt
			}),
			createAbility({
				id = "cy02_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(3),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { imperialFaction }
			}),
			createAbility({
				id = "cy02_ind_3",
				layout = prompt3,
				trigger = uiTrigger, 
				effect = cycleCardsEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function cy03_ind_carddef()
	--TODO: Outputs wrong source to log on opponents turn
	return quickCreateChampion({
		name = "CY03 Scripture Compositor",
		cost = 2,
		health = 4,
		isGuard = false,
		faction = 1,
		art = "art/ancestry/elven_wisdom",
			text = [[<vlayout>
				<hlayout flexibleheight="3">
					<box flexiblewidth="0.5"/>
					<tmpro text="{expend}" fontsize="70" flexiblewidth="0"/>
					<vlayout flexiblewidth="5">
						<tmpro text="{gold_1}" fontsize="60" flexibleheight="2"/>
					</vlayout>
				</hlayout>
				<divider/>
				<box flexibleheight="0.2"/>
				<hlayout flexibleheight="2">
					<box flexiblewidth="0.5"/>
					<vlayout flexiblewidth="5">
						<tmpro text="Whenever you acquire a card, gain {health_2}." fontsize="22" flexibleheight="2"/>
					</vlayout>
					<box flexiblewidth="0.5"/>
				</hlayout>
			</vlayout>]],
		abilities = {
			createAbility({
				id = "cy03_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(1),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "cy03_ind_3",
				trigger = abilityTrigger(customAcquireTrigger),
				effect = gainHealthEffect(2),
				cost = noCost,
				activations = multipleActivations
			})
		}
	})
end

function cy04_ind_carddef()
	return quickCreateChampion({
		name = "CY04 Overseer's Bodyguard",
		cost = 6,
		health = 6,
		isGuard = true,
		faction = 1,
		art = "art/T_Fighter_Male",
		text = [[<vlayout>
			<hlayout flexibleheight="2.5">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="60" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="10">
					<tmpro text="When you discard this, you gain {gold_1} {combat_2} {health_3} and draw a card." fontsize="22" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cy04_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(4),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "cy04_ind_2",
				trigger = onDiscardTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(2)).seq(gainHealthEffect(3)).seq(drawCardsWithAnimation(1)),
				cost = noCost,
				activations = multipleActivations
			})
		}
	})
end

function cy05_ind_carddef()
	-- This card depends on all market card id's being listed in ids, and also in getRegisterList() in the same order.
	-- If an id is missing from the list, this won't function properly
	local prompt2 = createLayout({
		name = "Generous Investment",
		art = "art/T_Profit",
		frame = "frames/Imperial_Action_CardFrame",
		xmlText = [[<vlayout>
			<hlayout>
				<tmpro text="{imperial}" fontsize="50" alignment="left" flexiblewidth="0"/>
				<box flexiblewidth="0.7"/>
				<vlayout flexiblewidth="2">
					<tmpro text="Draw a card." fontsize="30" alignment="left" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
	})
	
	return quickCreateAction({
		name = "CY05 Generous Investment",
		cost = 2,
		faction = 1,
		art = "art/T_Profit",
		text = [[<vlayout>
			<tmpro text="Acquire a card for free. Each opponent acquires a copy of it." fontsize="24" flexibleheight="3"/>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<tmpro text="{imperial}" fontsize="60" flexiblewidth="1"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="Draw a card." fontsize="26" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cy05_ind_1",
				trigger = autoTrigger,
				effect = visual_bug_hotfix_effect().seq(acquireSymmetricEffect(1)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cy05_ind_2",
				layout = prompt2,
				trigger = uiTrigger, 
				effect = drawCardsEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function cy06_ind_carddef()
	return quickCreateAction({
		name = "CY06 Supply Wagon",
		cost = 4,
		faction = 1,
		art = "art/T_Heist",
		text = [[<vlayout>
			<box flexibleheight="0.5"/>
			<tmpro text="{health_8}" fontsize="52" flexibleheight="1.5"/>
			<tmpro text="Prepare target Champion" fontsize="22" flexibleheight="1.5"/>
			<divider/>
			<box flexibleheight="0.5"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{imperial}" fontsize="58" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_4}" fontsize="54" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cy06_ind_1",
				trigger = autoTrigger,
				effect = gainHealthEffect(8).seq(prepareChampionsEffect(1)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cy06_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function ry01_ind_carddef()
	local choiceTable = {}	
	local artSource = "art/ancestry/friendly_banter"
	
	choiceTable[1] = {
		effect = nullEffect(),                  
		layout = layoutCard({
			title = "Don't acquire",
			art = artSource,
			text = "<size=100%>Acquire no cards."
		})
	}
	choiceTable[2] = {
		effect = acquireCardEffect(gold_carddef(), currentHandLoc),                  
		layout = layoutCard({
			title = "Acquire one",
			art = artSource,
			text = "<size=100%>Acquire one Gold."
		})
	}
	choiceTable[3] = {
		effect = acquireCardEffect(gold_carddef(), currentHandLoc).seq(acquireCardEffect(gold_carddef(), currentHandLoc)),
		layout = layoutCard({
			title = "Acquire two",
			art = artSource,
			text = "<size=100%>Acquire two Golds."
		})
	}
	choiceTable[4] = {
		effect = acquireCardEffect(gold_carddef(), currentHandLoc).seq(acquireCardEffect(gold_carddef(), currentHandLoc)).seq(acquireCardEffect(gold_carddef(), currentHandLoc)),
		layout = layoutCard({
			title = "Acquire three",
			art = artSource,
			text = "<size=100%>Acquire three Golds."
		})
	}
	
	return quickCreateChampion({
		name = "RY01 Orval the Blithe",
		cost = 2,
		health = 3,
		isGuard = false,
		faction = 1,
		art = artSource,
		text = [[<vlayout>
			<box flexibleheight="0.3"/>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="0.7"/>
				<vlayout flexiblewidth="6">
					<tmpro text="{health_4}" fontsize="50" flexibleheight="2"/>
					<tmpro text="Acquire up to three Golds ({gold_1}) to your hand." fontsize="18" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.4"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{imperial}" fontsize="56" flexiblewidth="0"/>
				<box flexiblewidth="0.7"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{gold_1}" fontsize="50" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ry01_ind_1",
				trigger = uiTrigger,
				effect = gainHealthEffect(4).seq(pushChoiceEffectWithTitle({
					choices = choiceTable,
					upperTitle = "Acquire up to three Golds to your hand."
				})),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "ry01_ind_2",
				trigger = autoTrigger, 
				effect = gainGoldEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function ry02_ind_carddef()
	local slot = createPlayerIntExpressionSlot("RY02_slot", const(4), { endOfTurnExpiry })
	
	local prompt1old = createLayout({
		name = "Security Officer",
		art = "art/T_Man_at_Arms",
		frame = "frames/Imperial_Champion_CardFrame",
		text = format("<size=180%><sprite name=\"expend\">    <sprite name=\"combat_2\"> <sprite name=\"health_2\">\n<size=65%>For every 4 cards in your discard pile, gain an additional <sprite name=\"combat_1\"> <sprite name=\"health_1\">.<size=65%>\n\n<i>(Currently gains {0}<sprite name=\"combat\">, {0}<sprite name=\"health\">)\n(Cards in discard pile: {1})</i>", { divide(selectLoc(currentDiscardLoc).count(), 4).add(2), selectLoc(currentDiscardLoc).count() })
	})
	
	local prompt1 = createLayout({
		name = "Security Officer",
		art = "art/T_Man_at_Arms",
		frame = "frames/Imperial_Champion_CardFrame",
		xmlText = format([[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.7"/>
				<tmpro text="{expend}" fontsize="64" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="0.2"/>
					<tmpro text="{combat_2} {health_2}" fontsize="48" flexibleheight="3"/>
					<box flexibleheight="0.6"/>
					<tmpro text="For every four cards in your discard pile, gain an additional {combat_1} {health_1}." fontsize="18" flexibleheight="3"/>
					<box flexibleheight="1"/>
					<tmpro text="(Currently gains: {0}{combat} {0}{health})" fontsize="14" flexibleheight="0.5"/>
					<box flexibleheight="0.35"/>
					<tmpro text="(Cards in discard pile: {1})" fontsize="14" flexibleheight="0.5"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]], { divide(selectLoc(currentDiscardLoc).count(), 4).add(2), selectLoc(currentDiscardLoc).count() })
	})
	
	return quickCreateChampion({
		name = "RY02 Security Officer",
		cost = 4,
		health = 4,
		isGuard = true,
		faction = 1,
		art = "art/T_Man_at_Arms",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.7"/>
				<tmpro text="{expend}" fontsize="64" flexiblewidth="0"/>
				<box flexiblewidth="0.7"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="1"/>
					<tmpro text="{combat_2} {health_2}" fontsize="54" flexibleheight="2"/>
					<tmpro text="For every four cards in your discard pile, gain an additional {combat_1} {health_1}." fontsize="20" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ry02_ind_1",
				layout = prompt1,
				trigger = uiTrigger,
				effect = gainCombatEffect(2).seq(gainHealthEffect(2)).seq(addSlotToPlayerEffect(currentPid, slot))
					.seq(ifElseEffect(selectLoc(currentDiscardLoc).count().gte(sumIntSlots(currentPid, "RY02_slot")), fireAbilityTriggerForTarget("customRY02Trigger").apply(selectSource()), removeSlotFromPlayerEffect(currentPid, "RY02_slot"))),
				cost = expendCost,
				activations = multipleActivations,
				promptType = showPrompt
			}),
			createAbility({
				id = "ry02_ind_1_recursion",
				trigger = abilityTrigger("customRY02Trigger"),
				effect = gainCombatEffect(1).seq(gainHealthEffect(1)).seq(addSlotToPlayerEffect(currentPid, slot))
					.seq(ifElseEffect(selectLoc(currentDiscardLoc).count().gte(sumIntSlots(currentPid, "RY02_slot")), fireAbilityTriggerForTarget("customRY02Trigger").apply(selectSource()), removeSlotFromPlayerEffect(currentPid, "RY02_slot"))),
				cost = noCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function ry03_ind_carddef()
	local prompt2 = createLayout({
		name = "Izetta, Earnest Captain",
		art = "art/T_Fighter_FemaleAlternate",
		frame = "frames/Imperial_Champion_CardFrame",
		xmlText = [[<vlayout>
			<hlayout>
				<tmpro text="{imperial}" fontsize="50" alignment="left" flexiblewidth="0"/>
				<box flexiblewidth="0.6"/>
				<vlayout flexiblewidth="2">
					<tmpro text="Prepare another target Champion" fontsize="26" alignment="left" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]]
	})
	
	return quickCreateChampion({
		name = "RY03 Izetta, Earnest Captain",
		cost = 6,
		health = 6,
		isGuard = false,
		faction = 1,
		art = "art/T_Fighter_FemaleAlternate",
		text = [[<vlayout>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="50" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{imperial}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="5">
					<tmpro text="Prepare another target Champion." fontsize="24" alignment="left" flexibleheight="1"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ry03_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(4),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "ry03_ind_2",
				layout = prompt2,
				trigger = uiTrigger, 
				effect = prepareOtherChampionsEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function ry04_ind_carddef()
	return quickCreateChampion({
		name = "RY04 Mitchell the Industrialist",
		cost = 8,
		health = 7,
		isGuard = true,
		faction = 1,
		art = "art/T_Cleric_MaleAlternate",
		text = [[<vlayout>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_3} {health_3}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{imperial}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_3}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ry04_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(3).seq(gainHealthEffect(3)),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "ry04_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(3),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function ry05_ind_carddef()
	return quickCreateAction({
		name = "RY05 Railway Freight",
		cost = 2,
		faction = 1,
		art = "art/T_Expansion",
		text = [[<vlayout>
			<box flexibleheight="0.7"/>
			<tmpro text="{gold_1}" fontsize="50" flexibleheight="1"/>
			<box flexibleheight="0.7"/>
			<tmpro text="Draw two cards." fontsize="20" flexibleheight="1"/>
			<box flexibleheight="0"/>
			<tmpro text="Each opponent draws a card." fontsize="20" flexibleheight="1"/>
			<box flexibleheight="0.4"/>
			<divider/>
			<box flexibleheight="0.6"/>
			<hlayout flexibleheight="1.2">
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="10">
					<tmpro text="When you discard this, gain  {combat_2} {health_3}." fontsize="20" flexibleheight="4"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ry05_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(drawCardsWithAnimation(2)).seq(oppDrawCardsEffect(1)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "ry05_ind_2",
				trigger = onDiscardTrigger,
				effect = gainCombatEffect(2).seq(gainHealthEffect(3)),
				cost = noCost,
				activations = multipleActivations
			})
		}
	})
end

function ry06_ind_carddef()
	return quickCreateAction({
		name = "RY06 Imperial Infrastructure Infusion",
		cost = 6,
		faction = 1,
		art = "art/T_Bribe",
		text = [[<vlayout>
			<box flexibleheight="0.3"/>
			<tmpro text="{gold_4} {combat_5} {health_6}" fontsize="55" flexibleheight="1"/>
			<box flexibleheight="0.5"/>
			<tmpro text="You may put a card from your hand on the top of your deck. If you don't, acquire a Gold." fontsize="20" flexibleheight="0.8"/>
			<box flexibleheight="0.4"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ry06_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(4).seq(gainCombatEffect(5)).seq(gainHealthEffect(6)).seq(pushTargetedEffect({
					desc = "You may topdeck a card. If you don't, acquire a gold.",
					min = 0,
					max = 1,
					validTargets = selectLoc(currentHandLoc),
					targetEffect = moveToTopDeckTarget(true).seq(ifElseEffect(selectTargets().count().gte(1), nullEffect(), acquireCardEffect(gold_carddef())))
				})),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function ry07_ind_carddef()
	local prompt2 = createLayout({
		name = "Izetta, Earnest Captain",
		art = "art/T_Fighter_FemaleAlternate",
		frame = "frames/Imperial_Champion_CardFrame",
		xmlText = format([[<vlayout>
			<box flexibleheight="1"/>
			<hlayout>
				<tmpro text="{imperial}" fontsize="50" alignment="left" flexiblewidth="0"/>
				<box flexiblewidth="0.6"/>
				<vlayout flexiblewidth="2">
					<tmpro text="Prepare X Champions, where X is the number of other {imperial} cards you have in play." fontsize="20" alignment="left" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<box flexibleheight="1"/>
			<tmpro text="(Currently prepares up to {0} Champions)" fontsize="14" alignment="center" flexibleheight="2"/>
		</vlayout>]], { selectLoc(currentInPlayLoc).union(selectLoc(currentCastLoc)).where(isCardFaction(imperialFaction)).count().add(-1) } )
	})
	
	return quickCreateAction({
		name = "RY07 Unite for Progress",
		cost = 8,
		faction = 1,
		art = "art/T_All_Heroes",
		text = [[<vlayout>
			<tmpro text="Reveal cards from top of your deck until you have revealed two champions. Draw those champions and discard the other revealed cards." fontsize="16" flexibleheight="2.5"/>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.5"/>
			<hlayout flexibleheight="2">
				<tmpro text="{imperial}" fontsize="60" flexiblewidth="1"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="Prepare up to X Champions, where X is the number of other {imperial} cards you have in play." fontsize="16" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ry07_ind_1",
				trigger = autoTrigger,
				effect = fireAbilityTriggerForTarget("customRY07Trigger").apply(selectSource()),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "ry07_ind_1_recursion",
				trigger = abilityTrigger("customRY07Trigger"),
				effect = drawToLocationEffect(1, currentRevealLoc).seq(
					ifElseEffect(
						selectLoc(currentDeckLoc).union(selectLoc(currentDiscardLoc)).count().gte(1).And(selectLoc(currentRevealLoc).where(isCardChampion()).count().lte(1)),
						fireAbilityTriggerForTarget("customRY07Trigger").apply(selectSource()),
						fireAbilityTriggerForTarget("customRY07FinishTrigger").apply(selectSource())
					)
				),
				cost = noCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "ry07_ind_1_finish",
				trigger = abilityTrigger("customRY07FinishTrigger"),
				effect = moveTarget(currentHandLoc).apply(selectLoc(currentRevealLoc).where(isCardChampion())).seq(discardTarget().apply(selectLoc(currentRevealLoc))),
				cost = noCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "ry07_ind_2",
				layout = prompt2,
				trigger = uiTrigger, 
				effect = pushTargetedEffect({
					desc =  format("Prepare up to {0} champion(s).", { selectLoc(currentInPlayLoc).union(selectLoc(currentCastLoc)).where(isCardFaction(imperialFaction)).count().add(-1) }),
					min = 0,
					max = selectLoc(currentInPlayLoc).union(selectLoc(currentCastLoc)).where(isCardFaction(imperialFaction)).count().add(-1),
					validTargets = selectLoc(loc(currentPid, inPlayPloc)).where(isCardExpended()),
					targetEffect = prepareTarget()
				}),
				cost = noCost,
				activations = singleActivation,
				promptType = showPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function cu01_ind_carddef()
	return quickCreateChampion({
		name = "CU01 Warehouse Sentry",
		cost = 2,
		health = 4,
		isGuard = true,
		faction = 2,
		art = "art/T_Orc_Guardian",
		text = [[<vlayout>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="65" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_2}" fontsize="60" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{guild}" fontsize="65" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_2}" fontsize="60" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cu01_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(2),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "cu01_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(2),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { guildFaction }
			})
		}
	})
end

function cu02_ind_carddef()
	return quickCreateChampion({
		name = "CU02 Union Enforcer",
		cost = 4,
		health = 5,
		isGuard = true,
		faction = 2,
		art = "art/T_Fighter_FemaleAlternate",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.8"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_3}" fontsize="65" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0"/>
				<vlayout flexiblewidth="10">
					<tmpro text="When you discard this, play it. It gets -2{shield} until it leaves play." fontsize="20" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cu02_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(3),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "cu02_ind_2",
				trigger = onDiscardTrigger,
				effect = playTarget().apply(selectSource()).seq(grantHealthTarget(-2, {leavesPlayExpiry}).apply(selectSource())),
				cost = noCost,
				activations = multipleActivations
			})
		}
	})
end

function cu03_ind_carddef()
	return quickCreateChampion({
		name = "CU03 Factory Sentinel",
		cost = 6,
		health = 8,
		isGuard = true,
		faction = 2,
		art = "art/T_Torgen_Rocksplitter",
		text = [[<vlayout>
			<tmpro text="&quot;The contract says that I protect, but nowhere does it say that I have to fight.&quot;" fontsize="12" fontstyle="Italic" flexibleheight="3"/>
			<box flexibleheight="0"/>
			<divider/>
			<box flexibleheight="1"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.2"/>
				<tmpro text="{guild}" fontsize="70" flexiblewidth="0.8"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="65" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cu03_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { guildFaction }
			})
		}
	})
end

function cu04_ind_carddef()
	return quickCreateAction({
		name = "CU04 Industrial Lobbying",
		cost = 2,
		faction = 2,
		art = "art/T_Fire_Gem",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.4"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{gold_3}" fontsize="45" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
			<box flexibleheight="0.5"/>
			<divider/>
			<box flexibleheight="0.5"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.4"/>
				<tmpro text="{guild}" fontsize="45" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="45" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
			<box flexibleheight="0.5"/>
			<divider/>
			<box flexibleheight="0.5"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.4"/>
				<tmpro text="{imperial}" fontsize="45" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{health_4}" fontsize="45" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cu04_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(3),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cu04_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { guildFaction }
			}),
			createAbility({
				id = "cu04_ind_3",
				trigger = autoTrigger, 
				effect = gainHealthEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function cu05_ind_carddef()
	return quickCreateAction({
		name = "CU05 Coercive Coinage",
		cost = 2,
		faction = 2,
		art = "art/T_Taxation",
		text = [[<vlayout>
			<box flexibleheight="0.4"/>
			<tmpro text="{gold_1}" fontsize="55" flexibleheight="1.5"/>
			<box flexibleheight="0.2"/>
			<tmpro text="You may stun target Champion." fontsize="20" flexibleheight="2"/>
			<divider/>
			<box flexibleheight="0.6"/>
			<hlayout flexibleheight="1.5">
				<box flexiblewidth="0.79"/>
				<tmpro text="{guild}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_6}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.8"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cu05_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(stunChampionsEffect(1)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cu05_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(6),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { guildFaction }
			})
		}
	})
end

function cu06_ind_carddef()
	return quickCreateAction({
		name = "CU06 Steam Engine",
		cost = 4,
		faction = 2,
		art = "art/T_Wind_Tunnel",
		text = [[<vlayout>
			<box flexibleheight="0.7"/>
			<tmpro text="{gold_2}" fontsize="60" flexibleheight="2"/>
			<box flexibleheight="1.5"/>
			<tmpro text="You may put another card you have in play on the top of your deck." fontsize="20" flexibleheight="2"/>
			<box flexibleheight="2"/>
			<tmpro text="(If that card is drawn this turn, all abilities on that card can be activated again.)" fontsize="10" fontstyle="Italic" flexibleheight="0.5"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cu06_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(2).seq(pushTargetedEffect({
					desc = "You may topdeck another card you have in play.",
					min = 0,
					max = 1,
					validTargets = selectLoc(currentCastLoc).union(selectLoc(currentInPlayLoc)).exclude(selectSource()),
					targetEffect = moveToTopDeckTarget(false)
				})),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function ru01_ind_carddef()
	local slot = createPlayerIntExpressionSlot("RU01_slot", const(3), { endOfTurnExpiry })

	local prompt1 = createLayout({
		name = "Ambitious Liaison",
		art = "art/T_Elven_Gift",
		frame = "frames/Guild_Champion_CardFrame",
		xmlText = format([[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.7"/>
				<tmpro text="{expend}" fontsize="64" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="0.2"/>
					<tmpro text="{combat_2}" fontsize="48" flexibleheight="3"/>
					<box flexibleheight="0.6"/>
					<tmpro text="For every three cards in your discard pile, gain an additional {combat_1}." fontsize="18" flexibleheight="3"/>
					<box flexibleheight="1"/>	
					<tmpro text="(Currently gains: {0}{combat})" fontsize="14" flexibleheight="0.5"/>
					<box flexibleheight="0.35"/>
					<tmpro text="(Cards in discard pile: {1})" fontsize="14" flexibleheight="0.5"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]], { divide(selectLoc(currentDiscardLoc).count(), 3).add(2), selectLoc(currentDiscardLoc).count() })
	})

	return quickCreateChampion({
		name = "RU01 Ambitious Liaison",
		cost = 2,
		health = 3,
		isGuard = false,
		faction = 2,
		art = "art/T_Elven_Gift",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.2"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0.8"/>
				<box flexiblewidth="0.4"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="1"/>
					<tmpro text="{combat_2}" fontsize="45" flexibleheight="2"/>
					<box flexibleheight="0.4"/>
					<tmpro text="For every three cards in your discard pile, gain an additional {combat_1}." fontsize="18" flexibleheight="2"/>
					<box flexibleheight="1"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ru01_ind_1",
				layout = prompt1,
				trigger = uiTrigger,
				effect = gainCombatEffect(2).seq(addSlotToPlayerEffect(currentPid, slot))
					.seq(ifElseEffect(selectLoc(currentDiscardLoc).count().gte(sumIntSlots(currentPid, "RU01_slot")), fireAbilityTriggerForTarget("customRU01Trigger").apply(selectSource()), removeSlotFromPlayerEffect(currentPid, "RU01_slot"))),
				cost = expendCost,
				activations = multipleActivations,
				promptType = showPrompt
			}),
			createAbility({
				id = "ru01_ind_1_recursion",
				trigger = abilityTrigger("customRU01Trigger"),
				effect = gainCombatEffect(1).seq(addSlotToPlayerEffect(currentPid, slot))
					.seq(ifElseEffect(selectLoc(currentDiscardLoc).count().gte(sumIntSlots(currentPid, "RU01_slot")), fireAbilityTriggerForTarget("customRU01Trigger").apply(selectSource()), removeSlotFromPlayerEffect(currentPid, "RU01_slot"))),
				cost = noCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function ru02_ind_carddef()
	local choiceTable = {}	
		
	choiceTable[1] = {
		effect = nullEffect(),                  
		layout = layoutCard({
			title = "Do nothing.",
			art = "art/T_Wind_Storm",
			text = "<size=120%>Do nothing."
		})
	}
	
	choiceTable[2] = {
		effect = acquireCardEffect(ti03_ind_carddef(), currentHandLoc),                  
		layout = layoutCard({
			title = "Acquire Mithril Pickaxe",
			art = "art/T_Wind_Storm",
			text = "<size=120%>Acquire Mithril Pickaxe. (<sprite name=\"gold_2\"> <sprite name=\"combat_4\">)"
		})
	}
	
	local prompt1 = createLayout({
		name = "Ennis the Climber",
		art = "art/T_Fighter_Rallying_Flag",
		frame = "frames/Guild_Champion_CardFrame",
		xmlText = [[<vlayout>
			<hlayout flexibleheight="2.2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="5">
					<tmpro text="Acquire a Mithril Pickaxe ({gold_2} {combat_5})" fontsize="27" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		cost = 2,
	})
	
	local prompt2 = createLayout({
		name = "Ennis the Climber",
		art = "art/T_Fighter_Rallying_Flag",
		frame = "frames/Guild_Champion_CardFrame",
		xmlText = [[<vlayout>
			<hlayout flexibleheight="2.2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="5">
					<tmpro text="You may discard a card. If you do, draw a card." fontsize="27" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		cost = 2,
	})
	
	return quickCreateChampion({
		name = "RU02 Ennis the Climber",
		cost = 4,
		health = 5,
		isGuard = false,
		faction = 2,
		art = "art/T_Fighter_Rallying_Flag",
		text = [[<vlayout>
			<hlayout flexibleheight="3">
				<box flexiblewidth="0.7"/>
				<tmpro text="{expend}" fontsize="65" flexiblewidth="0"/>
				<box flexiblewidth="0.7"/>
				<vlayout flexiblewidth="6">
					<tmpro text="Acquire a Mithril Pickaxe ({gold_2} {combat_5})." fontsize="24" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
			<box flexibleheight="0.3"/>
			<divider/>
			<box flexibleheight="0.8"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.7"/>
				<tmpro text="{wild}" fontsize="65" flexiblewidth="0"/>
				<box flexiblewidth="0.7"/>
				<vlayout flexiblewidth="5">
					<tmpro text="You may discard a card. If you do, draw a card." fontsize="22" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ru02_ind_1",
				layout = prompt1,
				trigger = uiTrigger,
				effect = acquireCardEffect(ti03_ind_carddef()),
				cost = expendCost,
				activations = multipleActivations,
				promptType = showPrompt
			}),
			createAbility({
				id = "ru02_ind_2",
				layout = prompt2,
				trigger = uiTrigger, 
				effect = cycleCardsEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function ru03_ind_carddef()
	return quickCreateChampion({
		name = "RU03 Phoebe, Shadow Broker",
		cost = 6,
		health = 5,
		isGuard = false,
		faction = 2,
		art = "art/T_Thief_Female",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{gold_2}" fontsize="65" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<vlayout flexiblewidth="5">
					<tmpro text="Whenever you acquire a card, gain {combat_3}." fontsize="26" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ru03_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(2),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "ru03_ind_2",
				trigger = abilityTrigger(customAcquireTrigger),
				effect = gainCombatEffect(3),
				cost = noCost,
				activations = multipleActivations
			})
		}
	})
end

function ru04_ind_carddef()
	local prompt2 = createLayout({
		name = "Ironclad Operative",
		art = "avatars/assassin",
		frame = "frames/Guild_Champion_CardFrame",
		xmlText = [[<vlayout>
			<tmpro text="Spend {gold_2} to stun target Champion." fontsize="32" flexibleheight="2"/>
		</vlayout>]],
		cost = 2,
	})

	return quickCreateChampion({
		name = "RU04 Ironclad Operative",
		cost = 8,
		health = 7,
		isGuard = false,
		faction = 2,
		art = "avatars/assassin",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="65" flexiblewidth="0"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{gold_2} {combat_3}" fontsize="60" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.8"/>
			</hlayout>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<vlayout flexiblewidth="5">
					<tmpro text="Pay {gold_2} to stun target Champion. You can activate this ability any number of times each turn." fontsize="18" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ru04_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(2).seq(gainCombatEffect(3)),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "ru04_ind_2",
				layout = prompt2,
				trigger = uiTrigger,
				effect = stunChampionsEffect(1),
				cost = goldCost(2),
				activations = multipleActivations,
				check = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()).count().gte(1),
				promptType = showPrompt
			})
		}
	})
end

function ru05_ind_carddef()
	return quickCreateAction({
		name = "RU05 Shady Bargain",
		cost = 2,
		faction = 2,
		art = "art/T_Pilfer",
		text = [[<vlayout>
			<box flexibleheight="0.3"/>
			<tmpro text="{gold_1} {combat_5}" fontsize="65" flexibleheight="2.5"/>
			<box flexibleheight="0.4"/>
			<divider/>
			<box flexibleheight="0.4"/>
			<tmpro text="When you discard this, acquire a card costing {gold_4} or less for free." fontsize="20" flexibleheight="2"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ru05_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(5)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "ru05_ind_2",
				trigger = onDiscardTrigger,
				effect = pushTargetedEffect({
					desc = "Acquire a card costing <sprite name=\"gold_4\"> or less for free.",
					min = 0,
					max = 1,
					validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable().And(getCardCost().lte(4))),
					targetEffect = acquireForFreeTarget()
				}),
				cost = noCost,
				activations = multipleActivations
			})
		}
	})
end

function ru06_ind_carddef()
	return quickCreateAction({
		name = "RU06 Red Tape Tangle",
		cost = 6,
		faction = 2,
		art = "art/T_Myros_Guild_Mage",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<tmpro text="{gold_4} {combat_4}" fontsize="48" flexibleheight="1.5"/>
			<box flexibleheight="0"/>
			<tmpro text="When you acquire your 3rd card this turn, each opponent acquires a Gold." fontsize="16" flexibleheight="1.5"/>
			<tmpro text="(They won't receive additional Golds for card acquisisitions beyond the 3rd.)" fontsize="7.5" fontstyle="Italic" flexibleheight="0.2"/>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.4"/>
			<hlayout flexibleheight="1.5">
				<box flexiblewidth="0.5"/>
				<tmpro text="{guild}" fontsize="50" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_4}" fontsize="50" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ru06_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(4).seq(gainCombatEffect(4)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "ru06_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { guildFaction }
			}),
			createAbility({
				id = "ru06_ind_3",
				trigger = abilityTrigger(customAcquireTrigger),
				effect = ifElseEffect(
					sumIntSlots(currentPid, "cards_acquired_count").eq(3),
					oppAcquireCardEffect(gold_carddef()),
					nullEffect()
				),
				cost = noCost,
				activations = multipleActivations,
			})
		}
	})
end

function ru07_ind_carddef()
	local layout1 = createLayout({
		name = "Special Connections",
		art = "art/T_Walking_Dirt",
		frame = "frames/Guild_Action_CardFrame",
		xmlText = [[<vlayout>
			<tmpro text="Acquire a card to your hand." fontsize="30" flexibleheight="2"/>
		</vlayout>]],
		cost = 8,
	})
	
	local layout2 = createLayout({
		name = "Special Connections",
		art = "art/T_Walking_Dirt",
		frame = "frames/Guild_Action_CardFrame",
		xmlText = [[<vlayout>
			<tmpro text="Draw a card." fontsize="36" flexibleheight="2"/>
		</vlayout>]],
		cost = 8,
	})
	
	return quickCreateAction({
		name = "RU07 Special Connections",
		cost = 8,
		faction = 2,
		art = "art/T_Walking_Dirt",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<tmpro text="{combat_3}" fontsize="50" flexibleheight="2.5"/>
			<box flexibleheight="0.2"/>
			<tmpro text="You may acquire a card to your hand." fontsize="20" flexibleheight="2"/>
			<box flexibleheight="0.3"/>
			<tmpro text="(You still have to pay it's cost.)" fontsize="12" flexibleheight="0.5"/>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.4"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{guild}" fontsize="46" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="Draw a card." fontsize="22" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ru07_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(3),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "ru07_ind_1b",
				layout = layout1,
				trigger = uiTrigger, 
				effect = pushTargetedEffect({
					desc = "You may acquire a card to your hand.",
					min = 0,
					max = 1,
					validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable().And(isCardAffordable())),
					targetEffect = acquireTarget(0, CardLocEnum.Hand)
				}),
				cost = noCost,
				activations = singleActivation,
				check = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAffordable().And(isCardAcquirable())).count().gte(1),
				promptType = showPrompt
			}),
			createAbility({
				id = "ru07_ind_2",
				layout = layout2,
				trigger = uiTrigger, 
				effect = drawCardsWithAnimation(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { guildFaction }
			})
		}
	})
end

function cg01_ind_carddef()
	local slot = createPlayerIntExpressionSlot("CG01_slot", const(7), { endOfTurnExpiry })
	local slot2 = createPlayerIntExpressionSlot("CG01_draws", const(1), { endOfTurnExpiry })
	
	local prompt1 = createLayout({
		name = "Scrapyard Goblin",
		art = "art/T_Goblin",
		frame = "frames/Wild_Champion_CardFrame",
		xmlText = format([[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.2"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="1"/>
				<box flexiblewidth="0.2"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="1"/>
					<tmpro text="{gold_1}" fontsize="60" flexibleheight="3"/>
					<box flexibleheight="2.5"/>
					<tmpro text="For every 7 cards in your discard pile, draw a card." fontsize="20" flexibleheight="2"/>
					<box flexibleheight="1.5"/>
					<tmpro text="(Currently draws {0} cards)" fontsize="10" fontstyle="Italic" flexibleheight="1"/>
					<tmpro text="(Cards in discard pile: {1})" fontsize="10" fontstyle="Italic" flexibleheight="1"/>
				</vlayout>
			</hlayout>
		</vlayout>]], { divide(selectLoc(currentDiscardLoc).count(), 7), selectLoc(currentDiscardLoc).count() })
	})
	
	return quickCreateChampion({
		name = "CG01 Scrapyard Goblin",
		cost = 2,
		health = 4,
		isGuard = false,
		faction = 3,
		art = "art/T_Goblin",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.2"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="1"/>
				<box flexiblewidth="0.2"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="1"/>
					<tmpro text="{gold_1}" fontsize="60" flexibleheight="3"/>
					<box flexibleheight="2.5"/>
					<tmpro text="For every 7 cards in your discard pile, draw a card." fontsize="20" flexibleheight="2"/>
					<box flexibleheight="1.5"/>
					<tmpro text="(If your deck runs out and gets reshuffled when drawing, you still draw the remaining cards.)" fontsize="10" fontstyle="Italic" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cg01_ind_1",
				layout = prompt1,
				trigger = uiTrigger,
				effect = gainGoldEffect(1).seq(addSlotToPlayerEffect(currentPid, slot))
					.seq(ifElseEffect(selectLoc(currentDiscardLoc).count().gte(sumIntSlots(currentPid, "CG01_slot")), fireAbilityTriggerForTarget("customCG01Trigger").apply(selectSource()), removeSlotFromPlayerEffect(currentPid, "CG01_slot"))),
				cost = expendCost,
				activations = multipleActivations,
				promptType = showPrompt
			}),
			createAbility({
				id = "cg01_ind_1_recursion",
				trigger = abilityTrigger("customCG01Trigger"),
				effect = addSlotToPlayerEffect(currentPid, slot).seq(addSlotToPlayerEffect(currentPid, slot2))
					.seq(ifElseEffect(
						selectLoc(currentDiscardLoc).count().gte(sumIntSlots(currentPid, "CG01_slot")),
						fireAbilityTriggerForTarget("customCG01Trigger").apply(selectSource()), 
						drawCardsEffect(sumIntSlots(currentPid, "CG01_draws")).seq(removeSlotFromPlayerEffect(currentPid, "CG01_slot")).seq(removeSlotFromPlayerEffect(currentPid, "CG01_draws"))
					)),
				cost = noCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function cg02_ind_carddef()
	return quickCreateChampion({
		name = "CG02 Orcish Artisan",
		cost = 4,
		health = 4,
		isGuard = true,
		faction = 3,
		art = "art/T_Orc",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.2"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="0.8"/>
				<box flexiblewidth="0.3"/>
				<vlayout flexiblewidth="6">
					<tmpro text="{combat_3}" fontsize="65" flexibleheight="2"/>
					<tmpro text="You may discard a card. If you do, draw a card." fontsize="24" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cg02_ind_1",
				trigger = uiTrigger,
				effect = gainCombatEffect(3).seq(cycleCardsEffect(1)),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function cg03_ind_carddef()
	return quickCreateChampion({
		name = "CG03 Luddite Ogre",
		cost = 6,
		health = 5,
		isGuard = false,
		faction = 3,
		art = "avatars/ogre",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="0.2"/>
					<tmpro text="{combat_2}" fontsize="55" flexibleheight="1.4"/>
					<box flexibleheight="0.2"/>
					<tmpro text="Target opponent discards a card." fontsize="21" flexibleheight="1.5"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.8"/>
			<hlayout flexibleheight="1">
				<box flexiblewidth="0.5"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cg03_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(2).seq(oppDiscardEffect(1)),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "cg03_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function cg04_ind_carddef()
	return quickCreateAction({
		name = "CG04 Replaceable Parts",
		cost = 2,
		faction = 3,
		art = "art/T_Spell_Components",
		text = [[<vlayout>
			<box flexibleheight="1"/>
			<tmpro text="{combat_1}" fontsize="70" flexibleheight="2"/>
			<box flexibleheight="2"/>
			<tmpro text="Discard up to three cards. Then draw that many cards." fontsize="24" flexibleheight="2"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cg04_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(1).seq(cycleCardsEffect(3)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function cg05_ind_carddef()
	return quickCreateAction({
		name = "CG05 Equipment Carriage",
		cost = 2,
		faction = 3,
		art = "art/T_Heist",
		text = [[<vlayout>
			<box flexibleheight="0.7"/>
			<tmpro text="{gold_2}" fontsize="55" flexibleheight="1.5"/>
			<box flexibleheight="1.2"/>
			<tmpro text="You may play a Weapon from your discard pile." fontsize="21" flexibleheight="1.5"/>
			<box flexibleheight="0.6"/>
			<divider/>
			<box flexibleheight="0.8"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.7"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_4}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.7"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cg05_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(2).seq(pushTargetedEffect({
					desc = "You may play a Weapon from your discard pile.",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardType(weaponType)),
					targetEffect = playTarget()
				})),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cg05_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function cg06_ind_carddef()
	return quickCreateAction({
		name = "CG06 Vandalization",
		cost = 4,
		faction = 3,
		art = "art/T_Fighter_Crushing_Blow",
		text = [[<vlayout>
			<box flexibleheight="1"/>
			<tmpro text="{gold_1} {combat_5}" fontsize="55" flexibleheight="1.5"/>
			<box flexibleheight="1.7"/>
			<tmpro text="Target opponent discards a card." fontsize="24" flexibleheight="1.5"/>
			<box flexibleheight="0.9"/>
			<divider/>
			<box flexibleheight="1.4"/>
			<hlayout flexibleheight="1.4">
				<box flexiblewidth="0.7"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{gold_2}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.7"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cg06_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(5)).seq(oppDiscardEffect(1)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cg06_ind_2",
				trigger = autoTrigger, 
				effect = gainGoldEffect(2),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function rg01_ind_carddef()
	local choiceTable = {}
	choiceTable[1] = {
		effect = nullEffect(),                  
		layout = layoutCard({
			title = "Do nothing.",
			art = "art/T_Wind_Storm",
			text = "<size=120%>Do nothing."
		})
	}
	choiceTable[2] = {
		effect = drawCardsEffect(1).seq(pushTargetedEffect({
			desc = "Discard two cards.",
			min = 2,
			max = 2,
			validTargets = selectLoc(currentHandLoc),
			targetEffect = discardTarget()
		})),
		layout = layoutCard({
			title = "Draw 1, discard 2.",
			art = "art/T_Wind_Storm",
			text = "<size=120%>Draw a card. Then discard two cards."
		}),
		condition = selectLoc(currentHandLoc).count().gte(2)
	}
	
	return quickCreateChampion({
		name = "RG01 Wilburn, Impetuous Engineer",
		cost = 2,
		health = 3,
		isGuard = true,
		faction = 3,
		art = "art/T_Thief_Jewelers_Loupe",
		text = [[<vlayout>
			<box flexibleheight="0.4"/>
			<hlayout flexibleheight="6.5">
				<box flexiblewidth="0.2"/>
				<tmpro text="{expend}" fontsize="55" flexiblewidth="0.8"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="8">
					<box flexibleheight="0.4"/>
					<tmpro text="{combat_2}" fontsize="50" flexibleheight="1"/>
					<box flexibleheight="1"/>
					<tmpro text="You may draw a card." fontsize="20" flexibleheight="1"/>
					<box flexibleheight="1"/>
					<tmpro text="If you do, discard two cards." fontsize="20" flexibleheight="1"/>
					<box flexibleheight="0.3"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
			<box flexibleheight="0.5"/>
			<divider/>
			<box flexibleheight="1"/>
			<hlayout flexibleheight="2">
				<tmpro text="{wild}" fontsize="55" flexiblewidth="1.2"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="Target opponent discards a card." fontsize="20" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rg01_ind_1",
				trigger = uiTrigger,
				effect = gainCombatEffect(2).seq(pushChoiceEffect({
					choices = choiceTable
				})),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "rg01_ind_2",
				trigger = autoTrigger, 
				effect = oppDiscardEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function rg02_ind_carddef()
	local slot = createPlayerSlot({ key = "rg02_2_slot", expiry = { endOfTurnExpiry } })

	return quickCreateChampion({
		name = "RG02 Gabe, Blast Miner",
		cost = 6,
		health = 7,
		isGuard = false,
		faction = 3,
		art = "art/ancestry/dwarf",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.7"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="0.8"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="0.5"/>
					<tmpro text="Acquire a Dynamite." fontsize="23" flexibleheight="1"/>
					<box flexibleheight="0.5"/>
					<tmpro text="({scrap}: {gold_5} or {combat_7})" fontsize="23" flexibleheight="1"/>
					<box flexibleheight="0.5"/>
				</vlayout>
				<box flexiblewidth="0.8"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.5"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="1.2"/>
				<box flexiblewidth="0.8"/>
				<vlayout flexiblewidth="10">
					<tmpro text="This turn, your Dynamites have both effects combined." fontsize="20" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.7"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rg02_ind_1",
				trigger = uiTrigger,
				effect = acquireCardEffect(ti04_ind_carddef()),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "rg02_ind_2",
				trigger = autoTrigger, 
				effect = addSlotToPlayerEffect(currentPid, slot),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function rg03_ind_carddef()
	local prompt2 = createLayout({
		name = "Clockwork Colossus",
		art = "art/T_GrakStormGiant",
		frame = "frames/Wild_Champion_CardFrame",
		xmlText = [[<vlayout>
			<hlayout flexibleheight="2.2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="5">
					<tmpro text="You may discard a card. If you do, draw a card." fontsize="27" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]]
	})
	
	return quickCreateChampion({
		name = "RG03 Clockwork Colossus",
		cost = 8,
		health = 9,
		isGuard = false,
		faction = 3,
		art = "art/T_GrakStormGiant",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.2"/>
				<tmpro text="{expend}" fontsize="65" flexiblewidth="0.8"/>
				<box flexiblewidth="0.3"/>
				<vlayout flexiblewidth="6">
					<tmpro text="{combat_4}" fontsize="60" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<divider/>
			<box flexibleheight="0.5"/>
			<hlayout flexibleheight="3">
				<tmpro text="{wild}" fontsize="65" flexiblewidth="1.2"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="You may discard a card. If you do, draw a card." fontsize="24" flexibleheight="3"/>
				</vlayout>
				<box flexiblewidth="0.2"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rg03_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(4),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "rg03_ind_2",
				layout = prompt2,
				trigger = uiTrigger, 
				effect = cycleCardsEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function rg04_ind_carddef()
	return quickCreateAction({
		name = "RG04 Firebrand Sabotage",
		cost = 2,
		faction = 3,
		art = "art/T_Fire_Blast",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<tmpro text="{combat_3}" fontsize="55" flexibleheight="1.4"/>
			<box flexibleheight="0.2"/>
			<hlayout>
				<box flexiblewidth="0.2"/>
				<tmpro text="Target opponent discards a card." fontsize="21" flexiblewidth="1" flexibleheight="1.5"/>
				<box flexiblewidth="0.2"/>
			</hlayout>
			<divider/>
			<box flexibleheight="0.8"/>
			<hlayout flexibleheight="1">
				<box flexiblewidth="0.5"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_3}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rg04_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(3).seq(oppDiscardEffect(1)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "rg04_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(3),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function rg05_ind_carddef()
	return quickCreateAction({
		name = "RG05 Adamant Forging",
		cost = 4,
		faction = 3,
		art = "icons/full_armor",
		text = [[<vlayout>
			<box flexibleheight="0.4"/>
			<tmpro text="{gold_1} {combat_7}" fontsize="65" flexibleheight="2.5"/>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="0.4"/>
			<hlayout flexibleheight="2">
				<vlayout flexiblewidth="7">
					<tmpro text="When you would sacrifice this from your discard pile, play this card instead." fontsize="20" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rg05_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(7)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
			-- Second ability is done by a checker in sacrificeCardsEffect()
		}
	})
end

function rg06_ind_carddef()
	return quickCreateAction({
		name = "RG06 Workers' Uprising",
		cost = 6,
		faction = 3,
		art = "art/T_Unify_Apsara",
		text = [[<vlayout>
			<box flexibleheight="0.8"/>
			<tmpro text="{gold_2} {combat_2}" fontsize="50" flexibleheight="3"/>
			<box flexibleheight="1.2"/>
			<tmpro text="Target opponent may discard two cards. If they don't, they acquire two Golds to their hand." fontsize="16" flexibleheight="4"/>
			<box flexibleheight="0.5"/>
			<tmpro text="(This will resolve before normal discard.)" fontsize="8" fontstyle="Italic" flexibleheight="1"/>
			<box flexibleheight="0.5"/>
			<divider/>
			<box flexibleheight="1.3"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{necro}" fontsize="44" flexiblewidth="0"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="7">
					<box flexibleheight="0.2"/>
					<tmpro text="Play a Champion from your discard pile." fontsize="16" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rg06_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(2).seq(gainCombatEffect(2)).seq(createCardEffect(rg06_buff_def(), loc(oppPid, buffsPloc))),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "rg06_ind_2",
				trigger = uiTrigger, 
				effect = pushTargetedEffect({
					desc = "You may play a Champion from your discard pile.",
					min = 0,
					max = 1,
					validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardChampion()),
					targetEffect = playTarget()
				}),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { necrosFaction }
			})
		}
	})
end

function rg07_ind_carddef()
	local prompt2 = createLayout({
		name = "Streamlined Warfare",
		art = "art/T_Rally_The_Troops",
		frame = "frames/Wild_Action_CardFrame",
		xmlText = [[<vlayout>
			<hlayout>
				<tmpro text="{wild}" fontsize="50" alignment="left" flexiblewidth="0"/>
				<box flexiblewidth="0.7"/>
				<vlayout flexiblewidth="2">
					<box flexibleheight="0.4"/>
					<tmpro text="{combat_5}" fontsize="60" alignment="center" flexibleheight="0.6"/>
					<tmpro text="Draw a card." fontsize="30" alignment="left" flexibleheight="0.6"/>
					<box flexibleheight="0.4"/>
				</vlayout>
				<box flexiblewidth="0.4"/>
			</hlayout>
		</vlayout>]],
		cost = 8,
	})
	
	return quickCreateAction({
		name = "RG07 Streamlined Warfare",
		cost = 8,
		faction = 3,
		art = "art/T_Rally_The_Troops",
		text = [[<vlayout>
			<box flexibleheight="1.5"/>
			<tmpro text="{combat_5}" fontsize="55" flexibleheight="2"/>
			<box flexibleheight="1"/>
			<tmpro text="Draw a card." fontsize="24" flexibleheight="2"/>
			<box flexibleheight="0.2"/>
			<divider/>
			<box flexibleheight="2"/>
			<hlayout flexibleheight="4.5">
				<box flexiblewidth="0.7"/>
				<tmpro text="{wild}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_5}" fontsize="55" flexibleheight="1.8"/>
					<box flexibleheight="2"/>
					<tmpro text="Draw a card." fontsize="24" flexibleheight="1.8"/>
				</vlayout>
				<box flexiblewidth="0.7"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rg07_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(5).seq(drawCardsEffect(1)),	
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "rg07_ind_2",
				layout = prompt2,
				trigger = uiTrigger, 
				effect = gainCombatEffect(5).seq(drawCardsEffect(1)),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { wildFaction }
			})
		}
	})
end

function cr01_ind_carddef()
	return quickCreateChampion({
		name = "CR01 Jeweler's Apprentice",
		cost = 2,
		health = 3,
		isGuard = true,
		faction = 4,
		art = "art/T_Wizard_Alchemist_S_Stone",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.2"/>
				<tmpro text="{expend}" fontsize="60" flexiblewidth="0.8"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="1"/>
					<tmpro text="Acquire a Ruby ({gold_2}) to your hand." fontsize="21" flexibleheight="1"/>
					<box flexibleheight="1.5"/>
					<tmpro text="You may sacrifice a card from your hand or discard pile." fontsize="21" flexibleheight="1"/>
					<box flexibleheight="1"/>
				</vlayout>
				<box flexiblewidth="0.5"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cr01_ind_1",
				trigger = uiTrigger,
				effect = acquireCardEffect(ruby_carddef(), currentHandLoc).seq(pushTargetedEffect({
					desc = "You may sacrifice a card from your hand or discard pile.",
					min = 0,
					max = 1,
					validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
					targetEffect = cSacTarget()
				})),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function cr02_ind_carddef()
	return quickCreateChampion({
		name = "CR02 Delirious Chanter",
		cost = 4,
		health = 5,
		isGuard = false,
		faction = 4,
		art = "avatars/chanting_cultist",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="65" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_2}" fontsize="60" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="3">
				<box flexiblewidth="0.5"/>
				<tmpro text="{necro}" fontsize="65" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="60" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cr02_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(2),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			}),
			createAbility({
				id = "cr02_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { necrosFaction }
			})
		}
	})
end

function cr03_ind_carddef()
	return quickCreateAction({
		name = "CR03 Chemical Synthesis",
		cost = 2,
		faction = 4,
		art = "art/treasures/T_Green_Potions_Large",
		text = [[<vlayout>
			<tmpro text="{gold_2} {combat_5}" fontsize="75" flexibleheight="2"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cr03_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(2).seq(gainCombatEffect(5)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function cr04_ind_carddef()
	local prompt3 = createLayout({
		name = "Flash Bomb",
		art = "art/T_Fireball",
		frame = "frames/Necros_Action_CardFrame",
		xmlText = [[<vlayout>
			<hlayout flexibleheight="2.2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{guild}" fontsize="60" flexiblewidth="0"/>
				<box flexiblewidth="1"/>
				<vlayout flexiblewidth="5">
					<tmpro text="Stun target Champion" fontsize="27" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]]
	})
	
	return quickCreateAction({
		name = "CR04 Flash Bomb",
		cost = 2,
		faction = 4,
		art = "art/T_Fireball",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="46" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<box flexibleheight="0.5"/>
			<divider/>
			<box flexibleheight="0.7"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{necro}" fontsize="50" flexiblewidth="0"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="46" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
			<box flexibleheight="0.5"/>
			<divider/>
			<box flexibleheight="0.7"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{guild}" fontsize="50" flexiblewidth="0"/>
				<box flexiblewidth="0.5"/>
				<vlayout flexiblewidth="5">
					<tmpro text="Stun target Champion" fontsize="22" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cr04_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cr04_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { necrosFaction }
			}),
			createAbility({
				id = "cr04_ind_3",
				layout = prompt3,
				trigger = uiTrigger, 
				effect = stunChampionsEffect(1),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = showPrompt,
				allyFactions = { guildFaction }
			})
		}
	})
end

function cr05_ind_carddef()
	return quickCreateAction({
		name = "CR05 Darkflame Boiler",
		cost = 4,
		faction = 4,
		art = "art/T_Sweltering_Heat",
		text = [[<vlayout>
			<box flexibleheight="0.7"/>
			<tmpro text="{combat_3}" fontsize="55" flexibleheight="1"/>
			<box flexibleheight="1.2"/>
			<tmpro text="You may sacrifice a card from your hand or discard pile. If you sacrifice from your hand this way, gain {combat_4}." fontsize="16" flexibleheight="1.5"/>
			<box flexibleheight="0.7"/>
			<divider/>
			<box flexibleheight="0.7"/>
			<hlayout flexibleheight="1.5">
				<box flexiblewidth="0.5"/>
				<tmpro text="{scrap}" fontsize="55" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="Draw a card." fontsize="22" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cr05_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(3).seq(pushTargetedEffect({
					desc = "You may sacrifice a card from your hand or discard pile.",
					min = 0,
					max = 1,
					validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
					targetEffect = ifElseTarget(
						isCardAtLoc(handPloc),
						cSacTarget().seq(gainCombatEffect(4)),
						cSacTarget()
					)
				})),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cr05_ind_2",
				trigger = uiTrigger,
				effect = drawCardsEffect(1),
				cost = sacrificeSelfCost,
				activations = singleActivation,
				promptType = showPrompt,
				layout = createLayout({
					name = "CR05 Darkflame Boiler",
					art = "art/T_Sweltering_Heat",
					frame = "frames/Necros_Action_CardFrame",
					xmlText = [[<vlayout>
						<box flexibleheight="0.2"/>
						<hlayout flexibleheight="1.5">
							<box flexiblewidth="1"/>
							<tmpro text="{scrap}" fontsize="60" flexiblewidth="0"/>
							<vlayout flexiblewidth="7">
								<tmpro text="Draw a card." fontsize="26" flexibleheight="2"/>
							</vlayout>
						</hlayout>
					</vlayout>]],
					cost = 4,
				})
			})
		}
	})
end

function cr06_ind_carddef()
	return quickCreateAction({
		name = "CR06 Void Resonator",
		cost = 6,
		faction = 4,
		art = "art/T_Deep_Channel",
		text = [[<vlayout>
			<box flexibleheight="0.7"/>
			<tmpro text="{combat_5}" fontsize="60" flexibleheight="1.2"/>
			<box flexibleheight="0.5"/>
			<tmpro text="Draw a card." fontsize="24" flexibleheight="1.5"/>
			<divider/>
			<box flexibleheight="0.5"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="1"/>
				<tmpro text="{necro}" fontsize="64" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_5}" fontsize="60" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "cr06_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(5).seq(drawCardsEffect(1)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "cr06_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(5),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { necrosFaction }
			})
		}
	})
end

function rr01_ind_carddef()
	local input = {
		name = "Alene, Stalwart Cultist",
		cost = 2,
		health = 2,
		isGuard = true,
		art = "art/T_Evangelize",
		text = [[<vlayout>
			<box flexibleheight="0.4"/>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_3}" fontsize="65" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<box flexibleheight="0.4"/>
			<divider/>
			<box flexibleheight="0.8"/>
			<hlayout flexibleheight="3">
				<vlayout flexiblewidth="5">
					<tmpro text="When you play a {necro} card while this is in your discard pile, put this card into play expended." fontsize="20" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rr01_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(3),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
			-- The second ability is triggered by a global buff that checks for this card's id.
			-- See rr01_tracker_def()
		}
	}
	
	local cardLayout = createLayout({
		name = input.name,
		art = input.art,
		frame = "frames/Necros_Champion_CardFrame",
		xmlText = input.text,
		health = input.health,
		isGuard = input.isGuard,
		cost = input.cost,
		
	})
	
	return createChampionDef({
		id = "rr01",
		name = input.name,
		acquireCost = input.cost,
		types = {},
		layout = cardLayout,
		health = input.health,
		isGuard = input.isGuard,
		abilities = input.abilities,
		factions = { necrosFaction }
	})
end

function rr02_ind_carddef()
	return quickCreateChampion({
		name = "RR02 Cult Reformer",
		cost = 6,
		health = 5,
		isGuard = true,
		faction = 4,
		art = "art/T_Cleric_Redeemed_Ruinos",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.3"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="0.7"/>
				<box flexiblewidth="0.6"/>
				<vlayout flexiblewidth="6">
					<box flexibleheight="0.4"/>
					<tmpro text="{combat_3}" fontsize="65" flexibleheight="1"/>
					<box flexibleheight="0.4"/>
					<tmpro text="You may sacrifice a card from your hand or discard pile." fontsize="22" flexibleheight="1.5"/>
				</vlayout>
				<box flexiblewidth="0.4"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rr02_ind_1",
				trigger = uiTrigger,
				effect = gainCombatEffect(3).seq(sacrificeCardsEffect(1)),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function rr03_ind_carddef()
	return quickCreateChampion({
		name = "RR03 Bag'thir, Underworld Baron",
		cost = 8,
		health = 7,
		isGuard = false,
		faction = 4,
		art = "art/T_HalfDemon_AntonisPapantoniou",
		text = [[<vlayout>
			<hlayout flexibleheight="4">
				<box flexiblewidth="0.5"/>
				<tmpro text="{expend}" fontsize="70" flexiblewidth="0"/>
				<vlayout flexiblewidth="5">
					<tmpro text="{combat_4}" fontsize="65" flexibleheight="2"/>
				</vlayout>
			</hlayout>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="3">
				<vlayout flexiblewidth="5">
					<tmpro text="Whenever another friendly Champion is stunned, this gets +2{shield} until this leaves play." fontsize="18" flexibleheight="2"/>
				</vlayout>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rr03_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(4),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
			-- The second ability is triggered by a global buff that checks for this card's id.
			-- See rr03_tracker_def()
		}
	})
end

function rr04_ind_carddef()
	local choiceTable = {}
	choiceTable[1] = {
		effect = nullEffect(),                  
		layout = layoutCard({
			title = "Do nothing.",
			art = "art/T_Wind_Storm",
			text = "<size=120%>Do nothing."
		})
	}
	choiceTable[2] = {
		effect = gainGoldEffect(3).seq(gainHealthEffect(-6)),
		condition = getPlayerHealth(currentPid).gte(7),
		layout = layoutCard({
			title = "Take action",
			art = "art/T_Wind_Storm",
			text = "<size=300%><sprite name=\"gold_3\"> <sprite name=\"health_-6\">"
		})
	}

	return quickCreateAction({
		name = "RR04 Life Tap",
		cost = 2,
		faction = 4,
		art = "icons/life_siphon",
		text = [[<vlayout>
			<box flexibleheight="1"/>
			<tmpro text="Draw a card." fontsize="28" flexibleheight="2"/>
			<box flexibleheight="0.6"/>
			<tmpro text="You may take {gold_3} {health_-6}." fontsize="28" flexibleheight="2"/>
			<box flexibleheight="1"/>
			<divider/>
			<box flexibleheight="0.6"/>
			<hlayout flexibleheight="4">
				<box flexiblewidth="1"/>
				<tmpro text="{necro}" fontsize="60" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_4}" fontsize="55" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rr04_ind_1",
				trigger = autoTrigger,
				effect = drawCardsEffect(1).seq(pushChoiceEffect({
					choices = choiceTable
				})),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "rr04_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(4),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { necrosFaction }
			})
		}
	})
end

function rr05_ind_carddef()
	return quickCreateAction({
		name = "RR05 Creative Destruction",
		cost = 4,
		faction = 4,
		art = "art/T_Crushing_Strength",
		text = [[<vlayout>
			<box flexibleheight="1"/>
			<tmpro text="{combat_6}" fontsize="70" flexibleheight="1.5"/>
			<box flexibleheight="0.5"/>
			<tmpro text="Sacrifice up to two cards from your hand." fontsize="24" flexibleheight="1.5"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rr05_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(6).seq(pushTargetedEffect({
					desc = "Sacrifice up to two card from your hand.",
					min = 0,
					max = 2,
					validTargets = selectLoc(currentHandLoc),
					targetEffect = cSacTarget()
				})),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function rr06_ind_carddef()
	return quickCreateAction({
		name = "RR06 Malicious Tithe",
		cost = 6,
		faction = 4,
		art = "art/T_Tithe_Priest",
		text = [[<vlayout>
			<box flexibleheight="0.2"/>
			<tmpro text="Draw a card." fontsize="19" flexibleheight="2"/>
			<box flexibleheight="0.2"/>
			<tmpro text="Each opponent acquires a Gold." fontsize="19" flexibleheight="2"/>
			<box flexibleheight="0.4"/>
			<divider/>
			<box flexibleheight="0.9"/>
			<hlayout flexibleheight="4">
				<box flexiblewidth="1"/>
				<tmpro text="{necro}" fontsize="50" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{combat_6}" fontsize="46" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
			<box flexibleheight="0.7"/>
			<divider/>
			<box flexibleheight="0.9"/>
			<hlayout flexibleheight="4">
				<box flexiblewidth="1"/>
				<tmpro text="{imperial}" fontsize="50" flexiblewidth="0"/>
				<vlayout flexiblewidth="7">
					<tmpro text="{health_6}" fontsize="46" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="1"/>
			</hlayout>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rr06_ind_1",
				trigger = autoTrigger,
				effect = drawCardsEffect(1).seq(oppAcquireCardEffect(gold_carddef())),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			}),
			createAbility({
				id = "rr06_ind_2",
				trigger = autoTrigger, 
				effect = gainCombatEffect(6),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { necrosFaction }
			}),
			createAbility({
				id = "rr06_ind_3",
				trigger = autoTrigger, 
				effect = gainHealthEffect(6),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt,
				allyFactions = { imperialFaction }
			})
		}
	})
end

function rr07_ind_carddef()
	return quickCreateAction({
		name = "RR07 Ritual of Brass Moon",
		cost = 8,
		faction = 4,
		art = "icons/growing_flame",
		text = [[<vlayout>
			<box flexibleheight="0.5"/>
			<tmpro text="Sacrifice up to two cards from your hand or discard pile." fontsize="20" flexibleheight="1.5"/>
			<box flexibleheight="0.5"/>
			<tmpro text="Acquire a Voidfiend ({combat_3}, 4{shield}) to your hand." fontsize="20" flexibleheight="1.5"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "rr07_ind_1",
				trigger = autoTrigger,
				effect = pushTargetedEffect({
					desc = "Sacrifice up to two cards from your hand or discard pile.",
					min = 0,
					max = 2,
					validTargets = selectLoc(currentHandLoc).union(selectLoc(currentDiscardLoc)),
					targetEffect = cSacTarget().seq(acquireCardEffect(tc01_ind_carddef(), currentHandLoc))
				}),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function ti01_ind_carddef()
	return quickCreateItem({
		name = "TI01 Copper Coin",
		cost = 0,
		types = { coinType, currencyType },
		faction = 0,
		art = "icons/thief_pilfer",
		text = [[<vlayout>
			<tmpro text="{gold_1}" fontsize="60" flexibleheight="2"/>
			<tmpro text="You may draw a card. If you do, discard a card." fontsize="25" flexibleheight="2"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ti01_ind_1",
				trigger = autoTrigger, 
				effect = gainGoldEffect(1).seq(redrawCardsEffect(1)),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt
			})
		}
	})
end

function ti02_ind_carddef()
	return quickCreateItem({
		name = "TI02 Snake Oil",
		cost = 0,
		types = {},
		faction = 0,
		art = "art/T_Elixir_Of_Concentration",
		text = [[<vlayout>
			<tmpro text="{combat_1} {health_3}" fontsize="80" flexibleheight="2"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ti02_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(1).seq(gainHealthEffect(3)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function ti03_ind_carddef()
	return quickCreateItem({
		name = "TI03 Mithril Pickaxe",
		cost = 0,
		types = { weaponType, meleeWeaponType, toolType },
		faction = 0,
		art = "art/ancestry/pick",
		text = [[<vlayout>
			<tmpro text="{gold_2} {combat_5}" fontsize="75" flexibleheight="2"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ti03_ind_1",
				trigger = autoTrigger,
				effect = gainGoldEffect(2).seq(gainCombatEffect(5)),
				cost = noCost,
				activations = singleActivation,
				promptType = noPrompt
			})
		}
	})
end

function ti04_ind_carddef()
	local prompt1 = createLayout({
		name = "Dynamite",
		art = "art/T_Explosive_Fireball",
		frame = "frames/Generic_CardFrame",
		xmlText = [[<hlayout>
			<box flexiblewidth="1.5"/>
			<tmpro text="{scrap}" fontsize="70" flexiblewidth="0"/>
			<box flexiblewidth="3"/>
			<tmpro text="{gold_5}" fontsize="65" flexiblewidth="3"/>
			<tmpro text="or" fontsize="40" flexiblewidth="3"/>
			<tmpro text="{combat_7}" fontsize="65" flexiblewidth="3"/>
			<box flexiblewidth="1"/>	
		</hlayout>]]
	})
	
	local prompt2 = createLayout({
		name = "Dynamite",
		art = "art/T_Explosive_Fireball",
		frame = "frames/Generic_CardFrame",
		xmlText = [[<vlayout>
			<box flexibleheight="0.5"/>
			<tmpro text="(Effect boosted by Gabe, Blast Miner)" fontsize="16" fontstyle="Italic" flexibleheight="2"/>
			<hlayout flexibleheight="8">
				<box flexiblewidth="1.5"/>
				<tmpro text="{scrap}" fontsize="70" flexiblewidth="0"/>
				<box flexiblewidth="3"/>
				<tmpro text="{gold_5}" fontsize="65" flexiblewidth="3"/>
				<box flexiblewidth="1"/>
				<tmpro text="{combat_7}" fontsize="65" flexiblewidth="3"/>
				<box flexiblewidth="1"/>	
			</hlayout>
		</vlayout>]]
	})
	
	local choiceTable = {}	
	choiceTable[1] = {
		effect = gainGoldEffect(5),                  
		layout = layoutCard({
			title = "Dynamite",
			art = "art/T_Wind_Storm",
			text = "<size=300%><sprite name=\"gold_5\">"
		})
	}
	choiceTable[2] = {
		effect = gainCombatEffect(7),                  
		layout = layoutCard({
			title = "Dynamite",
			art = "art/T_Wind_Storm",
			text = "<size=300%><sprite name=\"combat_7\">"
		})
	}
	
	return quickCreateItem({
		name = "TI04 Dynamite",
		cost = 0,
		types = { weaponType, toolType },
		faction = 0,
		art = "art/T_Explosive_Fireball",
		text = [[<hlayout>
			<box flexiblewidth="1.5"/>
			<tmpro text="{scrap}" fontsize="70" flexiblewidth="0"/>
			<box flexiblewidth="3"/>
			<tmpro text="{gold_5}" fontsize="65" flexiblewidth="3"/>
			<tmpro text="or" fontsize="40" flexiblewidth="3"/>
			<tmpro text="{combat_7}" fontsize="65" flexiblewidth="3"/>
			<box flexiblewidth="1"/>	
		</hlayout>]],
		abilities = {
			createAbility({
				id = "ti04_ind_1",
				layout = prompt1,
				trigger = uiTrigger,
				effect = pushChoiceEffect({
					choices = choiceTable
				}),
				cost = sacrificeSelfCost,
				activations = singleActivation,
				check = hasPlayerSlot(currentPid, "rg02_2_slot").invert(),
				promptType = noPrompt
			}),
			createAbility({
				id = "ti04_ind_2",
				layout = prompt2,
				trigger = uiTrigger,
				effect = gainGoldEffect(5).seq(gainCombatEffect(7)),
				cost = sacrificeSelfCost,
				activations = singleActivation,
				check = hasPlayerSlot(currentPid, "rg02_2_slot"),
				promptType = showPrompt
			})
		}
	})
end

function tc01_ind_carddef()
	return quickCreateChampion({
		name = "TC01 Voidfiend",
		types = { demonType },
		cost = 0,
		health = 4,
		isGuard = false,
		faction = 0,
		art = "art/T_Demon",
		text = [[<hlayout>
			<tmpro text="{expend}" fontsize="70" flexiblewidth="2"/>
			<box flexiblewidth="1"/>
			<tmpro text="{combat_3}" fontsize="65" flexiblewidth="3"/>
			<box flexiblewidth="2"/>
		</hlayout>]],
		abilities = {
			createAbility({
				id = "tc01_ind_1",
				trigger = autoTrigger,
				effect = gainCombatEffect(3),
				cost = expendCost,
				activations = multipleActivations,
				promptType = noPrompt
			})
		}
	})
end

function ti05_ind_carddef()
	return quickCreateItem({
		name = "TI05 Antique Javelin",
		cost = 0,
		types = { weaponType },
		faction = 0,
		art = "art/T_Fighter_Jagged_Spear",
		text = [[<vlayout>
			<tmpro text="{combat_1}" fontsize="70" flexibleheight="2"/>
			<tmpro text="You may discard a card. If you do, draw a card." fontsize="25.35" flexibleheight="2"/>
		</vlayout>]],
		abilities = {
			createAbility({
				id = "ti05_ind_1",
				trigger = autoTrigger, 
				effect = gainCombatEffect(1).seq(cycleCardsEffect(1)),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt
			})
		}
	})
end

function fire_gem_carddef()
	local cardLayout = createLayout({
		name = "Fuel Stockpile",
		art = "icons/wizard_flame_burst_OLD",
		frame = "frames/Coop_Campaign_CardFrame",
		xmlText = [[<vlayout>
			<box flexibleheight="0.4"/>
			<tmpro text="{gold_2} {health_2}" fontsize="52" flexibleheight="1"/>
			<box flexibleheight="0.4"/>
			<divider/>
			<box flexibleheight="0.2"/>
			<hlayout flexibleheight="2">
				<box flexiblewidth="0.5"/>
				<tmpro text="{scrap}" fontsize="55" flexiblewidth="0"/>
				<box flexiblewidth="0.8"/>
				<vlayout flexiblewidth="5">
					<box flexibleheight="0.5"/>
					<tmpro text="{combat_3}" fontsize="45" flexibleheight="2"/>
					<box flexibleheight="1"/>
					<tmpro text="You may sacrifice a card from market row." fontsize="18" flexibleheight="2"/>
				</vlayout>
				<box flexiblewidth="0.8"/>
			</hlayout>
		</vlayout>]],
		cost = 3,
	})

	return createItemDef({
		id = "fire_gem",
		name = "FG01 Pile of Coal",
		types = {},
		acquireCost = 3,
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "fg01_ind_1",
				trigger = autoTrigger, 
				effect = gainGoldEffect(2).seq(gainHealthEffect(2)),
				cost = noCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt
			}),
			createAbility({
				id = "fg01_ind_2",
				trigger = uiTrigger, 
				effect = gainCombatEffect(3).seq(sacrificeMarketEffect(1)),
				cost = sacrificeSelfCost,
				activations = singleActivation,
				check = constBoolExpression(true),
				promptType = noPrompt
			})
		},
		factions = {}
	})
end



function getDebugHand()
	return {
		{ qty=2, card=ru02_ind_carddef() },
		{ qty=2, card=cg04_ind_carddef() },
		{ qty=1, card=test_card_carddef() },
	}
end

function getTradeDeck()
	return {
		{ qty = 2, cardId = "cy01" },
		{ qty = 3, cardId = "cy02" },
		{ qty = 3, cardId = "cy03" },
		{ qty = 3, cardId = "cy04" },
		{ qty = 2, cardId = "cy05" },
		{ qty = 3, cardId = "cy06" },
		{ qty = 1, cardId = "ry01" },
		{ qty = 2, cardId = "ry02" },
		{ qty = 1, cardId = "ry03" },
		{ qty = 1, cardId = "ry04" },
		{ qty = 2, cardId = "ry05" },
		{ qty = 1, cardId = "ry06" },
		{ qty = 1, cardId = "ry07" },
		{ qty = 3, cardId = "cu01" },
		{ qty = 2, cardId = "cu02" },
		{ qty = 3, cardId = "cu03" },
		{ qty = 3, cardId = "cu04" },
		{ qty = 2, cardId = "cu05" },
		{ qty = 3, cardId = "cu06" },
		{ qty = 2, cardId = "ru01" },
		{ qty = 1, cardId = "ru02" },
		{ qty = 1, cardId = "ru03" },
		{ qty = 1, cardId = "ru04" },
		{ qty = 1, cardId = "ru05" },
		{ qty = 2, cardId = "ru06" },
		{ qty = 1, cardId = "ru07" },
		{ qty = 2, cardId = "cg01" },
		{ qty = 3, cardId = "cg02" },
		{ qty = 3, cardId = "cg03" },
		{ qty = 3, cardId = "cg04" },
		{ qty = 2, cardId = "cg05" },
		{ qty = 3, cardId = "cg06" },
		{ qty = 1, cardId = "rg01" },
		{ qty = 1, cardId = "rg02" },
		{ qty = 1, cardId = "rg03" },
		{ qty = 2, cardId = "rg04" },
		{ qty = 2, cardId = "rg05" },
		{ qty = 1, cardId = "rg06" },
		{ qty = 1, cardId = "rg07" },
		{ qty = 2, cardId = "cr01" },
		{ qty = 3, cardId = "cr02" },
		{ qty = 3, cardId = "cr03" },
		{ qty = 3, cardId = "cr04" },
		{ qty = 3, cardId = "cr05" },
		{ qty = 2, cardId = "cr06" },
		{ qty = 1, cardId = "rr01" },
		{ qty = 2, cardId = "rr02" },
		{ qty = 1, cardId = "rr03" },
		{ qty = 2, cardId = "rr04" },
		{ qty = 1, cardId = "rr05" },
		{ qty = 1, cardId = "rr06" },
		{ qty = 1, cardId = "rr07" }
	}
end

local registerList = {
	cy01_ind_carddef(),
	cy02_ind_carddef(),
	cy03_ind_carddef(),
	cy04_ind_carddef(),
	cy05_ind_carddef(),
	cy06_ind_carddef(),
	ry01_ind_carddef(),
	ry02_ind_carddef(),
	ry03_ind_carddef(),
	ry04_ind_carddef(),
	ry05_ind_carddef(),
	ry06_ind_carddef(),
	ry07_ind_carddef(),
	cu01_ind_carddef(),
	cu02_ind_carddef(),
	cu03_ind_carddef(),
	cu04_ind_carddef(),
	cu05_ind_carddef(),
	cu06_ind_carddef(),
	ru01_ind_carddef(),
	ru02_ind_carddef(),
	ru03_ind_carddef(),
	ru04_ind_carddef(),
	ru05_ind_carddef(),
	ru06_ind_carddef(),
	ru07_ind_carddef(),
	cg01_ind_carddef(),
	cg02_ind_carddef(),
	cg03_ind_carddef(),
	cg04_ind_carddef(),
	cg05_ind_carddef(),
	cg06_ind_carddef(),
	rg01_ind_carddef(),
	rg02_ind_carddef(),
	rg03_ind_carddef(),
	rg04_ind_carddef(),
	rg05_ind_carddef(),
	rg06_ind_carddef(),
	rg07_ind_carddef(),
	cr01_ind_carddef(),
	cr02_ind_carddef(),
	cr03_ind_carddef(),
	cr04_ind_carddef(),
	cr05_ind_carddef(),
	cr06_ind_carddef(),
	rr01_ind_carddef(),
	rr02_ind_carddef(),
	rr03_ind_carddef(),
	rr04_ind_carddef(),
	rr05_ind_carddef(),
	rr06_ind_carddef(),
	rr07_ind_carddef(),
	fire_gem_carddef()
}

local convertedList = {}

for _, item in ipairs(registerList) do
    table.insert(convertedList, { qty = 1, card = item })
end
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

function setupGame(g)
	registerCards(g, registerList)
    standardSetup(g, {
        -- script description - displayed in in-game menu
        description = "Hero Realms: Industrialization\nCustom market mod",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
		tradeDeckExceptions = getTradeDeck(),
		noTradeDeck = true,
        centerRow = {}, 
        players = { 
            {
                id = plid1,
                init = {
                    fromEnv = plid1
                },
                cards = {
					--hand = getDebugHand(),
					--deck = convertedList,
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP1"),
						table.unpack(getStartBuffs())
                    }
                }
            },
            {
                id = plid2,
                --isAi = true,
                init = {
					fromEnv = plid2
				},
                cards = {
					--hand = getDebugHand(),
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        fatigueCount(40, 1, "FatigueP2"),
						table.unpack(getStartBuffs())
                    }
                }
            }
        }
    })
end

-- more info on this later
function endGame(g) 
end


function setupMeta(meta)
    meta.name = "hero_realms_industrialization_v1"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Program Files (x86)/Steam/steamapps/common/Hero Realms/hr_Data/hassu/hero_realms_industrialization_v1.lua"
     meta.features = {
}

end