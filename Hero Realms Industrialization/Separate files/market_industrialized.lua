require 'herorealms'
require 'decks'
require 'stdlib'
require 'stdcards'
require 'hardai'
require 'mediumai'
require 'easyai'

mergeFile userkaffes_utility_functions.lua
mergeFile spec_utility_functions.lua
mergeFile carddefs.lua
mergeFile override_defs.lua

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
    meta.name = "market_industrialized"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Program Files (x86)/Steam/steamapps/common/Hero Realms/hr_Data/hassu/merger-input-folder/market_industrialized.lua"
     meta.features = {
}

end