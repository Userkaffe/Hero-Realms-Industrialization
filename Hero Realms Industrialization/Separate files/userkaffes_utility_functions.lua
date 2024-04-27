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