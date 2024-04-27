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