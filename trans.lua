-- MAINTENANCE: Whenever a new Workspace path is used anywhere in this script,
-- add it to WORLD_KEEP or PLOT_KEEP below (unless its subtree is already kept).
-- Workspace auto deletion and Run once must never delete paths the script uses.
local scriptLoadedAt = os.time()

local CONFIG = {
    General = {
        DeleteOtherPlots = true,
        WorkspaceCleanupEnabled = false,
        LoadTimeout = math.huge, -- Unlimited waits; retry reports are configured under Logging.
        RetryInterval = 1,
        SettleTime = 0.75,
        StartupTeleportClickInterval = 1,
        StartupTeleportMinDistance = 10,
        ScanPoll = 0.1,
        WaitPoll = 0.05,
        ButtonDebounce = 0.25,
        DefaultClickEvent = "MouseButton1Click",
    },
    Trade = {
        -- Add Content.ItemName.Text values to each list (case-insensitive); each preset gets its own button.
        TradePreset = "Preset-1",
        ["trade-preset"] = {
            -- Dropdown order follows this list; move whole entries to reorder.
            { Name = "for-daily", Items = {"Gems", "Summon Scroll", "Enchanted Dice", "Violet Berserker", "Space Overlord", "Blue Flame Fighter", "Pirate King", "Marked Rival", "Prospector's Bottle II", "Mutation Luck Potion III", "Haste Potion II", "Unearth Elixir II", "Summon Luck Potion", "Regrowth Potion", "Haste Potion" } },
            { Name = "index", Items = {
               "Ignis Crimson",
               "King Biku",
               "King Biku Shiny",
               "Sandy Bag",
               "Heart Surgeon",
               "Lazy Justice",
               "Cursed Ring",
               "Hawk Eye Blade",
               "Iron Fist Marine",
               "Sorcerer Killer",
               "Quake Captain",
               "Bounce Brawler",
               "Ten Tails Host",
               "Baryon Chakra",
               "Sixth Panther",
               "Beast Scholar",
               "Earring Fusion",
               "Perfect Lifeform",
               "Kid Fusion",
               "Tea Party Queen",
               "Clown Emperor",
               "Cat Burglar",
               "Space Overlord",
               "Violet Berserker"
            } },
        },
        TradeBagPoll = 1,
        TradePresetItemDelay = 0.05, -- Between cards and around the Track click.
        TradeTrackRightInset = 20, -- Click this many pixels inside the Track right edge.
        TradeTrackRetry = 1, TradeMaxAmount = 999,
        TradeAddConfirmTimeout = 5, TradeAddPoll = 0.1,
        ConsoleLogs = true, VerboseLogs = false, LogRepeatInterval = 5,
        TradePoll = 0.5, TradeClickInterval = 1, DefaultClickEvent = "MouseButton1Click",
    },
    DailyRewards = {
        DefaultSpinEnabled = true,
        DefaultRedeemEnabled = true,
        SpinInterval = 24 * 60 * 60 + 10,
        CodeDelay = 2,
        Codes = { "Hallowkeep", "Moonrise", "Feasts", "ONANDON", "ACES", "AZURE" },
    },
    Flow = {

        DefaultMasterEnabled = false,
        DefaultStages = {
            sell = true,
            pickaxe = true,
            upgrades = true,
            upgradingOldUnit = true,
            unlockSlots = true,
            units = true,
            mutation = true,
            upgradingUnit = true,
            cycleEnd = true,
        },

        Order = { "sell", "pickaxe", "upgrades", "upgradingOldUnit", "unlockSlots", "units", "mutation", "upgradingUnit", "cycleEnd" },
        StageDelay = 0.75,
        CycleDelay = 20,
    },
    Sell = {
        TeleportDelay = 0.75,
        ChestDelay = 0.5,
        StandDelay = 0.25,
        PromptHold = 0.05,
        PromptDelay = 0.15,
        ShopTimeout = math.huge,
        ShopDelay = 0.15,
        SelectAllDelay = 0.3,
        SellDelay = 0.5,
        ClickDelay = 0.03,
        Poll = 0.02,
        StandDistance = 8,
        StandHeight = 4,
        CameraHeight = 2,
    },
    Pickaxe = {

        DefaultMaxPerID = 8,
        UnlimitedBestPickaxe = false,
        WaitingClickDelay = 2,
        ShopTeleportDelay = 0.5,
        MinimumPromptHold = 0.05,
        PromptHoldPadding = 0.05,
        StandDistance = 4,
        StandHeight = 2,
    },
    Upgrades = {
        DiscordWebhookUrl = "https://discord.com/api/webhooks/1568681244340920331/aRrPlNNswoFe-a5VzDDf4IcwCuqbjePGpbWs1zmlejxj_j8QBXn3Nu0DqHeIB6MuTiHH",
        SelectCurrentZone = true,
        SelectNextZone = true,
        RequestDelay = 0.35,
        RowScaleTolerance = 0.0001,

        NodeCategories = {
            Deposits = "NodeCount",
            Luck = "Luck",
            Density = "NodeLevel",
            Yield = "OreYield",
            Fracture = "NodeHealth",
            Unearth = "Unearth",
            Refine = "Refine",
            Force = "Force",
            Prospect = "Prospect",
            Regrowth = "Regrowth",
            Overdrive = "Crit",
            Tempo = "Tempo",
            Motherlode = "Lode",
            Windfall = "Windfall",
            Assay = "Assay",
            Awakening = "Awaken",
            CoreTap = "CoreTap",
            CoreSlot = "CoreSlot",
            Colossus = "BigNode"
        },
    },
    HotbarUpgrade = {
        DamageTargetLevel = 200,
        IdentitySettleTime = 0.2,
    },
    Units = {
        SequenceCooldown = 5 * 60,
        UpgradeRequestDelays = {
            Damage = 0.05,
            Speed = 0.05,
            MineSpeed = 0.05,
        },
        StatUpgrade = {
            MinimumDamageLevel = 11,
            GreenColor = Color3.fromRGB(38, 148, 84),
            TeleportHeight = 3,
            TeleportDelay = 0.05,
            AfterUpgradeClickDelay = 0.05,
            PanelSettleTime = 0.05,
            BeforeExitDelay = 0.05,
        },
        FinalEquipMode = "RequiredUnits",

 RequiredByZone = {
            Z1 = {
                DisplayName = "The Underground",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 0,
                    Rainbow = 0,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 0, Names = {} },
            Z2 = {
                DisplayName = "Crystal Caves",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 0,
                    Rainbow = 0,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 0, Names = {} },
            Z3 = {
                DisplayName = "Magma Hollows",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 0,
                    Rainbow = 0,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 0, Names = {} },
            Z4 = {
                DisplayName = "Ancient Ruins",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 1,
                    Rainbow = 0,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8, Names = {"Whale Island Kid", "Ant King", "Awakened Shrine King"} },
            Z5 = {
                DisplayName = "Voidreach",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 5,
                    Rainbow = 1,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8,
                Names = { "Makine", "Demon Cyborg", "Noon Pride", "Serious Baldy"},
            },
            Z6 = {
                DisplayName = "Starwell",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 5,
                    Rainbow = 1,
                    Frozen = 2,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8,
                Names = { "Petal Storm Noble", "Hypnosis Usurper", "Almighty Quincy King" },
            },
            Z7 = {
                DisplayName = "Dawnvault",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 5,
                    Rainbow = 1,
                    Frozen = 2,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8,
                Names = { "Namek Hero (Future)", "Fieren", "Zino", "Perfected Instinct" },
            },
            Z8 = {
                DisplayName = "Sunfall Crater",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 5,
                    Rainbow = 1,
                    Frozen = 2,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8,
                Names = { "Witch of Greed", "Forbidden Librarian", "One Arm Pirates (Prime)", "Golden Gate King" },
            },
            Z9 = {
                DisplayName = "Stillstorm",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 5,
                    Rainbow = 0,
                    Frozen = 3,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8,
                Names = {"Royal Guard", "Child The Liar Shiny", "Silver Spirit Princess"},
            },
            Z10 = {
                DisplayName = "Worldheart",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 4,
                    Rainbow = 0,
                    Frozen = 4,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8,
                Names = { "Vampire Emperor", "Martial Demon", "King Of Namek" },
            },
            Z11 = {
                DisplayName = "Soulforge",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 4,
                    Rainbow = 0,
                    Frozen = 4,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 8,
                Names = { "Lign", "Iron Chronicles Shiny", "Ignis Crimson", "King Biku", "King Biku Shiny", "Sandy Bag" },
            },
            Z12 = {
                DisplayName = "Hallowkeep",
                MaxLevelCap = 100,
                DamageBatchSize = 100, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 0,
                    Rainbow = 0,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 4,
                },
                RequiredUnitCount = 4,
                Names = { "Iron Chronicles Shiny", "Ignis Crimson", "King Biku", "King Biku Shiny", "Sandy Bag" },
            },
            Z13 = {
                DisplayName = "Petalfall",
                MaxLevelCap = 200,
                DamageBatchSize = 200, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 0,
                    Rainbow = 0,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 8,
                },
                RequiredUnitCount = 8,
                Names = {"Blue Phoenix", "Body Flicker"},
            },
            Z14 = {
                DisplayName = "Tidewreck",
                MaxLevelCap = 200,
                DamageBatchSize = 200, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 0,
                    Rainbow = 0,
                    Frozen = 0,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 8,
                },
                RequiredUnitCount = 8,
                Names = {"Wolf Guardian", "Ratio Blade", "Sixth Panther", "Bounce Brawler", "Ten Tails Host", "Baryon Chakra", "Beast Scholar", "Earring Fusion", "Perfect Lifeform", "Vessel King", "Storm Mane"},
                
            }
        },
        ActionTimeout = math.huge,
        TeleportDelay = 0.15,
        TeleportHeight = 3,
        EquipSlotDelay = 0.2,
        PlacementKeyHold = 0.05,
        PlacementDelay = 0.4,
        PlacementRetryDelay = 0.35,
        BestEquipDelay = 1.5,
        UISettleTime = 0.75,
        InventorySettleTime = 0.2, -- Required Units inventory/hotbar confirmation only.
        DisplayRemoveDelay = 0.05,
        InventoryClickDelay = 0.05,
        HotbarClearDelay = 0.1,
        RemovalMinimumHold = 0.1,
        RemovalHoldPadding = 0.15,
        RemovalRetryDelay = 0.35,
        PlacementMinimumHold = 0.05,
        HotbarKeys = { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" },
    },
    Mutation = {
        Priority = { "None", "Bronze", "Diamond", "Platinum", "Rainbow", "Frozen", "Inferno", "Nightmare", "Unreal" },

        TeleportDelay = 0.25,
        TeleportHeight = 3,
        PanelSettleTime = 0.3,
        RollSettleTime = 0.25,
        RapidRollSettleTime = 0.1,
        RapidRollDelay = 0.1,
        AfterUpgradeClickDelay = 0.3,
        BeforeExitDelay = 0.2,
        RescanSettleTime = 0.2,
        RollDelay = 0.1,
    },
    UI = {
        InitialTab = "master",
        Width = 620, Height = 620,
        ExpandedScale = 0.9,
        MinimizedWidth = 342, MinimizedHeight = 224,
        Colors = {
            bg = Color3.fromRGB(22, 25, 34), surface = Color3.fromRGB(31, 35, 47),
            muted = Color3.fromRGB(164, 174, 196), text = Color3.fromRGB(235, 240, 250),
            accent = Color3.fromRGB(99, 122, 246), success = Color3.fromRGB(148, 224, 175),
            error = Color3.fromRGB(255, 166, 166), idle = Color3.fromRGB(65, 70, 88),
        },
    },
    Logging = {
        ShowInfo = true,
        ShowWarnings = true,
        ShowUnitUpgradeDetails = false,
        RetryReportAttempts = 10,
        RepeatReportSeconds = 60, -- Print recurring messages at most once per minute; copied logs retain totals.
        RetryReportSeconds = 15,
        RetryMaxReportSeconds = 120, -- Back off reminders for an operation that stays blocked.
    },
}

local LOAD_TIMEOUT = CONFIG.General.LoadTimeout
local SETTLE_TIME = CONFIG.General.SettleTime
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local VIM = game:GetService("VirtualInputManager")
local ProximityPromptService = game:GetService("ProximityPromptService")
local player = Players.LocalPlayer
while not player do
    task.wait(CONFIG.General.ScanPoll)
    player = Players.LocalPlayer
end
local playerGui = player:FindFirstChildOfClass("PlayerGui")
while not playerGui do
    task.wait(CONFIG.General.ScanPoll)
    playerGui = player:FindFirstChildOfClass("PlayerGui")
end

for _, key in ipairs({"__AUTOMATION_KILL", "__AUTO_SELL_KILL"}) do
    if type(_G[key]) == "function" then pcall(_G[key]) end
end
for _, name in ipairs({"AutomationUI", "AutoSellUI", "PickaxeBuyerUI", "UpgradeClickerUI", "MineBestHotbarUI", "WorkspacePathCleanupUI"}) do
    local existing = playerGui:FindFirstChild(name)
    if existing then existing:Destroy() end
end

local alive, busy = true, false
local worker, activeStage, activeRun = nil, nil, nil
local minimizedActions = {rollEnabled = false, rollWorker = nil, openBusy = false, openWorker = nil}
local runScope = {buttonOwners = setmetatable({}, {__mode = "kv"}), masterAllowed = {}, current = nil, threads = setmetatable({}, {__mode = "k"}), background = {}, callbacks = {}}
local connections, shownPrompts = {}, {}
local heldPrompt, heldKey, mouseHeld = nil, nil, nil
local originalRoot, originalCFrame = nil, nil
local dragging, touchPointer, dragStart, panelStart = false, nil, nil, nil
local modules, pages, tabs, stageRows = {}, {}, {}, {}
local order = CONFIG.Flow.Order
local validStages, seenStages = {sell=true, pickaxe=true, upgrades=true, upgradingOldUnit=true, unlockSlots=true, units=true, mutation=true, upgradingUnit=true, cycleEnd=true}, {}
assert(#order == 9 and order[5] == "unlockSlots" and order[9] == "cycleEnd", "CONFIG.Flow.Order must contain all nine stages, with unlockSlots fifth and cycleEnd last.")
for _, id in ipairs(order) do
    assert(validStages[id] and not seenStages[id], "CONFIG.Flow.Order has an invalid or duplicate stage: " .. tostring(id))
    seenStages[id] = true
end
local selectedTab = CONFIG.UI.InitialTab
local lastRun = -math.huge
local unloadScript, startRun, stopRun
local gameEvent
local consolePrint, consoleWarn = print, warn
local scriptLogs, logging = {}, {}
do
    local originalPrint, originalWarn = consolePrint, consoleWarn
    local entriesByKey = {}
    local function output(entry)
        local message = entry.message
        if entry.count > entry.printedCount then
            message = message .. string.format(" [repeated %d more times; %d total]", entry.count - entry.printedCount, entry.count)
        end
        if entry.level == "INFO" then originalPrint(message) else originalWarn(message) end
        entry.printedCount, entry.lastPrinted = entry.count, os.clock()
    end
    function logging.emit(level, message, key, signature)
        message = tostring(message)
        key, signature = key or (level .. "\0" .. message), signature or message
        local entry = entriesByKey[key]
        if entry and entry.signature == signature then
            entry.count, entry.lastAt, entry.message = entry.count + 1, os.time(), message
            if os.clock() - entry.lastPrinted >= CONFIG.Logging.RepeatReportSeconds then output(entry) end
            return
        end
        entry = {key = key, signature = signature, level = level, message = message,
            firstAt = os.time(), lastAt = os.time(), count = 1, printedCount = 1}
        entriesByKey[key] = entry
        table.insert(scriptLogs, entry)
        -- Bound both the copied history and the lookup used to group recurring messages.
        if #scriptLogs > 2000 then
            local oldest = table.remove(scriptLogs, 1)
            if entriesByKey[oldest.key] == oldest then entriesByKey[oldest.key] = nil end
        end
        output(entry)
    end
    function logging.flush()
        for _, entry in ipairs(scriptLogs) do
            if entry.count > entry.printedCount then output(entry) end
        end
    end
    function logging.export()
        local lines = {}
        for _, entry in ipairs(scriptLogs) do
            local summary = entry.count > 1 and string.format(" [x%d; last seen %s]", entry.count, os.date("%H:%M:%S", entry.lastAt)) or ""
            table.insert(lines, os.date("[%H:%M:%S] ", entry.firstAt) .. entry.level .. " " .. entry.message .. summary)
        end
        return table.concat(lines, "\n")
    end
    local function messageText(...)
        local parts = {}
        for index = 1, select("#", ...) do parts[index] = tostring(select(index, ...)) end
        return table.concat(parts, "\t")
    end
    consolePrint = function(...) logging.emit("INFO", messageText(...)) end
    consoleWarn = function(...) logging.emit("WARN", messageText(...)) end
end
local consoleStageLabels = {
    sell = "Sell", pickaxe = "Pickaxe", upgrades = "Upgrades", upgradingOldUnit = "Upgrade Old Units",
    unlockSlots = "Unlock slots",
    units = "Required Units", mutation = "Mutate Units", upgradingUnit = "Upgrade Units", cycleEnd = "Cycle end",
}
local consoleStageLabelWidth = 0
for _, name in pairs(consoleStageLabels) do
    consoleStageLabelWidth = math.max(consoleStageLabelWidth, #name)
end
local function consolePrefix(scope)
    local id = activeStage or (validStages[activeRun] and activeRun)
    if not id then
        for stage, name in pairs(consoleStageLabels) do
            if scope == stage or scope == name then id = stage; break end
        end
        if scope == "Zone" then id = "upgrades" end
        if scope == "PickaxeBuyer" then id = "pickaxe" end
        if scope == "MineBestHotbar" then id = "units" end
    end
    for index, stage in ipairs(order) do
        if stage == id then
            return string.format("[Stage %d - %-" .. consoleStageLabelWidth .. "s]", index, consoleStageLabels[stage])
        end
    end
    return "[" .. tostring(scope or "General") .. "]"
end
local function logInfo(scope, message, key, signature)
    if not CONFIG.Logging.ShowInfo or scope == "Master" then return end
    logging.emit("INFO", consolePrefix(scope) .. " " .. tostring(message), key, signature)
end
local function logWarning(message)
    if not CONFIG.Logging.ShowWarnings then return end
    local text = tostring(message)
    local scope = text:match("^%[([^%]]+)%]")
    local clean = text:gsub("^%[[^%]]+%]%s*", "")
    consoleWarn(consolePrefix(scope) .. " Warning: " .. clean)
end
local scriptErrors = {retries = {}, stages = {}}
function scriptErrors.clearStage(stage)
    scriptErrors.stages[stage] = nil
    for monitor, source in pairs(scriptErrors.retries) do
        if source.stage == stage then scriptErrors.retries[monitor] = nil end
    end
end
function scriptErrors.clearAll()
    table.clear(scriptErrors.retries)
    table.clear(scriptErrors.stages)
end
function scriptErrors.hasAny()
    return next(scriptErrors.retries) ~= nil or next(scriptErrors.stages) ~= nil
end
local function logError(scope, message)
    -- Retry monitors own their recovery state; actual stage errors remain until recovery/restart.
    if scope ~= "Retry" then scriptErrors.stages[activeStage or activeRun or scope or "General"] = true end
    consoleWarn(consolePrefix(scope) .. " Error: " .. tostring(message))
end
local function logUnitUpgradeDetail(message)
    if CONFIG.Logging.ShowUnitUpgradeDetails then logInfo("Unit Upgrade Debug", message) end
end

local function newRetryMonitor(operation)
    local started, lastReport, attempts = os.clock(), os.clock(), 0
    local nextReport = CONFIG.Logging.RetryReportAttempts
    local reportInterval = CONFIG.Logging.RetryReportSeconds
    local expectedRoll = tostring(operation):lower():find("rolling mutations", 1, true) ~= nil
    local flagged, report = false, nil
    report = function(detail, recovered)
        if recovered then
            scriptErrors.retries[report] = nil
            if flagged then
                logInfo("Retry", string.format("%s recovered after %.1fs (%d failed checks).", operation, os.clock() - started, attempts))
            end
            started, lastReport, attempts = os.clock(), os.clock(), 0
            nextReport, flagged = CONFIG.Logging.RetryReportAttempts, false
            reportInterval = CONFIG.Logging.RetryReportSeconds
            return
        end
        -- Normal mutation rolls are expected work, not a stuck operation.
        if expectedRoll then return end
        attempts = attempts + 1
        local now = os.clock()
        if attempts >= nextReport and now - lastReport >= reportInterval then
            flagged = true
            logError("Retry", string.format("%s | %d failed checks/retries over %.1fs; still retrying.%s",
                operation, attempts, now - started, detail and (" Last issue: " .. tostring(detail)) or ""))
            nextReport = attempts + CONFIG.Logging.RetryReportAttempts
            lastReport = now
            reportInterval = math.min(reportInterval * 2, CONFIG.Logging.RetryMaxReportSeconds)
        end
        if flagged then scriptErrors.retries[report] = {stage = activeStage, run = activeRun} end
    end
    return report
end

local function hasMutationRequirements(rule)
    for _, tier in ipairs(CONFIG.Mutation.Priority) do
        local count = rule and rule[tier]
        if type(count) == "number" and count > 0 then return true end
    end
    return false
end

local preferences = {
    masterEnabled = CONFIG.Flow.DefaultMasterEnabled,
    autoAcceptTradeEnabled = true,
    indexPlacedUnits = {},
    masterActivatedOnce = false,
    tutorialHidden = false,
    firstLoadedAt = scriptLoadedAt,
    discordNotifications = {maxZone = {}, colossus = {}},
    dailySpinEnabled = CONFIG.DailyRewards.DefaultSpinEnabled,
    autoRedeemEnabled = CONFIG.DailyRewards.DefaultRedeemEnabled,
    lastDailySpinAt = nil,
    redeemedCodes = {},
    stages = {},
}
assert(type(preferences.masterEnabled) == "boolean", "CONFIG.Flow.DefaultMasterEnabled must be boolean.")
assert(type(CONFIG.General.DeleteOtherPlots) == "boolean", "CONFIG.General.DeleteOtherPlots must be boolean.")
assert(type(CONFIG.General.WorkspaceCleanupEnabled) == "boolean", "CONFIG.General.WorkspaceCleanupEnabled must be boolean.")
for _, id in ipairs(order) do
    local enabled = CONFIG.Flow.DefaultStages[id]
    assert(type(enabled) == "boolean", "CONFIG.Flow.DefaultStages." .. id .. " must be boolean.")
    preferences.stages[id] = enabled
end
local savePreferences
local indexQueueCached = false
do
    local file = string.format("automation_preferences_%s_%s.json", tostring(game.GameId), tostring(player.UserId))
    local storageAvailable = type(isfile) == "function" and type(readfile) == "function" and type(writefile) == "function"
    local function storageWarning(message)

        consoleWarn("[Preferences] " .. message)
    end
    savePreferences = function()
        if not storageAvailable then
            storageWarning("isfile/readfile/writefile are unavailable; preferences apply only to this run.")
            return false
        end
        local data = {
            version = 1,
            gameId = tostring(game.GameId), userId = tostring(player.UserId),
            masterEnabled = preferences.masterEnabled,
            autoAcceptTradeEnabled = preferences.autoAcceptTradeEnabled,
            indexPlacedUnits = preferences.indexPlacedUnits,
            masterActivatedOnce = preferences.masterActivatedOnce,
            tutorialHidden = preferences.tutorialHidden,
            firstLoadedAt = preferences.firstLoadedAt,
            discordNotifications = preferences.discordNotifications,
            dailySpinEnabled = preferences.dailySpinEnabled,
            autoRedeemEnabled = preferences.autoRedeemEnabled,
            lastDailySpinAt = preferences.lastDailySpinAt,
            redeemedCodes = preferences.redeemedCodes,
            stages = preferences.stages,
            selectCurrentZone = CONFIG.Upgrades.SelectCurrentZone,
            selectNextZone = CONFIG.Upgrades.SelectNextZone,
            unlimitedBestPickaxe = CONFIG.Pickaxe.UnlimitedBestPickaxe,
            deleteOtherPlots = CONFIG.General.DeleteOtherPlots,
            workspaceCleanupEnabled = CONFIG.General.WorkspaceCleanupEnabled,
        }
        local encodedOK, encoded = pcall(HttpService.JSONEncode, HttpService, data)
        if not encodedOK then storageWarning("Cannot encode preferences; changes were not saved."); return false end
        local writeOK = pcall(writefile, file, encoded)
        local readOK, saved = pcall(readfile, file)
        if not writeOK or not readOK or saved ~= encoded then
            storageWarning("Cannot verify " .. file .. "; changes may not be retained on the next run.")
            return false
        end
        indexQueueCached = next(data.indexPlacedUnits) ~= nil
        if minimizedActions.refreshIndexQueue then minimizedActions.refreshIndexQueue() end
        return true
    end
    local function loadPreferences()
        if not storageAvailable then
            storageWarning("isfile/readfile/writefile are unavailable; using CONFIG defaults for this run.")
            return
        end
        local existsOK, exists = pcall(isfile, file)
        if not existsOK then storageWarning("Cannot check " .. file .. "; using CONFIG defaults."); return end
        if not exists then savePreferences(); return end
        local readOK, raw = pcall(readfile, file)
        if not readOK then storageWarning("Cannot read " .. file .. "; using CONFIG defaults."); return end
        local decodeOK, data = pcall(HttpService.JSONDecode, HttpService, raw)
        if not decodeOK or type(data) ~= "table" or data.version ~= 1
            or data.gameId ~= tostring(game.GameId) or data.userId ~= tostring(player.UserId) then
            storageWarning("Invalid " .. file .. "; using CONFIG defaults. File left unchanged until a toggle changes.")
            return
        end
        local function booleanOrDefault(value, fallback)
            if value == nil then return fallback end
            if type(value) == "boolean" then return value end
            storageWarning("Invalid saved toggle; using its CONFIG default.")
            return fallback
        end
        preferences.masterEnabled = booleanOrDefault(data.masterEnabled, preferences.masterEnabled)
        preferences.autoAcceptTradeEnabled = booleanOrDefault(data.autoAcceptTradeEnabled, true)
        preferences.indexPlacedUnits = {}
        if type(data.indexPlacedUnits) == "table" then
            for name, placed in pairs(data.indexPlacedUnits) do
                if type(name) == "string" and name ~= "" and placed == true then
                    preferences.indexPlacedUnits[name:lower()] = true
                end
            end
        end
        indexQueueCached = next(preferences.indexPlacedUnits) ~= nil
        preferences.masterActivatedOnce = booleanOrDefault(data.masterActivatedOnce, false)
        preferences.tutorialHidden = booleanOrDefault(data.tutorialHidden, false)
        preferences.dailySpinEnabled = booleanOrDefault(data.dailySpinEnabled, preferences.dailySpinEnabled)
        preferences.autoRedeemEnabled = booleanOrDefault(data.autoRedeemEnabled, preferences.autoRedeemEnabled)
        local savedSpinAt = data.lastDailySpinAt
        if type(savedSpinAt) == "number" and savedSpinAt > 0 and savedSpinAt < math.huge
            and savedSpinAt == math.floor(savedSpinAt) then
            preferences.lastDailySpinAt = savedSpinAt
        end
        if type(data.redeemedCodes) == "table" then
            for code, sent in pairs(data.redeemedCodes) do
                if type(code) == "string" and sent == true then preferences.redeemedCodes[code] = true end
            end
        end
        local savedFirstLoadedAt = data.firstLoadedAt
        local validFirstLoadedAt = type(savedFirstLoadedAt) == "number" and savedFirstLoadedAt > 0
            and savedFirstLoadedAt <= scriptLoadedAt and savedFirstLoadedAt == math.floor(savedFirstLoadedAt)
        if validFirstLoadedAt then preferences.firstLoadedAt = savedFirstLoadedAt end
        if type(data.discordNotifications) == "table" then
            for kind, zones in pairs(preferences.discordNotifications) do
                local saved = data.discordNotifications[kind]
                if type(saved) == "table" then
                    for zoneId, sent in pairs(saved) do
                        if type(zoneId) == "string" and zoneId:match("^Z%d+$") and sent == true then
                            zones[zoneId] = true
                        end
                    end
                end
            end
        end
        if data.stages ~= nil and type(data.stages) ~= "table" then
            storageWarning("Invalid saved stages; using CONFIG stage defaults.")
        elseif data.stages then
            for _, id in ipairs(order) do
                preferences.stages[id] = booleanOrDefault(data.stages[id], preferences.stages[id])
            end
        end
        CONFIG.Upgrades.SelectCurrentZone = booleanOrDefault(data.selectCurrentZone, CONFIG.Upgrades.SelectCurrentZone)
        CONFIG.Upgrades.SelectNextZone = booleanOrDefault(data.selectNextZone, CONFIG.Upgrades.SelectNextZone)
        CONFIG.Pickaxe.UnlimitedBestPickaxe = booleanOrDefault(data.unlimitedBestPickaxe, CONFIG.Pickaxe.UnlimitedBestPickaxe)
        CONFIG.General.DeleteOtherPlots = booleanOrDefault(data.deleteOtherPlots, CONFIG.General.DeleteOtherPlots)
        CONFIG.General.WorkspaceCleanupEnabled = booleanOrDefault(data.workspaceCleanupEnabled, CONFIG.General.WorkspaceCleanupEnabled)

        if data.selectCurrentZone == nil or data.selectNextZone == nil or data.unlimitedBestPickaxe == nil
            or data.deleteOtherPlots == nil or data.workspaceCleanupEnabled == nil
            or data.tutorialHidden == nil or data.discordNotifications == nil
            or data.dailySpinEnabled == nil or data.autoRedeemEnabled == nil or data.redeemedCodes == nil
            or data.autoAcceptTradeEnabled == nil or data.indexPlacedUnits == nil
            or not validFirstLoadedAt or type(data.stages) == "table" and data.stages.unlockSlots == nil then
            savePreferences()
        end
    end
    loadPreferences()
end

local function logStageResult(id, message)
    -- A ticking cooldown is one unchanged result; a new result still appears immediately.
    local signature = message:gsub("cooldown %d+:%d+ remaining", "cooldown active")
    logInfo(consoleStageLabels[id], message, "stage-result:" .. id, signature)
end
local colors = CONFIG.UI.Colors

local function connect(signal, callback)
    local connection = signal:Connect(function(...)
        if not alive then return end
        local owner = runScope.buttonOwners[signal]
        if busy and activeRun == "master" and owner and not runScope.masterAllowed[owner] then return end
        local thread = coroutine.running()
        runScope.callbacks[thread] = true
        local ok, message = pcall(callback, ...)
        runScope.callbacks[thread] = nil
        if not ok then error(message, 0) end
    end)
    table.insert(connections, connection)
    return connection
end

local function actionIsCurrent(token)
    if not alive then return false end
    if token.kind == "roll" then
        return minimizedActions.rollToken == token and minimizedActions.rollEnabled
            and not (busy and activeRun == "master")
    elseif token.kind == "open" then
        return minimizedActions.openToken == token and minimizedActions.openBusy
            and not (busy and activeRun == "master")
    end
    return busy and runScope.current == token
        and (token.id ~= "master" or preferences.masterEnabled)
end
local function checkAlive()
    if not alive then error("Unloaded.", 0) end
    local token = runScope.threads[coroutine.running()]
    if token and not actionIsCurrent(token) then error("Run stopped.", 0) end
end

local function pause(seconds)
    checkAlive()
    task.wait(seconds)
    checkAlive()
end

local function waitUntil(test, _timeout, message, retryAction)
    local token = runScope.threads[coroutine.running()]
    local fastPoll = token and (activeStage == "hotbarUpgrade" or activeStage == "mutation"
        or activeStage == "upgradingUnit" or activeStage == "upgradingOldUnit")
    local pollInterval = fastPoll and 0.05 or 0.5
    local reportRetry = newRetryMonitor(message or "Waiting for an operation to complete")
    local nextRetry = os.clock() + CONFIG.General.RetryInterval
    local problem
    while true do
        checkAlive()
        local result = test()
        if result then reportRetry(nil, true); return result end
        if retryAction and os.clock() >= nextRetry then
            local ok, response = pcall(retryAction)
            checkAlive()
            problem = not ok and response or nil
            nextRetry = os.clock() + CONFIG.General.RetryInterval
        end
        reportRetry(problem)
        pause(pollInterval)
    end
end

local function path(parent, names)
    for _, name in ipairs(names) do
        local current = parent
        parent = waitUntil(function() return current:FindFirstChild(name) end, nil,
            "Waiting for path component " .. name .. " under " .. current:GetFullName())
    end
    return parent
end

local function getGameEvent()
    checkAlive()
    if not gameEvent or not gameEvent:IsDescendantOf(ReplicatedStorage) then
        gameEvent = path(ReplicatedStorage, {"Remotes", "GamestateEvent"})
    end
    if not gameEvent:IsA("RemoteEvent") then error("GamestateEvent is not a RemoteEvent.", 0) end
    return gameEvent
end

-- Game settings are read live on each entry; no completion file is used.
do
local refreshSettingsFrame
local function closeSettingsFrame()
    local frame = refreshSettingsFrame
    refreshSettingsFrame = nil
    if frame then pcall(function() frame.Visible = false end) end
end
modules.gameSettings = {cleanup = closeSettingsFrame, apply = function(checkCurrent, status)
    local settings = {
        {name = "CutsceneExotic", section = "CutscenesOption", option = "Exotic", enabled = false},
        {name = "CutsceneMythical", section = "CutscenesOption", option = "Mythical", enabled = false},
        {name = "CutsceneMutations", section = "RevealsOption", option = "Mutations", enabled = false},
        {name = "CutsceneSummons", section = "RevealsOption", option = "Summons", enabled = false},
        {name = "NightMode", section = "NightModeOption", option = "Toggle", enabled = true},
    }
    local function check()
        checkAlive()
        if checkCurrent then checkCurrent() end
    end
    local function readState(setting)
        local content = player:FindFirstChildOfClass("PlayerGui")
        for _, name in ipairs({"ScreenGui", "CutGrassGame", "SettingsFrame", "List",
            setting.section, setting.option, "Content"}) do
            content = content and content:FindFirstChild(name)
        end
        local color
        if activeRun == "master" then
            color = content and content:IsA("GuiObject") and content.BackgroundColor3
        else
            color = content and content:GetAttribute("realcolor")
        end
        if typeof(color) ~= "Color3" then return nil end
        local r = math.floor(color.R * 255 + 0.5)
        local g = math.floor(color.G * 255 + 0.5)
        local b = math.floor(color.B * 255 + 0.5)
        if r == 38 and g == 148 and b == 84 then return {enabled = true} end
        if r == 80 and g == 80 and b == 80 then return {enabled = false} end
        return nil
    end
    local function currentState(setting)
        return waitUntil(function()
            check()
            return readState(setting)
        end, nil, "Reading live game setting " .. setting.name .. (activeRun == "master" and " BackgroundColor3" or " realcolor"))
    end
    local event, toggled = nil, 0
    for _, setting in ipairs(settings) do
        check()
        if status then status.Text = "Checking game setting: " .. setting.name end
        local state = currentState(setting)
        if state.enabled ~= setting.enabled then
            event = event or getGameEvent()
            -- Resolving the event can wait; re-read before sending a toggle.
            state = currentState(setting)
            if state.enabled ~= setting.enabled then
                check()
                if status then status.Text = "Setting " .. setting.name .. (setting.enabled and " ON" or " OFF") end
                event:FireServer("ToggleSetting", setting.name)
                toggled = toggled + 1
                -- Re-read the live state before any retry to avoid undoing a confirmed setting.
                local operation = "Confirming game setting " .. setting.name .. (setting.enabled and " ON" or " OFF")
                if activeRun == "master" then
                    local reportRetry = newRetryMonitor(operation)
                    while true do
                        check()
                        local confirmed = readState(setting)
                        if confirmed and confirmed.enabled == setting.enabled then
                            reportRetry(nil, true)
                            break
                        end
                        reportRetry()
                        -- Alternate every failed confirmation with a settings-frame refresh.
                        local gui = player:FindFirstChildOfClass("PlayerGui")
                        local screen = gui and gui:FindFirstChild("ScreenGui")
                        local gameGui = screen and screen:FindFirstChild("CutGrassGame")
                        local frame = gameGui and gameGui:FindFirstChild("SettingsFrame")
                        if frame and frame:IsA("GuiObject") then
                            refreshSettingsFrame = frame
                            frame.Visible = true
                            pause(1)
                            closeSettingsFrame()
                            check()
                        end
                        local latest = readState(setting)
                        if latest and latest.enabled ~= setting.enabled then
                            event = getGameEvent()
                            check()
                            latest = readState(setting)
                            if latest and latest.enabled ~= setting.enabled then
                                event:FireServer("ToggleSetting", setting.name)
                                toggled = toggled + 1
                            end
                        end
                        pause(CONFIG.General.WaitPoll)
                    end
                else
                    waitUntil(function()
                        check()
                        local confirmed = readState(setting)
                        return confirmed and confirmed.enabled == setting.enabled
                    end, nil, operation)
                end
            end
        end
    end
    local summary = string.format("Game settings checked live: %d toggled; all five confirmed.", toggled)
    if status then status.Text = summary end
    return summary
end}
end

local function releaseInputs()
    local prompt, key, mouse = heldPrompt, heldKey, mouseHeld
    heldPrompt, heldKey, mouseHeld = nil, nil, nil
    if prompt then pcall(function() prompt:InputHoldEnd() end) end
    if key then pcall(function() VIM:SendKeyEvent(false, key, false, game) end) end
    if mouse then pcall(function() VIM:SendMouseButtonEvent(mouse.X, mouse.Y, 0, false, game, 0) end) end
end

-- Master hover follows the running Master, including cycle waits and respawns.
do
    local flyRoot, attachment, velocity, watcher
    local function clearFlight()
        local oldVelocity, oldAttachment = velocity, attachment
        flyRoot, attachment, velocity = nil, nil, nil
        if oldVelocity then oldVelocity:Destroy() end
        if oldAttachment then oldAttachment:Destroy() end
    end
    local function stopFlight()
        if watcher then watcher:Disconnect(); watcher = nil end
        clearFlight()
    end
    local function updateFlight()
        if not alive or not busy or activeRun ~= "master" or not preferences.masterEnabled then
            stopFlight()
            return
        end
        local character = player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root and not root:IsA("BasePart") then root = nil end
        local valid = flyRoot == root and velocity and velocity.Parent == root
            and attachment and attachment.Parent == root
        if not valid then
            clearFlight()
            if not root then return end
            flyRoot = root
            attachment = Instance.new("Attachment")
            attachment.Name = "MasterFlyAttachment"
            attachment.Parent = root
            velocity = Instance.new("LinearVelocity")
            velocity.Name = "MasterFlyVelocity"
        end
        -- Reassert hover and clear downward velocity before each physics step.
        velocity.Attachment0 = attachment
        velocity.RelativeTo = Enum.ActuatorRelativeTo.World
        velocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        velocity.VectorVelocity = Vector3.zero
        velocity.ForceLimitsEnabled = false
        velocity.Enabled = true
        if velocity.Parent ~= root then velocity.Parent = root end
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
    end
    modules.masterFly = {
        start = function()
            stopFlight()
            if not alive or not busy or activeRun ~= "master" or not preferences.masterEnabled then return end
            updateFlight()
            watcher = game:GetService("RunService").PreSimulation:Connect(updateFlight)
        end,
        stop = stopFlight,
    }
end

local function restorePosition()
    local root, position = originalRoot, originalCFrame
    originalRoot, originalCFrame = nil, nil
    if root and position and player.Character and root:IsDescendantOf(player.Character) then
        pcall(function()
            root.CFrame = position
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end)
    end
end

local gui = Instance.new("ScreenGui")
gui.Name = "AutomationUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 2147483647 -- Set once at startup; do not monitor other interfaces.
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function cleanup(destroyGui)
    if runScope.cleanupComplete then return true end
    if runScope.cleanupRunning then return false end
    runScope.cleanupRunning = true
    -- Revoke every action before cancelling threads or touching game/UI state.
    alive, busy, dragging = false, false, false
    runScope.current, minimizedActions.rollToken, minimizedActions.openToken = nil, nil, nil
    minimizedActions.rollEnabled, minimizedActions.openBusy = false, false
    touchPointer, dragStart, panelStart = nil, nil, nil
    local complete = true
    local function attempt(name, callback)
        local ok, result = pcall(callback)
        if not ok or result == false then
            complete = false
            consoleWarn("[Cleanup] " .. name .. ": " .. tostring(ok and "did not complete" or result))
        end
        return ok and result ~= false
    end
    local currentThread = coroutine.running()
    local function cancelThread(thread)
        if not thread or thread == currentThread then return true end
        return attempt("Cancel worker", function()
            if coroutine.status(thread) ~= "dead" then task.cancel(thread) end
        end)
    end
    for index = #connections, 1, -1 do
        local connection = connections[index]
        if attempt("Disconnect event", function() connection:Disconnect() end) then table.remove(connections, index) end
    end
    if cancelThread(worker) then worker = nil end
    if cancelThread(minimizedActions.rollWorker) then minimizedActions.rollWorker = nil end
    if cancelThread(minimizedActions.openWorker) then minimizedActions.openWorker = nil end
    for _, threads in ipairs({runScope.threads, runScope.background, runScope.callbacks}) do
        for thread in pairs(threads) do
            if cancelThread(thread) then threads[thread] = nil end
        end
    end
    -- A failing module must not prevent the remaining cleanup steps from running.
    for _, entry in ipairs({
        {"plotCleanup", "stop"}, {"masterFly", "stop"}, {"chestRecovery", "cleanup"},
        {"gameSettings", "cleanup"}, {"hotbarUpgrade", "cleanup"}, {"autoSequence", "cleanup"}, {"trade", "cleanup"},
        {"pickaxe", "cleanupWaiting"}, {"upgrades", "cleanup"},
        {"mutation", "cleanup"}, {"upgradingUnit", "cleanup"},
    }) do
        local module = rawget(modules, entry[1])
        local callback = module and module[entry[2]]
        if type(callback) == "function" then attempt(entry[1], callback) end
    end
    attempt("Release inputs", releaseInputs)
    attempt("Close game panels", function()
        local mine = playerGui:FindFirstChild("MineGui")
        if not mine then return end
        for _, name in ipairs({"SellFrame", "PickaxeShopFrame", "SkillTreeFullFrame", "InventoryFrame",
            "SlotFocusFrame", "ChestFrame", "TrialFrame", "EventsFrameV2", "MailboxFrame"}) do
            local frame = mine:FindFirstChild(name)
            if frame and frame:IsA("GuiObject") then
                attempt("Close " .. name, function() frame.Visible = false end)
            end
        end
    end)
    if modules.tutorial then attempt("tutorial", modules.tutorial.cleanup) end
    attempt("Restore position", restorePosition)
    attempt("Flush logs", logging.flush)
    table.clear(shownPrompts)
    if _G.__AUTOMATION_KILL == unloadScript then
        _G.MineHotbarSummary, _G.MineHotbarTotalCount, _G.MineHotbarMatchSummary = nil, nil, nil
        local densityState = _G.__AUTOMATION_DENSITY_II
        if type(densityState) == "table" then
            densityState[tostring(game.GameId) .. ":" .. tostring(player.UserId)] = nil
        end
    end
    if destroyGui then attempt("Destroy UI", function() gui:Destroy() end) end
    if complete and _G.__AUTOMATION_KILL == unloadScript then _G.__AUTOMATION_KILL = nil end
    runScope.cleanupComplete, runScope.cleanupRunning = complete, false
    return complete
end
unloadScript = function() return cleanup(true) end
_G.__AUTOMATION_KILL = unloadScript
connect(gui.Destroying, function() cleanup(false) end)
connect(ProximityPromptService.PromptShown, function(prompt) shownPrompts[prompt] = true end)
connect(ProximityPromptService.PromptHidden, function(prompt) shownPrompts[prompt] = nil end)

local function make(className, parent, properties)
    local object = Instance.new(className)
    for key, value in pairs(properties) do object[key] = value end
    object.Parent = parent
    return object
end
local function corner(object, radius)
    make("UICorner", object, {CornerRadius = UDim.new(0, radius or 8)})
end
local function label(parent, text, position, size, textSize)
    return make("TextLabel", parent, {
        BackgroundTransparency = 1, Text = text, Position = position, Size = size,
        Font = Enum.Font.Gotham, TextSize = textSize or 13, TextColor3 = colors.muted,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
    })
end
local function button(parent, text, position, size)
    local object = make("TextButton", parent, {
        Text = text, Position = position, Size = size, BackgroundColor3 = colors.accent,
        BorderSizePixel = 0, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = colors.text,
    })
    corner(object)
    runScope.buttonOwners[object.Activated] = object
    return object
end

-- Draw icons with GUI strokes so they never depend on font glyph support.
minimizedActions.drawButtonIcon = function(parent, kind)
    local icon = make("Frame", parent, {
        Name = "ButtonIcon", BackgroundTransparency = 1, Active = false,
        Position = UDim2.new(0.5, -9, 0.5, -9), Size = UDim2.fromOffset(18, 18),
        ZIndex = (parent.ZIndex or 1) + 1,
    })
    local function stroke(x1, y1, x2, y2)
        local dx, dy = x2 - x1, y2 - y1
        local segment = make("Frame", icon, {
            Name = "IconStroke", BackgroundColor3 = colors.text, BorderSizePixel = 0, Active = false,
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2),
            Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy) + 1, 2),
            Rotation = math.deg(math.atan2(dy, dx)), ZIndex = icon.ZIndex + 1,
        })
        corner(segment, 1)
    end
    if kind == "refresh" then
        local radius, startAngle, endAngle = 6.5, math.rad(50), math.rad(330)
        local x, y = 9 + radius * math.cos(startAngle), 9 + radius * math.sin(startAngle)
        for index = 1, 14 do
            local angle = startAngle + (endAngle - startAngle) * index / 14
            local nextX, nextY = 9 + radius * math.cos(angle), 9 + radius * math.sin(angle)
            stroke(x, y, nextX, nextY)
            x, y = nextX, nextY
        end
        local direction = endAngle + math.pi / 2
        for _, offset in ipairs({math.rad(-35), math.rad(35)}) do
            stroke(x, y, x - 3.5 * math.cos(direction + offset), y - 3.5 * math.sin(direction + offset))
        end
    elseif kind == "next" then
        stroke(2, 4, 7, 9)
        stroke(7, 9, 2, 14)
        stroke(7, 4, 12, 9)
        stroke(12, 9, 7, 14)
        stroke(15, 4, 15, 14)
    end
end

local panel = make("Frame", gui, {
    Name = "Browser", Size = UDim2.fromOffset(CONFIG.UI.Width, CONFIG.UI.Height), Position = UDim2.fromOffset(0, 0),
    AnchorPoint = Vector2.new(0, 0),
    BackgroundColor3 = colors.bg, BorderSizePixel = 0, Active = true,
})
-- Block input behind the panel, including blank areas, in both UI sizes.
-- Active above also supports clients without the newer InputSink property.
pcall(function() panel.InputSink = Enum.InputSink.All end)
corner(panel, 12)
local minimized = false
local scale = make("UIScale", panel, {Scale = 1})
local function resize()
    local screen = gui.AbsoluteSize
    if screen.X <= 0 or screen.Y <= 0 then return end
    scale.Scale = math.max(0.01, math.min(1, (screen.X - 24) / CONFIG.UI.Width, (screen.Y - 48) / CONFIG.UI.Height))
        * (minimized and 1 or CONFIG.UI.ExpandedScale)
    local width, height = panel.Size.X.Offset * scale.Scale, panel.Size.Y.Offset * scale.Scale
    local x = panel.Position.X.Scale * screen.X + panel.Position.X.Offset
    local top = panel.Position.Y.Scale * screen.Y + panel.Position.Y.Offset
    x = math.clamp(x, 0, math.max(0, screen.X - width))
    top = math.clamp(top, 0, math.max(0, screen.Y - height))
    panel.Position = UDim2.fromOffset(x, top)
end
connect(gui:GetPropertyChangedSignal("AbsoluteSize"), resize)
connect(UserInputService.WindowFocused, resize)

local title = button(panel, "  Automation", UDim2.fromOffset(10, 8), UDim2.new(1, -128, 0, 36))
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.AutoButtonColor = false
title.TextSize = 17
local close = button(panel, "X", UDim2.new(1, -48, 0, 8), UDim2.fromOffset(36, 32))
close.BackgroundColor3 = colors.surface
connect(close.Activated, function() cleanup(true) end)
local minimize = button(panel, "-", UDim2.new(1, -88, 0, 8), UDim2.fromOffset(32, 32))
minimize.Name = "Minimize"
minimize.BackgroundTransparency = 1
minimize.TextSize = 20
local minimizedControls = make("Frame", panel, {
    Name = "MinimizedControls", Position = UDim2.fromOffset(8, 34), Size = UDim2.new(1, -16, 1, -42),
    BackgroundTransparency = 1, Visible = false,
})
local minimizedMaster = button(minimizedControls, "Master: OFF", UDim2.fromOffset(0, 0), UDim2.new(0.5, -3, 0, 32))
minimizedMaster.Name = "MinimizedMaster"
minimizedMaster.TextSize = 14
do
    local updateStatus = label(minimizedControls, "", UDim2.fromOffset(0, 186), UDim2.new(1, 0, 0, 0), 11)
    updateStatus.Name, updateStatus.Visible = "MinimizedUpdateStatus", false
    local currentStatus
    minimizedActions.getHeight = function()
        return CONFIG.UI.MinimizedHeight + (minimizedActions.presetExtraHeight or 0)
            + (updateStatus.Visible and 4 + updateStatus.Size.Y.Offset or 0)
    end
    minimizedActions.refreshStatus = function()
        local text = currentStatus and currentStatus.Text or ""
        updateStatus.Text = text
        updateStatus.TextColor3 = currentStatus and currentStatus.TextColor3 or colors.muted
        updateStatus.Visible = text ~= ""
        local bounds = game:GetService("TextService"):GetTextSize(text, updateStatus.TextSize,
            updateStatus.Font, Vector2.new(CONFIG.UI.MinimizedWidth - 16, math.huge))
        updateStatus.Size = UDim2.new(1, 0, 0, updateStatus.Visible and math.max(16, math.ceil(bounds.Y)) or 0)
        if minimized then
            panel.Size = UDim2.fromOffset(CONFIG.UI.MinimizedWidth, minimizedActions.getHeight())
            resize()
        end
    end
    minimizedActions.newStatus = function(initialText)
        -- Keep each task's state separate while displaying only its latest update.
        local state = {Text = "", TextColor3 = colors.muted}
        local status = setmetatable({}, {
            __index = state,
            __newindex = function(_, key, value)
                state[key] = value
                if key == "Text" then
                    currentStatus = state
                    minimizedActions.refreshStatus()
                elseif key == "TextColor3" and currentStatus == state then
                    updateStatus.TextColor3 = value
                end
            end,
        })
        if initialText and initialText ~= "" then status.Text = initialText end
        return status
    end
end
do
    local tutorialButton = button(minimizedControls, "Auto complete tutorial", UDim2.new(0.5, 3, 0, 0), UDim2.new(0.5, -3, 0, 32))
    tutorialButton.Name = "AutoCompleteTutorial"
    tutorialButton.TextSize = 13
    tutorialButton.TextWrapped = true
    local tutorialStatus = minimizedActions.newStatus("")
    pages.tutorial = {name = "Auto complete tutorial", run = tutorialButton, status = tutorialStatus, runText = "Auto complete tutorial"}
    minimizedActions.refreshTutorial = function()
        tutorialButton.Visible = not preferences.tutorialHidden
        minimizedMaster.Size = UDim2.new(preferences.tutorialHidden and 1 or 0.5, preferences.tutorialHidden and 0 or -3, 0, 32)
        minimizedActions.refreshStatus()
    end
    minimizedActions.hideTutorial = function(zoneId, densityLevel)
        if preferences.tutorialHidden then return end
        local zoneNumber = tonumber(tostring(zoneId):match("^Z(%d+)$"))
        local shouldHide = zoneNumber and (zoneNumber >= 2
            or (zoneNumber == 1 and type(densityLevel) == "number" and densityLevel >= 1))
        if not shouldHide then return end
        preferences.tutorialHidden = true
        minimizedActions.refreshTutorial()
        assert(savePreferences(), "Could not save the completed tutorial state; check executor file access.")
    end
    connect(tutorialButton.Activated, function()
        if not alive or preferences.tutorialHidden then return end
        if busy and activeRun == "tutorial" then
            if not modules.tutorial.acceptsUi() then return end
            if modules.tutorial.pending() then modules.tutorial.confirm()
            elseif stopRun then stopRun() end
        elseif startRun then startRun("tutorial") end
    end)
    minimizedActions.refreshTutorial()
end
minimizedActions.toggleMaster = function()
    if not alive then return end
    if busy and activeRun == "master" then
        if stopRun then stopRun() end
    elseif startRun then
        startRun("master")
    end
end
connect(minimizedMaster.Activated, minimizedActions.toggleMaster)

connect(title.InputBegan, function(input)
    if not alive or dragging then return end
    local kind = input.UserInputType
    if kind ~= Enum.UserInputType.MouseButton1 and kind ~= Enum.UserInputType.Touch then return end
    dragging = true
    touchPointer = kind == Enum.UserInputType.Touch and input or nil
    dragStart, panelStart = input.Position, panel.Position
end)
connect(UserInputService.InputChanged, function(input)
    if not alive or not dragging then return end
    if touchPointer then
        if input ~= touchPointer then return end
    elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
    local delta = input.Position - dragStart
    panel.Position = UDim2.new(panelStart.X.Scale, panelStart.X.Offset + delta.X,
        panelStart.Y.Scale, panelStart.Y.Offset + delta.Y)
    resize()
end)
local function endDrag()
    dragging, touchPointer, dragStart, panelStart = false, nil, nil, nil
end
connect(UserInputService.InputEnded, function(input)
    if dragging and (input == touchPointer or (not touchPointer and input.UserInputType == Enum.UserInputType.MouseButton1)) then endDrag() end
end)
connect(UserInputService.WindowFocusReleased, endDrag)

local tabBar = make("Frame", panel, {
    Size = UDim2.new(1, -24, 0, 38), Position = UDim2.fromOffset(12, 50),
    BackgroundTransparency = 1,
})
local address = label(panel, "automation://master", UDim2.fromOffset(22, 98), UDim2.new(1, -44, 0, 22), 12)
local content = make("Frame", panel, {
    Position = UDim2.fromOffset(12, 126), Size = UDim2.new(1, -24, 1, -182),
    BackgroundColor3 = colors.surface, BorderSizePixel = 0,
})
corner(content)
local footer = label(panel, "Ready. Choose a tab or run the full flow.", UDim2.new(0, 18, 1, -39), UDim2.new(1, -136, 0, 30), 12)
local stop = button(panel, "Stop", UDim2.new(1, -106, 1, -44), UDim2.fromOffset(90, 32))
stop.BackgroundColor3 = colors.idle

do
    local function setMinimized(value)
        if not alive then return end
        endDrag()
        minimized = value
        local width = minimized and CONFIG.UI.MinimizedWidth or CONFIG.UI.Width
        local height = minimized and minimizedActions.getHeight() or CONFIG.UI.Height
        panel.Size = UDim2.fromOffset(width, height)
        minimize.Text = minimized and "+" or "-"
        minimizedControls.Visible = minimized
        title.Position = UDim2.fromOffset(minimized and 6 or 10, minimized and 4 or 8)
        title.Size = minimized and UDim2.new(1, -68, 0, 24) or UDim2.new(1, -128, 0, 36)
        title.TextSize = minimized and 14 or 17
        close.Position = minimized and UDim2.new(1, -30, 0, 4) or UDim2.new(1, -48, 0, 8)
        close.Size = UDim2.fromOffset(minimized and 24 or 36, minimized and 24 or 32)
        minimize.Position = minimized and UDim2.new(1, -58, 0, 4) or UDim2.new(1, -88, 0, 8)
        minimize.Size = UDim2.fromOffset(minimized and 24 or 32, minimized and 24 or 32)
        for _, object in ipairs({tabBar, address, content, footer, stop}) do
            object.Visible = not minimized
        end
        resize()
    end
    connect(minimize.Activated, function() setMinimized(not minimized) end)
    setMinimized(true)
end

do
    local notificationBox = make("TextLabel", minimizedControls, {
        Name = "MinimizedNotificationBox", Position = UDim2.fromOffset(0, 158), Size = UDim2.new(1, 0, 0, 24),
        BackgroundColor3 = colors.idle, BackgroundTransparency = 0, BorderSizePixel = 0, Visible = true,
        Text = "Notifications", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = colors.text,
        TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 5,
    })
    corner(notificationBox)
    minimizedActions.setNotificationZone = function(zoneId, maxZoneColossus)
        if minimizedActions.notificationZone ~= zoneId then minimizedActions.maxZoneColossus = false end
        minimizedActions.notificationZone = zoneId
        if maxZoneColossus ~= nil then minimizedActions.maxZoneColossus = maxZoneColossus end
    end
    minimizedActions.refreshNotification = function()
        local hasError = scriptErrors.hasAny()
        local complete = minimizedActions.maxZoneColossus == true
        local indicatorColor = hasError and Color3.fromRGB(165, 67, 79)
            or (complete and Color3.fromRGB(38, 148, 84) or colors.idle)
        local text = hasError and "Notifications: Error"
            or (complete and "Max zone + Colossus unlocked" or "Notifications")
        if notificationBox.BackgroundColor3 ~= indicatorColor then notificationBox.BackgroundColor3 = indicatorColor end
        if notificationBox.Text ~= text then notificationBox.Text = text end
    end
    minimizedActions.refreshNotification()
    connect(game:GetService("RunService").Heartbeat, minimizedActions.refreshNotification)
end

local stageGuide
local function selectTab(id)
    if stageGuide then stageGuide.Visible = false end
    selectedTab = id
    address.Text = "automation://" .. id
    for key, page in pairs(pages) do
        if tabs[key] then
            page.frame.Visible = key == id
            tabs[key].BackgroundColor3 = key == id and colors.surface or colors.bg
            tabs[key].TextColor3 = key == id and colors.text or colors.muted
        end
    end
end

local renderMutationSettings, refreshUnitCooldown, refreshMasterRequirements
local masterRequirementProgress = {}
local function recordMasterUnitCount(zoneId, matched)
    local progress = masterRequirementProgress[zoneId] or {}
    masterRequirementProgress[zoneId] = progress
    progress.matched = matched
    if refreshMasterRequirements then refreshMasterRequirements() end
end
local masterLayout = {}
do
    function masterLayout.stack(parent, spacing)
        make("UIListLayout", parent, {FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, spacing or 4)})
    end
    function masterLayout.text(parent, text, size, color)
        local object = label(parent, text, UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, 0), size or 13)
        object.AutomaticSize, object.TextColor3 = Enum.AutomaticSize.Y, color or colors.muted
        return object
    end
    function masterLayout.section(name, caption, layoutOrder, parent)
        local card = make("Frame", parent or masterLayout.body, {Name = name,
            LayoutOrder = layoutOrder, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = colors.bg, BorderSizePixel = 0})
        corner(card)
        make("UIPadding", card, {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})
        masterLayout.stack(card)
        local heading = masterLayout.text(card, caption, 12, colors.text)
        heading.Font = Enum.Font.GothamBold
        return card
    end
    function masterLayout.setting(parent, name, caption, hint)
        local slot = masterLayout.settingSlots[name]
        local row = make("Frame", parent:FindFirstChild("SettingsRow" .. slot[1]), {Name = name .. "Row",
            Position = UDim2.new(slot[2] * 0.5, slot[2] == 0 and 0 or 4, 0, 0),
            Size = UDim2.new(0.5, -4, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = colors.bg, BorderSizePixel = 0})
        corner(row)
        make("UIPadding", row, {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})
        local copy = make("Frame", row, {Size = UDim2.new(1, -52, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
        masterLayout.stack(copy, 3)
        masterLayout.text(copy, caption, 12, colors.text)
        masterLayout.text(copy, hint, 11)
        local toggle = button(row, "", UDim2.new(1, -44, 0, 0), UDim2.fromOffset(44, 24))
        toggle.Name, toggle.TextSize = name, 11
        return toggle
    end
end
assert(({master=true, sell=true, pickaxe=true, upgrades=true, upgradingOldUnit=true, unlockSlots=true, units=true, mutation=true, upgradingUnit=true, cycleEnd=true})[CONFIG.UI.InitialTab], "Invalid CONFIG.UI.InitialTab")

local specs = {
    {"master", "Master", "Start Master", "Runs enabled stages in order and repeats until stopped."},
    {"sell", "Sell", "Run Auto Sell", "1. Collect the chest at your plot.\n2. Teleport to the Hub and open the sell stand.\n3. Click Select All, then Sell.\n4. Return to your plot."},
    {"pickaxe", "Pickaxe", "Buy Best Pickaxe", "1. Check the current zone, then open, refresh, and close the shop.\n2. Find the highest unlocked pickaxe; at the max zone, also select the second highest.\n3. Check each saved count against the same limit and require its buy button to be green.\n4. Record and send one purchase request per eligible selection."},
    {"upgrades", "Upgrades", "Run Upgrades", "1. Read the current zone from your ZoneBoard.\n2. Recheck Colossus Pips as upgrades run.\n3. Prioritize eligible Density, then other available nodes.\n4. Turn stages 3-4 and 6-8 OFF as soon as Colossus Pips reach 1 or higher in the current zone; otherwise turn them ON.\nTurn Unlimited Best Pickaxe ON at the max zone and OFF in other zones. Check zone/Density fresh every cycle, including while OFF."},
    {"upgradingOldUnit", "Upgrade Old Units", "Run Upgrade Old Units", "1. Check that current-zone Density is 0.\n2. Find displayed units matching the previous zone's required names.\n3. Upgrade Damage toward the target, starting with the lowest level.\n4. Stop when the target is reached or further upgrades are unavailable."},
    {"unlockSlots", "Unlock slots", "Run Unlock slots", "Z4 only. Try each locked slot up to five times with a random one-stud offset and a two-second hold. Stop at the first slot still locked after five attempts; skip stages 6-8 that cycle. Once all slots unlock, skip this stage on later cycles."},
    {"units", "Required Units", "Run Required Units", "1. Check cooldown and clear the hotbar.\n2. Count whitelisted inventory copies plus displayed units.\n3. If eligible, remove displayed units.\n4. Fill empty unlocked pads using one stack at a time through hotbar 1."},
    {"mutation", "Mutate Units", "Run Mutate Units", "1. Check zone rules, Density, and Required Units preparation.\n2. Scan mutations in the first required unlocked holders.\n3. Roll eligible units below the active targets.\n4. Rescan until the targets are met or further rolls are unavailable."},
    {"upgradingUnit", "Upgrade Units", "Run Upgrade Units", "1. Check cooldown and scan the required lineup.\n2. Upgrade Damage to the allowed cap, with stat catch-up between batches.\n3. Finish Speed and MineSpeed catch-up on eligible units."},
    {"cycleEnd", "Cycle end", "Run Cycle end", "1. Equip Best and wait for the equip delay.\n2. Select Current Zone if enabled.\n3. Select Next Zone if enabled."},
}
for index, spec in ipairs(specs) do
    local id, name, runText, description = spec[1], spec[2], spec[3], spec[4]
    local tab = button(tabBar, name, UDim2.new((index - 1) / #specs, 2, 0, 0), UDim2.new(1 / #specs, -4, 1, 0))
    tab.TextSize = (id == "unlockSlots" or id == "units" or id == "mutation" or id == "upgradingUnit" or id == "upgradingOldUnit") and 11 or 13
    tab.TextWrapped = true
    if id == "units" then
        make("Frame", tabBar, {
            Name = "DecisionStageDivider", Position = UDim2.new((index - 1) / #specs, -1, 0, 5),
            Size = UDim2.new(0, 2, 1, -10), BackgroundColor3 = colors.accent, BorderSizePixel = 0,
        })
    end
    tabs[id] = tab
    runScope.masterAllowed[tab] = true
    local scrollable = id == "master" or id == "cycleEnd"
    local frame = make(scrollable and "ScrollingFrame" or "Frame", content,
        {Name = id, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false})
    if scrollable then
        frame.CanvasSize = UDim2.fromOffset(0, 0)
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        frame.ScrollingDirection = Enum.ScrollingDirection.Y
        frame.ScrollBarThickness = 4
        frame.BorderSizePixel = 0
    end
    local run, status
    if id == "master" then
        frame.ScrollBarImageColor3 = colors.muted
        masterLayout.body = make("Frame", frame, {Name = "MasterSections", Position = UDim2.fromOffset(18, 12),
            Size = UDim2.new(1, -36, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
        masterLayout.stack(masterLayout.body, 8)
        make("UIPadding", masterLayout.body, {PaddingBottom = UDim.new(0, 12)})
        local card = make("Frame", masterLayout.body, {Name = "MasterControls", LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
        masterLayout.stack(card, 4)
        masterLayout.titleRow = make("Frame", card, {Name = "MasterHeading",
            Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1})
        local heading = label(masterLayout.titleRow, "Master flow", UDim2.fromOffset(0, 0), UDim2.new(0.42, -8, 1, 0), 19)
        heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.text
        masterLayout.text(card, description, 12)
        run = button(card, runText, UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, 34))
        status = masterLayout.text(card, "Ready to start.", 12)
        status.Name = "MasterStatus"
        masterLayout.controls = card
    else
        local heading = label(frame, name, UDim2.fromOffset(18, 16), UDim2.new(1, -36, 0, 24), 19)
        heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.text
        label(frame, description, UDim2.fromOffset(18, 48), UDim2.new(1, -36, 0, 84), 13)
        run = button(frame, runText, UDim2.fromOffset(18, 140), UDim2.new(1, -36, 0, 38))
        status = label(frame, "Idle. Press the button to run once.", UDim2.fromOffset(18, 188), UDim2.new(1, -36, 0, 58), 12)
    end
    pages[id] = {frame = frame, run = run, status = status, runText = runText, name = name}
    connect(tab.Activated, function()
        selectTab(id)
        if refreshUnitCooldown then refreshUnitCooldown() end
        if id == "mutation" and renderMutationSettings then renderMutationSettings() end
        if id == "master" and refreshMasterRequirements then refreshMasterRequirements() end
    end)
    connect(run.Activated, function()
        if id == "master" and busy and activeRun == "master" then
            if stopRun then stopRun() end
        elseif startRun then
            startRun(id)
        end
    end)
end
pages.master.cooldown = label(masterLayout.titleRow, "Unit sequence: Ready",
    UDim2.new(0.42, 0, 0, 0), UDim2.new(0.58, 0, 1, 0), 12)
pages.master.cooldown.TextXAlignment, pages.master.cooldown.TextYAlignment = Enum.TextXAlignment.Right, Enum.TextYAlignment.Center
pages.units.cooldown = label(pages.units.frame, "Unit sequence: Ready",
    UDim2.fromOffset(18, 260), UDim2.new(1, -36, 0, 24), 14)
label(pages.units.frame, "Cooldown updates each cycle and when this tab opens.",
    UDim2.fromOffset(18, 288), UDim2.new(1, -36, 0, 22), 12)
pages.units.resetCooldown = button(pages.units.frame, "Reset Cooldown",
    UDim2.fromOffset(18, 322), UDim2.new(1, -36, 0, 36))
pages.units.resetCooldown.Name = "ResetSequenceCooldown"
local unitLevelList = make("ScrollingFrame", pages.upgradingUnit.frame, {
    Name = "UnitLevelCaps", Position = UDim2.fromOffset(18, 250),
    Size = UDim2.new(1, -36, 1, -262), BackgroundTransparency = 1,
    BorderSizePixel = 0, ScrollBarThickness = 5, CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
})
do
    local zones = {}
    for zoneId in pairs(CONFIG.Units.RequiredByZone) do table.insert(zones, zoneId) end
    table.sort(zones, function(a, b) return (tonumber(a:match("%d+")) or 0) < (tonumber(b:match("%d+")) or 0) end)
    for index, zoneId in ipairs(zones) do
        local cap = CONFIG.Units.RequiredByZone[zoneId].MaxLevelCap
        label(unitLevelList, zoneId .. " | Max level cap per unit: " .. tostring(cap),
            UDim2.fromOffset(6, (index - 1) * 28), UDim2.new(1, -24, 0, 24), 13)
    end
end
local mutationList = make("ScrollingFrame", pages.mutation.frame, {
    Name = "MutationSettings", Position = UDim2.fromOffset(18, 238),
    Size = UDim2.new(1, -36, 1, -250), BackgroundTransparency = 1,
    BorderSizePixel = 0, ScrollBarThickness = 5, CanvasSize = UDim2.fromOffset(0, 0),
    ScrollingDirection = Enum.ScrollingDirection.Y,
})
pages.master.status.Text = "OFF. Press Start Master to begin the cycle."
pages.mutation.status.Text = "Mutate only the first RequiredUnitCount unlocked holders. Zero tier counts and cached cycle density 2+ skip rolling."
pages.mutation.status.Size = UDim2.new(1, -36, 0, 40)
renderMutationSettings = function()
    for _, row in ipairs(mutationList:GetChildren()) do row:Destroy() end
    local zones = {}
    for zone in pairs(CONFIG.Units.RequiredByZone) do table.insert(zones, zone) end
    table.sort(zones, function(a, b)
        return (tonumber(a:match("%d+")) or 0) < (tonumber(b:match("%d+")) or 0)
    end)
    for index, zone in ipairs(zones) do
        local settings = CONFIG.Units.RequiredByZone[zone].RequiredMutations or {}
        local caption = string.format(
            "%s | Tier counts: %s\nDiamond: %d   Platinum: %d   Rainbow: %d\nFrozen: %d   Inferno: %d   Nightmare: %d   Unreal: %d",
            zone, hasMutationRequirements(settings) and "configured" or "none", settings.Diamond or 0, settings.Platinum or 0, settings.Rainbow or 0,
            settings.Frozen or 0, settings.Inferno or 0, settings.Nightmare or 0, settings.Unreal or 0)
        label(mutationList, caption, UDim2.fromOffset(6, (index - 1) * 76), UDim2.new(1, -24, 0, 70), 12)
    end
    mutationList.CanvasSize = UDim2.fromOffset(0, #zones * 76)
end
renderMutationSettings()
local stageToggles = {}
local function refreshStageToggles(locked)
    for _, id in ipairs(order) do
        local toggle = stageToggles[id]
        local enabled = preferences.stages[id]
        toggle.Text = enabled and "ON" or "OFF"
        toggle.BackgroundColor3 = enabled and colors.accent or colors.bg
        toggle.Active, toggle.AutoButtonColor = not locked, not locked
    end
end
local function setMasterStageState(id, text, color)
    -- Keep this compact column short; full details remain in the run status and stage tab.
    stageRows[id].Text = text:match("^Error") and "Error" or text
    stageRows[id].TextColor3 = color or colors.muted
end
local function resetStageRows()
    for _, id in ipairs(order) do
        setMasterStageState(id, preferences.stages[id] and "Waiting" or "OFF")
    end
end
do
    -- Preserve the original side-by-side overview: stages on the left, zone progress on the right.
    masterLayout.overview = make("Frame", masterLayout.body, {Name = "CompactOverview", LayoutOrder = 2,
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
    local card = masterLayout.section("StageSequence", "GENERAL STAGES", 0, masterLayout.overview)
    card.Size = UDim2.new(0.56, -4, 0, 0)
    card:FindFirstChildWhichIsA("TextLabel").TextColor3 = colors.accent
    for index, id in ipairs(order) do
        if id == "units" then
            local heading = masterLayout.text(card, "DECISION MAKING", 11, colors.accent)
            heading.Font = Enum.Font.GothamBold
        end
        local row = make("Frame", card, {Name = id .. "StageRow", Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1})
        local name = label(row, string.format("%d. %s", index, pages[id].name),
            UDim2.fromOffset(0, 0), UDim2.new(1, -118, 1, 0), 12)
        name.TextColor3, name.TextYAlignment = colors.text, Enum.TextYAlignment.Center
        local state = label(row, "", UDim2.new(1, -110, 0, 0), UDim2.new(0, 58, 1, 0), 10)
        state.Name, state.TextXAlignment, state.TextYAlignment = "StageState", Enum.TextXAlignment.Right, Enum.TextYAlignment.Center
        stageRows[id] = state
        local toggle = button(row, "", UDim2.new(1, -44, 0, 1), UDim2.fromOffset(44, 22))
        toggle.Name, toggle.TextSize = id .. "StageToggle", 11
        stageToggles[id] = toggle
        connect(toggle.Activated, function()
            if not alive or busy then return end
            preferences.stages[id] = not preferences.stages[id]
            savePreferences()
            refreshStageToggles(false)
            resetStageRows()
        end)
    end
    masterLayout.tools = make("Frame", masterLayout.body, {Name = "SessionTools", LayoutOrder = 3,
        Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1})
    masterLayout.automation = make("Frame", masterLayout.body, {Name = "AutomationSettings", LayoutOrder = 4,
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
    masterLayout.stack(masterLayout.automation, 8)
    masterLayout.settingSlots = {WorkspaceCleanupToggle = {1, 0}, DeleteOtherPlotsToggle = {1, 1},
        AutoDailySpinToggle = {2, 0}, AutoRedeemToggle = {2, 1}}
    masterLayout.automationRows = {}
    for index = 1, 2 do
        masterLayout.automationRows[index] = make("Frame", masterLayout.automation, {Name = "SettingsRow" .. index,
            LayoutOrder = index, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1})
    end
end
refreshStageToggles(false)
resetStageRows()
do
    local guides = {
        master = [[MASTER FLOW
Run enabled stages in the configured order. Each stage button can also run its stage once. Master repeats until stopped; saved Master/stage toggles are restored on load.

Before starting, save any pending Pickaxe limit edit when Pickaxe is enabled. Reject overlapping runs and rapid repeat clicks. Master turns off enchant rolling before starting the run. Fly keeps the character afloat throughout the active Master run, including between teleports, prompt holds, and cycle waits, and resumes after respawning. Master OFF, stopping the run, or unloading disables fly. Waiting for ZoneBoardGui and standalone stages do not enable fly.

Start each cycle with fresh cycle state. Wait for your owned plot's ZoneBoard.ZoneBoardGui.Root.List and readable zone locks, then confirm the current zone before settings, rewards, or stages. There is no separate game-load checker. Start Master fly after the first zone confirmation. At the start of the first Master cycle, check live game settings: turn Exotic/Mythical cutscenes and Mutations/Summons reveals OFF when their Content.BackgroundColor3 is (38, 148, 84), and turn NightMode ON when its Content.BackgroundColor3 is (80, 80, 80). Skip already-correct values and confirm each change; no settings completion file is used. During Master, read each setting Content.BackgroundColor3 and send a toggle request if it differs from the desired state. If confirmation fails, set PlayerGui.ScreenGui.CutGrassGame.SettingsFrame.Visible=true for 1 second, close it with Visible=false, then re-read and resend only while the setting is still wrong. Repeat until all five settings are confirmed. Tutorial Stage 0 performs the same live check. Check the shared unit-sequence cooldown once at cycle start. A ready cycle gets permission for Required Units, Upgrade Units, and enabled automatic Workspace cleanup before starting the shared timer. That permission stays fixed for the cycle. Workspace cleanup also runs with Required Units OFF. Zone changes and Reset Cooldown affect the next cycle's check. Other-plot/weather cleanup starts after Sell. Skip disabled stages, except Upgrades still prepares cached zone/Density values. Restore temporary movement and release held inputs after each stage. Pause between stages.

On a stage error, show its error, close Sell/skill-tree/inventory panels, and retry on the next cycle. Still attempt Cycle end if enabled. During the cycle delay, visit the pickaxe shop and click its first two purchase rows; see the Pickaxe guide. The minimized notification box turns red while a reported retry/stage error is active. Otherwise it turns green when the latest zone/Colossus scan confirms the highest configured zone with at least 1 valid Colossus Pip, and stays neutral in other cases. Red takes priority over green; recovery restores the applicable color. Expected mutation rolls are excluded.

Stop, Master OFF, unload, or the relevant shortcuts cancel active work, restore saved positions where available, and release prompts, keys, and focused panels.

MASTER CONTROLS
Stage toggles select the repeated flow. Reset Cooldown is in Required Units. A confirmed zone change resets the unit-sequence cooldown. The zone card shows cached requirements and observed progress.

Unlimited Best Pickaxe bypasses the saved limit for the highest unlocked pickaxe and, at the max zone, the second-highest unlocked pickaxe, while retaining separate per-ID request counts. Delete other plots / weather removes other plots and weather effects while enabled; rejoin to restore removed plots.

Ctrl+1 toggles Master; Ctrl+2 toggles enchant rolling; Ctrl+3 opens Altar; Ctrl+4 Events Board; Ctrl+5 Mailbox; Ctrl+6 Trial. Other action shortcuts are disabled while Master is ON. All shortcuts are ignored while typing.

HOTBAR UPGRADES
Refresh and select hotbar entries to process their copies through M1. This is a separate run, outside the nine-stage cycle. Use the same UpgradePart teleport and placement/pickup timing as Units, the Mutation stage panel opener, and the Upgrade Unit Stats session. Place each selected copy, check its identity, and mutate it to Unreal. Click Stats without closing the unit panel, then read Damage, Speed, and Mining levels. Upgrade only stats below their goals: Damage to the configured target and Speed/Mining to their available maxima. Use the regular Mutation stage focused-panel rank check before and after each rapid roll. Stop rolling as soon as that rank reaches Unreal, then click Stats in the same open UI. Before pickup, check the same focused mutation rank again, return to Stats, and verify all three levels. If the mutation is below Unreal, resume rolling in that same UI. If a returned unit leaves a multi-copy stack unchanged, continue other selected slots but report remaining indistinguishable copies as incomplete rather than counting repeated checks as new units. A unit already at Unreal with all upgrade goals met completes only its own check; continue through every remaining selected hotbar slot before reporting the batch finished. Before selecting each hotbar unit, including placement retries, set MineGui.HotbarFrame.Visible=true directly. If HotbarFrame or its slot container is missing, wait for it to load and enable Visible; do not open inventory to restore the hotbar. Stop on changed hotbar identity/count, missing M1 controls, or unavailable upgrades. Retry unconfirmed placement/pickup by returning to M1 with a different random one-stud horizontal offset and rechecking identity, occupancy, and stack consumption before activating its prompt again.]],
        sell = [[ACTIONS
1. Master waits for your owned plot's ZoneBoardGui and confirms the current zone before running stages. There is no separate game-load checker.
2. Teleport to your plot, wait, retry ChestFrame.Visible=true once per second until the chest UI is visible, collect the plot chest, and close it with Visible=false.
3. Teleport to the Hub. Move in front of the sell stand, face the camera toward it, and activate its prompts.
4. Hold the enabled sell prompt for its required duration, then wait for the game to open the sell window with visible ancestors. Each failed window retry returns the current character to a different random point exactly one horizontal stud from the usual stand position, stops residual movement, faces the stand, and activates its prompt again. Repeat until the window appears or the run is stopped.
5. Wait for a visible, active Select All button with a usable size, checking its name, text, or child caption. Click it once, wait, then wait for and click the separate Sell button. Wait the configured post-sale delay after Sell, then click SellFrame.Close once per second while SellFrame.Visible remains true. Return to your plot only after the frame closes.
6. Master closes the sell window after this stage.

CONDITIONS / STOPS
Only act while this Sell run remains active. Click buttons only when visible and with a usable size. Missing stand parts or SellFrame stop the stage with an error. Select All and Sell controls are polled until ready or stopped; prolonged retries report the buttons found. Configured delays separate teleports, prompts, selection, and sale.]],
        pickaxe = [[ACTIONS
1. Save pending limit edits before starting; the limit must be a whole number of zero or more.
2. Freshly check the current zone, then teleport to the pickaxe stand, wait for its enabled prompt, hold it long enough to open the shop, and wait for tiles to settle. Each unconfirmed opening retry returns beside the stand with a different random one-stud horizontal offset, then reactivates the prompt if the shop is still closed. Close the shop and restore position.
3. Scan stable tile identities/colors. Tile IDs start at 2 in child order. Choose the highest unlocked ID and, only in the highest configured zone, the second-highest unlocked ID. Sold-out or unaffordable unlocked tiles still count toward rank; locked tiles do not.
4. Load this account/game's saved per-ID request counts. Both selected IDs use the same saved limit and Unlimited Best Pickaxe setting, with separate request counts.
5. Process each selected ID independently, best first. Require its tile to remain present and buyable (green). Reserve one count, save it, read it back to verify, recheck the tile, and send one purchase request per eligible ID.

CONDITIONS / STOPS
Outside the max zone, only the highest unlocked ID is considered. At the max zone, independently consider the two highest unlocked IDs even if one is capped or unavailable; do not fall back to a third ID. No request is sent for a selected ID if its limit is reached or its tile is not buyable. Unlimited mode bypasses the limit only; requests are still counted.

Unavailable file functions, invalid or unreadable count data, a disappearing previously seen file, or unverifiable saves stop purchases. A count saved before a later cancellation or color change remains reserved. Counts represent reserved requests, rather than confirmed inventory purchases.

BETWEEN MASTER CYCLES
During the cycle delay, open the shop and click visible buy buttons on rows with LayoutOrder 1 then 2 at the configured click interval. These use VirtualInputManager mouse-down/up clicks with a 0.05-second hold, separate from this stage's best-pickaxe limit/count reservation. Close the shop and restore position when the wait ends or is stopped. A shop-wait error uses the rest of the cycle delay. The notification box remains active throughout.]],
        upgrades = [[ZONE / DENSITY SCAN
Read all of your owned plot's ZoneBoard rows in numeric order. ZoneRowN means ZN. Button.Lock.Visible true means locked; false means unlocked. The highest numbered row with its lock hidden is the current zone. Retry missing rows or Lock objects until stable. Set MineGui.SkillTreeFullFrame.Visible to true, then wait for Tree.Canvas and the matching Zone_ZN folder to read Density and Colossus data. The zone still comes from the ZoneBoard. Set Visible to false when finished. Cache the zone ID, folder name, and confirmed Density for the cycle. A changed zone clears the unit-sequence cooldown. The maximum configured zone is the highest numeric Z key in RequiredByZone, with no fixed zone-number limit.

Open and close SkillTreeFullFrame through its Visible property. Main automation does not use chest recovery; the tutorial retains its own behavior.

Density is the highest green/upgraded Density node. Unknown node colors or an unsettled/missing tree are retried until ready or stopped; prolonged retries log errors. Confirmed Density 2+ stops mutation for that zone; a later confirmed lower Density clears a stale stop flag. Hide and save the tutorial button at Z2+ or at Z1 with Density 1+.

UPGRADE SELECTION
Recheck Colossus progress before and during upgrades. Prioritize the next available Density node. Density II requires every exact required slot M1..M<RequiredUnitCount> to hold a current-zone whitelisted unit at Diamond or higher, plus configured mutation quotas. RequiredUnitCount zero passes this gate.

Before Density is fully upgraded, other available nodes must be above its next-node row or on the same row within the configured tolerance. Rank them by horizontal distance, then row height, then name. When Density is maxed, consider all available non-Density nodes.

Use configured node-category mappings, falling back to the node base name. Skip invalid categories. Recheck the node, its color, and the Density II gate before each purchase. Retry while the node remains available, respecting the request delay and reporting prolonged retries. Stop processing a node when it disappears, becomes unavailable, or valid Colossus Pips reach 1 or higher in the current zone. Rescan Density and count confirmed green upgrades; repeat while upgrades are confirmed.

COLOSSUS / NOTIFICATIONS
Positive valid Colossus Pips confirms the unlock. Turn stages 3-4 and 6-8 OFF as soon as valid Colossus Pips reach 1 or higher (for example 1/5), in any current zone; otherwise turn stages 3-4 and 6-8 ON. Turn Unlimited Best Pickaxe ON at the max zone, even without positive Colossus Pips, and OFF in other zones. Send a Discord alert with username, zone name/ID, and Pips only when the player is in the highest configured zone and has at least 1 valid Colossus Pip. Reaching the max zone alone or unlocking Colossus in a lower zone does not send an alert.

The message ends its elapsed-time line with @everyone. Time is measured from the account/game's cached first script load, including restarts and offline time. Old caches missing a valid timestamp start tracking on their next load. Under one hour displays unknown. A valid saved timestamp is retained.

The combined max-zone + Colossus alert uses the Colossus sent flag per zone. Pending requests suppress duplicates in the current run; successful HTTP responses save the sent flag in the preferences cache. Failed requests can be retried on later checks. Missing webhook/request support skips sending. A cache-save failure is warned because it can allow a repeat after restarting.

WHEN UPGRADES IS OFF
In Master, freshly read the ZoneBoard zone, Density, and Colossus Pips every cycle, including while Upgrades is OFF. Open the skill tree by enabling SkillTreeFullFrame.Visible, wait for Tree.Canvas and the board-selected zone, then read upgrade data and send requests. Missing or unsettled Density data is retried until ready or stopped. Recheck Colossus progress in the current zone. If valid Colossus Pips have not reached 1, turn stages 3-4 and 6-8 ON and resume Upgrades in the same cycle. Turn Unlimited Best Pickaxe ON at the max zone and OFF in other zones. These scans also prepare zone selection and tutorial hiding.

FINISH
Disable SkillTreeFullFrame.Visible to close the skill tree and keep the zone/Density values ready for Cycle end. Stop and unload also close a frame opened by the script. Current/next selection follows its toggles; a standalone Upgrades run selects zones immediately after finishing.]],
        upgradingOldUnit = [[ENTRY CONDITIONS
Use the cached current zone and Density. Run only at Density 0. Z1 has no previous zone and is skipped. Skip if the previous numbered zone has no configured Names.

ACTIONS
1. Check plot ownership and scan displayed numbered holders.
2. Read each unit's displayed name. Include only exact matches in the previous zone's Names list; skip other or unreadable names.
3. Upgrade Damage only, toward each unit's own maximum Damage level read from its Stats panel. Work on the lowest Damage level first, breaking ties by holder number, in batches of up to five requests.
4. Open the correct unit panel and require a green Damage button. Recheck unit identity/ownership and confirm a level or button-color response after each request. Close focus between batches.

STOPS
Skip if no displayed unit matches. Stop a unit at the target or when Damage is unavailable; stop with an error if ownership, identity, character, required controls, or expected response is lost. This stage does not run Speed/MineSpeed catch-up.]],
        units = [[ENTRY CONDITIONS
Require Density 1 or higher in Z1-Z11, or Density 0 or higher in Z12 and above. Use the shared cooldown permission granted at Master cycle start; manual runs check the cooldown directly. Without permission, keep displayed units and skip. Reset Cooldown clears it; a new zone resets it. Validate the equipment mode, use cached zone/Density, and check plot ownership. Manual runs start the sequence cooldown here; Master keeps the timer started at cycle entry.

AVAILABILITY CHECK
Clear occupied hotbar assignments, open InventoryFrame with Visible=true, and count current-zone whitelisted copies directly from inventory, including stack quantities. Close inventory with Visible=false. Skip unreadable Damage values. Add matching displayed units to this inventory count; no inventory card is selected during the check. If insufficient, FinalEquipMode is Best, or Density is below the current zone minimum, keep displayed units and skip replacement/mutation preparation. Equip Best is handled at Cycle end.

REPLACEMENT / PLACEMENT
Once eligible, require a ready character, close panels, and remove all displayed units with confirmed pickup retries. Clear occupied hotbar assignments again, open inventory, and recheck available matching copies plus units already placed in required pads.

Rank eligible inventory stacks by highest Damage, then preserve inventory order on equal Damage. Select only the highest ranked stack into hotbar 1. Confirm its stack quantity and that other hotbar slots are empty, keep inventory open, and place its copies in empty unlocked pads in holder-number order. Finish placing the selected stack before fetching another inventory card; confirm hotbar 1 is empty before loading another stack. Continue until every unlocked empty pad is filled, including pads beyond RequiredUnitCount, or no eligible inventory copies remain. RequiredUnitCount stays the minimum count gate. Keep inventory open between placement batches and close it when placement finishes or stops for insufficient copies.

If selection confirmation fails, recheck for delayed success, reacquire the same card, and retry without clearing the selected stack or cycling inventory closed and open. Unreadable quantities, UI waits, pickup, and placement retry without timeouts and report periodic errors. Preserve character, plot, hotbar identity, focus/text-field, and held-input checks.

MUTATION READINESS
Confirm whitelisted units occupy every required pad and provide that displayed-unit count to later stages. Partial/failed preparation, Density below the current zone minimum, and cooldown skips keep Mutate Units locked.]],
        mutation = [[ENTRY CONDITIONS
Use the cached zone/Density. Skip at Density 2+, when all RequiredMutations tier counts are zero, or when full Required Units preparation/count confirmation did not complete this cycle.

Validate configured tier counts and RequiredUnitCount; quota totals cannot exceed that count. Select only the first RequiredUnitCount unlocked holders by holder number. Require all selected holders to contain readable displayed mutations. Extra holders are excluded.

TARGETS
All required units must reach Diamond or higher. Higher mutation ranks can satisfy lower-rank quotas; cumulative counts reserve the higher requirements first. Choose the lowest-ranked required unit, breaking ties by holder number.

ROLL ACTIONS
Move to the selected holder, open its unit panel and Mutation tab, and require a green or orange Roll button. Recheck ownership, selected-holder scope, and the Density II stop flag before sending a roll.

For Inferno/Nightmare/Unreal requirements, keep focus and rapidly roll toward the highest unmet cumulative target. Read the focused mutation after each roll. If a holder label is behind, reopen the same unit and verify its current panel mutation instead of waiting for an old exact-match label. Accept a higher displayed mutation; use the freshly verified panel value when the display is lower. Otherwise send one roll, wait, close focus, and rescan.

STOP / COMPLETE
Stop when required slots satisfy their Diamond minimum and applicable quotas, funds are unavailable, Density II is confirmed, required holders disappear, mutation text is unreadable, the character/plot changes, or a panel/scan times out. Update observed mutation progress as rolls complete and close focus during cleanup. Zero tier counts skip rolling but do not remove the Diamond requirement used by full Damage and Density II gates.]],
        upgradingUnit = [[ENTRY CONDITIONS
Use the shared cooldown permission granted at Master cycle start. Manual runs check the shared cooldown directly and start a sequence only when ready. Consume that allowance for this run. Validate cached Density, check plot ownership, close previous focus, and scan displayed units.

FULL DAMAGE GATE
The exact required slots must all be displayed, match current-zone Names, and be Diamond or higher. Configured mutation quotas must pass. If the gate fails, only displayed current-zone whitelisted units receive Damage toward level 10; no other units receive Damage in that branch.

WHEN THE GATE PASSES
Upgrade matching required units toward the zone MaxLevelCap. Confirm required units at cap before allowing Damage on cached extra displayed holders. Recheck the required lineup/quotas after core upgrades. Extras must still be displayed and cached. Their Damage target is half their own actual maximum from the Stats panel, rounded down; the zone MaxLevelCap does not limit extra Damage. The gate can fail when required count is zero; that does not grant unrestricted Damage upgrades.

BATCHES / STAT CATCH-UP
Choose the lowest Damage level first, then holder number, with up to the current zone's DamageBatchSize requests per batch (default 5). Require a green button and confirm each level/color response. On the full-cap path, catch up that same unit immediately after each Damage batch, before any further Damage upgrades on any unit. Refresh its Speed/Mining levels and maxima from the Stats panel and catch up to the lesser of its current Damage and each stat maximum. If catch-up is unavailable, pause further Damage.

Cache identities and initial Damage/Speed/Mining levels for this run. Refresh Speed/Mining readings for each unit during catch-up. Include current-zone whitelisted units, units already at the configured stat minimum, and extras when a valid core exists. After Damage processing, catch up Speed and MineSpeed for cached displayed units at or above the minimum Damage level, regardless of their name. Balance the lowest stat levels in batches of up to five; cap each at the lesser of current Damage and that stat's maximum.

STOPS
Unavailable upgrade buttons stop progress rather than sending requests. Unfinished stat catch-up pauses further Damage. Identity, plot, character, display, focus-target, unreadable-level, or invalid-response failures stop the stage. Close the focused unit panel on exit.]],
        unlockSlots = [[ACTIONS
1. Run only in Z4. Scan all numbered holder slots in numeric order before Required Units. Compare trimmed, lowercase ActionText only to the exact values "unlock" and "unlock at the hub"; ignore other text containing "unlock".
2. If no matching unlock prompts are found, skip this stage and continue stages 6-8 normally. Otherwise move to the lowest matching locked slot, unequip tools, and activate its enabled prompt.
3. Make up to five attempts per locked slot. Every attempt teleports using a different random one-stud horizontal offset and holds the unlock prompt for two seconds. During Master, fly stays enabled for the whole run. After every failed attempt, send a fresh Equip Best request.
4. Confirm the slot now offers Place or Pick Up before attempting any higher matching locked slot, with its own five-attempt limit. A previously targeted lower slot not confirmed unlocked blocks higher slots; unrelated prompt text is ignored. Stop at the first matching slot still locked after five attempts. Reacquire prompts and recheck the exact ActionText before teleporting and holding.

UNIT-STAGE RECOVERY
A slot that stays locked after five attempts skips stages 6-8 for the current cycle; Cycle end still runs if enabled. If all slots unlock, stages 6-8 run normally and future cycles skip Unlock slots for that plot. If Required Units (stage 6) reports a required slot without its unlocked placement prompt in Z4, clear the completed-unlock state and return to this stage with the same five-attempt limit; stages 6-8 stay skipped for that failed cycle. Saved stage toggles stay unchanged.

STOPS
Stop/unload cancels retries, releases held input, and disables Master fly. Other zones skip this stage. Retry Equip Best requests do not suppress the normal Cycle end Equip Best request.]],
        cycleEnd = [[ACTIONS
1. Check plot ownership. Request Equip Best, wait the configured delay, and refresh observed mutation progress when a zone is known. A repeated cycle-end request in the same cycle is skipped.
2. Select the cached current zone if its toggle is ON.
3. Select the next numbered zone if its toggle is ON.

ZONE-SELECTION CONDITIONS
Selection runs only if Upgrades has prepared zone/Density values. It can use the scan prepared while Upgrades is OFF. Both toggles OFF skips zone selection. Next means the cached zone number plus one; this requests selection without claiming the next zone is unlocked.

MASTER / STANDALONE
Master attempts this stage after normal stages, including after a stage error, when Cycle end is enabled. Its own failure is reported and retried in later cycles. A standalone run may Equip Best while zone selection is skipped because no cycle scan is ready. Slot unlocking is handled only by the Z4 Unlock slots stage.]],
    }
    local common = "\n\nRUN SAFETY\nRun buttons start work only while idle and outside the click debounce. Stop/unload cancels active work and releases held inputs. Stages that move temporarily restore saved position where available. Missing required game objects, invalid settings, changed targets, or prolonged confirmation retries are reported as errors in the script logs; see Master for retry behavior."
    stageGuide = make("Frame", content, {
        Name = "StageActionsAndConditions", Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = colors.surface, BorderSizePixel = 0, Visible = false, Active = true, ZIndex = 30,
    })
    local guideHeading = label(stageGuide, "Actions & conditions", UDim2.fromOffset(18, 16), UDim2.new(1, -124, 0, 26), 16)
    guideHeading.Font, guideHeading.TextColor3 = Enum.Font.GothamBold, colors.text
    local back = button(stageGuide, "Back", UDim2.new(1, -86, 0, 12), UDim2.fromOffset(68, 30))
    local scroll = make("ScrollingFrame", stageGuide, {
        Name = "GuideScroll", Position = UDim2.fromOffset(18, 54), Size = UDim2.new(1, -36, 1, -72),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 5,
        CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
    })
    local body = label(scroll, "", UDim2.fromOffset(0, 0), UDim2.new(1, -16, 0, 0), 14)
    body.Name, body.AutomaticSize, body.TextColor3 = "GuideText", Enum.AutomaticSize.Y, colors.text
    runScope.masterAllowed[back] = true
    connect(back.Activated, function() stageGuide.Visible = false end)
    for _, spec in ipairs(specs) do
        local id, page = spec[1], pages[spec[1]]
        local position = id == "master" and UDim2.fromOffset(0, 0) or UDim2.new(1, -196, 0, 14)
        local size = id == "master" and UDim2.new(1 / 3, -4, 0, 28) or UDim2.fromOffset(178, 28)
        local open = button(id == "master" and masterLayout.tools or page.frame, "Actions & conditions", position, size)
        open.Name, open.TextSize = "OpenStageGuide", 11
        runScope.masterAllowed[open] = true
        connect(open.Activated, function()
            local settings = {}
            if id == "master" then
                table.insert(settings, string.format("Stage delay: %gs. Cycle delay: %gs. Hotbar Damage target: %d.",
                    CONFIG.Flow.StageDelay, CONFIG.Flow.CycleDelay, CONFIG.HotbarUpgrade.DamageTargetLevel))
            elseif id == "sell" then
                table.insert(settings, string.format("Teleport wait: %gs. Chest wait: %gs. Stand wait: %gs. Shop waits: unlimited. Select All wait: %gs. Sale wait: %gs.",
                    CONFIG.Sell.TeleportDelay, CONFIG.Sell.ChestDelay, CONFIG.Sell.StandDelay,
                    CONFIG.Sell.SelectAllDelay, CONFIG.Sell.SellDelay))
            elseif id == "pickaxe" then
                table.insert(settings, string.format("Default limit: %d per ID (saved edits take priority). Unlimited best: %s. Between-cycle click interval: %gs.",
                    CONFIG.Pickaxe.DefaultMaxPerID, tostring(CONFIG.Pickaxe.UnlimitedBestPickaxe), CONFIG.Pickaxe.WaitingClickDelay))
            elseif id == "upgrades" then
                table.insert(settings, string.format("Per-node requests: unlimited while available. Request delay: %gs. Row tolerance: %g.",
                    CONFIG.Upgrades.RequestDelay, CONFIG.Upgrades.RowScaleTolerance))
            elseif id == "upgradingOldUnit" then
                table.insert(settings, "Old-unit Damage target: each unit's own maximum from its Stats panel.")
            elseif id == "units" then
                table.insert(settings, string.format("Equipment mode: %s. Sequence cooldown: %gs. Removal/placement retries: unlimited.",
                    CONFIG.Units.FinalEquipMode, CONFIG.Units.SequenceCooldown))
            elseif id == "mutation" then
                table.insert(settings, "Mutation order: " .. table.concat(CONFIG.Mutation.Priority, " < "))
            elseif id == "upgradingUnit" then
                table.insert(settings, string.format("Stat catch-up starts at Damage %d. Sequence cooldown: %gs.",
                    CONFIG.Units.StatUpgrade.MinimumDamageLevel, CONFIG.Units.SequenceCooldown))
            elseif id == "cycleEnd" then
                table.insert(settings, string.format("Equip Best delay: %gs. Select current: %s. Select next: %s.",
                    CONFIG.Units.BestEquipDelay, tostring(CONFIG.Upgrades.SelectCurrentZone), tostring(CONFIG.Upgrades.SelectNextZone)))
            end
            if id == "upgrades" or id == "upgradingOldUnit" or id == "units" or id == "mutation" or id == "upgradingUnit" then
                local zones = {}
                for zoneId in pairs(CONFIG.Units.RequiredByZone) do table.insert(zones, zoneId) end
                table.sort(zones, function(a, b) return (tonumber(a:match("%d+")) or 0) < (tonumber(b:match("%d+")) or 0) end)
                table.insert(settings, "\nZONE SETTINGS (from the current config)")
                for _, zoneId in ipairs(zones) do
                    local rule = CONFIG.Units.RequiredByZone[zoneId]
                    local rows = {zoneId .. " - " .. (rule.DisplayName or zoneId)}
                    if id == "upgrades" or id == "upgradingUnit" then
                        table.insert(rows, "Damage cap: " .. tostring(rule.MaxLevelCap) .. "; required units: " .. tostring(rule.RequiredUnitCount))
                    end
                    if id == "upgradingUnit" then table.insert(rows, "Damage batch size: " .. tostring(rule.DamageBatchSize == nil and 5 or rule.DamageBatchSize)) end
                    if id == "units" then table.insert(rows, "Required units: " .. tostring(rule.RequiredUnitCount)) end
                    if id ~= "mutation" then table.insert(rows, "Names: " .. (#(rule.Names or {}) > 0 and table.concat(rule.Names, ", ") or "none")) end
                    if id == "mutation" or id == "upgrades" or id == "upgradingUnit" then
                        local mutations = rule.RequiredMutations or {}
                        local quotas = {}
                        for _, name in ipairs({"Platinum", "Rainbow", "Frozen", "Inferno", "Nightmare", "Unreal"}) do
                            table.insert(quotas, name .. "=" .. tostring(mutations[name] or 0))
                        end
                        table.insert(rows, "Mutation tier counts configured: " .. tostring(hasMutationRequirements(mutations))
                            .. "; required units: " .. tostring(rule.RequiredUnitCount) .. "; " .. table.concat(quotas, ", "))
                    end
                    table.insert(settings, table.concat(rows, "\n"))
                end
            end
            guideHeading.Text = page.name .. " - guide"
            body.Text = guides[id] .. common .. "\n\nCURRENT SETTINGS\n" .. table.concat(settings, "\n\n")
            scroll.CanvasPosition = Vector2.zero
            stageGuide.Visible = true
        end)
    end
end

do
    local refresh = button(masterLayout.tools, "Refresh script", UDim2.new(1 / 3, 2, 0, 0), UDim2.new(1 / 3, -4, 0, 28))
    refresh.Name, refresh.TextSize = "RefreshScriptOnce", 12
    runScope.masterAllowed[refresh] = true
    local refreshing = false
    connect(refresh.Activated, function()
        if not alive or refreshing then return end
        refreshing = true
        refresh.Active, refresh.AutoButtonColor = false, false
        refresh.Text = "Refreshing script..."
        local ok, message = pcall(function()
            -- Leave disk caches untouched; finish unloading before fetching/executing code.
            assert(unloadScript(), "Old script cleanup failed; replacement was not started. See [Cleanup] warnings.")
            local nonce = HttpService:GenerateGUID(false)
            local function getFresh(url)
                url = url .. "?refresh=" .. nonce
                local body
                if type(request) == "function" then
                    local response = request({Url = url, Method = "GET", Headers = {
                        ["Cache-Control"] = "no-cache, no-store", ["Pragma"] = "no-cache",
                        ["User-Agent"] = "AutomationRefresh", ["Accept"] = "application/vnd.github+json",
                    }})
                    local status = type(response) == "table" and tonumber(response.StatusCode)
                    assert(status and status >= 200 and status < 300,
                        "GitHub download failed (HTTP " .. tostring(status or "unknown") .. ").")
                    body = response.Body
                else
                    body = game:HttpGet(url)
                end
                assert(type(body) == "string" and body:find("%S"), "GitHub returned an empty response.")
                return body
            end
            -- Resolve main first, then pin the download to that exact commit instead of a cached branch URL.
            local ref = HttpService:JSONDecode(getFresh("https://api.github.com/repos/championsDecay/s/git/ref/heads/main"))
            local sha = type(ref) == "table" and type(ref.object) == "table" and ref.object.sha
            assert(type(sha) == "string" and #sha == 40 and sha:match("^%x+$"), "GitHub returned an invalid main commit.")
            local source = getFresh("https://raw.githubusercontent.com/championsDecay/s/" .. sha .. "/main.luau")
            local chunk, compileError = loadstring(source, "@github/championsDecay/s/" .. sha .. "/main.luau")
            assert(chunk, "Updated script did not compile: " .. tostring(compileError))
            assert(_G.__AUTOMATION_KILL == nil, "Another script started during refresh; replacement was skipped.")
            consolePrint("[Refresh Script] Loading GitHub commit " .. sha:sub(1, 12))
            chunk()
        end)
        if not ok then consoleWarn("[Refresh Script] " .. tostring(message)) end
    end)
end

do
    local copyLogs = button(masterLayout.tools, "Copy logs", UDim2.new(2 / 3, 4, 0, 0), UDim2.new(1 / 3, -4, 0, 28))
    copyLogs.Name, copyLogs.TextSize = "CopyScriptLogs", 12
    runScope.masterAllowed[copyLogs] = true
    connect(copyLogs.Activated, function()
        if not alive then return end
        local copy = type(setclipboard) == "function" and setclipboard
            or type(toclipboard) == "function" and toclipboard
            or type(setrbxclipboard) == "function" and setrbxclipboard
        if not copy then
            footer.Text = "Clipboard is unavailable in this executor."
            return
        end
        if #scriptLogs == 0 then
            footer.Text = "No script logs have been recorded in this session yet."
            return
        end
        local ok, message = pcall(copy, logging.export())
        if not alive then return end
        if ok then
            footer.Text = string.format("Copied %d grouped log entries (latest 2000 this session).", #scriptLogs)
        else
            footer.Text = "Could not copy script logs: " .. tostring(message)
        end
    end)
end

do
    local toggle = masterLayout.setting(masterLayout.automation, "WorkspaceCleanupToggle", "Clean workspace extras",
        "Works with Required Units OFF; shares its cooldown.")
    local function refresh()
        local enabled = CONFIG.General.WorkspaceCleanupEnabled
        toggle.Text = enabled and "ON" or "OFF"
        toggle.BackgroundColor3 = enabled and colors.accent or colors.bg
    end
    pages.master.refreshWorkspaceCleanupToggle = refresh
    connect(toggle.Activated, function()
        if not alive then return end
        CONFIG.General.WorkspaceCleanupEnabled = not CONFIG.General.WorkspaceCleanupEnabled
        savePreferences()
        refresh()
        modules.workspaceCleanup.refresh()
    end)
    refresh()
end

do
    local features = {
        {key = "dailySpinEnabled", name = "AutoDailySpinToggle", caption = "Daily spin",
            hint = "Checked each cycle; once per 24 hours + 10 seconds."},
        {key = "autoRedeemEnabled", name = "AutoRedeemToggle", caption = "Redeem codes",
            hint = "Sends each new code once, 2 seconds apart."},
    }
    for _, feature in ipairs(features) do
        local toggle = masterLayout.setting(masterLayout.automation, feature.name, feature.caption, feature.hint)
        local function refresh()
            local enabled = preferences[feature.key]
            toggle.Text = enabled and "ON" or "OFF"
            toggle.BackgroundColor3 = enabled and colors.accent or colors.bg
        end
        connect(toggle.Activated, function()
            if not alive then return end
            preferences[feature.key] = not preferences[feature.key]
            savePreferences()
            refresh()
        end)
        refresh()
    end
end

do
    local card = masterLayout.section("KeyboardShortcuts", "SHORTCUTS", 6)
    for _, pair in ipairs({{"Ctrl+1  Master on/off", "Ctrl+2  Enchant roll on/off"},
        {"Ctrl+3  Altar", "Ctrl+4  Events Board"}, {"Ctrl+5  Mailbox", "Ctrl+6  Trial"}}) do
        local row = make("Frame", card, {Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1})
        for column, text in ipairs(pair) do
            local item = label(row, text, UDim2.new((column - 1) * 0.5, 0, 0, 0), UDim2.new(0.5, -4, 1, 0), 12)
            item.TextColor3 = colors.text
        end
    end
    masterLayout.text(card, "Works expanded or minimized. Other actions are disabled while Master is ON. Ignored while typing.", 11)
end

do
    local toggle = masterLayout.setting(masterLayout.automation, "DeleteOtherPlotsToggle", "Clear other plots and weather",
        "Keeps your plot; rejoin to restore removed effects.")
    local function refresh()
        local enabled = CONFIG.General.DeleteOtherPlots
        toggle.Text = enabled and "ON" or "OFF"
        toggle.BackgroundColor3 = enabled and colors.accent or colors.bg
    end
    connect(toggle.Activated, function()
        if not alive then return end
        CONFIG.General.DeleteOtherPlots = not CONFIG.General.DeleteOtherPlots
        savePreferences()
        refresh()
        if CONFIG.General.DeleteOtherPlots then modules.plotCleanup.start()
        else modules.plotCleanup.stop() end
    end)
    refresh()
end

do
    local card = masterLayout.section("ZoneRequirements", "Zone requirements", 0, masterLayout.overview)
    card.Position, card.Size = UDim2.new(0.56, 4, 0, 0), UDim2.new(0.44, -4, 0, 0)
    masterLayout.zone = card
    local heading = card:FindFirstChildWhichIsA("TextLabel")
    local zone = masterLayout.text(card, "Zone: --", 12, colors.text)
    local density = masterLayout.text(card, "Density level: --", 12, colors.text)
    local count = masterLayout.text(card, "Required units: --", 12, colors.text)
    local mutation = masterLayout.text(card, "Waiting for Upgrades to detect the zone.", 11)
    local quotas = masterLayout.text(card, "", 11)
    local lastZone, lastDensity
    refreshMasterRequirements = function(zoneId, densityLevel)
        if zoneId and zoneId ~= lastZone then lastDensity = nil end
        lastZone = zoneId or lastZone
        if densityLevel ~= nil then lastDensity = densityLevel end
        local rule = lastZone and CONFIG.Units.RequiredByZone[lastZone]
        zone.Text = lastZone and string.format("Zone %s: %s", lastZone:match("^Z(%d+)$") or lastZone,
            (rule and rule.DisplayName) or "Unknown name") or "Zone: --"
        density.Text = "Density level: " .. (lastDensity ~= nil and tostring(lastDensity) or "--")
        if not rule then
            heading.Text = "Zone requirements"
            count.Text = "Required units: --"
            mutation.Text = lastZone and "No requirements configured for this zone." or "Waiting for Upgrades to detect the zone."
            quotas.Text, quotas.Visible = "", false
            return
        end
        local settings = rule.RequiredMutations or {}
        heading.Text = "Zone requirements"
        local progress = masterRequirementProgress[lastZone] or {}
        local required = rule.RequiredUnitCount or 0
        count.Text = string.format("Required units: %s / %s", progress.matched == nil and "--" or tostring(progress.matched), tostring(required))
        local mutations = progress.mutations
        local diamondCurrent = mutations and tostring(mutations.Diamond) or "--"
        local quotaTotal = 0
        for _, name in ipairs({"Platinum", "Rainbow", "Frozen", "Inferno", "Nightmare", "Unreal"}) do
            quotaTotal = quotaTotal + (settings[name] or 0)
        end
        local diamondGoal = math.max(0, required - quotaTotal)
        local state = hasMutationRequirements(settings) and "Tier quotas set" or "No tier quotas"
        local diamondText = required > 0 and (diamondCurrent .. "/" .. tostring(diamondGoal)) or "Not required"
        mutation.Text = string.format("Mutations: %s\nDiamond+: %s", state, diamondText)
        local entries = {}
        if hasMutationRequirements(settings) then
            for _, name in ipairs({"Platinum", "Rainbow", "Frozen", "Inferno", "Nightmare", "Unreal"}) do
                local goal = settings[name] or 0
                if goal > 0 then
                    local current = mutations and tostring(mutations[name] or 0) or "--"
                    table.insert(entries, name .. ": " .. current .. "/" .. tostring(goal))
                end
            end
        end
        local rows = {}
        for index = 1, #entries, 2 do
            table.insert(rows, entries[index] .. (entries[index + 1] and ("   " .. entries[index + 1]) or ""))
        end
        quotas.Text, quotas.Visible = table.concat(rows, "\n"), #rows > 0
        quotas.TextColor3 = hasMutationRequirements(settings) and colors.text or colors.muted
    end
    refreshMasterRequirements()
end
selectTab(CONFIG.UI.InitialTab)

local function stageStatus(id)
    return setmetatable({}, {
        __index = function(_, key) return pages[id].status[key] end,
        __newindex = function(_, key, value)
            if not alive then return end
            pages[id].status[key] = value
            if activeRun == "master" and activeStage == id and (key == "Text" or key == "TextColor3") then
                pages.master.status[key] = key == "Text" and (pages[id].name .. ": " .. value) or value
            elseif activeRun == "autoSequence" and activeStage == id and pages.autoSequence
                and (key == "Text" or key == "TextColor3") then
                pages.autoSequence.status[key] = key == "Text" and (pages[id].name .. ": " .. value) or value
            end
        end,
    })
end

local function visible(object)
    if not object or not object:IsDescendantOf(playerGui) then return false end
    while object and object ~= playerGui do
        if object:IsA("GuiObject") and not object.Visible then return false end
        if object:IsA("ScreenGui") and not object.Enabled then return false end
        object = object.Parent
    end
    return true
end

local function resolveButton(object)
    if not object then return nil, "Object is missing" end
    if object:IsA("GuiButton") then return object end
    local buttons, names = {}, {}
    for _, child in ipairs(object:GetDescendants()) do
        if child:IsA("GuiButton") and visible(child) then
            table.insert(buttons, child)
            table.insert(names, child:GetFullName())
        end
    end
    if #buttons == 1 then return buttons[1] end
    local description = object:GetFullName() .. " [" .. object.ClassName .. "]"
    if #buttons == 0 then return nil, description .. " has no visible GuiButton inside it" end
    return nil, description .. " contains multiple buttons: " .. table.concat(names, ", ")
end

local function clickButton(object)
    checkAlive()
    if type(firesignal) ~= "function" then error("This environment needs firesignal.", 0) end
    local target, reason = resolveButton(object)
    if not target then error("Cannot click: " .. reason, 0) end
    if not visible(target) then error("Button is hidden: " .. target:GetFullName(), 0) end
    local eventName = CONFIG.General.DefaultClickEvent
    if type(getconnections) == "function" then
        for _, name in ipairs({"Activated", "MouseButton1Click"}) do
            local ok, handlers = pcall(getconnections, target[name])
            if ok and type(handlers) == "table" then
                local found = false
                for _, handler in pairs(handlers) do
                    if handler.Enabled ~= false then found = true; break end
                end
                if found then eventName = name; break end
            end
        end
    end
    checkAlive()
    if eventName == "Activated" then firesignal(target.Activated, nil, 1)
    else firesignal(target.MouseButton1Click) end
end

local getMyPlot

local function chestTopPosition(chest, base, character, root, position, maxDistance)
    -- Include solid/visible chest geometry, but ignore invisible non-solid prompt volumes.
    local minimum = Vector3.new(math.huge, math.huge, math.huge)
    local maximum = Vector3.new(-math.huge, -math.huge, -math.huge)
    local parts = chest:GetDescendants()
    if chest:IsA("BasePart") then table.insert(parts, chest) end
    local found = false
    local function includePart(part)
        found = true
        for x = -1, 1, 2 do
            for y = -1, 1, 2 do
                for z = -1, 1, 2 do
                    local corner = part.CFrame:PointToWorldSpace(Vector3.new(part.Size.X * x * 0.5,
                        part.Size.Y * y * 0.5, part.Size.Z * z * 0.5))
                    minimum = Vector3.new(math.min(minimum.X, corner.X), math.min(minimum.Y, corner.Y), math.min(minimum.Z, corner.Z))
                    maximum = Vector3.new(math.max(maximum.X, corner.X), math.max(maximum.Y, corner.Y), math.max(maximum.Z, corner.Z))
                end
            end
        end
    end
    for _, part in ipairs(parts) do
        if part:IsA("BasePart") and (part.CanCollide or part.Transparency < 1) then includePart(part) end
    end
    if not found then includePart(base) end
    -- The destination is upright: keep the avatar's lowest point one stud above the lid.
    local bodyFrame, bodySize = character:GetBoundingBox()
    local lowest = -root.Size.Y * 0.5
    for x = -1, 1, 2 do
        for y = -1, 1, 2 do
            for z = -1, 1, 2 do
                local corner = bodyFrame:PointToWorldSpace(Vector3.new(bodySize.X * x * 0.5,
                    bodySize.Y * y * 0.5, bodySize.Z * z * 0.5))
                lowest = math.min(lowest, root.CFrame:PointToObjectSpace(corner).Y)
            end
        end
    end
    position = position or base.Position
    local stand = Vector3.new(math.clamp(position.X, minimum.X, maximum.X), maximum.Y - lowest + 1,
        math.clamp(position.Z, minimum.Z, maximum.Z))
    if maxDistance and (stand - position).Magnitude > maxDistance - 0.25 then
        return nil, "The position above the chest and avatar bounds is outside prompt range."
    end
    return stand
end

local function recoverUnitPanelThroughChest(checkCurrent, operation, retryTeleport)
    local recoveryName = operation or "ExitButton recovery"
    local function check()
        checkAlive()
        if checkCurrent then checkCurrent() end
    end
    check()
    local plot = getMyPlot()
    local chest = path(plot, {"Chest"})
    local base = path(chest, {"ChestBase"})
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root or not base:IsA("BasePart") then error(recoveryName .. ": character or ChestBase is unavailable.", 0) end
    local savedCFrame = root.CFrame
    local ownsPosition = not originalRoot
    if ownsPosition then originalRoot, originalCFrame = root, savedCFrame end
    local function checkTarget()
        check()
        if player.Character ~= character or not root:IsDescendantOf(character) then
            error("Character changed during " .. recoveryName .. ".", 0)
        end
        if not plot:IsDescendantOf(workspace) or tonumber(plot:GetAttribute("OwnerUserId")) ~= player.UserId
            or not chest:IsDescendantOf(plot) then
            error("Plot/chest ownership changed during " .. recoveryName .. ".", 0)
        end
    end
    local hoverAttachment, hoverVelocity, hoverWatcher
    local recoveryToken = runScope.threads[coroutine.running()]
    local teleported, recoveryTurn, offsetIndex = false, 0, 0
    local offsets = retryTeleport and {
        Vector3.new(1, 0, 0), Vector3.new(0, 0, 1),
        Vector3.new(-1, 0, 0), Vector3.new(0, 0, -1),
    }
    local function stopHover()
        if hoverWatcher then hoverWatcher:Disconnect(); hoverWatcher = nil end
        if hoverVelocity then hoverVelocity:Destroy(); hoverVelocity = nil end
        if hoverAttachment then hoverAttachment:Destroy(); hoverAttachment = nil end
        if modules.chestRecovery and modules.chestRecovery.cleanup == stopHover then modules.chestRecovery = nil end
    end
    local function startHover()
        if modules.chestRecovery then modules.chestRecovery.cleanup() end
        modules.chestRecovery = {cleanup = stopHover}
        hoverAttachment = Instance.new("Attachment")
        hoverAttachment.Name, hoverAttachment.Parent = "ChestRecoveryAttachment", root
        hoverVelocity = Instance.new("LinearVelocity")
        hoverVelocity.Name = "ChestRecoveryVelocity"
        hoverVelocity.Attachment0 = hoverAttachment
        hoverVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
        hoverVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        hoverVelocity.VectorVelocity = Vector3.zero
        hoverVelocity.ForceLimitsEnabled = false
        hoverVelocity.Enabled, hoverVelocity.Parent = true, root
        local function holdPosition()
            if (recoveryToken and not actionIsCurrent(recoveryToken)) or not pcall(checkTarget) then
                stopHover()
                return
            end
            root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        end
        holdPosition()
        hoverWatcher = game:GetService("RunService").PreSimulation:Connect(holdPosition)
    end
    local function chestFrame()
        local mine = playerGui:FindFirstChild("MineGui")
        return mine and mine:FindFirstChild("ChestFrame")
    end
    local function retryRecovery(chestAction)
        checkTarget()
        recoveryTurn = recoveryTurn + 1
        if retryTeleport and recoveryTurn % 2 == 1 then
            local confirmed, reason = retryTeleport()
            teleported = confirmed == true
            if not teleported and reason then error(reason, 0) end
        else
            chestAction()
        end
    end
    local function triggerChest()
        checkTarget()
        local function findPrompt()
            checkTarget()
            local found
            for _, candidate in ipairs(chest:GetDescendants()) do
                if candidate:IsA("ProximityPrompt") and candidate.Enabled then
                    if found then error("Multiple enabled chest prompts found during " .. recoveryName .. ".", 0) end
                    found = candidate
                end
            end
            return found
        end
        local prompt
        if retryTeleport then
            -- A missing prompt must not prevent the next TeleportButton turn.
            prompt = assert(findPrompt(), recoveryName .. ": your chest proximity prompt is not ready.")
        else
            prompt = waitUntil(findPrompt, nil, recoveryName .. ": waiting for your chest proximity prompt")
        end
        local reportStand = newRetryMonitor(recoveryName .. ": finding a safe position above the chest")
        local stand, position
        while not stand do
            checkTarget()
            local parent = prompt.Parent
            position = parent:IsA("Attachment") and parent.WorldPosition
                or parent:IsA("BasePart") and parent.Position or base.Position
            local problem
            stand, problem = chestTopPosition(chest, base, character, root, position, prompt.MaxActivationDistance)
            if not stand then
                if retryTeleport then error(problem, 0) end
                reportStand(problem)
                pause(CONFIG.General.ScanPoll)
            end
        end
        reportStand(nil, true)
        if retryTeleport then
            -- Use a different one-stud horizontal offset each chest attempt, never cumulatively.
            offsetIndex = offsetIndex % #offsets + 1
            stand = stand + offsets[offsetIndex]
            assert((stand - position).Magnitude <= prompt.MaxActivationDistance - 0.25,
                recoveryName .. ": offset position is outside chest prompt range.")
        end
        local facing = Vector3.new(position.X, stand.Y, position.Z)
        if (facing - stand).Magnitude < 0.001 then facing = stand + Vector3.new(0, 0, -1) end
        root.CFrame = CFrame.new(stand, facing)
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        pause(CONFIG.Units.TeleportDelay)
        checkTarget()
        heldPrompt = prompt
        prompt:InputHoldBegin()
        -- Match the existing chest prompt hold behavior, then close as soon as its UI opens.
        local ok, message = pcall(pause, math.max(prompt.HoldDuration, 2) + 0.5)
        releaseInputs()
        if not ok then error(message, 0) end
    end
    local function findClose(frame)
        for _, names in ipairs({{"Content", "Actions", "Close"}, {"Content", "Actions", "CloseButton"},
            {"CloseButton"}, {"ExitButton"}, {"Close"}}) do
            local candidate = frame
            for _, name in ipairs(names) do candidate = candidate and candidate:FindFirstChild(name) end
            if candidate and visible(candidate) then
                local button = resolveButton(candidate)
                if button then return button end
            end
        end
        local found
        for _, candidate in ipairs(frame:GetDescendants()) do
            local name = candidate.Name:lower():gsub("[%s%p]", "")
            if candidate:IsA("GuiButton") and visible(candidate)
                and (name == "close" or name == "closebutton" or name == "exit" or name == "exitbutton"
                    or candidate:IsA("TextButton") and candidate.Text:match("^%s*[xX×]%s*$")) then
                if found then error("Multiple chest close buttons found during " .. recoveryName .. ".", 0) end
                found = candidate
            end
        end
        return found
    end
    local closeAttempts = 0
    local function closeChest()
        checkTarget()
        local frame = chestFrame()
        if not visible(frame) then return end
        local button = findClose(frame)
        if not button then error(recoveryName .. ": chest Close button is not ready.", 0) end
        if type(firesignal) ~= "function" then error("Chest closing needs firesignal.", 0) end
        closeAttempts = closeAttempts + 1
        if closeAttempts % 2 == 1 then firesignal(button.MouseButton1Click)
        else firesignal(button.Activated, nil, 1) end
    end
    local ok, message = pcall(function()
        if retryTeleport then
            startHover()
            pcall(triggerChest)
        else
            triggerChest()
        end
        waitUntil(function()
            checkTarget()
            return teleported or visible(chestFrame())
        end, nil, recoveryName .. ": waiting for the chest UI to open", function() retryRecovery(triggerChest) end)
        if teleported then return end
        -- This interaction only resets the UI; it never requests chest contents.
        pcall(closeChest)
        waitUntil(function()
            checkTarget()
            return teleported or not visible(chestFrame())
        end, nil, recoveryName .. ": closing the chest UI", function() retryRecovery(closeChest) end)
    end)
    stopHover()
    releaseInputs()
    local stillCurrent = pcall(check)
    if not teleported and stillCurrent and player.Character == character and root:IsDescendantOf(character) then
        pcall(function()
            root.CFrame = savedCFrame
            root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        end)
    end
    if stillCurrent and ownsPosition and originalRoot == root and originalCFrame == savedCFrame then
        originalRoot, originalCFrame = nil, nil
    end
    if not ok then error(message, 0) end
    if retryTeleport then return teleported end
end

local function hideUnitPanel(focus)
    focus.Visible = false
end

local function closeUnitPanel(operation, checkCurrent)
    local reportRetry = newRetryMonitor(operation or "Closing SlotFocusFrame through Visible")
    local nextAttempt, hiddenSince, sawPanel = 0, nil, false
    while true do
        checkAlive()
        if checkCurrent then checkCurrent() end
        local mine = playerGui:FindFirstChild("MineGui")
        local focus = mine and mine:FindFirstChild("SlotFocusFrame")
        if not focus or not focus.Visible then
            if not sawPanel then reportRetry(nil, true); return end
            hiddenSince = hiddenSince or os.clock()
            if os.clock() - hiddenSince >= 0.1 then reportRetry(nil, true); return end
        else
            sawPanel, hiddenSince = true, nil
            if os.clock() >= nextAttempt then
                local ok, message = pcall(hideUnitPanel, focus)
                checkAlive()
                if checkCurrent then checkCurrent() end
                pause(SETTLE_TIME)
                local currentMine = playerGui:FindFirstChild("MineGui")
                local currentFocus = currentMine and currentMine:FindFirstChild("SlotFocusFrame")
                if currentFocus and currentFocus.Visible then
                    reportRetry(not ok and message or "SlotFocusFrame.Visible is still enabled; retrying.")
                end
                nextAttempt = os.clock() + CONFIG.General.RetryInterval
            end
        end
        pause(CONFIG.General.WaitPoll)
    end
end

do
    local hotkeyActions = {[Enum.KeyCode.One] = minimizedActions.toggleMaster}
    local teleportKeys = {Enum.KeyCode.Three, Enum.KeyCode.Four, Enum.KeyCode.Five, Enum.KeyCode.Six}
    local function findPath(parent, names)
        for _, name in ipairs(names) do
            parent = parent and parent:FindFirstChild(name)
            if not parent then return nil end
        end
        return parent
    end

    for index, destination in ipairs({
        {"Altar", {"EnchantAltar", "Altar"}},
        {"Events Board", {"EventBoard", "Lectern"}},
        {"Mailbox", {"Mailbox"}, ownPlot = true},
        {"Trial", {"TrialStone", "Plinth1"}, ownPlot = true},
    }) do
        local function teleportOnce()
            if not alive or (busy and activeRun == "master") then return end
            if busy and activeRun == "autoSequence" and modules.autoSequence and not modules.autoSequence.canStop() then return end
            if busy and (activeRun == "master" or activeRun == "hotbarUpgrade" or activeRun == "tutorial" or activeRun == "autoSequence") and stopRun then stopRun() end
            local ok, reason = pcall(function()
                local parent = destination.ownPlot and getMyPlot() or workspace
                local target = findPath(parent, destination[2])
                if not target then error(destination[1] .. " is not loaded.", 0) end
                local character = player.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if not root then error("Character is not ready.", 0) end
                local targetCFrame
                if target:IsA("BasePart") then targetCFrame = target.CFrame
                elseif target:IsA("Model") then targetCFrame = target:GetPivot()
                elseif target:IsA("Attachment") then targetCFrame = target.WorldCFrame
                else error(destination[1] .. " has no teleport position.", 0) end
                local position = (targetCFrame * CFrame.new(0, 3, -4)).Position
                root.CFrame = CFrame.new(position, targetCFrame.Position)
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end)
            if not ok then logError("Teleport", reason) end
        end
        if index == 1 then
            local shortcut = button(minimizedControls, destination[1], UDim2.new(0.5, 3, 0, 98), UDim2.new(0.5, -3, 0, 26))
            shortcut.Name = "Teleport" .. destination[1]:gsub(" ", "")
            shortcut.TextSize = 12
            shortcut.TextWrapped = true
            shortcut.BackgroundColor3 = colors.surface
            connect(shortcut.Activated, teleportOnce)
        end
        if teleportKeys[index] then hotkeyActions[teleportKeys[index]] = teleportOnce end
    end

    local rollToggle = button(minimizedControls, "Enchant Roll: OFF", UDim2.fromOffset(0, 68), UDim2.new(0.5, -3, 0, 26))
    rollToggle.Name = "EnchantRollToggle"
    rollToggle.TextSize = 11
    rollToggle.TextWrapped = true
    rollToggle.BackgroundColor3 = colors.idle
    local function setRollEnabled(enabled)
        minimizedActions.rollToken = nil
        minimizedActions.rollEnabled = enabled
        if minimizedActions.rollWorker then pcall(task.cancel, minimizedActions.rollWorker) end
        minimizedActions.rollWorker = nil
        rollToggle.Text = enabled and "Enchant Roll: ON" or "Enchant Roll: OFF"
        rollToggle.BackgroundColor3 = enabled and colors.accent or colors.idle
        if not enabled then return end
        local token = {kind = "roll"}
        minimizedActions.rollToken = token
        minimizedActions.rollWorker = task.defer(function()
            runScope.threads[coroutine.running()] = token
            while actionIsCurrent(token) do

                local roll = findPath(playerGui, {"MineGui", "EnchantFrame", "Bottom", "Stack", "RollButton"})
                if roll and visible(roll) and roll:IsA("GuiButton") and roll.Active then
                    local ok, reason = pcall(clickButton, roll)
                    if not actionIsCurrent(token) then return end
                    if not ok then
                        minimizedActions.rollEnabled = false
                        minimizedActions.rollWorker = nil
                        rollToggle.Text = "Enchant Roll: OFF"
                        rollToggle.BackgroundColor3 = colors.idle
                        logError("Enchant Roll", reason)
                        return
                    end
                end
                task.wait(1)
            end
        end)
    end
    minimizedActions.setRollEnabled = setRollEnabled
    local function toggleRoll()
        if not alive or (busy and activeRun == "master") then return end
        if busy and activeRun == "autoSequence" and modules.autoSequence and not modules.autoSequence.canStop() then return end
        if busy and (activeRun == "master" or activeRun == "hotbarUpgrade" or activeRun == "tutorial" or activeRun == "autoSequence") and stopRun then stopRun() end
        setRollEnabled(not minimizedActions.rollEnabled)
    end
    connect(rollToggle.Activated, toggleRoll)
    hotkeyActions[Enum.KeyCode.Two] = toggleRoll

    local openCrates = button(minimizedControls, "Open crates", UDim2.new(0.5, 3, 0, 68), UDim2.new(0.5, -3, 0, 26))
    openCrates.Name = "ColossusOpenButton"
    openCrates.TextSize = 11
    openCrates.TextWrapped = true

    local function readPetalfallCrateCount(scroll)
        local total = 0
        for _, row in ipairs(scroll:GetChildren()) do
            local content = row:FindFirstChild("Content")
            local nameLabel = content and content:FindFirstChild("ItemName")
            if nameLabel and (nameLabel:IsA("TextLabel") or nameLabel:IsA("TextButton") or nameLabel:IsA("TextBox")) then
                local name = nameLabel.Text:gsub("<[^>]*>", ""):match("^%s*(.-)%s*$")
                if name == "Petalfall Crate" then
                    local countLabel = content:FindFirstChild("ActualItemCount")
                    if not countLabel or not (countLabel:IsA("TextLabel") or countLabel:IsA("TextButton") or countLabel:IsA("TextBox")) then
                        return nil
                    end
                    local text = countLabel.Text:gsub("<[^>]*>", ""):gsub(",", "")
                    if text:match("^%s*$") then return nil end
                    local digits = text:match("^%s*[xX]?%s*(%d+)%s*$")
                    local count = digits and tonumber(digits)
                    if not count or count == math.huge or count % 1 ~= 0 then
                        error("Cannot read Petalfall Crate count: " .. countLabel.Text, 0)
                    end
                    total = total + count
                end
            end
        end
        return total
    end

    local openContext
    local function startOpeningCrates()
        if not alive or (busy and activeRun == "master") or minimizedActions.openBusy or (busy and activeRun == "hotbarUpgrade") then return end
        if busy and activeRun == "autoSequence" and modules.autoSequence and not modules.autoSequence.canStop() then return end
        local token = {kind = "open"}
        minimizedActions.openToken, minimizedActions.openBusy = token, true
        local ctx = {}
        openContext = ctx
        openCrates.Text = "Opening Crates"
        openCrates.Active, openCrates.AutoButtonColor = false, false
        openCrates.BackgroundColor3 = colors.idle
        if busy and (activeRun == "master" or activeRun == "hotbarUpgrade" or activeRun == "tutorial" or activeRun == "autoSequence") and stopRun then stopRun() end
        setRollEnabled(false)
        if not actionIsCurrent(token) then return end
        minimizedActions.openWorker = task.defer(function()
            runScope.threads[coroutine.running()] = token
            local inventory, openedInventory, sent = nil, false, 0
            local ok, result = pcall(function()
                checkAlive()
                inventory = path(playerGui, {"MineGui", "InventoryFrame"})
                ctx.inventory = inventory
                if not visible(inventory) then
                    inventory.Visible = true
                    openedInventory, ctx.openedInventory = true, true
                end
                waitUntil(function() return visible(inventory) end,
                    CONFIG.Units.ActionTimeout, "Waiting for inventory to open for crate counting.", function()
                        inventory.Visible = true
                    end)
                pause(CONFIG.Units.UISettleTime)
                local count = waitUntil(function()
                    if not visible(inventory) then error("Inventory closed before Petalfall Crates could be counted.", 0) end
                    return readPetalfallCrateCount(path(inventory, {"Content", "Scroll"}))
                end, CONFIG.Units.ActionTimeout, "Petalfall Crate count did not finish loading.")
                inventory.Visible = false
                waitUntil(function() return not visible(inventory) end,
                    CONFIG.Units.ActionTimeout, "Waiting for inventory to close before opening crates.", function()
                        inventory.Visible = false
                    end)
                openedInventory, ctx.openedInventory = false, false
                if count == 0 then return "No Petalfall Crates found." end
                local event = getGameEvent()
                for index = 1, count do
                    checkAlive()
                    event:FireServer("MineOpenColossusCrate", "Petalfall Crate", 1)
                    sent = sent + 1
                    if index < count then pause(0.1) end
                end
                return string.format("Sent %d Petalfall Crate open requests.", sent)
            end)
            if not actionIsCurrent(token) then return end
            if openedInventory and inventory and visible(inventory) then
                pcall(function() inventory.Visible = false end)
                if not actionIsCurrent(token) then return end
            end
            minimizedActions.openBusy, minimizedActions.openToken, minimizedActions.openWorker = false, nil, nil
            openContext = nil
            openCrates.Text = "Open crates"
            openCrates.Active, openCrates.AutoButtonColor = true, true
            openCrates.BackgroundColor3 = colors.accent
            if ok then logInfo("Crates", result)
            else logError("Crates", string.format("Stopped after %d requests: %s", sent, tostring(result))) end
        end)
    end
    minimizedActions.stopOpeningCrates = function()
        minimizedActions.openToken, minimizedActions.openBusy = nil, false
        local thread = minimizedActions.openWorker
        minimizedActions.openWorker = nil
        if thread and coroutine.status(thread) ~= "dead" then pcall(task.cancel, thread) end
        local ctx = openContext
        openContext = nil
        if ctx and ctx.openedInventory and ctx.inventory and ctx.inventory.Parent then
            ctx.inventory.Visible = false
        end
        openCrates.Text = "Open crates"
        openCrates.Active, openCrates.AutoButtonColor = true, true
        openCrates.BackgroundColor3 = colors.accent
    end
    connect(openCrates.Activated, startOpeningCrates)

    connect(UserInputService.InputBegan, function(input, gameProcessedEvent)
        if not alive or gameProcessedEvent or UserInputService:GetFocusedTextBox() then return end
        if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
            or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then return end
        if busy and activeRun == "master" and input.KeyCode ~= Enum.KeyCode.One then return end
        local action = hotkeyActions[input.KeyCode]
        if action then action() end
    end)
end

getMyPlot = function()
    local plots = path(workspace, {"MineWorld", "Plots"})
    return waitUntil(function()
        for _, plot in ipairs(plots:GetChildren()) do
            if tonumber(plot:GetAttribute("OwnerUserId")) == player.UserId then
                return plot
            end
        end
    end, LOAD_TIMEOUT, "Your plot was not found (OwnerUserId must match your UserId).")
end

do
    local cleanupWorker
    local function scanOtherPlots()

        local weather = workspace:FindFirstChild("WeatherFX_Local")
        if weather then weather:ClearAllChildren() end

        local mineWorld = workspace:FindFirstChild("MineWorld")
        local plots = mineWorld and mineWorld:FindFirstChild("Plots")
        if not plots then return end
        local children = plots:GetChildren()
        local myPlot
        for _, plot in ipairs(children) do
            if plot.Name:match("^MinePlot%d+$") and tonumber(plot:GetAttribute("OwnerUserId")) == player.UserId then
                myPlot = plot
                break
            end
        end

        if not myPlot then return end
        for _, plot in ipairs(children) do
            if not alive or not CONFIG.General.DeleteOtherPlots then return end
            if plot ~= myPlot and plot.Parent == plots and plot.Name:match("^MinePlot%d+$")
                and tonumber(plot:GetAttribute("OwnerUserId")) ~= player.UserId then
                plot:Destroy()
            end
        end
    end
    modules.plotCleanup = {
        start = function()
            if cleanupWorker or not alive or not CONFIG.General.DeleteOtherPlots then return end
            cleanupWorker = task.defer(function()
                local warned = false
                while alive and CONFIG.General.DeleteOtherPlots do
                    local ok, message = pcall(scanOtherPlots)
                    if not ok and not warned then
                        logWarning("[Plot Cleanup] " .. tostring(message))
                    end
                    warned = not ok
                    task.wait(1)
                end
                cleanupWorker = nil
            end)
        end,
        stop = function()
            if cleanupWorker then pcall(task.cancel, cleanupWorker) end
            cleanupWorker = nil
        end,
    }
end

-- Automatic Workspace cleanup shares the unit sequence's cooldown and resets.
-- Each permitted cycle gets one attempt; there is no separate cleanup timer.
-- Other MinePlots/weather use the independent automatic plotCleanup worker above.
do
    local status = minimizedActions.newStatus("Keeps script paths and prompts. Rejoin to restore.")

-- MAINTENANCE: Keep every Workspace path used anywhere in the script, including
-- future stage paths. Add new paths here or to PLOT_KEEP before using them.
-- These lists protect the full subtree of each leaf; prompts are also kept dynamically.
local WORLD_KEEP = {
    {"MineWorld", "BaseplateCollision"},
    {"SellStand"},
    {"PickaxesStand"},
    {"EnchantAltar", "Altar"},
    {"EventBoard", "Lectern"},
}
local PLOT_KEEP = {
    {"Chest"},
    {"Holders"},
    {"Nodes"},
    {"Mailbox"},
    {"TrialStone"},
    {"PlatformBack"},
    {"ZoneBoard"},
}

local function findOwnedPlot()
    local world = workspace:FindFirstChild("MineWorld")
    local plots = world and world:FindFirstChild("Plots")
    if not plots then return nil, nil, "Waiting for MineWorld.Plots; nothing deleted." end
    local mine
    for _, candidate in ipairs(plots:GetChildren()) do
        if candidate.Name:match("^MinePlot%d+$")
            and tonumber(candidate:GetAttribute("OwnerUserId")) == player.UserId then
            if mine then
                return nil, nil, "Multiple owned plots found; cleanup paused."
            end
            mine = candidate
        end
    end
    if not mine then return nil, nil, "Waiting for your owned MinePlot; nothing deleted." end
    return plots, mine
end

-- An instance-keyed tree preserves ancestors without accidentally retaining
-- unrelated siblings. Existing allowlisted prefixes are kept when a leaf has not streamed in.
local function makeKeepTree(plots, plot)
    local tree = { children = {} }
    local function keep(object, subtree)
        if not object or not object:IsDescendantOf(workspace) then return end
        local chain = {}
        local current = object
        while current and current ~= workspace do
            table.insert(chain, 1, current)
            current = current.Parent
        end
        if current ~= workspace then return end
        local node = tree
        for _, ancestor in ipairs(chain) do
            local nextNode = node.children[ancestor]
            if not nextNode then
                nextNode = { children = {} }
                node.children[ancestor] = nextNode
            end
            node = nextNode
        end
        if subtree then node.all = true end
    end
    local function keepPath(root, names)
        -- Preserve existing prefixes even when the leaf has not streamed in.
        local parents = { root }
        for index, name in ipairs(names) do
            local nextParents = {}
            for _, parent in ipairs(parents) do
                for _, child in ipairs(parent:GetChildren()) do
                    if child.Name == name then
                        keep(child, index == #names)
                        table.insert(nextParents, child)
                    end
                end
            end
            parents = nextParents
        end
    end

    keep(plots, false)
    keep(plot, false)
    -- Other plots belong to the separate DeleteOtherPlots toggle/worker.
    for _, candidate in ipairs(plots:GetChildren()) do
        if candidate ~= plot and candidate.Name:match("^MinePlot%d+$") then keep(candidate, true) end
    end
    for _, names in ipairs(WORLD_KEEP) do keepPath(workspace, names) end
    for _, names in ipairs(PLOT_KEEP) do keepPath(plot, names) end
    keep(player.Character, true)
    keep(workspace.CurrentCamera, true)
    -- Keeping only the prompt is insufficient: deleting its part/model would
    -- destroy the prompt too. keep() also protects every ancestor up to Workspace.
    -- Include disabled prompts and discover newly spawned prompts on every scan.
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then keep(descendant, true) end
    end
    -- Terrain is an engine object; do not Clear() its voxels or destroy it.
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Terrain") then keep(child, true) end
    end
    -- Protect this script if executed as a LocalScript inside Workspace.
    if typeof(script) == "Instance" then keep(script, true) end
    return tree
end

local function scan(automatic)
    local plots, plot, reason = findOwnedPlot()
    if not plot then error(reason, 0) end
    -- A character can briefly be in Workspace before Character is assigned.
    -- Wait for a living character instead of risking deletion during respawn.
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not character or not character:IsDescendantOf(workspace)
        or not humanoid or humanoid.Health <= 0 or not workspace.CurrentCamera then
        error("Waiting for your character/camera; try cleanup again when ready.", 0)
    end
    local removed, failed = 0, 0
    local tree = makeKeepTree(plots, plot)
    local function prune(parent, node)
        if node.all then return end
        for _, child in ipairs(parent:GetChildren()) do
            if not alive then error("Unloaded.", 0) end
            if automatic and not CONFIG.General.WorkspaceCleanupEnabled then return end
            local branch = node.children[child]
            if branch then
                prune(child, branch)
            else
                -- Recheck ownership immediately before each destructive action.
                if plot.Parent ~= plots or tonumber(plot:GetAttribute("OwnerUserId")) ~= player.UserId then
                    error("Plot ownership changed; cleanup paused.", 0)
                end
                local ok = pcall(function() child:Destroy() end)
                if ok then removed = removed + 1 else failed = failed + 1 end
            end
        end
    end
    prune(workspace, tree)
    return removed, failed
end

    local function refreshAutomaticStatus()
        pages.master.refreshWorkspaceCleanupToggle()
        status.Text = CONFIG.General.WorkspaceCleanupEnabled
            and "Auto cleanup: shares the unit-sequence cooldown."
            or "Auto cleanup: OFF."
        status.TextColor3 = colors.muted
    end
    modules.workspaceCleanup = {
        refresh = refreshAutomaticStatus,
        onMasterEnabled = function()
            if preferences.masterActivatedOnce then return end
            preferences.masterActivatedOnce = true
            CONFIG.General.WorkspaceCleanupEnabled = true
            refreshAutomaticStatus()
        end,
        runWithSequence = function()
            if not alive or not CONFIG.General.WorkspaceCleanupEnabled then return end
            local ok, removed, failed = pcall(scan, true)
            if not alive then return end
            if ok and failed == 0 then
                status.Text = string.format("Auto cleanup done: removed %d branches.", removed)
                status.TextColor3 = colors.success
                logInfo("Workspace Cleanup", status.Text)
            else
                status.Text = "Auto cleanup incomplete. Will retry with the next unit sequence."
                status.TextColor3 = colors.error
                local reason = ok and string.format("%d branches could not be removed.", failed) or tostring(removed)
                logWarning("[Workspace Cleanup] " .. reason)
            end
        end,
    }
end

-- Check rewards once per Master cycle.
-- Each pass uses its own toggles and can finish across Master stops.
do
    local running = false
    local function saveRewardState()
        if not savePreferences() then
            logWarning("[Daily Rewards] Request sent, but its cache could not be saved; it may repeat after restarting.")
        end
    end
    local function claimSpin()
        if not alive or not preferences.dailySpinEnabled then return end
        local lastSpin = preferences.lastDailySpinAt
        if lastSpin and os.time() < lastSpin + CONFIG.DailyRewards.SpinInterval then return end
        local event = getGameEvent()
        if not alive or not preferences.dailySpinEnabled then return end
        event:FireServer("MineDailySpin")
        preferences.lastDailySpinAt = os.time()
        saveRewardState()
        logInfo("Daily Rewards", "Daily spin requested; next spin in 24 hours + 10 seconds.")
    end
    local function redeemCodes()
        local sent = {}
        for _, code in ipairs(CONFIG.DailyRewards.Codes) do
            if not alive or not preferences.autoRedeemEnabled then break end
            if not preferences.redeemedCodes[code] then
                local event = getGameEvent()
                if not alive or not preferences.autoRedeemEnabled then break end
                event:FireServer("UseCode", code)
                -- FireServer has no reply; cache sent requests to avoid resending codes.
                preferences.redeemedCodes[code] = true
                saveRewardState()
                table.insert(sent, code)
                task.wait(CONFIG.DailyRewards.CodeDelay)
            end
        end
        if #sent > 0 then
            logInfo("Daily Rewards", string.format("Requested %d codes: %s.", #sent, table.concat(sent, ", ")))
        end
    end
    modules.dailyRewards = {
        runCycle = function()
            if running or not alive then return end
            running = true
            local thread = task.defer(function()
                if not alive then return end
                local ok, message = pcall(function()
                    claimSpin()
                    redeemCodes()
                end)
                runScope.background[coroutine.running()] = nil
                running = false
                if not ok and alive then logWarning("[Daily Rewards] " .. tostring(message)) end
            end)
            runScope.background[thread] = true
        end,
    }
end

local function checkPlot(plot)
    checkAlive()
    if not plot:IsDescendantOf(workspace)
        or tonumber(plot:GetAttribute("OwnerUserId")) ~= player.UserId then
        error("Plot ownership changed. Run again after your plot loads.", 0)
    end
end

local function getCurrentZone()
    local plot = getMyPlot()
    local list
    local function zoneList()
        local board = plot:FindFirstChild("ZoneBoard")
        local boardGui = board and board:FindFirstChild("ZoneBoardGui")
        local root = boardGui and boardGui:FindFirstChild("Root")
        return root and root:FindFirstChild("List")
    end
    local reportRetry = newRetryMonitor("Waiting for your ZoneBoardGui and current-zone rows")
    local lastSignature = nil
    local stableSince = os.clock()

    while true do
        checkPlot(plot)
        local currentList = zoneList()
        if not currentList then
            list, lastSignature, stableSince = nil, nil, os.clock()
            if activeRun == "master" then pages.master.status.Text = "Waiting for your plot's ZoneBoardGui..." end
            reportRetry("Waiting for ZoneBoard.ZoneBoardGui.Root.List in your owned plot.")
            pause(CONFIG.General.ScanPoll)
            continue
        end
        if list ~= currentList then
            list, lastSignature, stableSince = currentList, nil, os.clock()
        end
        local rows = {}
        for _, child in ipairs(list:GetChildren()) do
            local number = tonumber(child.Name:match("^ZoneRow(%d+)$"))
            if number and number >= 1 then
                table.insert(rows, {number = number, row = child})
            end
        end
        table.sort(rows, function(a, b) return a.number < b.number end)
        local highestNumber = 0
        local entries = {}
        local ready = #rows > 0
        local problem = "ZoneBoard rows are missing or still changing."
        for index, entry in ipairs(rows) do
            if entry.number ~= index then
                ready = false
                problem = "Waiting for ZoneRow" .. index .. " before scanning later zones."
                break
            end
            local button = entry.row:FindFirstChild("Button")
            local lock = button and button:FindFirstChild("Lock")
            if not lock or not lock:IsA("GuiObject") then
                ready = false
                problem = entry.row.Name .. ": Button.Lock is missing."
                break
            end
            local locked = lock.Visible
            table.insert(entries, string.format("%d:%s", entry.number, tostring(locked)))
            if not locked then highestNumber = math.max(highestNumber, entry.number) end
        end
        if ready and highestNumber > 0 then
            local signature = table.concat(entries, "|")
            if signature ~= lastSignature then
                lastSignature = signature
                stableSince = os.clock()
            elseif os.clock() - stableSince >= SETTLE_TIME then
                local zoneId = "Z" .. tostring(highestNumber)
                reportRetry(nil, true)
                return zoneId, "Zone_" .. zoneId
            end
        else
            lastSignature = nil
            stableSince = os.clock()
            if ready then problem = "ZoneBoard has no confirmed unlocked zone." end
        end
        reportRetry(problem)
        pause(CONFIG.General.ScanPoll)
    end
end

local openedUpgradeFrame = nil

local function openUpgrades()
    checkAlive()
    local frame = path(playerGui, {"MineGui", "SkillTreeFullFrame"})
    if not frame.Visible then openedUpgradeFrame = frame end
    frame.Visible = true
    return frame
end

local function closeSkillTree(ownedOnly)
    local frame = openedUpgradeFrame
    if not ownedOnly then
        local mine = playerGui:FindFirstChild("MineGui")
        frame = (mine and mine:FindFirstChild("SkillTreeFullFrame")) or frame
    end
    openedUpgradeFrame = nil
    if frame and frame.Parent then frame.Visible = false end
end

local function getUpgradeZone(zoneName)
    checkAlive()
    assert(zoneName and zoneName:match("^Zone_Z%d+$"), "A ZoneBoard zone is required for the skill tree.")
    local frame = openUpgrades()
    return path(frame, {"Tree", "Canvas", zoneName})
end

local cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady
local cycleBestEquipped = false
local readCycleDensity
-- Keep the last confirmed scan across cycles, but start fresh on each script execution.
local savedZoneScan
local function useSavedZoneScan()
    if not savedZoneScan or savedZoneScan.zoneId ~= cycleZoneId then return false end
    cycleDensityLevel = savedZoneScan.densityLevel
    minimizedActions.setNotificationZone(cycleZoneId)
    refreshMasterRequirements(cycleZoneId, cycleDensityLevel)
    return true
end
local function getCycleZone()
    if not cycleZoneId then
        cycleZoneId, cycleZoneName = getCurrentZone()
        cycleDensityLevel = nil
        if activeStage ~= "upgrades" and not preferences.stages.upgrades then useSavedZoneScan() end
        minimizedActions.setNotificationZone(cycleZoneId)
        refreshMasterRequirements(cycleZoneId, cycleDensityLevel)
        logUnitUpgradeDetail(string.format("%s (%s) cached from ZoneBoard for this cycle.",
            cycleZoneId, cycleZoneName))
    end
    return cycleZoneId, cycleZoneName
end

local densityIIState = _G.__AUTOMATION_DENSITY_II
if type(densityIIState) ~= "table" then
    densityIIState = {}
    _G.__AUTOMATION_DENSITY_II = densityIIState
end
local densityIIKey = tostring(game.GameId) .. ":" .. tostring(player.UserId)
if type(densityIIState[densityIIKey]) ~= "table" then densityIIState[densityIIKey] = {} end
local densityIIZones = densityIIState[densityIIKey]
local function cacheConfirmedDensity(zoneId, level)
    if zoneId == cycleZoneId then
        cycleDensityLevel = level
        savedZoneScan = {zoneId = zoneId, zoneName = cycleZoneName, densityLevel = level}
        refreshMasterRequirements(zoneId, level)
    end
    local wasStopped = densityIIZones[zoneId] == true
    densityIIZones[zoneId] = level >= 2 and true or nil
    if level >= 2 and not wasStopped then
        logInfo("Mutate Units", zoneId .. ": confirmed Canvas density " .. level .. "; mutation rolling stopped.")
    elseif level < 2 and wasStopped then
        logInfo("Mutate Units", zoneId .. ": confirmed Canvas density " .. level .. "; cleared stale Density II stop flag.")
    end
end
local function requiredSlotCount(zoneId)
    local rule = CONFIG.Units.RequiredByZone[zoneId] or {}
    local count = rule.RequiredUnitCount or 0
    if type(count) ~= "number" or count ~= count or count < 0 or count % 1 ~= 0 or count == math.huge then
        error(zoneId .. ": RequiredUnitCount must be a finite nonnegative whole number.", 0)
    end
    return count
end
local function requiredHolderTargets(plot, RequiredUnitCount, allowPartial)
    checkPlot(plot)
    local holders = plot:FindFirstChild("Holders")
    if not holders then return {}, {}, "Your plot's Holders folder is missing." end
    local available = {}
    for _, holder in ipairs(holders:GetChildren()) do
        local number = tonumber(holder.Name:match("^M(%d+)$"))
        if number and number >= 1 then
            local pad = holder:FindFirstChild("Pad")
            local prompt = pad and pad:FindFirstChild("HolderPrompt")
            local upgrade = holder:FindFirstChild("UpgradePart")
            local detector = upgrade and upgrade:FindFirstChild("UpgradeClick")
            local action = prompt and prompt:IsA("ProximityPrompt") and prompt.ActionText or ""
            local occupied = action:match("^%s*(.-)%s*$"):lower() == "pick up"
                or (detector and detector:IsA("ClickDetector") and detector.MaxActivationDistance > 0)
            if action == "Place" or occupied then
                table.insert(available, {name = holder.Name, number = number})
            end
        end
    end
    table.sort(available, function(a, b) return a.number < b.number end)
    if #available < RequiredUnitCount and not allowPartial then
        return {}, {}, string.format("Need %d unlocked required holders, but only %d are available.", RequiredUnitCount, #available)
    end
    local targets, selected = {}, {}
    for index = 1, math.min(RequiredUnitCount, #available) do
        local target = available[index]
        table.insert(targets, target)
        selected[target.name] = true
    end
    return targets, selected
end
local function splitUnitSlots(slots, RequiredUnitCount)
    local sorted, required, extra = {}, {}, {}
    for _, slot in ipairs(slots) do table.insert(sorted, slot) end
    table.sort(sorted, function(a, b) return a.number < b.number end)
    for index, slot in ipairs(sorted) do
        if index <= RequiredUnitCount then table.insert(required, slot)
        else table.insert(extra, slot) end
    end
    local reason = #required < RequiredUnitCount and "Not all required holders have a displayed unit." or nil
    return required, extra, reason
end
local unitCountSnapshot
local cycleUnitsPreparedZone
local cycleUnitUpgradeReadyZone
local cycleSkipUnitsReason
local cycleUnitCooldown
local lastUnitSequence = -math.huge
local unitSequenceZone

refreshUnitCooldown = function()
    local seconds = math.max(0, math.ceil(CONFIG.Units.SequenceCooldown - (os.clock() - lastUnitSequence)))
    local text = seconds > 0
        and string.format("Unit sequence: %d:%02d remaining", math.floor(seconds / 60), seconds % 60)
        or "Unit sequence: Ready"
    for _, id in ipairs({"master", "units"}) do
        pages[id].cooldown.Text = text
        pages[id].cooldown.TextColor3 = seconds > 0 and colors.muted or colors.success
    end
end
local function unitSequenceCooldownReason(raw)
    if activeRun == "master" and not raw then
        if cycleUnitCooldown and cycleUnitCooldown.allowed then return nil end
        return cycleUnitCooldown and cycleUnitCooldown.reason or "shared cooldown permission has not been checked for this cycle."
    end
    local cooldown = CONFIG.Units.SequenceCooldown
    if type(cooldown) ~= "number" or cooldown ~= cooldown or cooldown < 0 or cooldown == math.huge then
        error("SequenceCooldown must be a finite nonnegative number of seconds.", 0)
    end
    local remaining = cooldown - (os.clock() - lastUnitSequence)
    if remaining > 0 then
        local seconds = math.ceil(remaining)
        return string.format("unit sequence cooldown %d:%02d remaining.", math.floor(seconds / 60), seconds % 60)
    end
end
local function beginUnitSequence(zoneId)
    if activeRun == "master" then
        assert(cycleUnitCooldown and cycleUnitCooldown.allowed, "Unit stages were not granted permission for this cycle.")
        cycleUnitUpgradeReadyZone = zoneId
        modules.workspaceCleanup.runForCycle()
        return
    end
    -- Manual runs keep their existing direct cooldown behavior.
    lastUnitSequence = os.clock()
    unitSequenceZone = zoneId
    cycleUnitUpgradeReadyZone = zoneId
    refreshUnitCooldown()
    modules.workspaceCleanup.runWithSequence()
end
modules.workspaceCleanup.beginCycle = function(zoneId)
    checkAlive()
    local reason = unitSequenceCooldownReason(true)
    local enabled = preferences.stages.units or preferences.stages.upgradingUnit
        or CONFIG.General.WorkspaceCleanupEnabled
    cycleUnitCooldown = {
        allowed = enabled and not reason,
        reason = reason and "shared cooldown was active at cycle start; wait for the next cycle."
            or "shared-cooldown stages are OFF for this cycle.",
        cleanupAttempted = false,
    }
    if cycleUnitCooldown.allowed then
        -- Reserve permission first, then start the one shared timer.
        lastUnitSequence = os.clock()
        unitSequenceZone = zoneId
        cycleUnitUpgradeReadyZone = zoneId
        refreshUnitCooldown()
    end
end
modules.workspaceCleanup.runForCycle = function()
    if not alive or activeRun ~= "master" or not CONFIG.General.WorkspaceCleanupEnabled
        or not cycleUnitCooldown or not cycleUnitCooldown.allowed or cycleUnitCooldown.cleanupAttempted then return false end
    checkAlive()
    cycleUnitCooldown.cleanupAttempted = true
    modules.workspaceCleanup.runWithSequence()
    return true
end
connect(pages.units.resetCooldown.Activated, function()
    if not alive then return end
    lastUnitSequence = -math.huge
    cycleUnitUpgradeReadyZone = nil
    refreshUnitCooldown()
    logInfo("Required Units", "Shared cooldown cleared for Workspace cleanup and unit stages.")
end)
local function syncUnitSequenceZone(zoneId)
    local previous = unitSequenceZone
    unitSequenceZone = zoneId
    if not previous or previous == zoneId then return end
    lastUnitSequence = -math.huge
    unitCountSnapshot, cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone = nil, nil, nil
    masterRequirementProgress[zoneId] = {}
    refreshMasterRequirements(zoneId)
    refreshUnitCooldown()
    logInfo("Upgrades", previous .. " -> " .. zoneId .. ": unit sequence cooldown reset for the new zone.")
end
local function unitsPreparedThisCycle(zoneId)
    if cycleUnitsPreparedZone ~= zoneId then
        return false, "Full Required Units preparation did not complete in this cycle (placement skipped / density below zone minimum / cooldown)."
    end
    return true
end
local function readCharacterName(holder)
    local pad = holder:FindFirstChild("Pad")
    local info = pad and pad:FindFirstChild("CrewInfo")
    local bg = info and info:FindFirstChild("BG")
    local label = bg and bg:FindFirstChild("CharName")
    if not label or not (label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox")) then
        return nil, "Pad.CrewInfo.BG.CharName is missing or unreadable."
    end
    local name = label.Text:gsub("<[^>]*>", ""):match("^%s*(.-)%s*$")
    if name == "" then return nil, "Pad.CrewInfo.BG.CharName is empty." end
    return name
end
local function requestCycleBestEquip()
    checkAlive()

    if cycleBestEquipped then return false end
    local plot = getMyPlot()
    checkPlot(plot)
    checkAlive()
    getGameEvent():FireServer("MineEquipBest")
    cycleBestEquipped = true
    pause(CONFIG.Units.BestEquipDelay)
    if modules.mutation and modules.mutation.observeProgress and cycleZoneId then
        modules.mutation.observeProgress(cycleZoneId, plot)
    end
    return true
end
local function RequiredUnitCountMet(zoneId)
    local rule = CONFIG.Units.RequiredByZone[zoneId] or {RequiredUnitCount = 0, Names = {}}
    local required = rule.RequiredUnitCount
    if type(required) ~= "number" or required ~= required or required < 0
        or required % 1 ~= 0 or required == math.huge then
        error(zoneId .. ": RequiredUnitCount must be a finite nonnegative whole number.", 0)
    end
    if required == 0 then return true end
    local snapshot = unitCountSnapshot
    if not snapshot or snapshot.zone ~= zoneId then
        return false, zoneId .. ": waiting for the Required Units stage to confirm RequiredUnitCount."
    end
    local allowed, matched = {}, 0
    for _, name in ipairs(rule.Names or {}) do allowed[name] = true end
    for _, entry in ipairs(snapshot.summary) do
        if allowed[entry.name] then matched = matched + entry.count end
    end
    if matched < required then
        return false, string.format("%s: matched %d/%d required units.", zoneId, matched, required)
    end
    return true
end

do
local status = stageStatus("sell")
local GameEvent, mineGui, hrp
local function sellIsActive()
    checkAlive()
    return alive and busy and activeStage == "sell"
        and (activeRun == "sell" or activeRun == "autoSequence"
            or (activeRun == "master" and preferences.masterEnabled))
end
local function sleepSell(seconds)
    local deadline = os.clock() + seconds
    while os.clock() < deadline do
        if not sellIsActive() then return false end
        pause(CONFIG.Sell.Poll)
    end
    return sellIsActive()
end

local function clickBtn(btn)
    checkAlive()
    if not sellIsActive() or not btn or not visible(btn) then return false end
    if btn.AbsoluteSize.X < 1 or btn.AbsoluteSize.Y < 1 then return false end
    clickButton(btn)
    checkAlive()
    return true
end

local sellButtonCache = {}
local function normalizedSellText(text)
    return text:gsub("<[^>]*>", ""):lower():gsub("[^%w]", "")
end
local function sellButtonMatches(button, needle, caption)
    if caption then
        if not caption:IsDescendantOf(button) then return false end
        local owner = caption:IsA("GuiButton") and caption or caption.Parent
        while owner and owner ~= button and not owner:IsA("GuiButton") do owner = owner.Parent end
        return owner == button and normalizedSellText(caption.Text):find(needle, 1, true) ~= nil
    end
    local text = button:IsA("TextButton") and button.Text or ""
    return normalizedSellText(button.Name .. " " .. text):find(needle, 1, true) ~= nil
end
local function sellButtonReady(entry)
    local button = entry.button
    return visible(button) and button.Active and button.AbsoluteSize.X >= 1 and button.AbsoluteSize.Y >= 1
        and (not entry.caption or visible(entry.caption))
end
local function findByText(root, needle, excluded)
    local pending
    for _, candidate in ipairs(root:GetDescendants()) do
        if candidate ~= excluded and candidate:IsA("GuiButton") then
            local matched = sellButtonMatches(candidate, needle)
            local caption
            if not matched then
                -- Remember the caption so readiness retries do not scan this button again.
                for _, child in ipairs(candidate:GetDescendants()) do
                    if (child:IsA("TextLabel") or child:IsA("TextButton")) and sellButtonMatches(candidate, needle, child) then
                        matched, caption = true, child
                        if visible(child) then break end
                    end
                end
            end
            if matched then
                local entry = {root = root, button = candidate, caption = caption}
                if sellButtonReady(entry) then return entry end
                pending = pending or entry
            end
        end
    end
    return pending
end
local function waitForSellButton(root, text, excluded)
    local reportRetry = newRetryMonitor("Finding Sell UI button: " .. text)
    local needle = normalizedSellText(text)
    local entry = sellButtonCache[text]
    local nextSearch, nextDetails = 0, 0
    while sellIsActive() do
        local currentGui = playerGui:FindFirstChild("MineGui")
        local currentRoot = currentGui and currentGui:FindFirstChild("SellFrame")
        if currentRoot ~= root then
            root, entry, nextSearch, nextDetails = currentRoot, nil, 0, 0
        end
        if entry and (entry.root ~= root or entry.button == excluded or not entry.button:IsDescendantOf(root)
            or not sellButtonMatches(entry.button, needle, entry.caption)) then
            entry, nextSearch = nil, 0
            sellButtonCache[text] = nil
        end
        if entry and sellButtonReady(entry) then reportRetry(nil, true); return entry.button end
        local now = os.clock()
        if root and now >= nextSearch then
            entry = findByText(root, needle, excluded)
            sellButtonCache[text] = entry
            nextSearch = now + CONFIG.General.RetryInterval
            if entry and sellButtonReady(entry) then reportRetry(nil, true); return entry.button end
        end
        if now >= nextDetails then
            local available = {}
            for _, candidate in ipairs(root and root:GetDescendants() or {}) do
                if candidate:IsA("GuiButton") then
                    local caption = candidate:IsA("TextButton") and candidate.Text or ""
                    table.insert(available, string.format("%s [%s; visible=%s; active=%s; size=%gx%g]",
                        candidate.Name, caption, tostring(visible(candidate)), tostring(candidate.Active),
                        candidate.AbsoluteSize.X, candidate.AbsoluteSize.Y))
                    if #available >= 10 then break end
                end
            end
            reportRetry("Buttons found: " .. (#available > 0 and table.concat(available, "; ") or "none"))
            nextDetails = now + CONFIG.General.RetryInterval
        end
        pause(CONFIG.General.WaitPoll)
    end
    return nil
end

local function doSellOnce()
    if not sellIsActive() then return end
    status.Text = "Collecting chest..."
    checkAlive()
    GameEvent:FireServer("MineTeleport", "Plot")
    if not sleepSell(CONFIG.Sell.TeleportDelay) then return end
    checkAlive()
    local chestFrame
    local nextChestOpen = 0
    local reportChest = newRetryMonitor("Opening ChestFrame through Visible")
    while sellIsActive() do
        local currentGui = playerGui:FindFirstChild("MineGui")
        chestFrame = currentGui and currentGui:FindFirstChild("ChestFrame")
        if chestFrame and chestFrame:IsA("GuiObject") and visible(chestFrame) then
            reportChest(nil, true)
            break
        end
        if os.clock() >= nextChestOpen then
            nextChestOpen = os.clock() + 1
            if chestFrame and chestFrame:IsA("GuiObject") then chestFrame.Visible = true end
            reportChest("Waiting for ChestFrame to become visible; retrying every second.")
        end
        if not sleepSell(CONFIG.Sell.Poll) then return end
    end
    if not sellIsActive() then return end
    local collected, collectionError = pcall(function() GameEvent:FireServer("MineTakeChest") end)
    chestFrame.Visible = false
    if not collected then error(collectionError, 0) end
    if not sleepSell(CONFIG.Sell.ChestDelay) then return end
    status.Text = "Going to the sell stand..."
    checkAlive()
    GameEvent:FireServer("MineTeleport", "Hub")
    if not sleepSell(CONFIG.Sell.TeleportDelay) then return end

    local function visibleSellFrame()
        mineGui = playerGui:FindFirstChild("MineGui")
        local frame = mineGui and mineGui:FindFirstChild("SellFrame")
        return visible(frame) and frame or nil
    end
    local lastRetryAngle
    local function approachSellStand(isRetry)
        if not sellIsActive() then return nil end
        local sellStand = workspace:FindFirstChild("SellStand")
        if not sellStand then error("SellStand is missing.", 0) end
        local standPart = sellStand:IsA("BasePart") and sellStand
            or (sellStand.PrimaryPart or sellStand:FindFirstChildWhichIsA("BasePart"))
        if not standPart then error("SellStand has no BasePart.", 0) end
        local character = player.Character
        hrp = character and character:FindFirstChild("HumanoidRootPart")
        if not hrp or not hrp:IsA("BasePart") then error("Character is not ready to return to the sell stand.", 0) end
        local standPos = standPart.Position
        local facing = standPart.CFrame.LookVector
        local offset = Vector3.zero
        if isRetry then
            local angle = math.random(0, 359)
            if angle == lastRetryAngle then angle = (angle + 1) % 360 end
            lastRetryAngle = angle
            local radians = math.rad(angle)
            offset = Vector3.new(math.cos(radians), 0, math.sin(radians))
        end
        -- Each retry stays exactly one horizontal stud from the usual stand point.
        local standSpot = standPos - facing * CONFIG.Sell.StandDistance + Vector3.new(0, CONFIG.Sell.StandHeight, 0) + offset
        hrp.CFrame = CFrame.new(standSpot, standPos)
        hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        local cam = workspace.CurrentCamera
        if cam then cam.CFrame = CFrame.new(standSpot + Vector3.new(0, CONFIG.Sell.CameraHeight, 0), standPos) end
        if not sleepSell(CONFIG.Sell.StandDelay) then return nil end
        return sellStand
    end
    local sellStand = approachSellStand()
    if not sellStand then return end
    for _, d in ipairs(sellStand:GetDescendants()) do
        if visibleSellFrame() then break end
        if d:IsA("ProximityPrompt") and d.Enabled then
            heldPrompt = d
            pcall(function() d:InputHoldBegin() end)
            pause(math.max(CONFIG.Sell.PromptHold, d.HoldDuration))
            pcall(function() d:InputHoldEnd() end)
            heldPrompt = nil
            if not sleepSell(CONFIG.Sell.PromptDelay) then return end
        end
    end

    status.Text = "Waiting for the game to open the sell window..."
    local sf = waitUntil(visibleSellFrame, LOAD_TIMEOUT, "Waiting for Sell window after activating the stand prompt.", function()
        sellStand = approachSellStand(true)
        if not sellStand then return end
        for _, prompt in ipairs(sellStand:GetDescendants()) do
            checkAlive()
            if not sellIsActive() or visibleSellFrame() then return end
            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                heldPrompt = prompt
                prompt:InputHoldBegin()
                pause(math.max(CONFIG.Sell.PromptHold, prompt.HoldDuration))
                releaseInputs()
                if not sleepSell(CONFIG.Sell.PromptDelay) then return end
            end
        end
    end)
    if not sleepSell(CONFIG.Sell.ShopDelay) then return end
    status.Text = "Selecting and selling items..."
    local sa = waitForSellButton(sf, "Select All")
    if not sellIsActive() then return end
    if not sa or not clickBtn(sa) then error("Select All button became unavailable before clicking.", 0) end
    if not sleepSell(CONFIG.Sell.SelectAllDelay) then return end
    local sb = waitForSellButton(sf, "Sell", sa)
    if not sellIsActive() then return end
    if not sb or not clickBtn(sb) then error("Sell button became unavailable before clicking.", 0) end
    if not sleepSell(CONFIG.Sell.SellDelay) then return end
    local nextCloseAt = 0
    local reportClose = newRetryMonitor("Closing SellFrame after selling")
    while sellIsActive() do
        local currentGui = playerGui:FindFirstChild("MineGui")
        local currentFrame = currentGui and currentGui:FindFirstChild("SellFrame")
        if not currentFrame or not currentFrame.Visible then
            reportClose(nil, true)
            break
        end
        if os.clock() >= nextCloseAt then
            nextCloseAt = os.clock() + 1
            status.Text = "Waiting for the sell window to close..."
            local close = currentFrame:FindFirstChild("Close")
            local ok, clicked = pcall(clickBtn, close)
            if not ok or not clicked then
                reportClose(not ok and clicked or "Waiting for SellFrame.Close to be clickable.")
            end
        end
        if not sleepSell(CONFIG.Sell.Poll) then return end
    end
    if not sellIsActive() then return end
    checkAlive()
    GameEvent:FireServer("MineTeleport", "Plot")
    if not sleepSell(CONFIG.Sell.TeleportDelay) then return end
end

modules.sell = {run = function()
    GameEvent = getGameEvent()
    local character = waitUntil(function() return player.Character end, LOAD_TIMEOUT, "Character is missing.")
    hrp = path(character, {"HumanoidRootPart"})
    mineGui = path(playerGui, {"MineGui"})
    doSellOnce()
    return "Sell cycle finished."
end}
end

do
local status = stageStatus("pickaxe")
local panel = pages.pickaxe.frame
local DEFAULT_MAX_PICKAXES = CONFIG.Pickaxe.DefaultMaxPerID
local maxPickaxes = DEFAULT_MAX_PICKAXES
local unlimitedPickaxeIds = {}
local countFile = string.format("pickaxe_counts_%s_%s.json", tostring(game.GameId), tostring(player.UserId))
local countFileSeen = false
local countStorageError = nil
local refreshCountsUI = nil

local function isValidQuantity(value)
    return type(value) == "number" and value == value
        and value >= 0 and value <= 9007199254740991 and value % 1 == 0
end

local function readPickaxeCounts()
    if countStorageError then error(countStorageError, 0) end
    if type(isfile) ~= "function" or type(readfile) ~= "function" or type(writefile) ~= "function" then
        error("Saving pickaxe counts requires isfile, readfile, and writefile. No purchase sent.", 0)
    end
    local existsOk, exists = pcall(isfile, countFile)
    if not existsOk then error("Cannot check pickaxe count file. No purchase sent.", 0) end
    if not exists then
        if countFileSeen then error("Pickaxe count file disappeared. No purchase sent.", 0) end
        return {
            version = 1,
            userId = tostring(player.UserId),
            gameId = tostring(game.GameId),
            maxPickaxes = DEFAULT_MAX_PICKAXES,
            requestCounts = {},
        }
    end
    countFileSeen = true
    local readOk, raw = pcall(readfile, countFile)
    if not readOk then error("Cannot read " .. countFile .. ". No purchase sent.", 0) end
    local decodeOk, data = pcall(HttpService.JSONDecode, HttpService, raw)
    if not decodeOk or type(data) ~= "table" or data.version ~= 1
        or data.userId ~= tostring(player.UserId) or data.gameId ~= tostring(game.GameId)
        or type(data.requestCounts) ~= "table" then
        error("Invalid pickaxe count file: " .. countFile .. ". No purchase sent.", 0)
    end

    if data.maxPickaxes == nil then data.maxPickaxes = DEFAULT_MAX_PICKAXES end
    if not isValidQuantity(data.maxPickaxes) then
        error("Invalid maxPickaxes in " .. countFile .. ". No purchase sent.", 0)
    end
    for id, count in pairs(data.requestCounts) do
        if type(id) ~= "string" or not id:match("^[1-9]%d*$")
            or not isValidQuantity(count) then
            error("Invalid pickaxe ID/count in " .. countFile .. ". No purchase sent.", 0)
        end
    end
    return data
end

local function savePickaxeData(data)
    local encodeOk, encoded = pcall(HttpService.JSONEncode, HttpService, data)
    if not encodeOk then error("Cannot encode pickaxe counts. No purchase sent.", 0) end
    local writeOk = pcall(writefile, countFile, encoded)
    local verifyOk, saved = pcall(readfile, countFile)
    if not writeOk or not verifyOk or saved ~= encoded then

        countStorageError = "Cannot verify saved pickaxe counts. No purchase sent; reload after fixing storage."
        error(countStorageError, 0)
    end
    countFileSeen = true
    if refreshCountsUI then refreshCountsUI(data) end
end

local function reservePickaxe(id, unlimited)
    if not isValidQuantity(id) or id <= 0 then
        error("Invalid pickaxe ID. No purchase sent.", 0)
    end

    local data = readPickaxeCounts()
    maxPickaxes = data.maxPickaxes
    if refreshCountsUI then refreshCountsUI(data) end
    local key = string.format("%.0f", id)
    local count = data.requestCounts[key] or 0
    if not unlimited and count >= maxPickaxes then return nil, count, maxPickaxes end
    if not isValidQuantity(count + 1) then error("Pickaxe request count exceeds the saved-count range. No purchase sent.", 0) end
    data.requestCounts[key] = count + 1
    savePickaxeData(data)
    return count + 1, nil, maxPickaxes
end

local unlimitedToggle = button(masterLayout.zone, "", UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, 28))
unlimitedToggle.Name, unlimitedToggle.TextSize = "UnlimitedBestPickaxeToggle", 12
local function refreshUnlimitedToggle(locked)
    local enabled = CONFIG.Pickaxe.UnlimitedBestPickaxe
    unlimitedToggle.Text = "Unlimited best pickaxe: " .. (enabled and "ON" or "OFF")
    unlimitedToggle.Active, unlimitedToggle.AutoButtonColor = not locked, not locked
    unlimitedToggle.BackgroundColor3 = locked and colors.idle or (enabled and colors.accent or colors.bg)
end
connect(unlimitedToggle.Activated, function()
    if not alive or busy then return end
    CONFIG.Pickaxe.UnlimitedBestPickaxe = not CONFIG.Pickaxe.UnlimitedBestPickaxe
    savePreferences()
    refreshUnlimitedToggle(false)
    if refreshCountsUI then
        local ok, data = pcall(readPickaxeCounts)
        if ok then refreshCountsUI(data) end
    end
end)
refreshUnlimitedToggle(false)
local unlimitedHint = masterLayout.text(masterLayout.zone, "Best; also second-best at max zone. Counts still saved.", 10)
unlimitedHint.Name = "UnlimitedBestPickaxeHint"

local maxLabel = Instance.new("TextLabel")
maxLabel.Position = UDim2.fromOffset(18, 256)
maxLabel.Size = UDim2.fromOffset(156, 32)
maxLabel.BackgroundTransparency = 1
maxLabel.Font = Enum.Font.Gotham
maxLabel.TextSize = 14
maxLabel.TextColor3 = Color3.fromRGB(220, 225, 235)
maxLabel.TextXAlignment = Enum.TextXAlignment.Left
maxLabel.Text = "Max per ID (0 = stop)"
maxLabel.Parent = panel

local maxInput = Instance.new("TextBox")
maxInput.Name = "MaxPickaxesInput"
maxInput.Position = UDim2.fromOffset(190, 252)
maxInput.Size = UDim2.fromOffset(104, 32)
maxInput.BackgroundColor3 = Color3.fromRGB(42, 47, 62)
maxInput.BorderSizePixel = 0
maxInput.Font = Enum.Font.Gotham
maxInput.TextSize = 16
maxInput.TextColor3 = Color3.new(1, 1, 1)
maxInput.ClearTextOnFocus = false
maxInput.MultiLine = false
maxInput.PlaceholderText = tostring(CONFIG.Pickaxe.DefaultMaxPerID)
maxInput.Text = tostring(DEFAULT_MAX_PICKAXES)
maxInput.Parent = panel
Instance.new("UICorner", maxInput).CornerRadius = UDim.new(0, 6)

local countsHeading = Instance.new("TextLabel")
countsHeading.Position = UDim2.fromOffset(314, 254)
countsHeading.Size = UDim2.new(1, -332, 0, 22)
countsHeading.BackgroundTransparency = 1
countsHeading.Font = Enum.Font.GothamBold
countsHeading.TextSize = 13
countsHeading.TextColor3 = Color3.fromRGB(220, 225, 235)
countsHeading.TextXAlignment = Enum.TextXAlignment.Left
countsHeading.Text = "Saved pickaxes (requests)"
countsHeading.Parent = panel

local countsList = Instance.new("ScrollingFrame")
countsList.Name = "BoughtIDsList"
countsList.Position = UDim2.fromOffset(18, 292)
countsList.Size = UDim2.new(1, -36, 1, -304)
countsList.BackgroundColor3 = Color3.fromRGB(34, 38, 51)
countsList.BorderSizePixel = 0
countsList.ScrollBarThickness = 5
countsList.ScrollingDirection = Enum.ScrollingDirection.Y
countsList.CanvasSize = UDim2.fromOffset(0, 0)
countsList.Parent = panel
Instance.new("UICorner", countsList).CornerRadius = UDim.new(0, 6)

local function addCountRow(text, index, capped)
    local row = Instance.new("TextLabel")
    row.Position = UDim2.fromOffset(8, 4 + (index - 1) * 24)
    row.Size = UDim2.new(1, -24, 0, 24)
    row.BackgroundTransparency = 1
    row.Font = Enum.Font.Gotham
    row.TextSize = 14
    row.TextXAlignment = Enum.TextXAlignment.Left
    row.TextColor3 = capped and Color3.fromRGB(255, 200, 125) or Color3.fromRGB(220, 225, 235)
    row.Text = text
    row.Parent = countsList
end

refreshCountsUI = function(data)
    if not alive then return end
    for _, child in ipairs(countsList:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    local ids = {}
    for id, count in pairs(data.requestCounts) do
        if count > 0 then table.insert(ids, id) end
    end
    table.sort(ids, function(a, b)
        local first, second = tonumber(a), tonumber(b)
        if first ~= second then return first < second end
        return a < b
    end)
    for index, id in ipairs(ids) do
        local count = data.requestCounts[id]
        local unlimited = CONFIG.Pickaxe.UnlimitedBestPickaxe and unlimitedPickaxeIds[tonumber(id)] == true
        local text = unlimited and string.format("ID: %s (%d; unlimited)", id, count)
            or string.format("ID: %s (%d/%d)", id, count, data.maxPickaxes)
        addCountRow(text, index, not unlimited and count >= data.maxPickaxes)
    end
    if #ids == 0 then addCountRow("No saved purchase requests yet.", 1, false) end
    countsList.CanvasSize = UDim2.fromOffset(0, math.max(#ids, 1) * 24 + 8)
end

addCountRow("Loading saved IDs...", 1, false)

local function tileState(tile)
    local button = tile:FindFirstChild("BuyButton")
    local content = button and button:FindFirstChild("Content")
    if not content or not content:IsA("GuiObject") then
        return nil, "BuyButton.Content is missing or is not a GuiObject"
    end

    local color = content.BackgroundColor3
    local r = math.floor(color.R * 255 + 0.5)
    local g = math.floor(color.G * 255 + 0.5)
    local b = math.floor(color.B * 255 + 0.5)
    if r == 38 and g == 148 and b == 84 then
        return "buyable"
    elseif r == 168 and g == 46 and b == 52 then
        return "sold_out_or_insufficient_gold"
    elseif r == 52 and g == 52 and b == 60 then
        return "locked"
    end
    return nil, string.format("unrecognized BackgroundColor3 (%d, %d, %d)", r, g, b)
end

local function isAvailable(state)
    return state == "buyable" or state == "sold_out_or_insufficient_gold"
end

local function scanBestPickaxe(list)
    local reportRetry = newRetryMonitor("Scanning the best Pickaxe")
    local previousTiles = nil
    local previousStates = nil
    local previousIds = nil
    local stableSince = os.clock()
    local problem = "No Tile children have loaded."

    while true do
        checkAlive()
        if not list:IsDescendantOf(playerGui) then
            error("Pickaxe shop List was removed. Try again.", 0)
        end
        local children = list:GetChildren()
        local tiles = {}
        local states = {}
        local ids = {}
        local ready = true
        local bestId = nil
        local bestTile = nil
        local secondId, secondTile
        for index = 1, #children do
            local tile = children[index]
            if tile.Name == "Tile" then
                local id = tile.LayoutOrder + 1
                local state, reason = tileState(tile)
                table.insert(tiles, tile)
                table.insert(states, state or "unknown")
                table.insert(ids, id)
                if not state then
                    ready = false
                    problem = string.format("Pickaxe ID %d: %s", id, reason)
                elseif isAvailable(state) then
                    if not bestId or id > bestId then
                        secondId, secondTile = bestId, bestTile
                        bestId, bestTile = id, tile
                    elseif id < bestId and (not secondId or id > secondId) then
                        secondId, secondTile = id, tile
                    end
                end
            end
        end

        if #tiles == 0 then
            ready = false
            problem = "No Tile children have loaded."
        end
        if ready then
            local unchanged = previousTiles ~= nil and #previousTiles == #tiles
            if unchanged then
                for index, tile in ipairs(tiles) do
                    if previousTiles[index] ~= tile or previousStates[index] ~= states[index]
                        or previousIds[index] ~= ids[index] then
                        unchanged = false
                        break
                    end
                end
            end
            if not unchanged then
                previousTiles = tiles
                previousStates = states
                previousIds = ids
                stableSince = os.clock()
            elseif os.clock() - stableSince >= SETTLE_TIME then

                for index, tile in ipairs(tiles) do
                    local color = tile.BuyButton.Content.BackgroundColor3

                end
                reportRetry(nil, true)
                return bestId, bestTile, secondId, secondTile
            end
            problem = "Pickaxe tiles or colors are still changing."
        else
            previousTiles = nil
            previousStates = nil
            previousIds = nil
            stableSince = os.clock()
        end
        reportRetry(problem)
        pause(CONFIG.General.ScanPoll)
    end
end

local function applyMaxInput()
    if not alive or busy then return false end
    local text = maxInput.Text:match("^%s*(.-)%s*$")
    local value = tonumber(text)
    if not text:match("^%d+$") or not isValidQuantity(value) then
        status.Text = "Max must be a whole number, 0 or higher."
        status.TextColor3 = Color3.fromRGB(255, 166, 166)
        return false
    end
    busy = true
    local ok, result = pcall(function()

        local data = readPickaxeCounts()
        data.maxPickaxes = value
        savePickaxeData(data)
        maxPickaxes = value
    end)
    busy = false
    if alive then
        if ok then
            maxInput.Text = tostring(maxPickaxes)
            status.Text = string.format("Saved max: %d per ID. Enter or leave field to save.", maxPickaxes)
        else
            status.Text = "Error: " .. tostring(result)
            logWarning("[PickaxeBuyer] " .. tostring(result))
        end
        status.TextColor3 = ok and Color3.fromRGB(148, 224, 175) or Color3.fromRGB(255, 166, 166)
    end
    return ok
end

connect(maxInput.FocusLost, function()
    if alive and not busy then applyMaxInput() end
end)

local function openPickaxeShop(deadline)
    local function shopWait(test, timeout, message, retryAction)
        if not deadline then return waitUntil(test, timeout, message, retryAction) end
        local expired = false
        local result = waitUntil(function()
            if os.clock() >= deadline then expired = true; return true end
            return test()
        end, timeout, message, retryAction)
        if expired then error("Inter-cycle shop wait ended.", 0) end
        return result
    end
    local function shopPath(parent, names)
        if not deadline then return path(parent, names) end
        for _, name in ipairs(names) do
            parent = shopWait(function() return parent:FindFirstChild(name) end,
                LOAD_TIMEOUT, "Missing pickaxe shop path component: " .. name)
        end
        return parent
    end
    local function shopPause(seconds)
        if not deadline then return pause(seconds) end
        pause(math.max(0, math.min(seconds, deadline - os.clock())))
        if os.clock() >= deadline then error("Inter-cycle shop wait ended.", 0) end
    end

    status.Text = "Refreshing the pickaxe shop..."
    local character = shopWait(function() return player.Character end, LOAD_TIMEOUT, "Character is missing.")
    local root = shopPath(character, {"HumanoidRootPart"})
    originalRoot, originalCFrame = root, root.CFrame
    local lastRetryAngle
    local function visibleShop()
        local mine = playerGui:FindFirstChild("MineGui")
        local current = mine and mine:FindFirstChild("PickaxeShopFrame")
        return visible(current) and current or nil
    end
    local function approachPickaxeStand(isRetry)
        checkAlive()
        if not player.Character or not root:IsDescendantOf(player.Character) then
            error("Character changed while opening the pickaxe shop. Run again after respawning.", 0)
        end
        local stand = shopPath(workspace, {"PickaxesStand"})
        local prompt = stand:FindFirstChildWhichIsA("ProximityPrompt", true)
        if not prompt then error("PickaxesStand has no ProximityPrompt.", 0) end
        local part = prompt.Parent
        while part and part ~= stand and not part:IsA("BasePart") do part = part.Parent end
        if not part or not part:IsA("BasePart") then
            part = stand:IsA("BasePart") and stand or stand:FindFirstChildWhichIsA("BasePart", true)
        end
        if not part then error("PickaxesStand has no BasePart to teleport to.", 0) end
        local position = prompt.Parent:IsA("Attachment") and prompt.Parent.WorldPosition or part.Position
        local distance = math.min(CONFIG.Pickaxe.StandDistance, math.max(0.5, prompt.MaxActivationDistance * 0.5))
        local offset = Vector3.zero
        if isRetry then
            local angle = math.random(0, 359)
            if angle == lastRetryAngle then angle = (angle + 1) % 360 end
            lastRetryAngle = angle
            local radians = math.rad(angle)
            offset = Vector3.new(math.cos(radians), 0, math.sin(radians))
        end
        root.CFrame = CFrame.new(position - part.CFrame.LookVector * distance + Vector3.new(0, CONFIG.Pickaxe.StandHeight, 0) + offset, position)
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        shopPause(CONFIG.Pickaxe.ShopTeleportDelay)
        if not player.Character or not root:IsDescendantOf(player.Character) then
            error("Character changed while opening the pickaxe shop. Run again after respawning.", 0)
        end
        return prompt
    end
    local prompt = approachPickaxeStand()
    shopWait(function() return visibleShop() or (prompt.Parent and prompt.Enabled) end,
        LOAD_TIMEOUT, "PickaxesStand proximity prompt is disabled.", function() prompt = approachPickaxeStand(true) end)
    local function activateStand(isRetry)
        if visibleShop() then return end
        if isRetry then prompt = approachPickaxeStand(true) end
        if visibleShop() or not prompt.Parent or not prompt.Enabled then return end
        heldPrompt = prompt
        prompt:InputHoldBegin()
        shopPause(math.max(prompt.HoldDuration, CONFIG.Pickaxe.MinimumPromptHold) + CONFIG.Pickaxe.PromptHoldPadding)
        releaseInputs()
    end
    activateStand(false)
    local shop = shopWait(visibleShop, LOAD_TIMEOUT,
        "Waiting for Pickaxe shop to open after activating its proximity prompt.", function() activateStand(true) end)
    local list = shopPath(shop, {"List"})
    shopWait(function() return list:FindFirstChild("Tile") end,
        LOAD_TIMEOUT, "Pickaxe shop opened, but no Tile children loaded.")
    shopPause(SETTLE_TIME)
    return shop
end

local function refreshPickaxeShop()
    local shop = openPickaxeShop()
    status.Text = "Closing the refreshed pickaxe shop..."
    clickButton(path(shop, {"Close"}))
    waitUntil(function() return not visible(shop) end,
        LOAD_TIMEOUT, "Waiting for Pickaxe shop to close after clicking Close.", function() clickButton(path(shop, {"Close"})) end)
    restorePosition()
end

local waitingAtPickaxeShop = false

local function clickWaitingBuyButton(button, deadline)
    checkAlive()
    local started = os.clock()
    if started >= deadline then return nil end
    local size = button.AbsoluteSize
    if size.X <= 0 or size.Y <= 0 then return nil end

    local inset = GuiService:GetGuiInset()
    local center = button.AbsolutePosition + size * 0.5 + inset
    local point = Vector2.new(math.round(center.X), math.round(center.Y))
    mouseHeld = point
    VIM:SendMouseButtonEvent(point.X, point.Y, 0, true, game, 0)
    pause(math.max(0, math.min(0.05, deadline - os.clock())))
    releaseInputs()
    return started
end

local function cleanupWaitingShop()
    if not waitingAtPickaxeShop then return end
    waitingAtPickaxeShop = false
    releaseInputs()
    local mine = playerGui:FindFirstChild("MineGui")
    local shop = mine and mine:FindFirstChild("PickaxeShopFrame")
    if shop and shop:IsA("GuiObject") then
        local close = shop:FindFirstChild("Close")
        if visible(shop) and close then pcall(clickButton, close) end

        if shop.Parent then shop.Visible = false end
    end
    releaseInputs()
    restorePosition()
end

local function waitAtPickaxeShop(seconds)
    local deadline = os.clock() + math.max(0, seconds)
    if os.clock() >= deadline then return end
    waitingAtPickaxeShop = true
    local ok, problem = pcall(function()
        openPickaxeShop(deadline)
        while os.clock() < deadline do
            checkAlive()
            local clicked = false
            for layoutOrder = 1, 2 do

                local mine = playerGui:FindFirstChild("MineGui")
                local shop = mine and mine:FindFirstChild("PickaxeShopFrame")
                if not visible(shop) then error("Pickaxe shop closed while waiting.", 0) end
                local list = shop:FindFirstChild("List")
                if list then
                    for _, tile in ipairs(list:GetChildren()) do
                        checkAlive()
                        if os.clock() >= deadline then return end
                        if tile.Name == "Tile" and tile:IsA("GuiObject") and tile.LayoutOrder == layoutOrder then
                            local button = tile:FindFirstChild("BuyButton")
                            if button and button:IsA("GuiButton") and visible(button) then
                                local clickedAt = clickWaitingBuyButton(button, deadline)
                                if clickedAt then
                                    clicked = true
                                    local nextClick = math.min(clickedAt + CONFIG.Pickaxe.WaitingClickDelay, deadline)
                                    if nextClick > os.clock() then pause(nextClick - os.clock()) end
                                    break
                                end
                            end
                        end
                    end
                end
            end

            if not clicked then
                pause(math.max(0, math.min(CONFIG.General.ScanPoll, deadline - os.clock())))
            end
        end
    end)
    cleanupWaitingShop()
    checkAlive()
    if not ok and os.clock() < deadline then logWarning("[Pickaxe wait] " .. tostring(problem)) end
    local remaining = deadline - os.clock()
    if remaining > 0 then pause(remaining) end
end

modules.pickaxe = {
    waitBetweenCycles = waitAtPickaxeShop,
    cleanupWaiting = cleanupWaitingShop,
    run = function()
        status.Text = "Checking the current zone for pickaxe purchases..."
        -- Master detects the zone at cycle start; standalone runs detect it on demand.
        local zoneId = getCycleZone()
        local atMaxZone = modules.upgrades.isMaxZone(zoneId)
        refreshPickaxeShop()

        local event = getGameEvent()
        if not event:IsA("RemoteEvent") then
            error("Remotes.GamestateEvent is not a RemoteEvent.", 0)
        end
        local list = path(playerGui, {"MineGui", "PickaxeShopFrame", "List"})
        status.Text = "Finding the highest unlocked pickaxes..."
        local id, tile, secondId, secondTile = scanBestPickaxe(list)
        unlimitedPickaxeIds = {}
        if not alive then return "Unloaded." end
        if not id then return "Cannot buy the best pickaxe at the moment." end

        local choices = {{id = id, tile = tile}}
        unlimitedPickaxeIds[id] = true
        if atMaxZone and secondId then
            table.insert(choices, {id = secondId, tile = secondTile})
            unlimitedPickaxeIds[secondId] = true
        end
        local unlimited = CONFIG.Pickaxe.UnlimitedBestPickaxe
        local results = {}
        local function buySelected(choice)
            local selectedId, selectedTile = choice.id, choice.tile
            local data = readPickaxeCounts()
            maxPickaxes = data.maxPickaxes
            maxInput.Text = tostring(maxPickaxes)
            refreshCountsUI(data)
            local savedCount = data.requestCounts[string.format("%.0f", selectedId)] or 0
            if not unlimited and savedCount >= maxPickaxes then
                return string.format("Pickaxe ID %d: limit reached (%d/%d).", selectedId, savedCount, maxPickaxes)
            end
            if selectedTile.Parent ~= list or tileState(selectedTile) ~= "buyable" then
                return string.format("Pickaxe ID %d: unavailable; no request sent.", selectedId)
            end

            local count, limitCount, limit = reservePickaxe(selectedId, unlimited)
            maxInput.Text = tostring(limit)
            if not count then
                return string.format("Pickaxe ID %d: limit reached (%d/%d).", selectedId, limitCount, limit)
            end
            if not alive then return "Unloaded; saved slot retained." end
            if selectedTile.Parent ~= list or tileState(selectedTile) ~= "buyable" then
                return string.format("Pickaxe ID %d: unavailable; saved slot retained.", selectedId)
            end
            checkAlive()
            event:FireServer("MineBuyPickaxe", selectedId)
            if unlimited then
                return string.format("ID %d: request sent. Saved %d requests; buy limit disabled.", selectedId, count)
            end
            return string.format("ID %d: request sent. Saved %d/%d.", selectedId, count, limit)
        end
        for _, choice in ipairs(choices) do
            checkAlive()
            table.insert(results, buySelected(choice))
        end
        return table.concat(results, " ")
    end,
    prepare = function()
        if maxInput.Text ~= tostring(maxPickaxes) then return applyMaxInput() end
        return true
    end,
    setBusy = function(value)
        maxInput.TextEditable = not value
        refreshUnlimitedToggle(value)
    end,
}

local settingsOk, settingsError = pcall(function()
    local data = readPickaxeCounts()
    savePickaxeData(data)
    maxPickaxes = data.maxPickaxes
end)
maxInput.Text = tostring(maxPickaxes)
if settingsOk then
    status.Text = "Enter or leave the max field to save. Drag title to move."
else
    for _, child in ipairs(countsList:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    addCountRow("Saved IDs could not be loaded.", 1, false)
    status.Text = "Error: " .. tostring(settingsError)
    status.TextColor3 = Color3.fromRGB(255, 166, 166)
    logWarning("[PickaxeBuyer] " .. tostring(settingsError))
end

end

do
local status = stageStatus("upgrades")
local UPGRADE_DELAY = CONFIG.Upgrades.RequestDelay
local ROW_SCALE_TOLERANCE = CONFIG.Upgrades.RowScaleTolerance
assert(type(ROW_SCALE_TOLERANCE) == "number" and ROW_SCALE_TOLERANCE == ROW_SCALE_TOLERANCE
    and ROW_SCALE_TOLERANCE >= 0 and ROW_SCALE_TOLERANCE < math.huge,
    "CONFIG.Upgrades.RowScaleTolerance must be a finite nonnegative number.")

local NODE_CATEGORIES = CONFIG.Upgrades.NodeCategories
local function nodeState(node)

    local content = node:FindFirstChild("Content")
    if not content then return nil, "Content is missing" end
    local color = content:GetAttribute("realcolor")
    if color == nil then
        color = node:GetAttribute("realcolor")
    end
    if typeof(color) ~= "Color3" then
        return nil, "realcolor is missing or is not a Color3"
    end

    local r = math.floor(color.R * 255 + 0.5)
    local g = math.floor(color.G * 255 + 0.5)
    local b = math.floor(color.B * 255 + 0.5)
    if r == 38 and g == 148 and b == 84 then
        return "upgraded"
    elseif r == 214 and g == 48 and b == 44 then
        return "available"
    elseif r == 52 and g == 52 and b == 60 then
        return "locked"
    elseif r == 114 and g == 118 and b == 132 then

        return "not_upgraded"
    end
    return nil, string.format("unrecognized realcolor (%d, %d, %d)", r, g, b)
end

local function scanDensity(zone)
    local reportRetry = newRetryMonitor("Scanning Density for " .. zone.Name)
    local lastSignature = nil
    local stableSince = os.clock()
    local problem = "No Node_Density nodes have loaded."

    while true do
        checkAlive()

        zone = getUpgradeZone(zone.Name)
        local entries = {}
        local level = 0
        local ready = true
        local count = 0
        for _, node in ipairs(zone:GetChildren()) do
            local suffix = node.Name:match("^Node_Density(%d*)$")
            if suffix then
                count = count + 1
                local state, reason = nodeState(node)
                if state == nil then
                    ready = false
                    problem = node.Name .. ": " .. reason
                else

                    local nodeLevel = tonumber(suffix) or 1

                    if state == "upgraded" then level = math.max(level, nodeLevel) end
                    table.insert(entries, node.Name .. ":" .. state)
                end
            end
        end
        if count == 0 then
            ready = false
            problem = "No Node_Density nodes have loaded."
        end
        if ready then
            table.sort(entries)
            local signature = table.concat(entries, "|")
            if signature ~= lastSignature then
                lastSignature = signature
                stableSince = os.clock()
            elseif os.clock() - stableSince >= SETTLE_TIME then
                if zone.Name == cycleZoneName then
                    cacheConfirmedDensity(cycleZoneId, level)
                    if activeStage == "upgrades" then minimizedActions.hideTutorial(cycleZoneId, level) end
                end
                reportRetry(nil, true)
                return level, zone
            end
            problem = "Density nodes are still changing."
        else
            lastSignature = nil
            stableSince = os.clock()
        end
        reportRetry(problem)
        pause(CONFIG.General.ScanPoll)
    end
end

readCycleDensity = scanDensity

local function skillArguments(nodeName)
    local skillId = nodeName:match("^Node_(.+)$")
    if not skillId then error("Invalid skill node name: " .. nodeName, 0) end
    local baseName = skillId:gsub("%d+$", "")
    local category = NODE_CATEGORIES[baseName]
    if category == nil then
        category = baseName
    end
    if type(category) ~= "string" or not category:find("%S") then
        return nil, skillId, baseName
    end
    return category, skillId, baseName
end

local lastDensityBlock
local function densityUpgradeReady(zoneId, nodeName)
    local ready, reason = modules.mutation.densityReady(zoneId)
    if not ready then
        local message = zoneId .. ": " .. nodeName .. " blocked: " .. tostring(reason)
        status.Text = message
        if lastDensityBlock ~= message then logInfo("Upgrades", message) end
        lastDensityBlock = message
    else
        lastDensityBlock = nil
    end
    return ready
end
local notificationsInFlight = {maxZone = {}, colossus = {}}
local function notifyUpgradeMilestone(kind, zoneId, pips)
    if not zoneId then return end
    local sent = preferences.discordNotifications[kind]
    local pending = notificationsInFlight[kind]
    if sent[zoneId] or pending[zoneId] then return end
    local webhookUrl = CONFIG.Upgrades.DiscordWebhookUrl
    if not webhookUrl:find("%S") then return end
    if type(request) ~= "function" then
        logWarning("[Upgrades] Discord webhook requires Volt's request function.")
        return
    end

    local rule = CONFIG.Units.RequiredByZone[zoneId]
    local zoneName = (rule and rule.DisplayName) or zoneId
    local content = string.format("**%s** reached **MAX zone + Colossus 1** in **%s (%s)**!\nColossus progress: **%s**.",
        player.Name, zoneName, zoneId, pips)
    local elapsed = math.max(0, os.time() - preferences.firstLoadedAt)
    local elapsedText = "unknown"
    if elapsed >= 3600 then
        local days = math.floor(elapsed / 86400)
        local hours = math.floor((elapsed % 86400) / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        elapsedText = string.format("%dh %02dm %02ds", hours, minutes, elapsed % 60)
        if days > 0 then elapsedText = tostring(days) .. "d " .. elapsedText end
    end
    content = content .. "\nTime since first script load: **" .. elapsedText .. "**. @everyone"
    pending[zoneId] = true
    task.spawn(function()
        local thread = coroutine.running()
        runScope.background[thread] = true
        local ok, response = pcall(function()
            return request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({
                    content = content,
                    allowed_mentions = {parse = {"everyone"}},
                }),
            })
        end)
        local statusCode = type(response) == "table" and tonumber(response.StatusCode)
        if ok and type(response) == "table"
            and ((statusCode and statusCode >= 200 and statusCode < 300)
                or (not statusCode and response.Success == true)) then
            sent[zoneId] = true
            if not savePreferences() then
                logWarning("[Upgrades] Discord notification sent, but its cache could not be saved; it may repeat after restarting.")
            end
        else
            logWarning("[Upgrades] " .. kind .. " Discord notification failed for " .. zoneId .. ".")
        end
        pending[zoneId] = nil
        runScope.background[thread] = nil
    end)
end

local function isMaxZone(zoneId)
    local maxZoneId, maxZoneNumber = nil, 0
    for configuredZoneId in pairs(CONFIG.Units.RequiredByZone) do
        local number = tonumber(configuredZoneId:match("^Z(%d+)$"))
        if number and number > maxZoneNumber then
            maxZoneId, maxZoneNumber = configuredZoneId, number
        end
    end
    return maxZoneId ~= nil and zoneId == maxZoneId
end
local function reachedColossusPips(zone)
    local node = zone:FindFirstChild("Node_Colossus")
    local content = node and node:FindFirstChild("Content")
    local pips = content and content:FindFirstChild("Pips")
    if not pips or not (pips:IsA("TextLabel") or pips:IsA("TextButton") or pips:IsA("TextBox")) then return nil end

    local countText, maxText = pips.Text:match("^%s*(%d+)%s*/%s*(%d+)%s*$")
    if not countText then return nil end
    local count, maximum = tonumber(countText), tonumber(maxText)
    if count >= 1 and count <= maximum and maximum < math.huge then
        local progress = countText .. "/" .. maxText
        local zoneId = zone.Name:match("^Zone_(Z%d+)$")
        if isMaxZone(zoneId) then
            notifyUpgradeMilestone("colossus", zoneId, progress)
        end
        return progress
    end
    return nil
end

local function colossusPipsUnlocked(pips)
    if type(pips) ~= "string" then return false end
    local countText, maxText = pips:match("^%s*(%d+)%s*/%s*(%d+)%s*$")
    local count, maximum = tonumber(countText), tonumber(maxText)
    return count ~= nil and maximum ~= nil and maximum > 0 and maximum < math.huge and count >= 1 and count <= maximum
end
local function shouldStopForColossus(zoneId, pips)
    return colossusPipsUnlocked(pips)
end
local function saveColossusStageToggles(zoneId, pips)
    local atMaxZone = isMaxZone(zoneId)
    local complete = colossusPipsUnlocked(pips)
    minimizedActions.setNotificationZone(zoneId, atMaxZone and complete)
    local changed = false
    -- Preserve the original Colossus-controlled stages after inserting Unlock slots.
    for _, id in ipairs({"upgrades", "upgradingOldUnit", "units", "mutation", "upgradingUnit"}) do
        local enabled = not complete
        if preferences.stages[id] ~= enabled then changed = true end
        preferences.stages[id] = enabled
        setMasterStageState(id, enabled and "Waiting" or "OFF")
    end
    if CONFIG.Pickaxe.UnlimitedBestPickaxe ~= atMaxZone then
        CONFIG.Pickaxe.UnlimitedBestPickaxe = atMaxZone
        changed = true
    end
    local saved = not changed or savePreferences()
    refreshStageToggles(busy)
    modules.pickaxe.setBusy(busy)

    local result = zoneId .. ": Colossus Pips " .. (pips or "not reached")
        .. (atMaxZone and "; max zone reached." or "; max zone not reached.")
        .. (complete and " Stages 3-4 and 6-8 OFF." or " Stages 3-4 and 6-8 ON.")
        .. (atMaxZone and " Unlimited Best Pickaxe ON." or " Unlimited Best Pickaxe OFF.")
    if changed then
        result = result .. (saved and " Preferences saved." or " Preference save could not be verified.")
    end
    return result, complete
end

local function upgradeNode(zone, nodeName, zoneId)
    local category, skillId, baseName = skillArguments(nodeName)
    if not category then
        logWarning(string.format(
            '[UpgradeClicker] ERROR: No valid third argument configured for %s. Add NODE_CATEGORIES["%s"] in the config. Skipping this node; no request sent.',
            nodeName, baseName
        ))
        return 0
    end
    local event = getGameEvent()
    local requests = 0
    local colossusPips
    local stopReason
    local reportRetry = newRetryMonitor("Buying upgrade " .. nodeName .. " in " .. zoneId)
    while true do
        checkAlive()
        if not alive then error("Unloaded.", 0) end
        zone = getUpgradeZone(zone.Name)
        colossusPips = reachedColossusPips(zone)
        if shouldStopForColossus(zoneId, colossusPips) then break end

        local node = zone:FindFirstChild(nodeName)
        if not node then
            stopReason = "node was removed"
            break
        end
        local state, reason = nodeState(node)
        if state ~= "available" then
            stopReason = state or (reason or "node state is unavailable")
            break
        end
        local densityTarget = tonumber(nodeName:match("^Node_Density(%d+)$"))
        if densityTarget == 2 and not densityUpgradeReady(zoneId, nodeName) then
            break
        end
        status.Text = string.format("Upgrading %s: request %d", nodeName, requests + 1)
        checkAlive()
        event:FireServer("MineBuySkill", zoneId, category, skillId)
        requests = requests + 1
        reportRetry("Node remains available after " .. requests .. " requests.")
        pause(UPGRADE_DELAY)
    end
    reportRetry(nil, true)
    if not alive then error("Unloaded.", 0) end
    local current = zone:FindFirstChild(nodeName)
    if current and nodeState(current) == "upgraded" then

    end

    return requests, colossusPips
end

local function upgradeNodes(zone, densityLevel, zoneId)
    local totalNodes = 0
    local totalRequests = 0
    local requestedNodes = {}
    local colossusPips
    local function process(nodeName)
        local requests
        requests, colossusPips = upgradeNode(zone, nodeName, zoneId)
        if requests > 0 then
            totalNodes = totalNodes + 1
            requestedNodes[nodeName] = true
        end
        totalRequests = totalRequests + requests
    end

    local attempted = {}
    local lastPolicy = nil
    while alive and not shouldStopForColossus(zoneId, colossusPips) do
        zone = getUpgradeZone(zone.Name)

        status.Text = "Refreshing " .. zone.Name .. " density..."
        densityLevel, zone = scanDensity(zone)
        colossusPips = reachedColossusPips(zone)
        if shouldStopForColossus(zoneId, colossusPips) then break end
        local highestDensityLevel = 0
        for _, node in ipairs(zone:GetChildren()) do
            local suffix = node.Name:match("^Node_Density(%d*)$")
            if suffix then
                highestDensityLevel = math.max(highestDensityLevel, tonumber(suffix) or 1)
            end
        end
        local maxed = densityLevel > 0 and densityLevel == highestDensityLevel

        local referenceLevel = maxed and densityLevel or (densityLevel + 1)
        local referenceName = "Node_Density" .. tostring(referenceLevel)
        local reference = zone:FindFirstChild(referenceName)
        if not reference and referenceLevel == 1 then
            reference = zone:FindFirstChild("Node_Density")
        end
        if not reference then reference = path(zone, {referenceName}) end
        if not alive then error("Unloaded.", 0) end
        if not reference or not reference:IsA("GuiObject") then
            error("Cannot read density reference Position: " .. referenceName, 0)
        end
        referenceName = reference.Name
        local referenceX = reference.Position.X.Scale
        local referenceY = reference.Position.Y.Scale
        local policy = tostring(densityLevel) .. ":" .. tostring(maxed) .. ":" .. referenceName
        if policy ~= lastPolicy then
            if maxed then

            else

            end
            lastPolicy = policy
        end

        local densityAllowed = maxed or referenceLevel ~= 2 or densityUpgradeReady(zoneId, referenceName)
        if not maxed and densityAllowed and not attempted[referenceName] and nodeState(reference) == "available" then
            attempted[referenceName] = true

            process(referenceName)
        else
            local candidates = {}
            for _, node in ipairs(zone:GetChildren()) do
                if node:IsA("GuiObject") and node.Name:match("^Node_.+")
                    and not node.Name:match("^Node_Density%d*$")
                    and not attempted[node.Name]
                    and nodeState(node) == "available" then
                    local y = node.Position.Y.Scale
                    local distanceX = math.abs(node.Position.X.Scale - referenceX)

                    local sameRow = math.abs(y - referenceY) <= ROW_SCALE_TOLERANCE

                    if maxed or y < referenceY or sameRow then
                        table.insert(candidates, {
                            node = node,
                            distanceX = distanceX,
                            y = y,
                        })
                    end
                end
            end
            if not maxed then
                table.sort(candidates, function(a, b)
                    if a.distanceX ~= b.distanceX then return a.distanceX < b.distanceX end
                    if a.y ~= b.y then return a.y < b.y end
                    return a.node.Name < b.node.Name
                end)
            end
            if #candidates == 0 then break end
            local choice = candidates[1]
            local nodeName = choice.node.Name
            attempted[nodeName] = true
            if maxed then

            else

            end
            process(nodeName)
        end

    end
    if not alive then error("Unloaded.", 0) end
    if shouldStopForColossus(zoneId, colossusPips) then
        return totalNodes, totalRequests, densityLevel, 0, colossusPips
    end

    if totalRequests > 0 then pause(SETTLE_TIME) end
    if not alive then error("Unloaded.", 0) end
    densityLevel, zone = scanDensity(zone)
    colossusPips = reachedColossusPips(zone)
    local confirmedUpgrades = 0
    for nodeName in pairs(requestedNodes) do
        local node = zone:FindFirstChild(nodeName)

        if node and nodeState(node) == "upgraded" then
            confirmedUpgrades = confirmedUpgrades + 1
        end
    end

    return totalNodes, totalRequests, densityLevel, confirmedUpgrades, colossusPips
end

local function scanCurrentUpgradeZone()
    checkAlive()
    cycleDensityLevel, cycleZoneReady = nil, false
    status.Text = "Opening the skill tree and checking current-zone upgrade data..."
    local zoneId, zoneName = getCycleZone()
    minimizedActions.setNotificationZone(zoneId)
    local level, zone = scanDensity(getUpgradeZone(zoneName))
    syncUnitSequenceZone(zoneId)
    logInfo("Upgrades", string.format("Fresh ZoneBoard zone: %s, Density %d.", zoneId, level))
    return zone, zoneId, level
end

local function runUpgrades()
            if not alive then return "Unloaded." end
            local zone, zoneId = scanCurrentUpgradeZone()
            local cycle = 0
            local totalRequests = 0
            local totalUpgrades = 0
            while alive do
                cycle = cycle + 1

                status.Text = "Cycle " .. cycle .. ": scanning density..."
                local level = scanDensity(zone)
                if not alive then return "Unloaded." end
                local toggleResult, complete = saveColossusStageToggles(zoneId, reachedColossusPips(zone))
                if complete then return toggleResult end

                local _, requests, currentDensity, confirmed, colossusPips = upgradeNodes(zone, level, zoneId)
                if shouldStopForColossus(zoneId, colossusPips) then
                    return (saveColossusStageToggles(zoneId, colossusPips))
                end
                totalRequests = totalRequests + requests
                totalUpgrades = totalUpgrades + confirmed
                if confirmed == 0 then

                    return string.format("%s density %d. Cycles: %d. Upgrades: %d. Requests: %d.", zoneId, currentDensity, cycle, totalUpgrades, totalRequests)
                end

                pause(UPGRADE_DELAY)
            end
            return "Unloaded."
end
label(pages.cycleEnd.frame, "Zone selection uses the zone and Density saved by the Upgrades step, even while OFF.",
    UDim2.fromOffset(18, 294), UDim2.new(1, -36, 0, 36), 12)
local selectCurrent = button(pages.cycleEnd.frame, "", UDim2.fromOffset(18, 338), UDim2.new(1, -36, 0, 30))
selectCurrent.Name = "SelectCurrentZoneToggle"
local selectNext = button(pages.cycleEnd.frame, "", UDim2.fromOffset(18, 376), UDim2.new(1, -36, 0, 30))
selectNext.Name = "SelectNextZoneToggle"

local function refreshZoneToggles(locked)
    for _, item in ipairs({
        {button = selectCurrent, key = "SelectCurrentZone", text = "Select current zone"},
        {button = selectNext, key = "SelectNextZone", text = "Select next zone"},
    }) do
        local enabled = CONFIG.Upgrades[item.key]
        item.button.Text = item.text .. (enabled and ": ON" or ": OFF")
        item.button.Active, item.button.AutoButtonColor = not locked, not locked
        item.button.BackgroundColor3 = locked and colors.idle or (enabled and colors.accent or colors.bg)
    end
end
connect(selectCurrent.Activated, function()
    if not alive or busy then return end
    CONFIG.Upgrades.SelectCurrentZone = not CONFIG.Upgrades.SelectCurrentZone
    savePreferences()
    refreshZoneToggles(false)
end)
connect(selectNext.Activated, function()
    if not alive or busy then return end
    CONFIG.Upgrades.SelectNextZone = not CONFIG.Upgrades.SelectNextZone
    savePreferences()
    refreshZoneToggles(false)
end)
refreshZoneToggles(false)
modules.upgrades = {isMaxZone = isMaxZone, setBusy = refreshZoneToggles,
cleanup = function() closeSkillTree(true) end, getDensity = function()

    getCycleZone()
    if cycleDensityLevel == nil then
        local mine = playerGui:FindFirstChild("MineGui")
        local frame = mine and mine:FindFirstChild("SkillTreeFullFrame")
        local wasOpen = frame and frame.Visible
        local ok, problem = pcall(function()
            assert(readCycleDensity, "Density reader is not initialized.")(getUpgradeZone(cycleZoneName))
        end)
        if not wasOpen then closeSkillTree(true) end
        if not ok then error(problem, 0) end
    end
    assert(cycleDensityLevel ~= nil, "Density cache is missing.")
    return cycleDensityLevel
end, cacheCurrentZone = function()
    local zone, zoneId, level = scanCurrentUpgradeZone()
    local result, complete = saveColossusStageToggles(zoneId, reachedColossusPips(zone))
    if not complete then return modules.upgrades.run() end
    closeSkillTree()
    cycleZoneReady = true
    return string.format("%s Fresh Canvas density %d; tutorial button %s; zone selection ready.",
        result, level, preferences.tutorialHidden and "hidden" or "still visible")
end, selectZones = function()
    checkAlive()
    if not cycleZoneReady then
        logUnitUpgradeDetail("Zone selection skipped: the Upgrades step has not prepared saved zone/Density values.")
        return
    end
    if not CONFIG.Upgrades.SelectCurrentZone and not CONFIG.Upgrades.SelectNextZone then return end
    local zoneId = assert(cycleZoneId, "Cannot select zones without this cycle's cached zone.")
    local zoneNumber = assert(tonumber(zoneId:match("^Z(%d+)$")), "Invalid cached zone ID.")
    local event = getGameEvent()
    if CONFIG.Upgrades.SelectCurrentZone then
        checkAlive()
        event:FireServer("MineSelectZone", zoneId)
        logUnitUpgradeDetail("Cycle end: selected cached current zone " .. zoneId .. ".")
    end
    if CONFIG.Upgrades.SelectNextZone then
        local nextZone = "Z" .. tostring(zoneNumber + 1)
        checkAlive()
        event:FireServer("MineSelectZone", nextZone)
        logUnitUpgradeDetail("Cycle end: selected next zone " .. nextZone .. ".")
    end
end, run = function()
    cycleZoneReady = false
    local result = runUpgrades()
    checkAlive()
    closeSkillTree()
    assert(cycleDensityLevel ~= nil, "Density cache is missing.")
    cycleZoneReady = true
    logUnitUpgradeDetail(string.format("Upgrades finished: %s, density %d cached; current/next selection deferred to the end.",
        tostring(cycleZoneId), cycleDensityLevel))
    return result
end}
end

local function mutationStoppedByDensityII(zoneId)

    local level = modules.upgrades.getDensity()
    assert(zoneId == cycleZoneId, "Mutation density check does not match the current zone.")
    return level >= 2
end

do
-- Separate setup scopes avoid exhausting the main chunk's registers on mobile compilers.
(function()
local status = stageStatus("units")

local FinalEquipMode = CONFIG.Units.FinalEquipMode

local RequiredUnitsByZone = CONFIG.Units.RequiredByZone
local ACTION_TIMEOUT = CONFIG.Units.ActionTimeout
local TELEPORT_SETTLE = CONFIG.Units.TeleportDelay

local EQUIP_SLOT_SETTLE = CONFIG.Units.EquipSlotDelay
local PLACEMENT_KEY_HOLD = CONFIG.Units.PlacementKeyHold
local PLACEMENT_SETTLE = CONFIG.Units.PlacementDelay
local HOTBAR_KEYS = CONFIG.Units.HotbarKeys
local UI_SETTLE = CONFIG.Units.InventorySettleTime
local DISPLAY_REMOVE_DELAY = CONFIG.Units.DisplayRemoveDelay
local CLICK_DELAY = CONFIG.Units.InventoryClickDelay

local function setStatus(message)
    checkAlive()
    status.Text = message

end
local unitRetryOffsets = {
    Vector3.new(1, 0, 0), Vector3.new(0, 0, 1),
    Vector3.new(-1, 0, 0), Vector3.new(0, 0, -1),
}
local function unitRetryOffset(attempt)
    if attempt == 1 then return Vector3.zero end
    return unitRetryOffsets[(attempt - 2) % #unitRetryOffsets + 1]
end

local function unitInteractionPath(parent, names)
    for _, name in ipairs(names) do
        local current = parent
        parent = waitUntil(function() return current:FindFirstChild(name) end, nil,
            "Waiting for unit interaction path component " .. name .. " under " .. current:GetFullName())
    end
    return parent
end

local function closeUnitInteractionPanel(frame, buttonPath, retryDelay)
    if #buttonPath == 1 and buttonPath[1] == "ExitButton" then
        closeUnitPanel("Closing SlotFocusFrame through Visible before unit interaction")
        return
    end
    local reportRetry = newRetryMonitor("Closing unit/inventory panel " .. frame.Name)
    while frame.Parent and visible(frame) do
        checkAlive()
        if frame.Name == "InventoryFrame" then
            frame.Visible = false
        else
            local button = frame
            for _, name in ipairs(buttonPath) do
                button = button and button:FindFirstChild(name)
            end
            if button and visible(button) then clickButton(button) end
        end
        reportRetry()
        pause(retryDelay)
    end
    reportRetry(nil, true)
end

local function listSlots(plot, waitForInteraction)
    checkPlot(plot)
    local holders = (waitForInteraction and unitInteractionPath or path)(plot, {"Holders"})
    local slots = {}
    for _, holder in ipairs(holders:GetChildren()) do
        local number = tonumber(holder.Name:match("^M(%d+)$"))
        if number and number >= 1 then
            table.insert(slots, { name = holder.Name, number = number })
        end
    end
    table.sort(slots, function(a, b) return a.number < b.number end)
    if #slots == 0 then error("No M1, M2, ... holders found in your plot.", 0) end
    return holders, slots
end

local function holderPrompt(plot, holderName, waitForInteraction)
    checkPlot(plot)
    local prompt = (waitForInteraction and unitInteractionPath or path)(plot, {"Holders", holderName, "Pad", "HolderPrompt"})
    if not prompt:IsA("ProximityPrompt") then error(holderName .. " HolderPrompt is not a ProximityPrompt.", 0) end
    return prompt
end

local function hasPickUpAction(prompt)
    return prompt.ActionText:match("^%s*(.-)%s*$"):lower() == "pick up"
end

local function emptyDisplayUnits(plot, phase)
    local mine = playerGui:FindFirstChild("MineGui")
    local focus = mine and mine:FindFirstChild("SlotFocusFrame")
    if focus and visible(focus) then
        closeUnitInteractionPanel(focus, {"ExitButton"}, CONFIG.Units.RemovalRetryDelay)
    end
    local inventory = mine and mine:FindFirstChild("InventoryFrame")
    if inventory and visible(inventory) then
        closeUnitInteractionPanel(inventory, {"Content", "Actions", "Close"}, CONFIG.Units.RemovalRetryDelay)
    end
    local removed = 0
    while true do
        local _, slots = listSlots(plot, true)
        for _, slot in ipairs(slots) do
            if hasPickUpAction(holderPrompt(plot, slot.name, true)) then
                local attempt = 0
                local reportRetry = newRetryMonitor("Removing unit from " .. slot.name)
                while true do
                    attempt = attempt + 1
                    local prompt = holderPrompt(plot, slot.name, true)
                    if not hasPickUpAction(prompt) then break end
                    local upgrade = unitInteractionPath(plot, {"Holders", slot.name, "UpgradePart"})
                    if not upgrade:IsA("BasePart") then error(slot.name .. " UpgradePart is not a BasePart.", 0) end
                    local root = originalRoot
                    if not root or not player.Character or not root:IsDescendantOf(player.Character) then
                        error("Character changed during removal. Run again after respawning.", 0)
                    end
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:UnequipTools() end
                    if not hasPickUpAction(holderPrompt(plot, slot.name, true)) then break end
                    setStatus(string.format("%s: removing %s (attempt %d)...",
                        phase, slot.name, attempt))
                    root.CFrame = CFrame.new(upgrade.Position + Vector3.new(0, CONFIG.Units.TeleportHeight, 0) + unitRetryOffset(attempt), upgrade.Position)
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                    pause(TELEPORT_SETTLE)
                    prompt = holderPrompt(plot, slot.name, true)
                    if hasPickUpAction(prompt) and prompt.Enabled then
                        heldPrompt = prompt
                        prompt:InputHoldBegin()
                        pause(math.max(prompt.HoldDuration, CONFIG.Units.RemovalMinimumHold) + CONFIG.Units.RemovalHoldPadding)
                        releaseInputs()
                    end
                    reportRetry()
                    pause(CONFIG.Units.RemovalRetryDelay)
                    if not hasPickUpAction(holderPrompt(plot, slot.name, true)) then break end
                end
                reportRetry(nil, true)
                removed = removed + 1
                pause(DISPLAY_REMOVE_DELAY)
            end
        end
        local _, remaining = listSlots(plot, true)
        local pending = false
        for _, slot in ipairs(remaining) do
            if hasPickUpAction(holderPrompt(plot, slot.name, true)) then
                pending = true
                break
            end
        end
        if not pending then return removed end
        pause(CONFIG.Units.RemovalRetryDelay)
    end
end

local function inventoryFrame()
    return path(playerGui, {"MineGui", "InventoryFrame"})
end

local function inventoryScroll()
    return path(inventoryFrame(), {"Content", "Scroll"})
end

local function rowButton(row)
    -- This scan only needs to know whether exactly one usable button exists.
    -- Avoid building resolveButton's diagnostic tables and full-name strings.
    if row:IsA("GuiButton") then return row end
    local found
    for _, child in ipairs(row:GetDescendants()) do
        if child:IsA("GuiButton") and visible(child) then
            if found then return nil end
            found = child
        end
    end
    return found
end

local function inventoryTargets(scroll, includeAll, children)
    local named
    if not includeAll then
        named = {}
        for index = 0, 8 do
            local row = scroll:FindFirstChild(tostring(index))
            if not row or not row:IsA("GuiObject") or not rowButton(row) or not visible(row) then
                named = nil
                break
            end
            table.insert(named, row)
        end
    end
    local rows = named or {}
    if not named then
        for _, row in ipairs(children or scroll:GetChildren()) do
            if row:IsA("GuiObject") and visible(row) and rowButton(row) then
                table.insert(rows, row)
            end
        end
        local layout = scroll:FindFirstChildWhichIsA("UIGridStyleLayout")
        local sortByName = layout and layout.SortOrder == Enum.SortOrder.Name
        table.sort(rows, function(a, b)
            if not sortByName and a.LayoutOrder ~= b.LayoutOrder then
                return a.LayoutOrder < b.LayoutOrder
            end
            return a.Name < b.Name
        end)
    end
    if #rows == 0 or (not includeAll and #rows < 9) then return nil end
    local targets = {}
    local seen = {}
    for index = 1, (includeAll and #rows or 9) do
        local row = rows[index]
        local key = row.Name .. "\0" .. tostring(row.LayoutOrder)
        if seen[key] then error("Inventory rows need unique names or LayoutOrder values.", 0) end
        seen[key] = true
        table.insert(targets, { name = row.Name, order = row.LayoutOrder })
    end
    return targets
end

local damageIllions = { [""] = 0 }
do
    local ones = {{""}, {"U"}, {"D"}, {"T"}, {"Qa"}, {"Qi", "Qu"}, {"Sx"}, {"Sp"}, {"Oc"}, {"No"}}
    local tens = {{""}, {"Dc", "De", "D"}, {"Vg"}, {"Tg"}, {"Qag", "Qd"}, {"Qig", "Qt"}, {"Sxg", "Sg"}, {"Spg", "St"}, {"Ocg", "Og"}, {"Nog", "Ng"}}
    local hundreds = {{""}, {"Ce"}, {"Duc"}, {"Trc"}, {"Qac"}, {"Qic"}, {"Sxc"}, {"Spc"}, {"Occ"}, {"Noc"}}
    for h = 0, 9 do
        for t = 0, 9 do
            for u = 0, 9 do
                local illion = h * 100 + t * 10 + u
                for _, hp in ipairs(hundreds[h + 1]) do
                    for _, tp in ipairs(tens[t + 1]) do
                        for _, up in ipairs(ones[u + 1]) do
                            damageIllions[(up .. tp .. hp):lower()] = illion
                        end
                    end
                end
            end
        end
    end

    for index, suffix in ipairs({"M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No"}) do
        damageIllions[suffix:lower()] = index
    end
end

local function damageSuffixPower(suffix)
    suffix = suffix:lower()
    if suffix == "" then return 0 end
    if suffix == "k" then return 3 end
    local illion = damageIllions[suffix]
    if illion then return (illion + 1) * 3 end

    local remainder, total, previousScale = suffix, 0, math.huge
    local markers = {"mi", "mc", "na", "pc", "fm", "at", "zp", "yc"}
    for index = #markers, 1, -1 do
        local marker = markers[index]
        local start = remainder:find(marker, 1, true)
        if start then
            local scale = 1000 ^ index
            if scale >= previousScale then return nil end
            local prefix = remainder:sub(1, start - 1)
            local group = prefix == "" and 1 or (prefix == "d" and 2 or damageIllions[prefix])
            if not group or group == 0 then return nil end
            total = total + group * scale
            remainder = remainder:sub(start + #marker)
            previousScale = scale
        end
    end

    if total == 0 then return nil end
    local tail = damageIllions[remainder]
    if tail == nil then return nil end
    return (total + tail + 1) * 3
end

local function inventoryDamageKey(text)
    local clean = text:gsub("<[^>]*>", ""):gsub("[,%s]", "")
    local amount, exponent = clean:match("^([%d%.]+)[eE]([%+%-]?%d+)$")
    local power
    if amount then
        power = tonumber(exponent)
        if not power or math.abs(power) == math.huge then return nil end
    else
        local suffix
        amount, suffix = clean:match("^([%d%.]+)(%a*)$")
        if not amount then return nil end
        power = damageSuffixPower(suffix)
        if not power then return nil end
    end
    local whole, fraction = amount:match("^(%d*)%.(%d*)$")
    if not whole then
        if not amount:match("^%d+$") then return nil end
        whole, fraction = amount, ""
    end
    local digits = whole .. fraction
    if digits == "" then return nil end
    local first = digits:find("[1-9]")
    if not first then return {power = -math.huge, digits = ""} end
    power = power + #whole - first
    digits = digits:sub(first):gsub("0+$", "")
    return {power = power, digits = digits}
end

local function inventoryText(label)
    if label and (label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox")) then
        return label.Text:gsub("<[^>]*>", ""):gsub("&nbsp;", " "):gsub("&amp;", "&")
            :gsub("\194\160", " "):gsub("\226\128\139", ""):gsub("%s+", " "):match("^%s*(.-)%s*$")
    end
    return ""
end

local function higherInventoryPriority(a, b)
    if a.damage.power ~= b.damage.power then return a.damage.power > b.damage.power end
    local width = math.max(#a.damage.digits, #b.damage.digits)
    local left = a.damage.digits .. string.rep("0", width - #a.damage.digits)
    local right = b.damage.digits .. string.rep("0", width - #b.damage.digits)
    if left ~= right then return left > right end
    return a.index < b.index
end

local function parseRequiredStackCount(countText)
    if countText == "" then return 1 end
    local compact = countText:lower():gsub("×", "x"):gsub(",", ""):gsub("%s+", "")
    local digits = compact:match("^x(%d+)$") or compact:match("^(%d+)x$") or compact:match("^(%d+)$")
    local count = digits and tonumber(digits)
    if count and count >= 1 and count < math.huge and count % 1 == 0 then return count end
    return nil
end

local function readRequiredHotbarSnapshot()
    local container = playerGui
    for _, name in ipairs({"MineGui", "HotbarFrame", "Content", "Container"}) do
        container = container and container:FindFirstChild(name)
    end
    if not container then return nil, "Hotbar container is not loaded." end
    local summary, signature = {}, {}
    for index = 1, 9 do
        local slot = container:FindFirstChild(tostring(index))
        local item = slot and slot:FindFirstChild("ItemFrame")
        local content = item and item:FindFirstChild("Content")
        local hidden = item and item:IsA("GuiObject") and not item.Visible
        local name = not hidden and inventoryText(content and content:FindFirstChild("ItemName")) or ""
        local count = 0
        if name ~= "" then
            local countLabel = content and content:FindFirstChild("ActualItemCount")
            local countText = inventoryText(countLabel)
            if countText == "" then
                -- The game omits the quantity text for single copies. Only accept this
                -- reading after the whole snapshot has stayed stable below.
                count = 1
            else
                count = parseRequiredStackCount(countText)
                if not count then
                    return nil, string.format("Hotbar slot %d (%s): unreadable quantity %q; waiting for a valid stack count.", index, name, countText)
                end
            end
        end
        summary[index] = {slot = index, name = name, count = count}
        signature[index] = string.format("%d:%q:%d", index, name, count)
    end
    return summary, table.concat(signature, "|")
end

local function readStableRequiredHotbar(operation, expected, retryAction, retryUnreadable)
    local reportRetry = newRetryMonitor(operation)
    local lastSignature, stableSince
    local nextRetry = os.clock() + math.max(CONFIG.General.RetryInterval, UI_SETTLE * 2)
    while true do
        checkAlive()
        local summary, signature = readRequiredHotbarSnapshot()
        local ready, problem = false, signature
        if summary then
            ready = not expected or expected(summary)
            if ready then
                if signature ~= lastSignature then lastSignature, stableSince = signature, os.clock() end
                if os.clock() - stableSince >= UI_SETTLE then reportRetry(nil, true); return summary end
                problem = "Hotbar names/stack counts are still settling."
            else
                lastSignature, stableSince = nil, nil
                problem = "The requested hotbar change has not been confirmed."
            end
        else
            lastSignature, stableSince = nil, nil
        end
        if retryAction and not ready and (summary or retryUnreadable) and os.clock() >= nextRetry then
            local ok, message = pcall(retryAction)
            checkAlive()
            if not ok then problem = tostring(message) end
            nextRetry = os.clock() + math.max(CONFIG.General.RetryInterval, UI_SETTLE * 2)
        end
        reportRetry(problem)
        pause(CONFIG.General.WaitPoll)
    end
end

local function hotbarCopiesOf(summary, name)
    local count = 0
    for _, entry in ipairs(summary) do
        if entry.name == name then count = count + entry.count end
    end
    return count
end

local function saveAndPrintHotbarSummary(operation, verifiedSummary)
    local summary = verifiedSummary or readStableRequiredHotbar(operation or "Reading stable Required Units hotbar quantities")
    local total, occupied, details = 0, 0, {}
    for _, entry in ipairs(summary) do
        total = total + entry.count
        if entry.name ~= "" then
            occupied = occupied + 1
            table.insert(details, string.format("slot %d: %s x%d", entry.slot, entry.name, entry.count))
        end
    end
    _G.MineHotbarSummary, _G.MineHotbarTotalCount = summary, total
    logUnitUpgradeDetail(string.format("Verified hotbar: %d occupied slots, %d unit copies (including stacks). %s",
        occupied, total, #details > 0 and table.concat(details, "; ") or "Hotbar is empty."))
    return summary
end

local function closeRequiredInventory()
    local function close()
        local frame = inventoryFrame()
        frame.Visible = false
    end
    close()
    waitUntil(function() return not visible(inventoryFrame()) end, nil,
        "Closing Required Units inventory", close)
end

local function openRequiredInventory()
    if visible(inventoryFrame()) then return end
    local function open()
        local frame = inventoryFrame()
        if not visible(frame) then frame.Visible = true end
    end
    open()
    waitUntil(function() return visible(inventoryFrame()) end, nil,
        "Opening Required Units inventory", open)
    pause(UI_SETTLE)
end

local function clearRequiredHotbar(event, plot, phase)
    local function clear()
        checkPlot(plot)
        local container = unitInteractionPath(playerGui, {"MineGui", "HotbarFrame", "Content", "Container"})
        -- Clear occupied assignments only; absent/locked hotbar slots need no request.
        -- Quantities need not be readable to remove an existing assignment.
        for index = 1, 9 do
            local slot = container:FindFirstChild(tostring(index))
            local item = slot and slot:FindFirstChild("ItemFrame")
            local content = item and item:FindFirstChild("Content")
            local hidden = item and item:IsA("GuiObject") and not item.Visible
            if not hidden and inventoryText(content and content:FindFirstChild("ItemName")) ~= "" then
                checkAlive()
                event:FireServer("MineAssignHotbar", tostring(index), "")
            end
        end
    end
    setStatus(phase .. ": emptying hotbar...")
    local ok, reason = pcall(clear)
    if not ok then logUnitUpgradeDetail(phase .. ": " .. tostring(reason)) end
    pause(CONFIG.Units.HotbarClearDelay)
    return readStableRequiredHotbar(phase .. ": confirming empty hotbar", function(summary)
        for _, entry in ipairs(summary) do if entry.name ~= "" then return false end end
        return true
    end, clear, true)
end

local function cachedInventoryValue(label, cache, textKey, valueKey, parse)
    -- Text properties are strings; false distinguishes a missing/unsupported label.
    local text = false
    if label and (label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox")) then
        text = label.Text
    end
    -- Cache nil parse results too; missing/malformed text must still fail normally.
    if cache[textKey] == text then return cache[valueKey] end
    local value = inventoryText(label)
    if parse then value = parse(value) end
    cache[textKey], cache[valueKey] = text, value
    return value
end

local function scanRequiredInventory(densityLevel, zoneId, cache)
    local rule = RequiredUnitsByZone[zoneId] or {Names = {}}
    local allowed, rows = {}, {}
    for _, name in ipairs(rule.Names) do allowed[name] = true end
    local scroll = inventoryScroll()
    local children = scroll:GetChildren()
    for _, row in ipairs(children) do
        if row:IsA("GuiObject") then rows[row.Name .. "\0" .. tostring(row.LayoutOrder)] = row end
    end
    -- Only retain rows from this pass, and only for the current stability read.
    local previousRows = cache and cache.rows or {}
    local parsedRows = {}
    if cache then cache.rows = parsedRows end
    local candidates, signature = {}, {}
    local total, skippedNames, skippedDamage = 0, 0, 0
    -- An empty inventory is a valid zero count; it may still pass with displayed units.
    local targets = inventoryTargets(scroll, true, children) or {}
    for index, target in ipairs(targets) do
        checkAlive()
        local row = rows[target.name .. "\0" .. tostring(target.order)]
        if not row then return nil, "Inventory rows changed while counting; waiting for a fresh scan." end
        local parsed = previousRows[row] or {}
        parsedRows[row] = parsed
        local content = row:FindFirstChild("Content")
        local itemName = content and content:FindFirstChild("ItemName")
        local name = cachedInventoryValue(itemName, parsed, "nameText", "name")
        if not allowed[name] then
            skippedNames = skippedNames + 1
        else
            local damage = cachedInventoryValue(content and content:FindFirstChild("Damage"), parsed, "damageText", "damage", inventoryDamageKey)
            if not damage then
                skippedDamage = skippedDamage + 1
            else
                local count = cachedInventoryValue(content and content:FindFirstChild("ActualItemCount"), parsed, "countText", "count", parseRequiredStackCount)
                if not count then return nil, "Unreadable inventory stack count for " .. name .. "; waiting for its quantity." end
                table.insert(candidates, {target = target, row = row, name = name,
                    damage = damage, index = index, count = count, source = "inventory"})
                total = total + count
            end
        end
    end
    table.sort(candidates, higherInventoryPriority)
    for _, entry in ipairs(candidates) do
        table.insert(signature, string.format("%q:%s:%q:%s:%s:%d", entry.target.name,
            tostring(entry.target.order), entry.name, tostring(entry.damage.power), entry.damage.digits, entry.count))
    end
    return {summary = candidates, total = total, skippedNames = skippedNames,
        skippedDamage = skippedDamage}, table.concat(signature, "|")
end

local function readRequiredInventory(densityLevel, zoneId, operation)
    local reportRetry = newRetryMonitor(operation)
    local lastSignature, stableSince
    local cache = {}
    while true do
        checkAlive()
        if not visible(inventoryFrame()) then openRequiredInventory() end
        local result, signature = scanRequiredInventory(densityLevel, zoneId, cache)
        local problem = signature
        if result then
            if signature ~= lastSignature then lastSignature, stableSince = signature, os.clock() end
            if os.clock() - stableSince >= UI_SETTLE then
                logUnitUpgradeDetail(string.format("%s density %d inventory count: %d whitelisted copies across %d stacks; skipped %d other names, %d unreadable Damage values.",
                    zoneId, densityLevel, result.total, #result.summary, result.skippedNames, result.skippedDamage))
                reportRetry(nil, true)
                return result
            end
            problem = "Inventory names, ranking, and stack counts are still settling."
        else
            lastSignature, stableSince = nil, nil
        end
        reportRetry(problem)
        pause(CONFIG.General.WaitPoll)
    end
end

local function selectRequiredStack(candidate)
    local function confirmed(summary)
        if summary[1].name ~= candidate.name or summary[1].count < candidate.count then return false end
        for index = 2, 9 do if summary[index].name ~= "" then return false end end
        return true
    end
    local function activate()
        local summary = readRequiredHotbarSnapshot()
        if not summary then return end
        -- Do not toggle a selection off while its name/quantity is arriving.
        for _, entry in ipairs(summary) do if entry.name ~= "" then return end end
        local match
        for _, row in ipairs(inventoryScroll():GetChildren()) do
            if row:IsA("GuiObject") and row.Name == candidate.target.name and row.LayoutOrder == candidate.target.order then
                if match then error("Inventory target became ambiguous: " .. candidate.target.name, 0) end
                match = row
            end
        end
        if not match then error("Waiting for the selected inventory card " .. candidate.target.name .. " (" .. candidate.name .. ").", 0) end
        local content = match:FindFirstChild("Content")
        local itemName = content and content:FindFirstChild("ItemName")
        local damage = inventoryDamageKey(inventoryText(content and content:FindFirstChild("Damage")))
        if inventoryText(itemName) ~= candidate.name
            or not damage or damage.power ~= candidate.damage.power or damage.digits ~= candidate.damage.digits then
            error("Inventory name/Damage changed before selecting " .. candidate.name .. ".", 0)
        end
        if visible(match) then clickButton(match) end
    end
    setStatus(string.format("Selecting %s x%d for hotbar 1...", candidate.name, candidate.count))
    local ok, reason = pcall(activate)
    if not ok then logUnitUpgradeDetail("Hotbar 1 selection: " .. tostring(reason)) end
    pause(CLICK_DELAY)
    readStableRequiredHotbar("Confirming " .. candidate.name .. " in hotbar 1", confirmed, function()
        local current = readRequiredHotbarSnapshot()
        if current and confirmed(current) then return end
        activate()
    end, true)
    local summary = readStableRequiredHotbar("Reading the confirmed hotbar 1 stack before placement", confirmed)
    saveAndPrintHotbarSummary(nil, summary)
    return summary[1]
end

local function closeUnitFocusForPlacement()
    local mine = playerGui:FindFirstChild("MineGui")
    local focus = mine and mine:FindFirstChild("SlotFocusFrame")
    if not focus or not visible(focus) then return end
    closeUnitInteractionPanel(focus, {"ExitButton"}, CONFIG.Units.PlacementRetryDelay)
end

local function validatePlacementHotbar(entry)
    local container = unitInteractionPath(playerGui, {"MineGui", "HotbarFrame", "Content", "Container"})
    local slot = container:FindFirstChild(tostring(entry.slot))
    local item = slot and slot:FindFirstChild("ItemFrame")
    local content = item and item:FindFirstChild("Content")
    local name = content and content:FindFirstChild("ItemName")
    if not name or not name:IsA("TextLabel") or name.Text:gsub("<[^>]*>", ""):match("^%s*(.-)%s*$") ~= entry.name then
        error("Hotbar slot " .. entry.slot .. " changed before placement; run again to refresh units.", 0)
    end
end

local function placeHotbarUnit(plot, holderName, entry, copy)
    local function alreadyPlaced(attempt)
        if not hasPickUpAction(holderPrompt(plot, holderName, true)) then return false end
        if attempt == 1 then error(holderName .. " became occupied before hotbar selection (Pick Up).", 0) end
        return true
    end
    local attempt = 0
    local reportRetry = newRetryMonitor("Placing " .. entry.name .. " in " .. holderName)
    while true do
        attempt = attempt + 1
        if alreadyPlaced(attempt) then reportRetry(nil, true); return true end
        closeUnitFocusForPlacement()
        local upgrade = unitInteractionPath(plot, {"Holders", holderName, "UpgradePart"})
        local root = originalRoot
        if not upgrade:IsA("BasePart") then error(holderName .. " UpgradePart is not a BasePart.", 0) end
        if not root or not player.Character or not root:IsDescendantOf(player.Character) then
            error("Character changed during placement; run again after respawning.", 0)
        end
        setStatus(string.format("Placing hotbar %d: %s (%d/%d) in %s; attempt %d...",
            entry.slot, entry.name, copy, entry.count, holderName, attempt))
        root.CFrame = CFrame.new(upgrade.Position + Vector3.new(0, CONFIG.Units.TeleportHeight, 0) + unitRetryOffset(attempt), upgrade.Position)
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        pause(TELEPORT_SETTLE)
        if alreadyPlaced(attempt) then reportRetry(nil, true); return true end
        if UserInputService:GetFocusedTextBox() then error("Leave the text field before placing units.", 0) end
        if attempt > 1 then

            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:UnequipTools() end
            pause(EQUIP_SLOT_SETTLE)
            if alreadyPlaced(attempt) then reportRetry(nil, true); return true end
        end
        local valid, reason = pcall(validatePlacementHotbar, entry)
        if not valid then
            if alreadyPlaced(attempt) then reportRetry(nil, true); return true end
            error(reason, 0)
        end
        if alreadyPlaced(attempt) then reportRetry(nil, true); return true end
        heldKey = Enum.KeyCode[HOTBAR_KEYS[entry.slot]]
        VIM:SendKeyEvent(true, heldKey, false, game)
        pause(PLACEMENT_KEY_HOLD)
        VIM:SendKeyEvent(false, heldKey, false, game)
        heldKey = nil
        pause(EQUIP_SLOT_SETTLE)
        local current = holderPrompt(plot, holderName, true)
        if hasPickUpAction(current) then reportRetry(nil, true); return true end
        if current.Parent and current.Enabled then
            setStatus("Activating placement prompt for " .. holderName .. "...")
            heldPrompt = current
            current:InputHoldBegin()
            pause(math.max(current.HoldDuration, CONFIG.Units.PlacementMinimumHold))
            releaseInputs()
            pause(PLACEMENT_SETTLE)
            if hasPickUpAction(holderPrompt(plot, holderName, true)) then reportRetry(nil, true); return true end
        end
        reportRetry()
        pause(CONFIG.Units.PlacementRetryDelay)
    end
end

local function requiredPlacementState(plot, zoneId)
    local required = requiredSlotCount(zoneId)
    local allowed, empty, displayed = {}, {}, {}
    for _, name in ipairs(RequiredUnitsByZone[zoneId].Names) do allowed[name] = true end
    local holders, slots = listSlots(plot, true)
    -- Preserve required-pad checks while also including every extra unlocked empty pad.
    for number = 1, required do holderPrompt(plot, "M" .. number, true) end
    for _, slot in ipairs(slots) do
        local holderName = slot.name
        local prompt = holderPrompt(plot, holderName, true)
        if hasPickUpAction(prompt) then
            local name = waitUntil(function()
                local current = readCharacterName(holders:FindFirstChild(holderName))
                return current and (allowed[current] or slot.number > required) and current
            end, nil, "Waiting for a displayed unit in " .. holderName)
            if allowed[name] then
                table.insert(displayed, {name = name, count = 1, holder = holderName, source = "displayed"})
            end
        elseif prompt.ActionText == "Place" then
            table.insert(empty, holderName)
        elseif slot.number <= required then
            return nil, nil, holderName .. ": waiting for its unlocked placement prompt."
        end
    end
    return empty, displayed
end

local function requiredUnitDensityReason(zoneId, densityLevel)
    local zoneNumber = assert(tonumber(zoneId:match("^Z(%d+)$")), "Invalid cached zone ID.")
    local minimum = zoneNumber >= 12 and 0 or 1
    if densityLevel < minimum then
        return string.format("%s requires Density %d or higher for Required Units; current Density is %d.",
            zoneId, minimum, densityLevel)
    end
end

local function finishEquipping(event, plot, zoneId, densityLevel)
    local required = requiredSlotCount(zoneId)
    local function skipPlacement(reason)
        setStatus("Placement skipped: " .. reason)
        logUnitUpgradeDetail("Required Units skipped serial placement: " .. reason)
        return "Placement skipped: " .. reason .. " Equip Best is handled at cycle end.", false, reason
    end
    if FinalEquipMode == "Best" then return skipPlacement("FinalEquipMode is Best.") end
    local densityReason = requiredUnitDensityReason(zoneId, densityLevel)
    if densityReason then return skipPlacement(densityReason) end
    if required == 0 then return skipPlacement("RequiredUnitCount is zero; no required pads to fill.") end
    local placed, batches = 0, 0
    local function finish(displayed, detail)
        closeRequiredInventory()
        unitCountSnapshot = {zone = zoneId, summary = displayed}
        recordMasterUnitCount(zoneId, #displayed)
        _G.MineHotbarMatchSummary = {zone = zoneId, matchedCount = #displayed,
            displayedMatchedCount = #displayed, RequiredUnitCount = required}
        return string.format("%s: placed %d matching units through hotbar 1 in %d batches; %s",
            zoneId, placed, batches, detail), placed > 0
    end
    while true do
        checkAlive()
        checkPlot(plot)
        local empty, displayed, problem = requiredPlacementState(plot, zoneId)
        if not empty then
            -- Master skips stages 6-8 and returns to Unlock slots for Z4 recovery.
            error(problem or "Required holder placement prompts are unavailable.", 0)
        elseif #empty == 0 then
            return finish(displayed, "all unlocked pads filled.")
        else
            clearRequiredHotbar(event, plot, "Preparing hotbar 1 batch " .. (batches + 1))
            openRequiredInventory()
            local inventory = readRequiredInventory(densityLevel, zoneId, "Counting inventory before the next hotbar 1 batch")
            local combined = {}
            for _, entry in ipairs(inventory.summary) do table.insert(combined, entry) end
            for _, entry in ipairs(displayed) do table.insert(combined, entry) end
            unitCountSnapshot = {zone = zoneId, summary = combined}
            local available = inventory.total + #displayed
            recordMasterUnitCount(zoneId, available)
            _G.MineHotbarMatchSummary = {zone = zoneId, matchedCount = available,
                inventoryMatchedCount = inventory.total, displayedMatchedCount = #displayed, RequiredUnitCount = required}
            if available < required then
                closeRequiredInventory()
                return skipPlacement(string.format("%s: inventory=%d, displayed=%d; matched %d, required %d.",
                    zoneId, inventory.total, #displayed, available, required))
            end
            if inventory.total == 0 then
                return finish(displayed, string.format("%d empty unlocked pads remain; no eligible inventory copies left.", #empty))
            end
            local entry = selectRequiredStack(inventory.summary[1])
            batches = batches + 1
            -- Consume this selected stack on empty pads before fetching another inventory card.
            local copies = math.min(entry.count, #empty)
            for copy = 1, copies do
                placeHotbarUnit(plot, empty[copy], entry, copy)
                placed = placed + 1
            end
            if copies == entry.count and copies < #empty then
                readStableRequiredHotbar("Confirming hotbar 1 is empty before selecting the next whitelisted stack", function(summary)
                    return summary[1].name == ""
                end, function()
                    -- Alternate confirmation checks with removal retries until slot 1 is empty.
                    checkPlot(plot)
                    event:FireServer("MineAssignHotbar", "1", "")
                end, true)
            end
            logUnitUpgradeDetail(string.format("%s hotbar 1 batch %d: %s; placed %d copies; %d empty unlocked pads remain.",
                zoneId, batches, entry.name, copies, #empty - copies))
        end
    end
end

local function combinedRequiredAvailability(plot, zoneId, inventorySummary)
    checkPlot(plot)
    local rule = RequiredUnitsByZone[zoneId] or {RequiredUnitCount = 0, Names = {}}
    local allowed, combined = {}, {}
    for _, name in ipairs(rule.Names or {}) do allowed[name] = true end
    local inventoryMatched, displayedMatched = 0, 0
    for _, entry in ipairs(inventorySummary) do
        table.insert(combined, entry)
        if allowed[entry.name] then inventoryMatched = inventoryMatched + entry.count end
    end
    local holders, slots = listSlots(plot)
    for _, slot in ipairs(slots) do
        if hasPickUpAction(holderPrompt(plot, slot.name)) then
            local name, reason = readCharacterName(holders:FindFirstChild(slot.name))
            if not name then error(slot.name .. ": " .. reason .. " Displayed units left in place.", 0) end
            if allowed[name] then
                displayedMatched = displayedMatched + 1
                table.insert(combined, {name = name, count = 1, holder = slot.name, source = "displayed"})
            end
        end
    end
    local total = inventoryMatched + displayedMatched
    recordMasterUnitCount(zoneId, total)
    if modules.mutation and modules.mutation.observeProgress then modules.mutation.observeProgress(zoneId, plot) end
    unitCountSnapshot = {zone = zoneId, summary = combined}
    _G.MineHotbarMatchSummary = {zone = zoneId, matchedCount = total,
        inventoryMatchedCount = inventoryMatched, displayedMatchedCount = displayedMatched,
        RequiredUnitCount = rule.RequiredUnitCount}
    logInfo("Required Units", string.format("%s availability: displayed=%d; inventory=%d; combined=%d/%d.",
        zoneId, displayedMatched, inventoryMatched, total, rule.RequiredUnitCount))
    local ready, reason = RequiredUnitCountMet(zoneId)
    if not ready then return false, reason end
    if total == 0 then return false, zoneId .. ": no matching displayed or inventory units." end
    return true
end

local function runRequiredUnits()
    unitCountSnapshot, cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone = nil, nil, nil
    _G.MineHotbarSummary, _G.MineHotbarTotalCount, _G.MineHotbarMatchSummary = nil, nil, nil
    local reason = unitSequenceCooldownReason()
    if reason then
        setStatus("Skipped: " .. reason)
        refreshUnitCooldown()
        return "Skipped: " .. reason .. " Match-checking sequence skipped; Equip Best is handled at cycle end."
    end
    if type(firesignal) ~= "function" then
        error("This environment needs firesignal, as used by upgrade.luau.", 0)
    end
    if FinalEquipMode ~= "RequiredUnits" and FinalEquipMode ~= "Best" then
        error('FinalEquipMode must be "RequiredUnits" or "Best".', 0)
    end
    setStatus("Using cached cycle zone...")
    local zoneId = getCycleZone()
    local event = getGameEvent()
    if not event:IsA("RemoteEvent") then error("GamestateEvent is not a RemoteEvent.", 0) end
    setStatus("Finding your plot...")
    local plot = getMyPlot()
    local densityLevel = modules.upgrades.getDensity()

    beginUnitSequence(zoneId)
    clearRequiredHotbar(event, plot, "Availability check")
    openRequiredInventory()
    local inventory = readRequiredInventory(densityLevel, zoneId, "Counting whitelisted inventory copies for RequiredUnitCount")
    closeRequiredInventory()
    local available, availabilityReason = combinedRequiredAvailability(plot, zoneId, inventory.summary)
    local densityReason = requiredUnitDensityReason(zoneId, densityLevel)
    if not available or FinalEquipMode == "Best" or densityReason then
        local reason = availabilityReason or (FinalEquipMode == "Best" and "FinalEquipMode is Best.") or densityReason
        return "Skipped: " .. reason .. " Displayed units kept in place; Mutate Units skipped."
    end

    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then error("Your character is not ready. Displayed units left in place.", 0) end
    originalRoot, originalCFrame = root, root.CFrame
    local removed = emptyDisplayUnits(plot, "Required count met")

    local finalResult, placedRequiredUnits, selectionReason = finishEquipping(event, plot, zoneId, densityLevel)
    if modules.mutation and modules.mutation.observeProgress then modules.mutation.observeProgress(zoneId, plot) end
    local ready, reason = RequiredUnitCountMet(zoneId)
    if ready and placedRequiredUnits then
        cycleUnitsPreparedZone = zoneId
        logUnitUpgradeDetail("Required Units preparation completed for " .. zoneId
            .. "; required count passed and required units placed. Mutate Units may proceed.")
    else
        logUnitUpgradeDetail(string.format("Required Units preparation failed for %s: RequiredUnitCountMet=%s, placedRequiredUnits=%s; %s",
            zoneId, tostring(ready), tostring(placedRequiredUnits), reason or "required-unit placement did not complete."))
        local followUp = " Mutate Units skipped: "
            .. (selectionReason or reason or "required-unit placement did not complete.")
        finalResult = finalResult .. followUp
    end

    return string.format("Removed %d units. %s", removed, finalResult)
end

modules.units = {run = runRequiredUnits}
end)()
end

do
local status = stageStatus("mutation")
local ownsFocus = false
local ranks, names = {}, CONFIG.Mutation.Priority
for rank, name in ipairs(names) do ranks[name:lower()] = rank end
local diamond = assert(ranks.diamond, "CONFIG.Mutation.Priority needs Diamond.")
local function normalize(text)
    local clean = (text or ""):gsub("<[^>]*>", ""):match("^%s*(.-)%s*$"):lower()
    if clean == "" or clean == "none" or clean == "normal" or clean == "no mutation"
        or clean == "without mutation" or clean == "unmutated" or clean == "default" then
        clean = "none"
    end
    local rank = ranks[clean]
    if not rank then return nil, "Unrecognized mutation: " .. tostring(text) end
    return rank
end
local function focusFrame()
    local mine = playerGui:FindFirstChild("MineGui")
    return mine and mine:FindFirstChild("SlotFocusFrame")
end
local function mutationPanel()
    local focus = focusFrame()
    local bottom = focus and focus:FindFirstChild("BottomPanels")
    local panel = bottom and bottom:FindFirstChild("MutationPanel")
    return visible(panel) and panel or nil
end
local function closeFocus()
    closeUnitPanel("Closing mutation/unit panel through SlotFocusFrame.Visible")
    ownsFocus = false
end
local function cleanupFocus()
    if not ownsFocus then return end
    local focus = focusFrame()
    if focus and focus.Visible then pcall(hideUnitPanel, focus) end
    ownsFocus = false
end
local function scanNow(plot, RequiredUnitCount)
    checkPlot(plot)
    local holders = plot:FindFirstChild("Holders")
    if not holders then return nil, "Your plot's Holders folder is missing." end
    local selected
    if RequiredUnitCount ~= nil then
        local _, selectedNames, reason = requiredHolderTargets(plot, RequiredUnitCount)
        if reason then return nil, reason end
        selected = selectedNames
    end
    local slots, seenHolders = {}, 0
    for _, holder in ipairs(holders:GetChildren()) do
        local number = tonumber(holder.Name:match("^M(%d+)$"))
        if number and number >= 1 and (not selected or selected[holder.Name]) then
            seenHolders = seenHolders + 1
            local pad = holder:FindFirstChild("Pad")
            local info = pad and pad:FindFirstChild("CrewInfo")
            local bg = info and info:FindFirstChild("BG")
            local variant = bg and bg:FindFirstChild("Variant")
            local upgrade = holder:FindFirstChild("UpgradePart")
            local detector = upgrade and upgrade:FindFirstChild("UpgradeClick")
            local prompt = pad and pad:FindFirstChild("HolderPrompt")
            local occupied
            if detector and detector:IsA("ClickDetector") then
                occupied = detector.MaxActivationDistance > 0
            elseif prompt and prompt:IsA("ProximityPrompt") then
                occupied = prompt.ActionText:match("^%s*(.-)%s*$"):lower() == "pick up"
            else
                occupied = variant ~= nil
            end
            if occupied then
                if not bg then return nil, holder.Name .. ": CrewInfo.BG is not loaded." end
                local text = ""
                if variant then
                    if not (variant:IsA("TextLabel") or variant:IsA("TextButton") or variant:IsA("TextBox")) then
                        return nil, holder.Name .. ": Variant is not a text label."
                    end
                    text = variant.Text
                end
                local rank, reason = normalize(text)
                if not rank then return nil, holder.Name .. ": " .. reason end
                table.insert(slots, {holder = holder, number = number, rank = rank,
                    mutation = names[rank], pad = pad, detector = detector})
            end
        end
    end
    if seenHolders == 0 then return nil, "No M1, M2, ... holders found in your plot." end
    table.sort(slots, function(a, b) return a.number < b.number end)
    local signature = {}
    for _, slot in ipairs(slots) do table.insert(signature, slot.holder.Name .. ":" .. slot.rank) end
    return slots, table.concat(signature, "|")
end
local function scanStable(plot, RequiredUnitCount)
    local signature, stableSince, problem = nil, os.clock(), "Holder data is still changing."
    local reportRetry = newRetryMonitor("Scanning displayed mutation data")
    while true do
        checkAlive()
        local slots, current = scanNow(plot, RequiredUnitCount)
        if not slots then
            problem = current
            signature, stableSince = nil, os.clock()
        else
            if signature ~= current then signature, stableSince = current, os.clock() end
            if os.clock() - stableSince >= CONFIG.Mutation.RescanSettleTime then reportRetry(nil, true); return slots end
            problem = "Holder data is still changing."
        end
        reportRetry(problem)
        pause(CONFIG.General.WaitPoll)
    end
end
local function scanRequiredMutations(plot, RequiredUnitCount)
    local slots = scanStable(plot, RequiredUnitCount)
    local targets, _, reason = requiredHolderTargets(plot, RequiredUnitCount)
    if reason then error(reason .. " No mutation roll sent.", 0) end
    local byName, required, missing = {}, {}, {}
    for _, slot in ipairs(slots) do byName[slot.holder.Name] = slot end
    for _, target in ipairs(targets) do
        if byName[target.name] then table.insert(required, byName[target.name])
        else table.insert(missing, target.name) end
    end
    if #missing > 0 then
        error("Required holders have no displayed unit: " .. table.concat(missing, ", ") .. ". No mutation roll sent.", 0)
    end
    return required
end
local function lowest(slots)
    local choice
    for _, slot in ipairs(slots) do
        if not choice or slot.rank < choice.rank or (slot.rank == choice.rank and slot.number < choice.number) then
            choice = slot
        end
    end
    return choice
end
local function readMutationRequirements(zoneId)
    local zone = CONFIG.Units.RequiredByZone[zoneId] or {}
    local rule = zone.RequiredMutations or {}
    local RequiredUnitCount = requiredSlotCount(zoneId)
    local quotaTotal = 0
    for _, tier in ipairs(names) do
        local count = rule[tier]
        if count == nil then count = 0 end
        if type(count) ~= "number" or count ~= count or count < 0 or count % 1 ~= 0 or count == math.huge then
            error(zoneId .. ": RequiredMutations counts must be finite nonnegative whole numbers.", 0)
        end
        quotaTotal = quotaTotal + count
    end
    if quotaTotal > RequiredUnitCount then
        error(string.format("%s: mutation quotas total %d but RequiredUnitCount is %d. Adjust this zone's quotas; extra slots will not be mutated.",
            zoneId, quotaTotal, RequiredUnitCount), 0)
    end
    return rule, RequiredUnitCount
end
local function requiredMutationCount(rule, RequiredUnitCount)
    if not hasMutationRequirements(rule) then return 0 end
    return RequiredUnitCount
end
local function requirementsMet(slots, rule, RequiredUnitCount)
    if not hasMutationRequirements(rule) then return true end
    local required, _, reason = splitUnitSlots(slots, RequiredUnitCount)
    if reason then return false end
    slots = required
    local diamondCount = 0
    for _, slot in ipairs(slots) do if slot.rank >= diamond then diamondCount = diamondCount + 1 end end
    if diamondCount < requiredMutationCount(rule, RequiredUnitCount) then return false end

    local reserved = 0
    for rank = #names, diamond + 1, -1 do
        reserved = reserved + (rule[names[rank]] or 0)
        local count = 0
        for _, slot in ipairs(slots) do if slot.rank >= rank then count = count + 1 end end
        if count < reserved then return false end
    end
    return true
end
local function mutationChoice(slots, rule, RequiredUnitCount)
    if not hasMutationRequirements(rule) then return nil end
    local required, _, reason = splitUnitSlots(slots, RequiredUnitCount)
    if reason then return nil end
    return lowest(required)
end
local function openSlot(slot, plot)
    checkPlot(plot)
    closeFocus()
    if type(fireclickdetector) ~= "function" then error("Mutate Units needs fireclickdetector, as used by mutation.luau.", 0) end
    if not slot.pad or not slot.pad:IsA("BasePart") then error(slot.holder.Name .. " Pad is missing.", 0) end
    if not slot.detector or not slot.detector:IsA("ClickDetector") then error(slot.holder.Name .. " UpgradeClick is missing.", 0) end
    local root = originalRoot
    if not root or not player.Character or not root:IsDescendantOf(player.Character) then
        error("Character changed during mutations; run again after respawning.", 0)
    end
    root.CFrame = CFrame.new(slot.pad.Position + Vector3.new(0, CONFIG.Mutation.TeleportHeight, 0), slot.pad.Position)
    root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
    pause(CONFIG.Mutation.TeleportDelay)
    checkPlot(plot)
    ownsFocus = true
    fireclickdetector(slot.detector)
    pause(CONFIG.Mutation.AfterUpgradeClickDelay)
    waitUntil(function() return visible(focusFrame()) end,
        CONFIG.Units.ActionTimeout, slot.holder.Name .. ": waiting for unit panel to open.", function() checkPlot(plot); fireclickdetector(slot.detector) end)
    pause(CONFIG.Mutation.PanelSettleTime)
    if not mutationPanel() then
        local clicked, mutationTabButton = false, nil
        for _, object in ipairs(focusFrame():GetDescendants()) do
            if object:IsA("GuiButton") and visible(object) then
                local text = object:IsA("TextButton") and object.Text or ""
                if (object.Name .. " " .. text):lower():find("mutation", 1, true) then
                    mutationTabButton = object
                    clickButton(object); clicked = true; break
                end
            end
        end
        if not clicked then error("Could not find the Mutation tab in the unit panel.", 0) end
        waitUntil(mutationPanel, CONFIG.Units.ActionTimeout, "Waiting for Mutation tab to open.", function() clickButton(mutationTabButton) end)
        pause(CONFIG.Mutation.PanelSettleTime)
    end
end
local function canRoll(button)
    local content = path(button, {"Content"})
    if not content:IsA("GuiObject") then error("RollButton.Content is not a GuiObject.", 0) end
    local c = content.BackgroundColor3
    local r, g, b = math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5)
    return (r == 38 and g == 148 and b == 84) or (r == 249 and g == 90 and b == 16)
end
local function readFocusedRank()
    local panel = mutationPanel()
    if not panel then error("Mutation panel closed during rapid rolling.", 0) end
    local side = panel:FindFirstChild("Side")
    local current = side and side:FindFirstChild("Current")
    local word = current and current:FindFirstChild("Word")
    if not word or not (word:IsA("TextLabel") or word:IsA("TextButton") or word:IsA("TextBox")) then
        error("Current mutation Word is not readable; stopped before another roll.", 0)
    end
    local text = word.Text:gsub("<[^>]*>", ""):match("^%s*(.-)%s*$")
    if text == "" then error("Current mutation is blank; stopped before another roll.", 0) end
    local rank, reason = normalize(text)
    if not rank then error(reason, 0) end
    return rank
end
local function readStableFocusedMutation(slot, plot, operation)
    local reportRetry = newRetryMonitor(operation)
    local lastRank, stableSince
    while true do
        checkAlive()
        checkPlot(plot)
        if not slot.holder:IsDescendantOf(plot) then
            error(slot.holder.Name .. ": holder was removed while verifying its current mutation.", 0)
        end
        if not mutationPanel() then
            openSlot(slot, plot)
            lastRank, stableSince = nil, nil
        end
        local ok, current = pcall(readFocusedRank)
        if ok then
            if current ~= lastRank then lastRank, stableSince = current, os.clock() end
            if os.clock() - stableSince >= math.max(CONFIG.Mutation.RescanSettleTime, CONFIG.Mutation.PanelSettleTime) then
                reportRetry(nil, true)
                return current
            end
            reportRetry("Current panel mutation: " .. names[current] .. "; waiting for a stable reading.")
        else
            lastRank, stableSince = nil, nil
            reportRetry("Cannot read the current mutation panel: " .. tostring(current))
        end
        pause(CONFIG.General.WaitPoll)
    end
end

local function reconcileMutationObservation(slot, observed, plot)
    if slot.rank >= observed.rank then return end
    local displayedRank = slot.rank
    openSlot(slot, plot)
    local current = readStableFocusedMutation(slot, plot,
        string.format("%s: verifying current mutation in the reopened panel (saved=%s, displayed=%s)",
            slot.holder.Name, names[observed.rank], names[displayedRank]))
    -- The current panel can be lower too if another queued roll finished after the saved result.
    -- Use its verified value instead of waiting for an obsolete exact-match label.
    slot.rank, slot.mutation = current, names[current]
    logUnitUpgradeDetail(string.format("%s: refreshed current mutation from its unit panel: saved=%s, displayed=%s, current=%s.",
        slot.holder.Name, names[observed.rank], names[displayedRank], names[current]))
    closeFocus()
end

local function focusTarget(slots, rule)
    local cumulative = 0
    for rank = #names, diamond + 1, -1 do
        cumulative = cumulative + (rule[names[rank]] or 0)
        local count = 0
        for _, slot in ipairs(slots) do if slot.rank >= rank then count = count + 1 end end
        if count < cumulative then return rank end
    end
    return diamond
end
local function report(slots, heading)
    local mutations = {}
    for _, slot in ipairs(slots) do
        table.insert(mutations, slot.holder.Name .. "=" .. slot.mutation)
    end
    logInfo("Mutate Units", heading .. " [" .. table.concat(mutations, ", ") .. "]")
end
local function recordMasterMutations(zoneId, slots)
    local rule = CONFIG.Units.RequiredByZone[zoneId] or {}
    local settings = rule.RequiredMutations or {}
    local required = rule.RequiredUnitCount or 0
    local requiredSlots = splitUnitSlots(slots, required)
    local allowed, selected = {}, {}
    for _, name in ipairs(rule.Names or {}) do allowed[name] = true end

    for _, slot in ipairs(requiredSlots) do
        local name = readCharacterName(slot.holder)
        if name and allowed[name] then table.insert(selected, slot) end
    end
    local counts, used = {Diamond = 0}, {}
    local quotaTotal = 0

    for rank = #names, diamond + 1, -1 do
        local goal = settings[names[rank]] or 0
        quotaTotal = quotaTotal + goal
        local current = 0
        for index, slot in ipairs(selected) do
            if current < goal and not used[index] and slot.rank >= rank then
                current = current + 1
                used[index] = true
            end
        end
        counts[names[rank]] = current
    end
    local progress = masterRequirementProgress[zoneId] or {}
    masterRequirementProgress[zoneId] = progress
    progress.mutations = counts

    local diamondGoal = math.max(0, required - quotaTotal)
    for index, slot in ipairs(selected) do

        if not used[index] and slot.rank >= diamond and counts.Diamond < diamondGoal then
            counts.Diamond = counts.Diamond + 1
        end
    end
    refreshMasterRequirements()
end

local function upgradeTargets(zoneId, displayed)
    local requiredCount = requiredSlotCount(zoneId)
    if requiredCount == 0 then return nil, nil, "RequiredUnitCount is zero." end
    local zone = CONFIG.Units.RequiredByZone[zoneId] or {}
    local rule = readMutationRequirements(zoneId)
    local allowed, byHolder = {}, {}
    for _, name in ipairs(zone.Names or {}) do allowed[name] = true end
    for _, slot in ipairs(displayed) do byHolder[slot.holder.Name] = slot end
    local core, selected = {}, {}
    for number = 1, requiredCount do
        local holderName = "M" .. tostring(number)
        local slot = byHolder[holderName]
        if not slot then return nil, nil, holderName .. ": no displayed required unit." end
        local name = readCharacterName(slot.holder)
        if not name or not allowed[name] then
            return nil, nil, holderName .. ": required unit is not whitelisted for " .. zoneId .. "."
        end
        local pad = slot.holder:FindFirstChild("Pad")
        local info = pad and pad:FindFirstChild("CrewInfo")
        local bg = info and info:FindFirstChild("BG")
        local variant = bg and bg:FindFirstChild("Variant")
        if not variant or not (variant:IsA("TextLabel") or variant:IsA("TextButton") or variant:IsA("TextBox")) then
            return nil, nil, holderName .. ": mutation label is missing or unreadable."
        end
        local rank, reason = normalize(variant.Text)
        if not rank then return nil, nil, holderName .. ": " .. reason end
        if rank < diamond then return nil, nil, holderName .. ": required unit must be Diamond or higher." end
        slot.expectedName, slot.rank = name, rank
        table.insert(core, slot)
        selected[holderName] = true
    end
    if not requirementsMet(core, rule, requiredCount) then
        return nil, nil, "Required slots do not meet configured RequiredMutations quotas."
    end
    return core, selected
end
local function densityReady(zoneId)
    local requiredCount = requiredSlotCount(zoneId)
    if requiredCount == 0 then
        readMutationRequirements(zoneId)
        return true
    end
    local plot = getMyPlot()
    checkPlot(plot)
    local holders = plot:FindFirstChild("Holders")
    if not holders then return false, "Your plot's Holders folder is missing." end
    local displayed = {}
    for number = 1, requiredCount do
        local holderName = "M" .. tostring(number)
        local holder = holders:FindFirstChild(holderName)
        local pad = holder and holder:FindFirstChild("Pad")
        local upgrade = holder and holder:FindFirstChild("UpgradePart")
        local detector = upgrade and upgrade:FindFirstChild("UpgradeClick")
        local prompt = pad and pad:FindFirstChild("HolderPrompt")
        local occupied = (detector and detector:IsA("ClickDetector") and detector.MaxActivationDistance > 0)
            or (prompt and prompt:IsA("ProximityPrompt")
                and prompt.ActionText:match("^%s*(.-)%s*$"):lower() == "pick up")
        if not occupied then return false, holderName .. ": no displayed required unit." end
        table.insert(displayed, {holder = holder, number = number})
    end

    local core, _, reason = upgradeTargets(zoneId, displayed)
    return core ~= nil, reason
end
local function selectHotbarMutationTab(slot, plot, checkTarget)
    checkPlot(plot)
    checkTarget(slot, true)
    if mutationPanel() then return end
    local focus = focusFrame()
    local button
    -- Use the same button name/text lookup as the regular Mutation opener.
    for _, object in ipairs(focus:GetDescendants()) do
        if object:IsA("GuiButton") and visible(object) then
            local text = object:IsA("TextButton") and object.Text or ""
            if (object.Name .. " " .. text):lower():find("mutation", 1, true) then
                button = object
                break
            end
        end
    end
    assert(button, "Could not find the Mutation tab in the current unit panel.")
    clickButton(button)
    waitUntil(function()
        checkTarget(slot, true)
        return mutationPanel()
    end, nil, "Waiting for the current unit Mutation tab to open.", function()
        checkTarget(slot, true)
        clickButton(button)
    end)
    pause(CONFIG.Mutation.PanelSettleTime)
end
local function verifyHotbarUnitUnreal(slot, plot, checkTarget, alreadyOnMutation)
    if not alreadyOnMutation then selectHotbarMutationTab(slot, plot, checkTarget) end
    checkAlive()
    checkPlot(plot)
    checkTarget(slot, true)
    local current = readFocusedRank()
    slot.rank, slot.mutation = current, names[current]
    -- Same focused-panel rank check as the regular Mutation stage; no extra confirmation loop.
    return current >= assert(ranks.unreal, "CONFIG.Mutation.Priority needs Unreal.")
end
local function mutateHotbarUnitToUnreal(slot, plot, checkTarget, report, keepOpen, reusePanel)
    local unreal = assert(ranks.unreal, "CONFIG.Mutation.Priority needs Unreal.")
    checkTarget(slot, false)
    slot.pad = path(slot.holder, {"Pad"})
    slot.detector = path(slot.holder, {"UpgradePart", "UpgradeClick"})
    if reusePanel and visible(focusFrame()) then
        selectHotbarMutationTab(slot, plot, checkTarget)
    else
        openSlot(slot, plot)
    end
    local rolls = 0
    -- Match the regular Mutation stage: read before and after each rapid roll, stopping at Unreal.
    -- There is no elapsed-time or roll-count limit.
    while true do
        checkAlive()
        checkTarget(slot, true)
        local current = readFocusedRank()
        slot.rank, slot.mutation = current, names[current]
        if current >= unreal then break end
        -- A color mismatch can be a UI transition, not proof of red/no money.
        -- Wait without a deadline and recheck Unreal before sending another roll.
        current = waitUntil(function()
            checkTarget(slot, true)
            local rank = readFocusedRank()
            if rank >= unreal then return rank end
            local panel = assert(mutationPanel(), "Mutation panel is unavailable.")
            if canRoll(path(panel, {"Side", "RollButton"})) then return rank end
            report((slot.hotbarName or slot.expectedName) .. ": waiting for the mutation Roll button to become ready...")
        end, math.huge, "M1: waiting for mutation Roll button readiness.")
        slot.rank, slot.mutation = current, names[current]
        if current >= unreal then break end
        report(string.format("%s: mutating to Unreal. Roll: %d", slot.hotbarName or slot.expectedName, rolls + 1))
        checkTarget(slot, true)
        checkAlive()
        getGameEvent():FireServer("MineRollMutation", slot.holder.Name)
        rolls = rolls + 1
        pause(CONFIG.Mutation.RapidRollSettleTime)
        current = readFocusedRank()
        slot.rank, slot.mutation = current, names[current]
        if current >= unreal then break end
        pause(CONFIG.Mutation.RapidRollDelay)
    end
    if not keepOpen then closeFocus() end
end
modules.mutation = {cleanup = cleanupFocus, mutateHotbarUnitToUnreal = mutateHotbarUnitToUnreal, verifyHotbarUnitUnreal = verifyHotbarUnitUnreal, upgradeTargets = upgradeTargets, densityReady = densityReady, observeProgress = function(zoneId, plot)

    return pcall(function()
        local slots = scanNow(plot, requiredSlotCount(zoneId))
        if slots then recordMasterMutations(zoneId, slots) end
    end)
end, run = function()
    local zoneId = getCycleZone()
    if mutationStoppedByDensityII(zoneId) then
        return "Skipped: Cached cycle density is 2+ for " .. zoneId .. "; mutation is stopped for this zone."
    end
    local rule, RequiredUnitCount = readMutationRequirements(zoneId)
    if not hasMutationRequirements(rule) then
        return "Skipped: all RequiredMutations tier counts are zero; no mutation rolling required."
    end
    if requiredMutationCount(rule, RequiredUnitCount) == 0 then
        return "Skipped: RequiredUnitCount and mutation quotas are zero; no mutations required."
    end
    local prepared, preparationReason = unitsPreparedThisCycle(zoneId)
    if not prepared then return "Skipped: " .. preparationReason end
    local countReady, countReason = RequiredUnitCountMet(zoneId)
    if not countReady then return "Skipped: " .. countReason end
    local hasHighRequirement = false
    for rank = diamond + 1, #names do
        local count = rule[names[rank]] or 0
        if count > 0 and (names[rank] == "Inferno" or names[rank] == "Nightmare" or names[rank] == "Unreal") then
            hasHighRequirement = true
        end
    end
    local plot = getMyPlot()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then error("Character is not ready for mutations.", 0) end
    originalRoot, originalCFrame = root, root.CFrame
    local slots = scanRequiredMutations(plot, RequiredUnitCount)
    if #slots == 0 then return "No displayed units to mutate." end
    recordMasterMutations(zoneId, slots)
    local needed = requiredMutationCount(rule, RequiredUnitCount)
    if needed > #slots then
        error(string.format("%s: mutation requirements need %d displayed units, but only %d are displayed. No roll sent.",
            zoneId, needed, #slots), 0)
    end
    local tierGoals = {}
    for _, tier in ipairs(names) do
        local count = rule[tier] or 0
        if count > 0 then table.insert(tierGoals, tier .. "=" .. count) end
    end
    report(slots, string.format("Starting mutations for %s on %s: first %d unlocked slots need Diamond or higher. Required tier counts: %s. Extra slots are excluded.",
        zoneId, plot.Name, needed, table.concat(tierGoals, ", ")))
    local rolls, lastRollingHolder = 0, nil
    local observedRanks = {}
    local function sendRoll(choice)
        checkPlot(plot)
        if densityIIZones[zoneId] then error("Density II stopped mutation for " .. zoneId .. ". No new roll sent.", 0) end
        local _, selected, scopeReason = requiredHolderTargets(plot, RequiredUnitCount)
        if scopeReason or not selected[choice.holder.Name] then
            error(scopeReason or "Refusing to mutate a holder outside the first required slots.", 0)
        end
        if not choice.holder:IsDescendantOf(plot) then error("Selected holder was removed. No roll sent.", 0) end
        status.Text = "Rolling " .. choice.holder.Name
        checkAlive()
        getGameEvent():FireServer("MineRollMutation", choice.holder.Name)
        if lastRollingHolder ~= choice.holder.Name then
            logUnitUpgradeDetail("Rolling " .. choice.holder.Name)
            lastRollingHolder = choice.holder.Name
        end
        rolls = rolls + 1
    end
    while alive do
        checkPlot(plot)
        if densityIIZones[zoneId] then return "Skipped: Confirmed Density II stopped mutation for " .. zoneId .. "." end
        slots = scanRequiredMutations(plot, RequiredUnitCount)
        if #slots == 0 then return "No displayed units remain. Rolls: " .. rolls end

        for _, entry in ipairs(slots) do
            local observed = observedRanks[entry.holder]
            if observed then
                reconcileMutationObservation(entry, observed, plot)
                observedRanks[entry.holder] = nil
            end
        end
        recordMasterMutations(zoneId, slots)
        if requirementsMet(slots, rule, RequiredUnitCount) then
            local minimum = requiredMutationCount(rule, RequiredUnitCount)
            status.Text = zoneId .. ": mutation quota reached."
            return string.format("%s: mutation requirements met (%d Diamond-or-higher units required). Rolls: %d.", zoneId, minimum, rolls)
        end
        local neededNow = requiredMutationCount(rule, RequiredUnitCount)
        if neededNow > #slots then
            error(string.format("%s: only %d displayed units remain; mutation requirements need %d. No new roll sent.",
                zoneId, #slots, neededNow), 0)
        end
        local choice = assert(mutationChoice(slots, rule, RequiredUnitCount), "No mutation candidate is available.")
        local target = hasHighRequirement and focusTarget(slots, rule) or nil
        status.Text = string.format("%s: opening %s (%s). Rolls: %d", zoneId, choice.holder.Name, choice.mutation, rolls)
        openSlot(choice, plot)
        local panel = assert(mutationPanel(), "Mutation panel is unavailable.")
        local button = path(panel, {"Side", "RollButton"})

        if not canRoll(button) then
            closeFocus()
            report(slots, "Roll button is neither green nor orange; no more money for a roll.")
            return string.format("%s: no funds for another roll. Rolls: %d.", zoneId, rolls)
        end
        if hasHighRequirement then

            while alive do
                local current = readFocusedRank()
                choice.rank, choice.mutation = current, names[current]
                observedRanks[choice.holder] = {rank = current}
                recordMasterMutations(zoneId, slots)
                if current >= target then break end
                local activePanel = assert(mutationPanel(), "Mutation panel is unavailable.")
                if not canRoll(path(activePanel, {"Side", "RollButton"})) then
                    closeFocus()
                    return string.format("%s: no funds for another roll. Rolls: %d.", zoneId, rolls)
                end
                sendRoll(choice)
                pause(CONFIG.Mutation.RapidRollSettleTime)
                current = readFocusedRank()
                choice.rank, choice.mutation = current, names[current]
                observedRanks[choice.holder] = {rank = current}
                recordMasterMutations(zoneId, slots)
                if current >= target then break end
                pause(CONFIG.Mutation.RapidRollDelay)
            end
            closeFocus()
        else
            sendRoll(choice)

            pause(CONFIG.Mutation.RollSettleTime)
            local current = readStableFocusedMutation(choice, plot, choice.holder.Name .. ": confirming the mutation after rolling")
            choice.rank, choice.mutation = current, names[current]
            observedRanks[choice.holder] = {rank = current}
            pause(CONFIG.Mutation.BeforeExitDelay)
            closeFocus()
            pause(CONFIG.Mutation.RollDelay)
        end
    end
end}
end

do
local status = stageStatus("upgradingUnit")
local function isDisplayed(holder)
    local pad = holder:FindFirstChild("Pad")
    local upgrade = holder:FindFirstChild("UpgradePart")
    local detector = upgrade and upgrade:FindFirstChild("UpgradeClick")
    local prompt = pad and pad:FindFirstChild("HolderPrompt")
    if prompt and prompt:IsA("ProximityPrompt") then

        local action = prompt.ActionText:match("^%s*(.-)%s*$"):lower()
        if action == "pick up" then return true end
        if action == "place" then return false end
    end
    if detector and detector:IsA("ClickDetector") then
        return detector.MaxActivationDistance > 0
    end
    return false
end
local function readLevel(holder)
    local pad = holder:FindFirstChild("Pad")
    local holderLabel = pad and pad:FindFirstChild("HolderLabel")
    local bg = holderLabel and holderLabel:FindFirstChild("BG")
    local level = bg and bg:FindFirstChild("Level")
    if not level or not (level:IsA("TextLabel") or level:IsA("TextButton") or level:IsA("TextBox")) then
        error(holder.Name .. ": Pad.HolderLabel.BG.Level is missing or unreadable.", 0)
    end
    local text = level.Text:gsub("<[^>]*>", "")
    local value = tonumber(text:match("^%s*Level%s+(%d+)%s*$"))
    if not value or value < 1 then error(holder.Name .. ": invalid damage level: " .. text, 0) end
    return value
end
local function unitLevelCap(zoneId)
    local rule = CONFIG.Units.RequiredByZone[zoneId]
    local cap = rule and rule.MaxLevelCap
    if type(cap) ~= "number" or cap ~= cap or cap < 1 or cap % 1 ~= 0 or cap == math.huge then
        error(zoneId .. ": MaxLevelCap must be a finite positive whole number.", 0)
    end
    return cap
end
local function waitForDisplayedUnit(plot, holders, slot)
    local stableName, stableSince, observedName
    local ok, result = pcall(waitUntil, function()
        checkPlot(plot)
        if slot.holder.Parent ~= holders or not holders:IsDescendantOf(plot) then
            error(slot.holder.Name .. ": holder was removed or moved; stopped upgrading.", 0)
        end
        local currentName = readCharacterName(slot.holder)
        observedName = currentName
        local matches = currentName and (slot.matchesName and slot.matchesName(currentName, slot.expectedName)
            or not slot.matchesName and (not slot.expectedName or currentName == slot.expectedName))
        if not matches then
            stableName, stableSince = nil, nil
            if currentName and slot.expectedName and not slot.identitySettleTime then
                error(slot.holder.Name .. ": displayed unit name changed; stopped before another upgrade request.", 0)
            end
            return nil
        end
        if not isDisplayed(slot.holder) then stableName, stableSince = nil, nil; return nil end
        if slot.identitySettleTime then
            if stableName ~= currentName then stableName, stableSince = currentName, os.clock() end
            if os.clock() - stableSince < slot.identitySettleTime then return nil end
        end
        return currentName
    end, CONFIG.Units.ActionTimeout,
        slot.holder.Name .. ": displayed-unit controls/name did not recover yet; waiting for controls/name to recover.")
    if not ok then
        checkAlive()
        if slot.identitySettleTime then
            error(string.format("%s: selected unit did not settle (hotbar slot %s; expected %q, observed %q): %s",
                slot.holder.Name, tostring(slot.sourceSlot or "--"), tostring(slot.expectedName or "any occupied unit"),
                tostring(observedName or "<empty>"), tostring(result)), 0)
        end
        error(result, 0)
    end
    return result
end

local ownsStatFocus = false
local function statFocusFrame()
    local mine = playerGui:FindFirstChild("MineGui")
    return mine and mine:FindFirstChild("SlotFocusFrame")
end
local function closeStatFocus()
    closeUnitPanel("Closing unit Stats panel through SlotFocusFrame.Visible")
    ownsStatFocus = false
    pause(CONFIG.Units.StatUpgrade.PanelSettleTime)
end
local function cleanupStatFocus()
    if not ownsStatFocus then return end
    local focus = statFocusFrame()
    if focus and focus.Visible then pcall(hideUnitPanel, focus) end
    ownsStatFocus = false
end
local function createUnitStatSession(plot, minimum)
    local settings = CONFIG.Units.StatUpgrade
    local holders = path(plot, {"Holders"})
    if type(fireclickdetector) ~= "function" then error("Unit upgrades need fireclickdetector.", 0) end
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then error("Character is not ready for unit upgrades.", 0) end
    if not originalRoot then originalRoot, originalCFrame = root, root.CFrame end
    local function checkTarget(slot, menuOpen)
        checkPlot(plot)
        if not player.Character or not root:IsDescendantOf(player.Character) then
            error("Character changed during unit upgrades; run again after respawning.", 0)
        end
        if not menuOpen then waitForDisplayedUnit(plot, holders, slot) end

        local damageLevel = slot.cachedStats and slot.cachedStats.Damage.level or readLevel(slot.holder)
        local currentName = readCharacterName(slot.holder)
        if menuOpen and slot.matchesName and not slot.matchesName(currentName, slot.expectedName) then
            currentName = waitForDisplayedUnit(plot, holders, slot)
        end
        local matches = slot.matchesName and slot.matchesName(currentName, slot.expectedName)
            or not slot.matchesName and currentName == slot.expectedName
        if slot.holder.Parent ~= holders or not matches or damageLevel < minimum then
            error(slot.holder.Name .. ": displayed unit changed during unit upgrades.", 0)
        end
        if menuOpen and not visible(statFocusFrame()) then error("Unit Stats menu closed during upgrades.", 0) end
    end
    local function statsPanel()
        local focus = statFocusFrame()
        local bottom = focus and focus:FindFirstChild("BottomPanels")
        local panel = bottom and bottom:FindFirstChild("StatsPanel")
        return visible(panel) and panel or nil
    end
    local function canUpgrade(slot, rowName)
        checkTarget(slot, true)
        local panel = assert(statsPanel(), "Stats panel is unavailable.")
        local row = path(panel, {"Scroll", rowName})
        local content = path(row, {"UpgradeButton", "Content"})
        if not content:IsA("GuiObject") or not visible(content) then error(rowName .. ": upgrade Content is unavailable.", 0) end
        local color = content.BackgroundColor3
        local function sameColor(expected)
            return math.floor(color.R * 255 + 0.5) == math.floor(expected.R * 255 + 0.5)
                and math.floor(color.G * 255 + 0.5) == math.floor(expected.G * 255 + 0.5)
                and math.floor(color.B * 255 + 0.5) == math.floor(expected.B * 255 + 0.5)
        end
        return sameColor(settings.GreenColor)
    end
    local function readStat(slot, rowName)
        checkTarget(slot, true)
        local panel = assert(statsPanel(), "Stats panel is unavailable.")
        local row = path(panel, {"Scroll", rowName})
        local label = path(row, {"LevelTitle"})
        if not (label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox")) then
            error(rowName .. ".LevelTitle is not readable.", 0)
        end
        local text = label.Text:gsub("<[^>]*>", "")
        local current, maximum = text:match("Level%s+(%d+)%s*/%s*(%d+)")
        current, maximum = tonumber(current), tonumber(maximum)
        if not current or not maximum or current > maximum then error(rowName .. ": invalid stat level: " .. text, 0) end
        return {level = current, maximum = maximum, upgradeable = canUpgrade(slot, rowName)}
    end

    local function selectStats(slot)
        checkTarget(slot, true)
        ownsStatFocus = true
        local label = path(statFocusFrame(), {"Tabs", "StatsTab", "Content", "Row", "Label"})
        local tab = path(statFocusFrame(), {"Tabs", "StatsTab"})
        local button = label
        while button ~= tab and not button:IsA("GuiButton") do button = button.Parent end
        clickButton(button)
        waitUntil(function()
            checkTarget(slot, true)
            return statsPanel()
        end, CONFIG.Units.ActionTimeout, "Waiting for Stats tab to open.", function()
            checkTarget(slot, true)
            clickButton(button)
        end)
        pause(settings.PanelSettleTime)
    end

    local function open(slot)
        closeStatFocus()
        checkTarget(slot, false)
        local upgrade = path(slot.holder, {"UpgradePart"})
        local detector = path(upgrade, {"UpgradeClick"})
        if not upgrade:IsA("BasePart") or not detector:IsA("ClickDetector") then
            error(slot.holder.Name .. ": UpgradePart/UpgradeClick is invalid.", 0)
        end
        waitUntil(function()
            checkTarget(slot, false)
            return detector.MaxActivationDistance > 0
        end, CONFIG.Units.ActionTimeout, slot.holder.Name .. ": UpgradeClick has not reactivated yet.")
        root.CFrame = CFrame.new(upgrade.Position + Vector3.new(0, settings.TeleportHeight, 0), upgrade.Position)
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        pause(settings.TeleportDelay)
        checkTarget(slot, false)
        ownsStatFocus = true
        fireclickdetector(detector)
        pause(settings.AfterUpgradeClickDelay)
        waitUntil(function() return visible(statFocusFrame()) end,
            CONFIG.Units.ActionTimeout, slot.holder.Name .. ": waiting for unit Stats menu to open.", function() checkTarget(slot, false); fireclickdetector(detector) end)
        pause(settings.PanelSettleTime)
        selectStats(slot)
    end
    return {open = open, selectStats = selectStats, readStat = readStat, canUpgrade = canUpgrade, checkTarget = checkTarget}
end

local function unitDamageBatchSize(zoneId)
    local rule = CONFIG.Units.RequiredByZone[zoneId] or {}
    local size = rule.DamageBatchSize
    if size == nil then size = 5 end
    if type(size) ~= "number" or size ~= size or size < 1 or size % 1 ~= 0 or size == math.huge then
        error(zoneId .. ": DamageBatchSize must be a finite positive whole number.", 0)
    end
    return size
end
local function minimumStatDamageLevel()
    local minimum = CONFIG.Units.StatUpgrade.MinimumDamageLevel
    if type(minimum) ~= "number" or minimum ~= minimum or minimum < 1 or minimum % 1 ~= 0 or minimum == math.huge then
        error("StatUpgrade.MinimumDamageLevel must be a finite positive whole number.", 0)
    end
    return minimum
end
local function initializeUnitUpgradeCache(plot, displayed, cache)
    cache = cache or {}
    if cache.slots then return cache end
    closeStatFocus()
    cache.slots, cache.byHolder = {}, {}
    if #displayed == 0 then return cache end
    cache.session = createUnitStatSession(plot, 1)
    for _, slot in ipairs(displayed) do
        local name, reason = readCharacterName(slot.holder)
        if not name then error(slot.holder.Name .. ": " .. reason, 0) end
        local entry = {holder = slot.holder, number = slot.number, expectedName = name,
            cachedStats = {Damage = {level = slot.initialDamageLevel or readLevel(slot.holder)}}}
        cache.session.open(entry)
        for _, stat in ipairs({"Damage", "Speed", "MineSpeed"}) do
            entry.cachedStats[stat] = cache.session.readStat(entry, stat == "MineSpeed" and "Mining" or stat)
        end
        cache.byHolder[slot.holder] = entry
        table.insert(cache.slots, entry)
        pause(CONFIG.Units.StatUpgrade.BeforeExitDelay)
        closeStatFocus()
    end
    return cache
end
local function getUnitUpgradeCache(plot, cache)
    if cache and cache.slots then return cache end
    local displayed = {}
    for _, holder in ipairs(path(plot, {"Holders"}):GetChildren()) do
        local number = tonumber(holder.Name:match("^M(%d+)$"))
        if number and number >= 1 and isDisplayed(holder) then
            table.insert(displayed, {holder = holder, number = number})
        end
    end
    table.sort(displayed, function(a, b) return a.number < b.number end)
    return initializeUnitUpgradeCache(plot, displayed, cache)
end
local function attachCachedUnit(cache, slot)
    local entry = cache.byHolder[slot.holder]
    if not entry or (slot.expectedName and slot.expectedName ~= entry.expectedName) then
        error(slot.holder.Name .. ": unit is missing from the upgrade cache or changed identity.", 0)
    end
    slot.expectedName, slot.cachedStats = entry.expectedName, entry.cachedStats
    return entry
end
local upgradeDisplayedStats
local stageSpeedRequests, stageMiningRequests = 0, 0
local function upgradeDisplayedSlots(plot, slots, cap, stageText, heading, options)
    options = options or {}
    local damageBatchSize = options.damageBatchSize or 5
    closeStatFocus()
    local holders = path(plot, {"Holders"})
    local event = getGameEvent()
    local settings = CONFIG.Units.StatUpgrade
    local damageRequests, session = 0, nil
    local minimum = options.balanceStats and minimumStatDamageLevel() or nil
    local statsReady, caughtUpLevels = true, {}
    local cache = options.cache or (minimum and getUnitUpgradeCache(plot))
    if cache then session = cache.session end
    local function checkSlot(slot)
        local currentName = waitForDisplayedUnit(plot, holders, slot)
        slot.expectedName = slot.expectedName or currentName
    end
    local function catchUpSlot(slot)
        if minimum and slot.level >= minimum and caughtUpLevels[slot.holder] ~= slot.level then
            local _, _, _, ready = upgradeDisplayedStats(plot, cache, slot.holder)
            statsReady = ready
            if not ready then
                stageText.Text = slot.holder.Name .. ": Damage paused until Speed/Mining catch up to its current Damage level."
                return false
            end
            caughtUpLevels[slot.holder] = slot.level
        end
        return true
    end
    logUnitUpgradeDetail(heading .. ": " .. #slots .. " displayed units.")
    for _, slot in ipairs(slots) do
        checkSlot(slot)
        if cache then attachCachedUnit(cache, slot) end
        local level = slot.cachedStats and slot.cachedStats.Damage.level or readLevel(slot.holder)
        slot.damageCap = cap
        if options.fullDamageMaximum then
            session = session or createUnitStatSession(plot, 1)
            session.open(slot)
            local damage = session.readStat(slot, "Damage")
            local maximum = damage.maximum
            if type(maximum) ~= "number" or maximum ~= maximum or maximum < 1
                or maximum % 1 ~= 0 or maximum == math.huge then
                error(slot.holder.Name .. ": actual maximum Damage level is missing or invalid; old-unit Damage stopped.", 0)
            end
            level, slot.damageCap = damage.level, maximum
            pause(settings.BeforeExitDelay)
            closeStatFocus()
        end
        slot.startLevel, slot.level = level, level
        if options.halfDamageMaximum then
            local maximum = slot.cachedStats and slot.cachedStats.Damage.maximum
            if type(maximum) ~= "number" or maximum ~= maximum or maximum < 1
                or maximum % 1 ~= 0 or maximum == math.huge then
                error(slot.holder.Name .. ": actual maximum Damage level is missing or invalid; extra Damage stopped.", 0)
            end
            slot.damageCap = math.floor(maximum / 2)
        end
        slot.remaining, slot.damageRequests = math.max(0, slot.damageCap - level), 0
        slot.damageUnavailable = false
    end
    while alive do
        local choice
        for _, slot in ipairs(slots) do
            if not cache then checkSlot(slot) end
            slot.level = slot.cachedStats and slot.cachedStats.Damage.level or readLevel(slot.holder)
            if slot.level >= slot.damageCap then slot.remaining = 0 end
            if slot.remaining > 0 and not slot.damageUnavailable and (not choice or slot.level < choice.level
                or (slot.level == choice.level and slot.number < choice.number)) then choice = slot end
        end
        if not choice then
            -- Already-maxed units still need catch-up before extras may receive Damage.
            for _, slot in ipairs(slots) do if not catchUpSlot(slot) then break end end
            break
        end
        if not catchUpSlot(choice) then break end
        session = session or createUnitStatSession(plot, 1)
        session.open(choice)
        local batchSize = math.min(damageBatchSize, choice.remaining)
        if minimum and choice.level < minimum then
            batchSize = math.min(batchSize, minimum - choice.level)
        end
        for _ = 1, batchSize do
            local before = choice.cachedStats and choice.cachedStats.Damage or session.readStat(choice, "Damage")
            choice.level = before.level
            if cache and before.level < choice.damageCap then before.upgradeable = session.canUpgrade(choice, "Damage") end
            if before.level >= choice.damageCap then choice.remaining = 0; break end
            if not before.upgradeable then choice.damageUnavailable = true; break end
            stageText.Text = string.format("%s: Damage %d -> %d (cap %d); button green",
                choice.holder.Name, before.level, before.level + 1, choice.damageCap)
            session.checkTarget(choice, true)
            checkAlive()
            event:FireServer("MineUpgradeCharacter", choice.holder.Name, "Damage")
            choice.remaining = choice.remaining - 1
            damageRequests = damageRequests + 1
            choice.damageRequests = choice.damageRequests + 1
            pause(math.max(CONFIG.Units.UpgradeRequestDelays.Damage, settings.PanelSettleTime))
            local after
            waitUntil(function()
                after = session.readStat(choice, "Damage")
                if cache then choice.cachedStats.Damage = after end
                return after.level > before.level or not after.upgradeable
            end, CONFIG.Units.ActionTimeout, choice.holder.Name .. ": waiting for Damage level/color response.", function()
                session.checkTarget(choice, true)
                local latest = session.readStat(choice, "Damage")
                if latest.level <= before.level and latest.upgradeable then
                    event:FireServer("MineUpgradeCharacter", choice.holder.Name, "Damage")
                    damageRequests = damageRequests + 1
                    choice.damageRequests = choice.damageRequests + 1
                end
            end)
            choice.level = after.level
            if after.level >= choice.damageCap then choice.remaining = 0; break end
            if not after.upgradeable then choice.damageUnavailable = true; break end
        end

        pause(settings.BeforeExitDelay)
        closeStatFocus()
        -- Finish this unit's Speed/Mining catch-up before any other Damage batch.
        if not catchUpSlot(choice) then break end
    end
    if options.confirmCap and damageRequests > 0 then pause(settings.PanelSettleTime) end
    if not cache then
        for _, slot in ipairs(slots) do
            local summary = string.format("Unit slot %d done upgrading: Damage requested %d times; level %d -> %d (target %d)",
                slot.number, slot.damageRequests, slot.startLevel, slot.cachedStats and slot.cachedStats.Damage.level or readLevel(slot.holder), slot.damageCap)
            if slot.damageUnavailable then summary = summary .. "; stopped because Damage button is not green" end
            logUnitUpgradeDetail(summary .. ".")
        end
    end
    return damageRequests, statsReady
end
modules.upgradingOldUnit = {run = function()
    local oldStatus = stageStatus("upgradingOldUnit")
    local zoneId = getCycleZone()
    local densityLevel = modules.upgrades.getDensity()
    if densityLevel ~= 0 then
        return string.format("Skipped: %s density is %d; Upgrade Old Units requires density 0.", zoneId, densityLevel)
    end
    local zoneNumber = assert(tonumber(zoneId:match("^Z(%d+)$")), "Invalid cached zone ID.")
    if zoneNumber <= 1 then return "Skipped: " .. zoneId .. " has no previous zone." end
    local previousZoneId = "Z" .. tostring(zoneNumber - 1)
    local previousRule = CONFIG.Units.RequiredByZone[previousZoneId]
    local allowed = {}
    for _, name in ipairs(previousRule and previousRule.Names or {}) do allowed[name] = true end
    if next(allowed) == nil then return "Skipped: " .. previousZoneId .. " has no configured required unit names." end
    local plot = getMyPlot()
    checkPlot(plot)
    local holders = path(plot, {"Holders"})
    local slots = {}
    logUnitUpgradeDetail(string.format("Current zone=%s; density=%d; ONLY previous zone %s Names are eligible; old-unit target is each unit's own maximum Damage level.",
        zoneId, densityLevel, previousZoneId))
    for _, holder in ipairs(holders:GetChildren()) do
        local number = tonumber(holder.Name:match("^M(%d+)$"))
        if number and number >= 1 and isDisplayed(holder) then
            local name, reason = readCharacterName(holder)
            if name and allowed[name] then
                table.insert(slots, {holder = holder, number = number, expectedName = name})
                logUnitUpgradeDetail(holder.Name .. ": matched " .. name .. " from " .. previousZoneId .. ".")
            else
                logUnitUpgradeDetail("Upgrade Old Units: skipped " .. holder.Name .. ": "
                    .. (name and (name .. " is not in " .. previousZoneId .. " Names.") or reason))
            end
        end
    end
    table.sort(slots, function(a, b) return a.number < b.number end)
    if #slots == 0 then return "Skipped: no displayed units match " .. previousZoneId .. " required Names." end
    local damageRequests = upgradeDisplayedSlots(plot, slots, nil, oldStatus,
        "Upgrading ONLY " .. previousZoneId .. " required units (Damage only)", {scope = "Upgrade Old Units", fullDamageMaximum = true})
    return string.format("%s: processed %d displayed units from %s Names only; sent %d Damage requests. Old-unit target: each unit's own maximum Damage level.",
        zoneId, #slots, previousZoneId, damageRequests)
end}

local function upgradeZoneDamage(plot, zoneId, densityLevel, cache)
    local holders = path(plot, {"Holders"})
    local rule = CONFIG.Units.RequiredByZone[zoneId] or {}
    local allowed = {}
    for _, name in ipairs(rule.Names or {}) do allowed[name] = true end
    local function scanDisplayed()
        local slots = {}
        for _, holder in ipairs(holders:GetChildren()) do
            local number = tonumber(holder.Name:match("^M(%d+)$"))
            if number and number >= 1 and isDisplayed(holder) then
                table.insert(slots, {holder = holder, number = number})
            end
        end
        table.sort(slots, function(a, b) return a.number < b.number end)
        return slots
    end
    local displayed = scanDisplayed()
    local cap = unitLevelCap(zoneId)
    local damageBatchSize = unitDamageBatchSize(zoneId)
    local core, requiredNames, eligibilityReason = modules.mutation.upgradeTargets(zoneId, displayed)
    local cacheTargets = {}
    local minimum = minimumStatDamageLevel()
    for _, slot in ipairs(displayed) do
        slot.initialDamageLevel = readLevel(slot.holder)
        local name = readCharacterName(slot.holder)

        if slot.initialDamageLevel >= minimum or allowed[name]
            or (core and not requiredNames[slot.holder.Name]) then
            table.insert(cacheTargets, slot)
        end
    end
    cache = initializeUnitUpgradeCache(plot, cacheTargets, cache)
    if not core then
        local matches = {}
        for _, slot in ipairs(displayed) do
            local name = readCharacterName(slot.holder)
            if name and allowed[name] then
                slot.expectedName = name
                table.insert(matches, slot)
            end
        end
        if #matches == 0 then return zoneId .. ": full Damage locked (" .. eligibilityReason .. "); no displayed whitelisted units for level-10 Damage." end
        local damageRequests = upgradeDisplayedSlots(plot, matches, 10, status,
            "Required-slot gate failed: matching units Damage to level 10", {cache = cache, damageBatchSize = damageBatchSize})
        return string.format("%s density %d: full Damage locked (%s); processed %d whitelisted units; sent %d Damage requests. Cap: 10.",
            zoneId, densityLevel, eligibilityReason, #matches, damageRequests)
    end
    local damageRequests, statsReady = 0, true
    if #core > 0 then
        damageRequests, statsReady = upgradeDisplayedSlots(plot, core, cap, status,
            "Required-slot gate passed: whitelisted required units Damage to zone cap", {confirmCap = true, balanceStats = true, cache = cache, damageBatchSize = damageBatchSize})
    end
    if not statsReady then
        return string.format("%s: sent %d Damage requests; extra Damage locked while eligible Speed/MineSpeed catch up.",
            zoneId, damageRequests)
    end
    for _, slot in ipairs(core) do
        attachCachedUnit(cache, slot)
        checkPlot(plot)
        if slot.holder.Parent ~= holders or not isDisplayed(slot.holder)
            or readCharacterName(slot.holder) ~= slot.expectedName or slot.cachedStats.Damage.level < cap then
            return string.format("%s: sent %d Damage requests to %d matching required units. Extra Damage locked: %s is not confirmed at cap %d.",
                zoneId, damageRequests, #core, slot.holder.Name, cap)
        end
    end
    local confirmed, _, reason = modules.mutation.upgradeTargets(zoneId, scanDisplayed())
    if not confirmed then return zoneId .. ": extra Damage locked after core upgrades: " .. reason end
    local extras = {}
    for _, holder in ipairs(holders:GetChildren()) do
        local number = tonumber(holder.Name:match("^M(%d+)$"))
        if number and number >= 1 and not requiredNames[holder.Name] and isDisplayed(holder)
            and cache.byHolder[holder] then
            table.insert(extras, {holder = holder, number = number, expectedName = readCharacterName(holder)})
        end
    end
    table.sort(extras, function(a, b) return a.number < b.number end)
    if #extras > 0 then
        local extraRequests, extrasReady = upgradeDisplayedSlots(plot, extras, nil, status,
            "Required matching units maxed: extra units Damage to half their own actual maximum", {confirmCap = true, balanceStats = true, halfDamageMaximum = true, cache = cache, damageBatchSize = damageBatchSize})
        damageRequests = damageRequests + extraRequests
        if not extrasReady then
            return string.format("%s: sent %d Damage requests; extra Damage paused while eligible Speed/MineSpeed catch up.",
                zoneId, damageRequests)
        end
    end
    return string.format("%s density %d: processed %d matching required units and %d extras; sent %d Damage requests. Required cap: %d; extras stop at half their own actual maximum Damage level.",
        zoneId, densityLevel, #core, #extras, damageRequests, cap)
end

upgradeDisplayedStats = function(plot, cache, onlyHolder)
    closeStatFocus()
    local settings = CONFIG.Units.StatUpgrade
    local minimum = minimumStatDamageLevel()
    cache = getUnitUpgradeCache(plot, cache)
    local eligible = {}
    for _, entry in ipairs(cache.slots) do
        if entry.cachedStats.Damage.level >= minimum and (not onlyHolder or entry.holder == onlyHolder) then
            table.insert(eligible, {holder = entry.holder, number = entry.number, expectedName = entry.expectedName,
                cachedStats = entry.cachedStats, target = entry.cachedStats.Damage.level})
        end
    end
    if #eligible == 0 then return 0, 0, 0, true end
    local session = cache.session
    if onlyHolder then
        -- Damage can raise stat maxima; do not keep an old level-11 limit cached.
        for _, slot in ipairs(eligible) do
            session.open(slot)
            for _, stat in ipairs({"Speed", "MineSpeed"}) do
                slot.cachedStats[stat] = session.readStat(slot, stat == "MineSpeed" and "Mining" or stat)
            end
            pause(settings.BeforeExitDelay)
            closeStatFocus()
        end
    end
    local function needsUpgrade(slot, state)
        return state.level < math.min(slot.target, state.maximum)
    end
    local event = getGameEvent()
    local totalSpeed, totalMining, ready = 0, 0, false
    local batchTarget
    while alive do
        local lowest
        for _, slot in ipairs(eligible) do
            for _, stat in ipairs({"Speed", "MineSpeed"}) do
                local state = slot.cachedStats[stat]
                if needsUpgrade(slot, state) then lowest = math.min(lowest or state.level, state.level) end
            end
        end
        if not lowest then ready = true; break end
        if not batchTarget or lowest >= batchTarget then batchTarget = lowest + 5 end
        local progressed = false
        for _, slot in ipairs(eligible) do
            local states = slot.cachedStats
            if (needsUpgrade(slot, states.Speed) and states.Speed.level < batchTarget)
                or (needsUpgrade(slot, states.MineSpeed) and states.MineSpeed.level < batchTarget) then
                session.open(slot)
                for _, stat in ipairs({"Speed", "MineSpeed"}) do
                    for _ = 1, 5 do
                        local before = slot.cachedStats[stat]
                        if before.level >= batchTarget or not needsUpgrade(slot, before) then break end
                        before.upgradeable = session.canUpgrade(slot, stat == "MineSpeed" and "Mining" or stat)
                        if not before.upgradeable then break end
                        session.checkTarget(slot, true)
                        status.Text = string.format("%s: %s %d -> %d (catch-up target %d)",
                            slot.holder.Name, stat, before.level, before.level + 1, math.min(slot.target, before.maximum))
                        checkAlive()
                        event:FireServer("MineUpgradeCharacter", slot.holder.Name, stat)
                        if stat == "Speed" then
                            totalSpeed = totalSpeed + 1
                        else
                            totalMining = totalMining + 1
                        end
                        pause(math.max(CONFIG.Units.UpgradeRequestDelays[stat], settings.PanelSettleTime))
                        waitUntil(function()
                            local after = session.readStat(slot, stat == "MineSpeed" and "Mining" or stat)
                            slot.cachedStats[stat] = after
                            return after.level > before.level or not after.upgradeable
                        end, CONFIG.Units.ActionTimeout, slot.holder.Name .. ": waiting for " .. stat .. " level/color response.", function()
                            session.checkTarget(slot, true)
                            local latest = session.readStat(slot, stat == "MineSpeed" and "Mining" or stat)
                            if latest.level <= before.level and latest.upgradeable then
                                event:FireServer("MineUpgradeCharacter", slot.holder.Name, stat)
                                if stat == "Speed" then totalSpeed = totalSpeed + 1 else totalMining = totalMining + 1 end
                            end
                        end)
                        if slot.cachedStats[stat].level > before.level then progressed = true end
                    end
                end
                pause(settings.BeforeExitDelay)
                closeStatFocus()
            end
        end

        if not progressed then break end
    end
    stageSpeedRequests = stageSpeedRequests + totalSpeed
    stageMiningRequests = stageMiningRequests + totalMining
    return #eligible, totalSpeed, totalMining, ready
end

do
    local selected, entries, optionConnections, optionRenderers = {}, {}, {}, {}
    local card = make("Frame", masterLayout.body, {
        Name = "HotbarUpgrades", LayoutOrder = 5,
        Size = UDim2.new(1, 0, 0, 226), BackgroundColor3 = colors.bg, BorderSizePixel = 0,
    })
    corner(card)
    local heading = label(card, "Hotbar upgrades / M1", UDim2.fromOffset(12, 10), UDim2.new(1, -24, 0, 20), 14)
    heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.text
    label(card, "Run once for all selected copies. Max Speed/Mining; Damage target from config.",
        UDim2.fromOffset(12, 34), UDim2.new(1, -24, 0, 30), 12)
    local dropdown = button(card, "Select hotbar units v", UDim2.fromOffset(12, 68), UDim2.new(0.64, -18, 0, 36))
    dropdown.Name, dropdown.TextSize = "HotbarUpgradeDropdown", 13
    dropdown.TextTruncate = Enum.TextTruncate.AtEnd
    local run = button(card, "Run Upgrades", UDim2.fromOffset(12, 112), UDim2.fromOffset(160, 32))
    run.Name, run.TextSize = "RunHotbarUpgrades", 14
    local refresh = button(card, "Refresh", UDim2.new(0.64, 2, 0, 68), UDim2.new(0.36, -14, 0, 36))
    refresh.Name, refresh.TextSize = "RefreshHotbarUnits", 13
    local status = label(card, "Refresh, then select hotbar units.", UDim2.fromOffset(12, 156), UDim2.new(1, -24, 0, 58), 12)
    local options = make("ScrollingFrame", card, {
        Name = "HotbarUnitOptions", Position = UDim2.fromOffset(12, 152), Size = UDim2.new(1, -24, 0, 184),
        BackgroundColor3 = colors.surface, BorderSizePixel = 0, ScrollBarThickness = 5,
        CanvasSize = UDim2.fromOffset(0, 0), Visible = false, ZIndex = 20,
    })
    corner(options)
    local function setDropdownVisible(value)
        options.Visible = value
        status.Position = UDim2.fromOffset(12, value and 346 or 156)
        card.Size = UDim2.new(1, 0, 0, value and 416 or 226)
    end
    local function normalizeName(name)
        if type(name) ~= "string" then return nil end
        return name:gsub("<[^>]*>", ""):gsub("&nbsp;", " "):gsub("&amp;", "&")
            :gsub("\194\160", " "):gsub("\226\128\139", ""):gsub("%s+", " "):match("^%s*(.-)%s*$")
    end
    local page = {name = "Hotbar Upgrades", run = run, runText = "Run Upgrades", status = status}
    local function find(parent, names)
        for _, name in ipairs(names) do parent = parent and parent:FindFirstChild(name) end
        return parent
    end
    local function textOf(object)
        if object and (object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox")) then
            return normalizeName(object.Text)
        end
        return ""
    end
    local function ensureHotbarVisible()
        return waitUntil(function()
            local hotbar = find(playerGui, {"MineGui", "HotbarFrame"})
            if not hotbar or not hotbar:IsA("GuiObject") then return nil end
            hotbar.Visible = true
            return find(hotbar, {"Content", "Container"})
        end, math.huge, "Waiting for HotbarFrame and its slots before selecting a hotbar unit.")
    end
    local function readEntry(index)
        local hotbar = find(playerGui, {"MineGui", "HotbarFrame"})
        local container = find(hotbar, {"Content", "Container"})
        if activeRun == "hotbarUpgrade" and (not hotbar or not hotbar:IsA("GuiObject")
            or not hotbar.Visible or not container) then
            container = ensureHotbarVisible()
        end
        if not container then error("Hotbar is not loaded; press Refresh when it is ready.", 0) end
        local content = find(container, {tostring(index), "ItemFrame", "Content"})
        local name = textOf(content and content:FindFirstChild("ItemName"))
        local countText = textOf(content and content:FindFirstChild("ActualItemCount"))
        local count = 0
        if name ~= "" then
            if countText == "" then count = 1
            else
                count = tonumber(countText:gsub(",", ""):match("^[xX]?%s*(%d+)$"))
                if not count or count == math.huge then error("Unreadable hotbar count in slot " .. index .. ".", 0) end
            end
        end
        return {slot = index, name = name, count = count}
    end
    local function readStableEntry(index)
        local latest, stableSince
        return waitUntil(function()
            local current = readEntry(index)
            if not latest or latest.name ~= current.name or latest.count ~= current.count then
                latest, stableSince = current, os.clock()
            end
            if os.clock() - stableSince >= CONFIG.HotbarUpgrade.IdentitySettleTime then return current end
        end, math.huge, "Hotbar slot " .. index .. " did not settle; refresh and try again.")
    end
    local function logHotbarIdentity(index)
        local hotbarSlot = find(playerGui, {"MineGui", "HotbarFrame", "Content", "Container", tostring(index)})
        local item = hotbarSlot and hotbarSlot:FindFirstChild("ItemFrame")
        local content = item and item:FindFirstChild("Content")
        local fields = {}
        for _, entry in ipairs({{"Slot", hotbarSlot}, {"ItemFrame", item}, {"Content", content}}) do
            local label, object = entry[1], entry[2]
            if object then
                local ok, attributes = pcall(function() return object:GetAttributes() end)
                if ok then
                    for key, value in pairs(attributes) do
                        if #fields >= 32 then break end
                        table.insert(fields, label .. ".@" .. key .. "=" .. tostring(value):sub(1, 160))
                    end
                end
                for _, child in ipairs(object:GetChildren()) do
                    if #fields >= 32 then break end
                    if child:IsA("ValueBase") then
                        table.insert(fields, label .. "." .. child.Name .. "=" .. tostring(child.Value):sub(1, 160))
                    end
                end
            end
        end
        table.sort(fields)
        logWarning("[Hotbar identity] slot " .. index .. ": " .. (#fields > 0 and table.concat(fields, "; ") or "No unit identifiers exposed in slot attributes/value fields."))
    end
    local function selectedSlot(expectedName, sourceSlot)
        return {holder = nil, number = 1, expectedName = expectedName, sourceSlot = sourceSlot,
            identitySettleTime = CONFIG.HotbarUpgrade.IdentitySettleTime,
            matchesName = function(current, expected)
                local name = normalizeName(current)
                return name ~= nil and name ~= "" and (not expected or name == normalizeName(expected))
            end}
    end
    local function updateSelection()
        local count, copies = 0, 0
        for _, entry in ipairs(entries) do
            if selected[entry.slot] == entry.name then count, copies = count + 1, copies + entry.count end
        end
        dropdown.Text = count == 0 and "Select hotbar units v" or string.format("%d slots / %d units selected v", count, copies)
    end
    local function refreshEntries()
        local fresh = {}
        for index = 1, 9 do
            local entry = readEntry(index)
            if selected[index] ~= entry.name or entry.count == 0 then selected[index] = nil end
            if entry.name ~= "" and entry.count > 0 then table.insert(fresh, entry) end
        end
        entries = fresh
        for _, connection in ipairs(optionConnections) do connection:Disconnect() end
        table.clear(optionConnections)
        table.clear(optionRenderers)
        options:ClearAllChildren()
        corner(options)
        for index, entry in ipairs(entries) do
            local option = button(options, "", UDim2.fromOffset(4, (index - 1) * 52 + 4), UDim2.new(1, -14, 0, 48))
            option.TextSize, option.TextXAlignment, option.TextWrapped, option.ZIndex = 20, Enum.TextXAlignment.Left, true, 21
            local function render()
                option.Text = string.format("%s %d: %s x%d", selected[entry.slot] == entry.name and "[x]" or "[ ]", entry.slot, entry.name, entry.count)
                option.BackgroundColor3 = selected[entry.slot] == entry.name and colors.accent or colors.idle
            end
            render()
            table.insert(optionRenderers, render)
            table.insert(optionConnections, option.Activated:Connect(function()
                if not alive or busy then return end
                if selected[entry.slot] == entry.name then selected[entry.slot] = nil
                else selected[entry.slot] = entry.name end
                render()
                updateSelection()
            end))
        end
        options.CanvasSize = UDim2.fromOffset(0, #entries * 52 + 8)
        updateSelection()
    end
    local function refreshSafely()
        if not alive or busy then return end
        table.clear(selected)
        for _, render in ipairs(optionRenderers) do render() end
        updateSelection()
        local ok, reason = pcall(refreshEntries)
        status.Text = ok and (#entries .. " occupied hotbar slots. Select units above.") or tostring(reason)
        status.TextColor3 = ok and colors.muted or colors.error
    end
    connect(refresh.Activated, refreshSafely)
    connect(dropdown.Activated, function()
        if not alive or busy then return end
        if #entries == 0 then refreshSafely() end
        setDropdownVisible(not options.Visible)
    end)
    connect(run.Activated, function()
        if not alive then return end
        if busy and activeRun == "hotbarUpgrade" then stopRun(); return end
        if busy and activeRun == "master" then return end
        if busy then status.Text = "Stop the current action first."; return end
        if minimizedActions.openBusy then status.Text = "Wait for the crate batch to finish."; return end
        local any = false
        for _, entry in ipairs(entries) do if selected[entry.slot] == entry.name then any = true; break end end
        if not any then status.Text = "Select at least one hotbar unit first."; return end
        setDropdownVisible(false)
        startRun("hotbarUpgrade")
    end)
    local function report(message) status.Text = message end
    local function runBatch()
        local settle = CONFIG.HotbarUpgrade.IdentitySettleTime
        if type(settle) ~= "number" or settle ~= settle or settle < 0 or settle == math.huge then
            error("HotbarUpgrade.IdentitySettleTime must be finite and nonnegative.", 0)
        end
        local target = CONFIG.HotbarUpgrade.DamageTargetLevel
        if type(target) ~= "number" or target ~= target or target < 1 or target % 1 ~= 0 or target == math.huge then
            error("HotbarUpgrade.DamageTargetLevel must be a finite positive whole number.", 0)
        end
        closeStatFocus()
        local mine = playerGui:FindFirstChild("MineGui")
        local inventory = mine and mine:FindFirstChild("InventoryFrame")
        if visible(inventory) then
            inventory.Visible = false
            waitUntil(function() return not visible(inventory) end, math.huge, "Waiting for inventory to close before Hotbar Upgrades.", function() inventory.Visible = false end)
        end
        local queue = {}
        for _, entry in ipairs(entries) do
            if selected[entry.slot] == entry.name then
                local current = readStableEntry(entry.slot)
                if current.name ~= entry.name or current.count == 0 then
                    error("Selected hotbar slot " .. entry.slot .. " changed; refresh and select again.", 0)
                end
                table.insert(queue, current)
            end
        end
        if #queue == 0 then error("Select at least one hotbar unit first.", 0) end
        local plot = getMyPlot()
        checkPlot(plot)
        local holder = path(plot, {"Holders", "M1"})
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then error("Character is not ready.", 0) end
        originalRoot, originalCFrame = root, root.CFrame
        local session = createUnitStatSession(plot, 1)
        local event, completed, unverifiedCopies = getGameEvent(), 0, 0
        local function prompt()
            checkPlot(plot)
            if holder.Parent ~= plot:FindFirstChild("Holders") then error("M1 changed during the batch.", 0) end
            local value = path(holder, {"Pad", "HolderPrompt"})
            if not value:IsA("ProximityPrompt") then error("M1 prompt is unavailable.", 0) end
            return value
        end
        local function action()
            local current = prompt()
            local text = (normalizeName(current.ActionText) or ""):lower()
            local compact = text:gsub("[%s%p]", "")
            if compact:match("^pickup") then return "pick up" end
            if compact:match("^place") then return "place" end
            if text:match("^unlock%f[%A]") or text:match("^locked%f[%A]") then return "locked" end
            local upgrade = holder:FindFirstChild("UpgradePart")
            local detector = upgrade and upgrade:FindFirstChild("UpgradeClick")
            if detector and detector:IsA("ClickDetector") and detector.MaxActivationDistance > 0
                and readCharacterName(holder) then return "pick up" end

            if compact:match("^equip") or compact:match("^select.*unit") or compact == "" then
                local pad = holder:FindFirstChild("Pad")
                local holderLabel = pad and pad:FindFirstChild("HolderLabel")
                local labelShown = holderLabel and ((holderLabel:IsA("LayerCollector") and holderLabel.Enabled)
                    or (holderLabel:IsA("GuiObject") and visible(holderLabel)))
                if detector and detector:IsA("ClickDetector") and detector.MaxActivationDistance <= 0
                    and not labelShown then return "place" end
            end
            return nil
        end
        local function waitForM1Action()
            local stable, since
            local ok, result = pcall(waitUntil, function()
                local state = action()
                if not state or state == "locked" then stable, since = nil, nil; return nil end
                if stable ~= state then stable, since = state, os.clock() end
                if os.clock() - since >= CONFIG.HotbarUpgrade.IdentitySettleTime then return state end
            end, math.huge, "M1 prompt did not become ready.")
            if ok then return result end
            checkAlive()
            local current = prompt()
            if action() == "locked" then
                error("M1 still shows an unlock prompt after waiting: " .. tostring(current.ActionText), 0)
            end
            error(string.format("M1 prompt is not ready (ActionText=%q, Enabled=%s). %s",
                tostring(current.ActionText), tostring(current.Enabled), tostring(result)), 0)
        end

        local lastM1RetryAngle
        local function moveToM1(isRetry)
            checkAlive()
            checkPlot(plot)
            if not player.Character or not root:IsDescendantOf(player.Character) then
                error("Character changed during M1 placement/pickup.", 0)
            end
            if holder.Parent ~= plot:FindFirstChild("Holders") then error("M1 changed during the batch.", 0) end
            local upgrade = path(holder, {"UpgradePart"})
            if not upgrade:IsA("BasePart") then error("M1 UpgradePart is not a BasePart.", 0) end
            local offset = Vector3.zero
            if isRetry then
                local angle = math.random(0, 359)
                if angle == lastM1RetryAngle then angle = (angle + 1) % 360 end
                lastM1RetryAngle = angle
                local radians = math.rad(angle)
                offset = Vector3.new(math.cos(radians), 0, math.sin(radians))
            end
            root.CFrame = CFrame.new(upgrade.Position + Vector3.new(0, CONFIG.Units.TeleportHeight, 0) + offset, upgrade.Position)
            root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
            pause(CONFIG.Units.TeleportDelay)
            checkPlot(plot)
            if not player.Character or not root:IsDescendantOf(player.Character) then
                error("Character changed during M1 placement/pickup.", 0)
            end
        end
        local function placeIntoM1(entry, copy)
            closeStatFocus()
            if waitForM1Action() ~= "place" then error("M1 must be empty before placing the next selected copy.", 0) end
            local source = readStableEntry(entry.slot)
            if source.name ~= entry.name or source.count == 0 then
                error("Selected hotbar slot " .. entry.slot .. " changed before placement; refresh and select again.", 0)
            end
            local keyName = CONFIG.Units.HotbarKeys[entry.slot]
            if not keyName or not Enum.KeyCode[keyName] then error("Selected hotbar slot has no number key.", 0) end
            local function placementConfirmed()
                if action() ~= "pick up" then return nil end
                local remaining = readEntry(entry.slot)
                return action() == "pick up" and (remaining.name == ""
                    or remaining.name == entry.name and remaining.count < source.count)
            end
            local function activatePlacement(isRetry)
                closeStatFocus()
                moveToM1(isRetry)
                if action() ~= "place" then return end
                -- Show the hotbar before validating and selecting this copy.
                local beforeEquip = readStableEntry(entry.slot)
                if action() ~= "place" then return end
                if beforeEquip.name ~= entry.name or beforeEquip.count ~= source.count then
                    error("Selected hotbar slot changed before equipping; stopped before placement.", 0)
                end
                if UserInputService:GetFocusedTextBox() then error("Leave the text field before placing units.", 0) end
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:UnequipTools() end
                pause(CONFIG.Units.EquipSlotDelay)
                if action() ~= "place" then return end
                report(string.format("Placing slot %d: %s (%d/%d) in M1...", entry.slot, entry.name, copy, entry.count))
                ensureHotbarVisible()
                local beforeKey = readEntry(entry.slot)
                if action() ~= "place" then return end
                if beforeKey.name ~= entry.name or beforeKey.count ~= source.count then
                    error("Selected hotbar slot changed before equipping; stopped before placement.", 0)
                end
                checkAlive()
                heldKey = Enum.KeyCode[keyName]
                VIM:SendKeyEvent(true, heldKey, false, game)
                pause(CONFIG.Units.PlacementKeyHold)
                VIM:SendKeyEvent(false, heldKey, false, game)
                heldKey = nil
                pause(CONFIG.Units.EquipSlotDelay)
                local beforePrompt = readStableEntry(entry.slot)
                if action() ~= "place" then return end
                if beforePrompt.name ~= entry.name or beforePrompt.count ~= source.count then
                    error("Selected hotbar slot changed while equipping; stopped before placement.", 0)
                end
                local current = prompt()
                if not current.Enabled then return end
                checkAlive()
                heldPrompt = current
                current:InputHoldBegin()
                pause(math.max(current.HoldDuration or 0, CONFIG.Units.PlacementMinimumHold))
                releaseInputs()
                pause(CONFIG.Units.PlacementDelay)
            end
            activatePlacement(false)
            waitUntil(placementConfirmed, math.huge, "M1: waiting for placement and consumption of the selected hotbar copy.", function()
                if action() == "place" then activatePlacement(true) end
            end)
            local slot = selectedSlot(nil, entry.slot)
            slot.holder, slot.hotbarName = holder, entry.name
            slot.expectedName = waitForDisplayedUnit(plot, path(plot, {"Holders"}), slot)
            return slot
        end

        local function clearM1(expectedName)
            closeStatFocus()

            moveToM1()
            local equippedHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if equippedHumanoid then equippedHumanoid:UnequipTools() end
            if waitForM1Action() == "place" then return end
            local guard = selectedSlot(expectedName)
            guard.holder = holder
            guard.expectedName = waitForDisplayedUnit(plot, path(plot, {"Holders"}), guard)
            local pickupAttempts = 0
            while true do
                if waitForM1Action() == "place" then return end
                waitForDisplayedUnit(plot, path(plot, {"Holders"}), guard)
                if not player.Character or not root:IsDescendantOf(player.Character) then error("Character changed during pickup.", 0) end
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:UnequipTools() end
                moveToM1(pickupAttempts > 0)
                pickupAttempts = pickupAttempts + 1
                local current = prompt()
                if action() == "place" then return end
                waitForDisplayedUnit(plot, path(plot, {"Holders"}), guard)
                if action() == "pick up" and current.Enabled then
                    heldPrompt = current
                    current:InputHoldBegin()
                    pause(math.max(current.HoldDuration, CONFIG.Units.RemovalMinimumHold) + CONFIG.Units.RemovalHoldPadding)
                    releaseInputs()
                    waitUntil(function() return action() == "place" end, math.huge, "M1: waiting for pickup to complete.", function()
                        if action() ~= "pick up" then return end
                        local currentName = readCharacterName(holder)
                        if not currentName or not guard.matchesName(currentName, guard.expectedName) then return end
                        moveToM1(true)
                        if action() ~= "pick up" then return end
                        currentName = readCharacterName(holder)
                        if not currentName or not guard.matchesName(currentName, guard.expectedName) then return end
                        local retryPrompt = prompt()
                        if action() == "pick up" and retryPrompt.Enabled then
                            heldPrompt = retryPrompt
                            retryPrompt:InputHoldBegin()
                            pause(math.max(retryPrompt.HoldDuration, CONFIG.Units.RemovalMinimumHold) + CONFIG.Units.RemovalHoldPadding)
                            releaseInputs()
                        end
                    end)
                    pause(CONFIG.Units.DisplayRemoveDelay)
                    return
                end
                pause(CONFIG.General.WaitPoll)
            end
        end
        local function upgradeTo(slot, stat, targetLevel)
            local row = stat == "MineSpeed" and "Mining" or stat
            local before = session.readStat(slot, row)
            local cap = math.min(targetLevel or before.maximum, before.maximum)
            while before.level < cap do
                checkAlive()
                if not before.upgradeable then
                    report("Waiting for M1 " .. stat .. " to become available...")
                    before = waitUntil(function()
                        local current = session.readStat(slot, row)
                        return (current.level >= cap or current.upgradeable) and current
                    end, math.huge, "M1: waiting for " .. stat .. " upgrade availability.")
                    if before.level >= cap then break end
                end
                report(string.format("%s: %s %d -> %d", slot.hotbarName or slot.expectedName, stat, before.level, cap))
                session.checkTarget(slot, true)
                checkAlive()
                event:FireServer("MineUpgradeCharacter", slot.holder.Name, stat)
                pause(math.max(CONFIG.Units.UpgradeRequestDelays[stat], CONFIG.Units.StatUpgrade.PanelSettleTime))
                local after
                waitUntil(function()
                    after = session.readStat(slot, row)
                    return after.level > before.level or not after.upgradeable
                end, math.huge, "M1: waiting for " .. stat .. " level response.", function()
                    session.checkTarget(slot, true)
                    local latest = session.readStat(slot, row)
                    if latest.level <= before.level and latest.upgradeable then
                        event:FireServer("MineUpgradeCharacter", slot.holder.Name, stat)
                    end
                end)
                before = after
            end
            return before
        end
        for queueIndex, entry in ipairs(queue) do
            report(string.format("Checking selected hotbar slot %d (%d/%d)...", entry.slot, queueIndex, #queue))
            -- Bound this slot by its original copy count, even if a checked unit returns to the same stack.
            for copy = 1, entry.count do
                checkAlive()
                local current = readStableEntry(entry.slot)
                if current.count == 0 and (current.name == "" or current.name == entry.name) then
                    local remaining = entry.count - copy + 1
                    unverifiedCopies = unverifiedCopies + remaining
                    logWarning(string.format("[Hotbar Upgrades] Slot %d became empty with %d original copies still unverified. Continuing other selected slots.", entry.slot, remaining))
                    break
                end
                if current.name ~= entry.name then return "Stopped: selected hotbar slot " .. entry.slot .. " changed. Completed " .. completed .. " units." end
                clearM1()

                current = readStableEntry(entry.slot)
                if current.name ~= entry.name or current.count == 0 then return "Stopped: selected hotbar slot " .. entry.slot .. " changed. Completed " .. completed .. " units." end
                local slot = placeIntoM1(entry, copy)
                modules.mutation.mutateHotbarUnitToUnreal(slot, plot, session.checkTarget, report, true)
                session.selectStats(slot)
                while true do
                    -- Check every stat after mutation and before upgrading or allowing pickup.
                    local damage = session.readStat(slot, "Damage")
                    local speed = session.readStat(slot, "Speed")
                    local mining = session.readStat(slot, "Mining")
                    if damage.level >= target and speed.level >= speed.maximum
                        and mining.level >= mining.maximum then
                        if modules.mutation.verifyHotbarUnitUnreal(slot, plot, session.checkTarget, false) then
                            session.selectStats(slot)
                            damage = session.readStat(slot, "Damage")
                            speed = session.readStat(slot, "Speed")
                            mining = session.readStat(slot, "Mining")
                            if damage.level >= target and speed.level >= speed.maximum
                                and mining.level >= mining.maximum then
                                report(string.format("Verified %s: Unreal; Damage %d/%d; Speed %d/%d; Mining %d/%d.",
                                    slot.hotbarName or slot.expectedName, damage.level, target,
                                    speed.level, speed.maximum, mining.level, mining.maximum))
                                break
                            end
                        else
                            report((slot.hotbarName or slot.expectedName) .. ": mutation is below Unreal; returning to Mutation before pickup...")
                            modules.mutation.mutateHotbarUnitToUnreal(slot, plot, session.checkTarget, report, true, true)
                            session.selectStats(slot)
                        end
                    end
                    if speed.level < speed.maximum then upgradeTo(slot, "Speed") end
                    if mining.level < mining.maximum then upgradeTo(slot, "MineSpeed") end
                    damage = session.readStat(slot, "Damage")
                    if damage.level < target then
                        if damage.level >= damage.maximum then error("M1 Damage maximum is below the configured target; batch stopped.", 0) end
                        upgradeTo(slot, "Damage", damage.level + 1)
                    else
                        -- Damage is ready; keep this copy in M1 until both other stats catch up.
                        pause(CONFIG.Units.StatUpgrade.PanelSettleTime)
                    end
                end
                pause(CONFIG.Units.StatUpgrade.BeforeExitDelay)
                closeStatFocus()
                completed = completed + 1

                clearM1(slot.expectedName)
                pause(CONFIG.Units.UISettleTime)
                local nextEntry = readStableEntry(entry.slot)
                if nextEntry.name ~= "" and nextEntry.name ~= entry.name then
                    return "Stopped: selected hotbar slot " .. entry.slot .. " changed. Completed " .. completed .. " units."
                end
                if nextEntry.name == entry.name and nextEntry.count > current.count then
                    error("Hotbar stack grew unexpectedly after pickup; remaining originals are unverified.", 0)
                end
                if nextEntry.name == entry.name and nextEntry.count == current.count and copy < entry.count then
                    -- Name/count cannot prove the next selection is a different original copy.
                    local remaining = entry.count - copy
                    unverifiedCopies = unverifiedCopies + remaining
                    logWarning(string.format("[Hotbar Upgrades] Slot %d: %d stacked copies remain unverified because the checked unit returned to the same stack. Continuing other selected slots.", entry.slot, remaining))
                    logHotbarIdentity(entry.slot)
                    break
                end
            end
        end
        if unverifiedCopies > 0 then
            error(string.format("Incomplete: verified %d units as Unreal with all upgrade goals met; %d stacked copies could not be distinguished from returned units. Remaining selected slots were checked.", completed, unverifiedCopies), 0)
        end
        return string.format("Finished %d verified units across %d selected hotbar slots: Unreal; Speed/Mining max; Damage %d.", completed, #queue, target)
    end
    modules.hotbarUpgrade = {
        page = page, run = runBatch,
        cleanup = function()
            for _, connection in ipairs(optionConnections) do connection:Disconnect() end
            table.clear(optionConnections)
            table.clear(optionRenderers)
        end,
        setBusy = function(running)
            local ownRun = running and activeRun == "hotbarUpgrade"
            local available = not running
            run.Active, run.AutoButtonColor = available or ownRun, available or ownRun
            run.Text = ownRun and "Stop Upgrades" or page.runText
            run.BackgroundColor3 = ownRun and Color3.fromRGB(165, 67, 79) or (available and colors.accent or colors.idle)
            dropdown.Active, refresh.Active = available, available
            dropdown.AutoButtonColor, refresh.AutoButtonColor = available, available
            if running then setDropdownVisible(false) end
        end,
    }
end

modules.upgradingUnit = {cleanup = cleanupStatFocus, run = function()
    local zoneId = getCycleZone()
    if cycleUnitUpgradeReadyZone ~= zoneId then
        local reason = unitSequenceCooldownReason()
        if reason then return "Skipped: " .. reason end
        beginUnitSequence(zoneId)
    end
    cycleUnitUpgradeReadyZone = nil
    local densityLevel = modules.upgrades.getDensity()
    if type(densityLevel) ~= "number" or densityLevel ~= densityLevel or densityLevel < 0
        or densityLevel % 1 ~= 0 or densityLevel == math.huge then
        error("Cached zone density must be a finite nonnegative whole number.", 0)
    end
    local plot = getMyPlot()
    checkPlot(plot)
    closeStatFocus()
    stageSpeedRequests, stageMiningRequests = 0, 0
    local cache = {}
    local damageResult = upgradeZoneDamage(plot, zoneId, densityLevel, cache)
    pause(CONFIG.Units.StatUpgrade.PanelSettleTime)
    local count, _, _, ready = upgradeDisplayedStats(plot, cache)
    return damageResult .. string.format(" Stats catch-up: %d displayed units at Damage level %d+; sent %d Speed and %d MineSpeed requests across all rounds; %s.",
        count, CONFIG.Units.StatUpgrade.MinimumDamageLevel, stageSpeedRequests, stageMiningRequests,
        ready and "caught up" or "waiting for available catch-up upgrades")
end}
end

do
-- Keep tutorial setup within its own compiler register budget as well.
(function()
local NODE_CLICK_INTERVAL = 0.15
local plots = workspace:WaitForChild("MineWorld"):WaitForChild("Plots")
local enabled = false
local running = false
local closed = false
local ignoreUiUntil = 0
local miningConnections = {}
local function clearMiningConnections()
    for _, connection in ipairs(miningConnections) do connection:Disconnect() end
    table.clear(miningConnections)
end
local statusLabel = {Text = "Ready"}
local button = {}
local function setEnabled(value, message)
    if closed then
        return
    end
    enabled = value
    statusLabel.Text = message or (value and "Mining: ON" or "Ready")
    statusLabel.TextColor3 = value and Color3.fromRGB(119, 213, 167) or colors.muted
    button.Text = value and "Stop Stage 1" or "Start Stage 1"
    button.BackgroundColor3 = value and Color3.fromRGB(156, 65, 79) or colors.accent
end

local function getTargetPart(target)
    if target:IsA("BasePart") then
        return target
    end
    if target:IsA("Model") then
        return target.PrimaryPart
            or target:FindFirstChildWhichIsA("BasePart", true)
    end
    return target:FindFirstChildWhichIsA("BasePart", true)
end

local function chooseTarget(nodes)
    local selected, detector, lowest = nil, nil, math.huge
    for _, child in ipairs(nodes:GetChildren()) do
        local number = tonumber(child.Name:match("^Node(%d+)$"))
        local clickDetector = child:FindFirstChild("NodeClick", true)
        if number and number < lowest and clickDetector and clickDetector:IsA("ClickDetector") then
            selected, detector, lowest = child, clickDetector, number
        end
    end
    return selected, detector
end

local function mine()
    if closed or running then return end
    clearMiningConnections()
    running = true
    local plot, nodes, target, detector
    local initialCount
    local countDecreased = false
    local nextClick = 0

    local function checkCount()
        if nodes and initialCount and #nodes:GetChildren() < initialCount then
            countDecreased = true
        end
        return countDecreased
    end
    local function finish()
        setEnabled(false, "Done: Nodes child count decreased")
        ignoreUiUntil = 0
    end

    local ok, reason = pcall(function()
        assert(type(fireclickdetector) == "function", "Tutorial mining requires fireclickdetector")
        while enabled and not closed do
            checkAlive()
            if not plot then
                for _, candidate in ipairs(plots:GetChildren()) do
                    if tonumber(candidate:GetAttribute("OwnerUserId")) == player.UserId then
                        plot = candidate
                        break
                    end
                end
            end
            if plot then
                assert(plot.Parent == plots and tonumber(plot:GetAttribute("OwnerUserId")) == player.UserId,
                    "Plot ownership changed")
                if not nodes then
                    nodes = plot:FindFirstChild("Nodes")
                    if nodes then
                        -- Latch a decrease even if a replacement is added before the next frame.
                        miningConnections[#miningConnections + 1] = nodes.ChildRemoved:Connect(checkCount)
                    end
                end
                if nodes then
                    assert(plot:FindFirstChild("Nodes") == nodes and nodes:IsDescendantOf(workspace),
                        "Nodes folder changed; restart the mining stage")
                    if checkCount() then finish(); break end
                    if not target or target.Parent ~= nodes or not detector or not detector.Parent
                        or not detector:IsDescendantOf(target) then
                        target, detector = chooseTarget(nodes)
                        if target and not initialCount then initialCount = #nodes:GetChildren() end
                    end
                    if target and detector and os.clock() >= nextClick then
                        setEnabled(true, "Mining: " .. target.Name)
                        checkAlive()
                        pcall(function() fireclickdetector(detector) end)
                        nextClick = os.clock() + NODE_CLICK_INTERVAL
                    elseif not target then
                        setEnabled(true, "Waiting for a node...")
                    end
                    if checkCount() then finish(); break end
                else
                    setEnabled(true, "Waiting for Nodes...")
                end
            else
                setEnabled(true, "Waiting for your owned plot...")
            end
            task.wait()
        end
    end)
    clearMiningConnections()
    running = false
    if not ok then
        setEnabled(false, "Mining failed: " .. tostring(reason))
        error(reason, 0)
    end
end

local ACTION_TIMEOUT = 12
-- Seconds around game UI transitions; Stop remains responsive during delays.
local UI_TIMING = {
    BeforeOpen = 0.25,
    AfterOpen = 0.75,
    BeforeClose = 0.25,
    AfterClose = 0.75,
    AfterTab = 0.35,
    ChestMinimumHold = 2.0, -- Hold E at least this long when opening the tutorial chest.
    ChestHoldPadding = 0.5, -- Extra time after the minimum or prompt HoldDuration.
}
local flowActive = false
local pendingConfirmation = false
local confirmed = false
local heldKey
local heldPrompt
local playerGui = player:WaitForChild("PlayerGui")
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")

local flowStatus = pages.tutorial.status
local confirmButton = setmetatable({}, {__newindex = function(_, key, value)
    if key == "Visible" then
        pages.tutorial.run.Text = value and "Confirm & continue" or "Stop tutorial"
    end
end})
local function checkFlow()
    checkAlive()
    if closed or not flowActive then error("Stopped", 0) end
end
local function pause(seconds)
    local deadline = os.clock() + seconds
    repeat checkFlow(); task.wait(0.05) until os.clock() >= deadline
    checkFlow()
end
local function waitFor(label, predicate, timeout)
    flowStatus.Text = label
    local deadline = os.clock() + (timeout or ACTION_TIMEOUT)
    repeat
        checkFlow()
        local value = predicate()
        if value then return value end
        task.wait(0.05)
    until os.clock() >= deadline
    error("Timed out: " .. label, 0)
end
local function path(root, names)
    local current = root
    for _, name in ipairs(names) do
        current = current and current:FindFirstChild(name)
    end
    return current
end
local function ui(...)
    return path(playerGui, {"MineGui", ...})
end
local function visible(object)
    if not object or not object:IsDescendantOf(playerGui) then return false end
    local current = object
    while current and current ~= playerGui do
        if current:IsA("GuiObject") and not current.Visible then return false end
        if current:IsA("LayerCollector") and not current.Enabled then return false end
        current = current.Parent
    end
    return true
end
local function click(object)
    checkFlow()
    assert(object and visible(object), "Click target is missing or hidden")
    local target = object:IsA("GuiButton") and object or nil
    if not target then
        for _, child in ipairs(object:GetDescendants()) do
            if child:IsA("GuiButton") and visible(child) then
                assert(not target, "Ambiguous buttons in " .. object:GetFullName())
                target = child
            end
        end
    end
    assert(target and target.Active, "Button is unavailable: " .. object:GetFullName())
    assert(type(firesignal) == "function", "firesignal is required")
    local event = "MouseButton1Click"
    if type(getconnections) == "function" then
        for _, name in ipairs({"Activated", "MouseButton1Click"}) do
            local ok, handlers = pcall(getconnections, target[name])
            local found = false
            if ok and type(handlers) == "table" then
                for _, handler in pairs(handlers) do
                    if handler.Enabled ~= false then found = true; break end
                end
            end
            if found then event = name; break end
        end
    end
    checkFlow()
    ignoreUiUntil = os.clock() + 0.2
    if event == "Activated" then firesignal(target.Activated, nil, 1)
    else firesignal(target.MouseButton1Click) end
end
local function releaseInputs()
    if heldPrompt then
        pcall(function() heldPrompt:InputHoldEnd() end)
        heldPrompt = nil
    end
    if heldKey then
        pcall(function() VIM:SendKeyEvent(false, heldKey, false, game) end)
        heldKey = nil
    end
end
local function ownedPlot()
    return waitFor("Waiting for your owned plot", function()
        for _, candidate in ipairs(plots:GetChildren()) do
            if tonumber(candidate:GetAttribute("OwnerUserId")) == player.UserId then return candidate end
        end
        return nil
    end)
end
local function validatePlot(plot)
    checkFlow()
    assert(plot.Parent == plots and tonumber(plot:GetAttribute("OwnerUserId")) == player.UserId,
        "Plot ownership changed; restart the stage")
end
local function rootPart()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    assert(root and humanoid and humanoid.Health > 0, "Character is not ready")
    return root
end
local function teleport(target)
    checkFlow()
    assert(target, "Teleport target is missing")
    local cf, size
    if target:IsA("BasePart") then cf, size = target.CFrame, target.Size
    elseif target:IsA("Model") then cf, size = target:GetBoundingBox()
    else
        local part = getTargetPart(target)
        assert(part, "Teleport target has no BasePart")
        cf, size = part.CFrame, part.Size
    end
    -- Top of the rotated bounds plus clearance for the character's feet.
    local halfHeight = (math.abs(cf.RightVector.Y) * size.X
        + math.abs(cf.UpVector.Y) * size.Y + math.abs(cf.LookVector.Y) * size.Z) / 2
    local destination = cf.Position + Vector3.new(0, halfHeight + 3.5, 0)
    local root = rootPart()
    root.CFrame = CFrame.new(destination) * cf.Rotation
    root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
    waitFor("Confirming teleport", function()
        return root == rootPart() and (root.Position - destination).Magnitude < 3
    end)
    pause(0.35)
end
local function promptUnder(target, preferred)
    return waitFor("Waiting for E proximity prompt", function()
        if not target or not target.Parent then return nil end
        if preferred then
            local match = target:FindFirstChild(preferred, true)
            if match and match:IsA("ProximityPrompt") and match.Enabled then return match end
        end
        local selected
        for _, item in ipairs(target:GetDescendants()) do
            if item:IsA("ProximityPrompt") and item.Enabled then
                assert(not selected, "Multiple prompts; specify the intended prompt name")
                selected = item
            end
        end
        return selected
    end)
end
local function pressE(prompt, minimumHold, holdPadding)
    checkFlow()
    assert(not UIS:GetFocusedTextBox(), "Leave the text field before pressing E")
    assert(prompt.Enabled and prompt.KeyboardKeyCode == Enum.KeyCode.E, "Expected an enabled E prompt")
    local parent = prompt.Parent
    local position = parent:IsA("Attachment") and parent.WorldPosition
        or (getTargetPart(parent) and getTargetPart(parent).Position)
    assert(position and (rootPart().Position - position).Magnitude <= prompt.MaxActivationDistance,
        "Outside prompt range; adjust teleport clearance")
    heldKey = Enum.KeyCode.E
    VIM:SendKeyEvent(true, heldKey, false, game)
    pause(math.max(prompt.HoldDuration, minimumHold or 0) + (holdPadding or 0.15))
    releaseInputs()
end
-- Unknown UI state never silently passes: allow an explicit in-game confirmation.
-- This is used only when the game's supplied paths expose no reliable receipt.
local function confirmResult(label, predicate)
    flowStatus.Text = label
    local deadline = os.clock() + ACTION_TIMEOUT
    while predicate and os.clock() < deadline do
        checkFlow()
        if predicate() then return end
        task.wait(0.05)
    end
    confirmed, pendingConfirmation = false, true
    confirmButton.Visible = true
    flowStatus.Text = label .. " — verify in game, then Confirm & continue (or Stop)."
    while not confirmed do checkFlow(); task.wait(0.05) end
    pendingConfirmation = false
    confirmButton.Visible = false
end
local function snapshotText(object)
    local result = {}
    if object then
        for _, child in ipairs(object:GetDescendants()) do
            if child:IsA("TextLabel") or child:IsA("TextButton") then
                table.insert(result, child:GetFullName() .. "=" .. child.Text)
            end
        end
    end
    table.sort(result)
    return table.concat(result, "|")
end
local function readFirstHotbarUnit()
    local content = ui("HotbarFrame", "Content", "Container", "1", "ItemFrame", "Content")
    local function text(name)
        local label = content and content:FindFirstChild(name)
        return label and label.Text:gsub("<[^>]*>", ""):match("^%s*(.-)%s*$") or ""
    end
    local name, countText = text("ItemName"), text("ActualItemCount")
    local count = 0
    if name ~= "" then
        count = countText == "" and 1 or tonumber(countText:gsub(",", ""):match("^[xX]?%s*(%d+)$"))
        assert(count and count < math.huge, "Unreadable hotbar 1 ActualItemCount")
    end
    return {name = name, count = count}
end
local function selectHotbarUnit(slot)
    -- Match main.luau's placeIntoM1: reset equipment, validate the source,
    -- hold the hotbar number key for 0.05s, then allow 0.3s to equip.
    assert(not UIS:GetFocusedTextBox(), "Leave the text field before selecting hotbar 1")
    checkFlow()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    assert(humanoid and humanoid.Health > 0, "Character is not ready")
    humanoid:UnequipTools()
    local label = path(slot, {"ItemFrame", "Content", "ItemName"})
    assert(label and label.Text:match("%S"), "Hotbar slot 1 has no unit")
    local name = label.Text
    checkFlow()
    heldKey = Enum.KeyCode.One
    VIM:SendKeyEvent(true, heldKey, false, game)
    pause(0.05)
    releaseInputs()
    pause(0.3)
    assert(path(slot, {"ItemFrame", "Content", "ItemName"}) == label and label.Text == name,
        "Hotbar slot 1 changed while equipping; stopped before placement")
end
local actions = {}
actions[0] = function()
    modules.gameSettings.apply(checkFlow, flowStatus)
end
local function tutorialChestCloseTarget()
    local frame = ui("ChestFrame")
    if not frame then return nil end
    for _, names in ipairs({{"Content", "Actions", "Close"}, {"Content", "Actions", "CloseButton"},
        {"CloseButton"}, {"ExitButton"}, {"Close"}}) do
        local candidate = path(frame, names)
        if candidate and visible(candidate) then return candidate end
    end
    local found
    for _, candidate in ipairs(frame:GetDescendants()) do
        local name = candidate.Name:lower():gsub("[%s%p]", "")
        if candidate:IsA("GuiButton") and visible(candidate)
            and (name == "close" or name == "closebutton" or name == "exit" or name == "exitbutton"
                or candidate:IsA("TextButton") and candidate.Text:match("^%s*[xX×]%s*$")) then
            assert(not found, "Multiple chest close buttons found")
            found = candidate
        end
    end
    return found
end
local function useTutorialChest(takeLoot)
    local retryPrompt, lootRequested = false, false
    while true do
        checkFlow()
        local ok, message = pcall(function()
            local plot = ownedPlot()
            local base = waitFor("Waiting for tutorial ChestBase", function()
                return path(plot, {"Chest", "ChestBase"})
            end)
            validatePlot(plot)
            teleport(base)
            if retryPrompt or not visible(ui("ChestFrame")) then
                pause(UI_TIMING.BeforeOpen)
                local prompt = promptUnder(plot:FindFirstChild("Chest"))
                validatePlot(plot)
                checkFlow()
                -- Simulate the prompt directly, as the normal shop/holder flows do.
                heldPrompt = prompt
                prompt:InputHoldBegin()
                pause(math.max(prompt.HoldDuration, UI_TIMING.ChestMinimumHold) + UI_TIMING.ChestHoldPadding)
                releaseInputs()
                waitFor("Confirming tutorial chest opened", function() return visible(ui("ChestFrame")) end)
            end
            pause(UI_TIMING.AfterOpen)
            if takeLoot and not lootRequested then
                validatePlot(plot)
                checkFlow()
                flowStatus.Text = "Taking tutorial chest contents..."
                getGameEvent():FireServer("MineTakeChest")
                lootRequested = true -- A close error must not repeat a successful collection request.
                pause(CONFIG.Sell.ChestDelay)
            end
            if visible(ui("ChestFrame")) then
                local close = waitFor("Waiting for tutorial chest close button", tutorialChestCloseTarget)
                pause(UI_TIMING.BeforeClose)
                click(close)
                waitFor("Confirming tutorial chest closed", function() return not visible(ui("ChestFrame")) end)
            end
            pause(UI_TIMING.AfterClose)
        end)
        checkFlow() -- Stop/unload must leave the retry loop immediately.
        if ok then return end
        releaseInputs()
        retryPrompt = true
        flowStatus.Text = "Chest error; retrying its proximity prompt: " .. tostring(message)
        warn("[MineStageBrowser] Tutorial chest retry:", message)
        pause(0.5)
    end
end
actions[2] = function()
    useTutorialChest(true)
end
actions[3] = function()
    local plot = ownedPlot()
    local holder = waitFor("Waiting for M1", function() return path(plot, {"Holders", "M1"}) end)
    local character, root = player.Character, rootPart()
    local function prompt()
        validatePlot(plot)
        assert(player.Character == character and root:IsDescendantOf(character), "Character changed during placement")
        assert(holder.Parent == plot:FindFirstChild("Holders"), "M1 was replaced during placement")
        local current = path(holder, {"Pad", "HolderPrompt"})
        assert(current and current:IsA("ProximityPrompt"), "M1 Pad.HolderPrompt is missing")
        return current
    end
    local function action()
        return prompt().ActionText:lower():gsub("[%s%p]", "")
    end
    local function occupied() return action() == "pickup" end
    local function consumed(source)
        local remaining = readFirstHotbarUnit()
        return remaining.name == "" or remaining.name == source.name and remaining.count < source.count
    end
    if occupied() then
        flowStatus.Text = "M1 is already occupied; skipping placement"
        return
    end
    if visible(ui("SlotFocusFrame")) then
        pause(UI_TIMING.BeforeClose)
        click(ui("SlotFocusFrame", "ExitButton"))
        waitFor("Closing unit panel before placement", function() return not visible(ui("SlotFocusFrame")) end)
        pause(UI_TIMING.AfterClose)
    end
    local slot = waitFor("Waiting for hotbar slot 1", function()
        return ui("HotbarFrame", "Content", "Container", "1")
    end)
    local latest, stableSince
    local source = waitFor("Waiting for hotbar 1 to settle", function()
        local current = readFirstHotbarUnit()
        if not latest or latest.name ~= current.name or latest.count ~= current.count then
            latest, stableSince = current, os.clock()
        end
        return os.clock() - stableSince >= 0.2 and current
    end)
    assert(source.name ~= "" and source.count > 0, "Hotbar slot 1 has no unit")
    local placementRequested = false
    for attempt = 1, 4 do
        if occupied() then
            if not placementRequested then
                flowStatus.Text = "M1 is already occupied; skipping placement"
                return
            end
            waitFor("Confirming hotbar 1 supplied the placed unit", function() return consumed(source) end)
            return
        end
        local current = readFirstHotbarUnit()
        assert(current.name == source.name and current.count == source.count,
            "Hotbar slot 1 changed before placement")
        -- Preserve the requested order on each attempt: select -> teleport -> place.
        flowStatus.Text = "Selecting hotbar 1; placement attempt " .. attempt .. "/4"
        slot = ui("HotbarFrame", "Content", "Container", "1")
        selectHotbarUnit(slot)
        validatePlot(plot)
        local base = holder:FindFirstChild("Pad")
        if not base or not base:IsA("BasePart") then base = holder:FindFirstChild("UpgradePart") end
        assert(base and base:IsA("BasePart"), "M1 placement base is missing")
        root.CFrame = CFrame.new(base.Position + Vector3.new(0, 3, 0), base.Position)
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        pause(0.35)
        local deadline = os.clock() + ACTION_TIMEOUT
        local currentPrompt = prompt()
        while not occupied() and not currentPrompt.Enabled and os.clock() < deadline do
            pause(0.05)
            currentPrompt = prompt()
        end
        if not occupied() and currentPrompt.Enabled then
            current = readFirstHotbarUnit()
            assert(current.name == source.name and current.count == source.count,
                "Hotbar slot 1 changed while equipping")
            assert(not action():match("^unlock") and not action():match("^locked"), "M1 is locked")
            -- main.luau activates HolderPrompt directly instead of sending E.
            -- Pair Begin/End and release on Stop/error/unload as well.
            flowStatus.Text = "Activating M1 HolderPrompt"
            heldPrompt = currentPrompt
            placementRequested = true
            currentPrompt:InputHoldBegin()
            pause(math.max(currentPrompt.HoldDuration, 0.05))
            releaseInputs()
            pause(0.6)
            deadline = os.clock() + ACTION_TIMEOUT
            while not occupied() and os.clock() < deadline do pause(0.05) end
        end
        if occupied() then
            if not placementRequested then
                flowStatus.Text = "M1 is already occupied; skipping placement"
                return
            end
            waitFor("Confirming hotbar 1 supplied the placed unit", function() return consumed(source) end)
            return
        end
        if attempt < 4 then pause(0.35) end
    end
    error("M1 placement failed after 4 attempts; HolderPrompt.ActionText=" .. prompt().ActionText, 0)
end
actions[1] = function()
    setEnabled(true)
    mine() -- Stages 1 and 4 stop only after the Nodes child count decreases.
    checkFlow()
    assert(statusLabel.Text:match("^Done:"), "Mining stage ended without confirming a Nodes child-count decrease")
end
local function teleportButtonTo(destination)
    local reportRetry = newRetryMonitor("Tutorial TeleportButton to " .. destination)
    while true do
        checkFlow()
        local ok, moved = pcall(function()
            pause(UI_TIMING.BeforeClose)
            local mine = playerGui:FindFirstChild("MineGui")
            local button = mine and mine:FindFirstChild("TeleportButton")
            assert(button, "TeleportButton is not available yet.")
            local character, root = player.Character, rootPart()
            -- Match startup: only this click's movement of the same character counts.
            local before = root.Position
            checkFlow()
            ignoreUiUntil = os.clock() + 0.2
            clickButton(button)
            local deadline = os.clock() + CONFIG.General.StartupTeleportClickInterval
            flowStatus.Text = "Confirming teleport to " .. destination
            while true do
                checkFlow()
                if player.Character ~= character or root ~= rootPart()
                    or root.Parent ~= character or not root:IsDescendantOf(workspace) then return false end
                if (root.Position - before).Magnitude > CONFIG.General.StartupTeleportMinDistance then
                    return true
                end
                if os.clock() >= deadline then return false end
                pause(CONFIG.General.WaitPoll)
            end
        end)
        checkFlow() -- Stop/unload must escape the retry loop, including after recovery.
        if ok and moved then
            pause(CONFIG.Sell.TeleportDelay)
            -- Keep destination validation separate from chest recovery movement.
            local anchor
            if destination == "Base" then anchor = path(ownedPlot(), {"Chest", "ChestBase"})
            else anchor = workspace:FindFirstChild("SellStand") end
            local target = anchor and getTargetPart(anchor)
            assert(target and (rootPart().Position - target.Position).Magnitude < 250,
                "TeleportButton did not reach " .. destination .. "; check starting location")
            reportRetry(nil, true)
            return
        end
        reportRetry(not ok and moved or "TeleportButton has not moved your character.")
        flowStatus.Text = "TeleportButton unavailable/unresponsive; refreshing the UI through your chest..."
        -- The failed baseline is out of scope before recovery moves the character.
        -- Shared startup recovery opens/closes the chest and restores the starting position.
        local recovered, message = pcall(recoverUnitPanelThroughChest, checkFlow, "Tutorial TeleportButton recovery")
        checkFlow()
        if not recovered then reportRetry(message) end
        pause(CONFIG.General.RetryInterval)
    end
end
actions[4] = actions[1] -- Fresh node-count baseline for the second mining stage.
actions[5] = function()
    teleportButtonTo("Shops")
    local stand = waitFor("Waiting for SellStand", function() return workspace:FindFirstChild("SellStand") end)
    -- Match the sell stage's positioning and direct prompt activation.
    local lastRetryAngle
    local function visibleSellFrame()
        checkFlow()
        return visible(ui("SellFrame"))
    end
    local function openSellStand(isRetry)
        checkFlow()
        if visibleSellFrame() then return end
        stand = workspace:FindFirstChild("SellStand")
        assert(stand, "SellStand is missing.")
        local standPart = stand:IsA("BasePart") and stand
            or (stand.PrimaryPart or stand:FindFirstChildWhichIsA("BasePart"))
        assert(standPart, "SellStand has no BasePart.")
        local root = rootPart()
        local standPos = standPart.Position
        local facing = standPart.CFrame.LookVector
        local offset = Vector3.zero
        if isRetry then
            local angle = math.random(0, 359)
            if angle == lastRetryAngle then angle = (angle + 1) % 360 end
            lastRetryAngle = angle
            local radians = math.rad(angle)
            offset = Vector3.new(math.cos(radians), 0, math.sin(radians))
        end
        local standSpot = standPos - facing * CONFIG.Sell.StandDistance
            + Vector3.new(0, CONFIG.Sell.StandHeight, 0) + offset
        root.CFrame = CFrame.new(standSpot, standPos)
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        local camera = workspace.CurrentCamera
        if camera then
            camera.CFrame = CFrame.new(standSpot + Vector3.new(0, CONFIG.Sell.CameraHeight, 0), standPos)
        end
        pause(CONFIG.Sell.StandDelay)
        for _, prompt in ipairs(stand:GetDescendants()) do
            checkFlow()
            if visibleSellFrame() then return end
            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                heldPrompt = prompt
                prompt:InputHoldBegin()
                pause(math.max(CONFIG.Sell.PromptHold, prompt.HoldDuration))
                releaseInputs()
                pause(CONFIG.Sell.PromptDelay)
            end
        end
    end
    pause(UI_TIMING.BeforeOpen)
    openSellStand(false)
    flowStatus.Text = "Confirming sell UI opened"
    waitUntil(visibleSellFrame, CONFIG.Sell.ShopTimeout, "Confirming sell UI opened", function()
        openSellStand(true)
    end)
    pause(UI_TIMING.AfterOpen)
    local card = waitFor("Finding Card with LayoutOrder 1", function()
        local scroll = ui("SellFrame", "Content", "Scroll")
        local found
        for _, child in ipairs(scroll and scroll:GetChildren() or {}) do
            if child.Name == "Card" and child:IsA("GuiObject") and child.LayoutOrder == 1 and visible(child) then
                assert(not found, "Multiple Cards have LayoutOrder 1")
                found = child
            end
        end
        return found
    end)
    -- The game does not guarantee a Selected attribute/checkmark on its Cards.
    -- Match main.luau's selection settle, then click Sell once. Confirm the
    -- actual sale below rather than blocking on a guessed selection marker.
    flowStatus.Text = "Selecting sell Card with LayoutOrder 1"
    click(card)
    pause(0.6)
    local sellButton = waitFor("Waiting for SellButton after item selection", function()
        local target = ui("SellFrame", "Content", "SellButton")
        if target and visible(target) and target:IsA("GuiObject")
            and (not target:IsA("GuiButton") or target.Active)
            and target.AbsoluteSize.X > 0 and target.AbsoluteSize.Y > 0 then return target end
        return nil
    end)
    local before = snapshotText(card)
    flowStatus.Text = "Clicking SellFrame.Content.SellButton"
    click(sellButton)
    pause(1.2)
    confirmResult("Confirm the selected item sold", function()
        return not card.Parent or not visible(card) or snapshotText(card) ~= before
    end)
    teleportButtonTo("Base")
end
actions[6] = function()
    local plot = ownedPlot()
    local upgrade = waitFor("Waiting for M1 UpgradePart", function()
        return path(plot, {"Holders", "M1", "UpgradePart"})
    end)
    validatePlot(plot)
    teleport(upgrade)
    local detector = upgrade:FindFirstChild("UpgradeClick") or upgrade:FindFirstChildWhichIsA("ClickDetector")
    assert(detector and detector.MaxActivationDistance > 0, "M1 UpgradeClick is unavailable")
    assert((rootPart().Position - upgrade.Position).Magnitude <= detector.MaxActivationDistance,
        "Outside UpgradeClick range")
    assert(type(fireclickdetector) == "function", "fireclickdetector is required")
    pause(UI_TIMING.BeforeOpen)
    checkFlow()
    fireclickdetector(detector)
    waitFor("Confirming unit UI opened", function() return visible(ui("SlotFocusFrame")) end)
    pause(UI_TIMING.AfterOpen)
    click(ui("SlotFocusFrame", "Tabs", "StatsTab"))
    waitFor("Confirming Stats opened", function()
        return visible(ui("SlotFocusFrame", "BottomPanels", "StatsPanel"))
    end)
    pause(UI_TIMING.AfterTab)
    local function level()
        local label = ui("SlotFocusFrame", "BottomPanels", "StatsPanel", "Scroll", "Damage", "LevelTitle")
        return label and tonumber(label.Text:gsub("<[^>]*>", ""):match("Level%s+(%d+)"))
    end
    local before = level()
    assert(before, "Cannot read Damage.LevelTitle; no upgrade sent")
    click(ui("SlotFocusFrame", "BottomPanels", "StatsPanel", "Scroll", "Damage", "UpgradeButton"))
    waitFor("Confirming Damage level increased", function() return level() and level() > before end)
    pause(UI_TIMING.BeforeClose)
    click(ui("SlotFocusFrame", "ExitButton"))
    waitFor("Confirming unit UI closed", function() return not visible(ui("SlotFocusFrame")) end)
    pause(UI_TIMING.AfterClose)
end
actions[7] = function()
    local function depositNode()
        return ui("SkillTreeFullFrame", "Tree", "Canvas", "Zone_Z1", "Node_Deposits1")
    end
    local function readPips()
        -- Reacquire the exact node on every read because a purchase can rebuild
        -- the tree. Never use another node's Pips as purchase confirmation.
        local label = path(depositNode(), {"Content", "Pips"})
        if not label then return nil end
        local text = label.Text:gsub("<[^>]*>", "")
        local current, maximum = text:match("^%s*(%d+)%s*/%s*(%d+)%s*$")
        current, maximum = tonumber(current), tonumber(maximum)
        if current and maximum and maximum > 0 and current <= maximum then
            return {current = current, maximum = maximum}
        end
        return nil
    end
    local function exitSkillTree()
        pause(UI_TIMING.BeforeClose)
        click(ui("SkillTreeFullFrame", "Footer", "Close"))
        waitFor("Confirming skill tree closed", function() return not visible(ui("SkillTreeFullFrame")) end)
        pause(UI_TIMING.AfterClose)
    end
    local function refreshUpgradesThroughChest()
        useTutorialChest(false)
    end
    local needsChestRefresh = false
    -- Retain the first request's receipt across UI reloads. Recovery must not
    -- submit additional purchases while waiting for the same Pips increase.
    local pendingPurchase
    while true do
        checkFlow()
        local ok, result = pcall(function()
            if needsChestRefresh then
                refreshUpgradesThroughChest()
                needsChestRefresh = false
            end
            if not visible(ui("SkillTreeFullFrame")) then
                local upgrades = ui("LeftBar", "Content", "Container", "UpgradesButton")
                if not upgrades or not visible(upgrades) then
                    needsChestRefresh = true
                    flowStatus.Text = "Upgrades button missing; reloading through the chest"
                    return false
                end
                pause(UI_TIMING.BeforeOpen)
                click(upgrades)
                waitFor("Confirming skill tree opened", function() return visible(ui("SkillTreeFullFrame")) end)
                pause(UI_TIMING.AfterOpen)
            end
            local before = waitFor("Reading Z1 Node_Deposits1.Content.Pips", readPips)
            if before.current >= before.maximum or pendingPurchase
                and before.maximum == pendingPurchase.maximum and before.current > pendingPurchase.current then
                exitSkillTree()
                return true
            end
            if not pendingPurchase then
                -- Same request and arguments as main.luau.
                local event = waitFor("Waiting for Remotes.GamestateEvent", function()
                    return path(game:GetService("ReplicatedStorage"), {"Remotes", "GamestateEvent"})
                end)
                assert(event:IsA("RemoteEvent"), "GamestateEvent is not a RemoteEvent")
                before = waitFor("Confirming Deposits Pips before buying", readPips)
                if before.current >= before.maximum then exitSkillTree(); return true end
                checkFlow()
                flowStatus.Text = "Requesting Z1 Node_Deposits1 upgrade"
                event:FireServer("MineBuySkill", "Z1", "NodeCount", "Deposits1")
                pendingPurchase = before
            end
            waitFor("Confirming Node_Deposits1 Pips increased from "
                .. pendingPurchase.current .. "/" .. pendingPurchase.maximum, function()
                local after = readPips()
                return after and after.maximum == pendingPurchase.maximum and after.current > pendingPurchase.current
            end)
            exitSkillTree()
            return true
        end)
        checkFlow()
        if ok and result then return end
        if not ok then
            releaseInputs()
            needsChestRefresh = true
            flowStatus.Text = "Stage 7 will retry: " .. tostring(result)
            warn("[MineStageBrowser] Stage 7 recovery:", result)
        end
        pause(0.5)
    end
end
modules.tutorial = {
    acceptsUi = function() return os.clock() >= ignoreUiUntil end,
    pending = function() return pendingConfirmation end,
    confirm = function()
        if pendingConfirmation and os.clock() >= ignoreUiUntil then confirmed = true end
    end,
    cleanup = function()
        enabled, flowActive, running = false, false, false
        pendingConfirmation, confirmed = false, false
        clearMiningConnections()
        releaseInputs()
    end,
    run = function()
        assert(not preferences.tutorialHidden, "Tutorial has already been completed.")
        flowActive = true
        for id = 0, 7 do
            checkFlow()
            flowStatus.Text = "Running tutorial Stage " .. id
            actions[id]()
            checkFlow()
            if id ~= 1 and id ~= 4 then pause(0.3) end
        end
        return "Tutorial stages 0–7 completed. Game settings were checked live."
    end,
}
end)()
end

-- Trade workers are independent of each other and the main stage runner.
do
(function()
local CONFIG = CONFIG.Trade
local presetsByName = {}
local contexts = {}
local autoIndexTradeFrame
local autoIndexHasOffers, autoIndexTradeReady, autoIndexRetryAt = false, false, 0
local watchIndexFrame
local resumeIndexPreset
local accept = button(minimizedControls, "Auto Accept Trade: OFF", UDim2.fromOffset(0, 98), UDim2.new(1, 0, 0, 26))
accept.Name, accept.TextSize = "AcceptTradeToggle", 11
local status = {accept = minimizedActions.newStatus(""), preset = minimizedActions.newStatus("")}

local function path(root, names)
    for _, name in ipairs(names) do
        root = root and root:FindFirstChild(name)
        if not root then return nil end
    end
    return root
end

local function visible(object)
    if not object or not object:IsDescendantOf(playerGui) then return false end
    while object and object ~= playerGui do
        if object:IsA("GuiObject") and not object.Visible then return false end
        if object:IsA("LayerCollector") and not object.Enabled then return false end
        object = object.Parent
    end
    return true
end

local function colorIs(color, r, g, b)
    return math.floor(color.R * 255 + 0.5) == r
        and math.floor(color.G * 255 + 0.5) == g
        and math.floor(color.B * 255 + 0.5) == b
end

local function guard(ctx)
    if not alive or contexts[ctx.kind] ~= ctx or ctx.cancelled then error("Trade action stopped.", 0) end
    if ctx.presetTradeFrame and (path(playerGui, {"MineGui", "TradeFrame"}) ~= ctx.presetTradeFrame
        or not ctx.presetTradeFrame.Visible) then
        error("Trade closed or TradeFrame was replaced while placing the preset. Run again.", 0)
    end
end

local function setStatus(ctx, message)
    guard(ctx)
    -- A background poll must not continually replace a preset's progress message.
    if status[ctx.kind].Text ~= message then status[ctx.kind].Text = message end
end

local function log(message, level, ctx)
    if level == "DEBUG" and not CONFIG.VerboseLogs then return end
    if not CONFIG.ConsoleLogs and level ~= "ERROR" then return end
    if level == "ERROR" then logError(ctx.kind == "accept" and "Auto Accept Trade" or "Trade Preset", message)
    else logInfo(ctx.kind == "accept" and "Auto Accept Trade" or "Trade Preset", message) end
end
local function logChanged(ctx, key, message, level)
    ctx.logStates = ctx.logStates or {}
    if ctx.logStates[key] ~= message then
        ctx.logStates[key] = message
        log(message, level or "DEBUG", ctx)
    end
end
local function logRetry(ctx, key, message, level)
    ctx.logTimes = ctx.logTimes or {}
    local now = os.clock()
    if not ctx.logTimes[key] or now - ctx.logTimes[key] >= CONFIG.LogRepeatInterval then
        ctx.logTimes[key] = now
        log(message, level or "RETRY", ctx)
    end
end

local function clickButton(ctx, object, watchGreen, beforeClick)
    guard(ctx)
    assert(type(firesignal) == "function", "Volt firesignal is required.")
    assert(object, "Click target is missing.")
    local target = object:IsA("GuiButton") and object or nil
    if not target then
        for _, child in ipairs(object:GetDescendants()) do
            if child:IsA("GuiButton") and visible(child) then
                assert(not target, "Multiple buttons inside " .. object:GetFullName())
                target = child
            end
        end
    end
    assert(target, "No clickable button inside " .. object:GetFullName())
    assert(visible(target), "Button is hidden: " .. target:GetFullName())
    local eventName = CONFIG.DefaultClickEvent
    if type(getconnections) == "function" then
        for _, name in ipairs({"Activated", "MouseButton1Click"}) do
            local ok, handlers = pcall(getconnections, target[name])
            local found = false
            if ok and type(handlers) == "table" then
                for _, handler in pairs(handlers) do
                    if handler.Enabled ~= false then found = true; break end
                end
            end
            if found then eventName = name; break end
        end
    end
    guard(ctx)
    logChanged(ctx, "click:" .. target:GetFullName(), "Click: " .. target:GetFullName() .. "; signal=" .. eventName
        .. "; Visible=" .. tostring(target.Visible) .. "; effectiveVisible=" .. tostring(visible(target)))
    if beforeClick and not beforeClick() then return false end
    if eventName == "Activated" then firesignal(target.Activated, nil, 1)
    else firesignal(target.MouseButton1Click) end
    return true
end


local function releasePresetInput(ctx)
    if ctx.mouseDown then
        local input = game:GetService("VirtualInputManager")
        input:SendMouseMoveEvent(0, 0, game)
        input:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        ctx.mouseDown = false
    end
    if ctx.controlsEnabled ~= nil then
        if gui.Parent then gui.Enabled = ctx.controlsEnabled end
        ctx.controlsEnabled = nil
    end
end

local function runAcceptTrade(ctx)
    assert(type(firesignal) == "function", "Volt firesignal is required.")
    local nextAccept, nextReady = 0, 0
    while true do
        guard(ctx)
        -- Start a cached index queue before Auto Accept can ready this trade.
        local indexPending = resumeIndexPreset()
        -- Pause both Accept and Ready while the preset is placing its items.
        if not contexts.preset then
            -- Resolve fresh instances on every poll so new requests and recreated panels work.
            local requestFrame = path(playerGui, {"MineGui", "TradeRequestFrame"})
            local tradeFrame = path(playerGui, {"MineGui", "TradeFrame"})
            local requestShown = requestFrame and requestFrame:IsA("GuiObject") and visible(requestFrame)
            local tradeShown = tradeFrame and tradeFrame:IsA("GuiObject") and visible(tradeFrame)
            local accept = path(requestFrame, {"Content", "AcceptButton"})
            if requestShown and accept and accept:IsA("GuiButton") and visible(accept)
                and os.clock() >= nextAccept then
                if clickButton(ctx, accept, false, function()
                    return not contexts.preset and path(playerGui, {"MineGui", "TradeRequestFrame"}) == requestFrame
                        and path(requestFrame, {"Content", "AcceptButton"}) == accept
                        and visible(requestFrame) and visible(accept)
                end) then
                    nextAccept = os.clock() + CONFIG.TradeClickInterval
                    logRetry(ctx, "tradeAccept", "Trade request: Accept clicked.", "INFO")
                end
            end

            local ready = path(tradeFrame, {"ContentV2", "Footer", "ReadyButton"})
            local content = ready and ready:FindFirstChild("Content")
            local green = content and content:IsA("GuiObject")
                and colorIs(content.BackgroundColor3, 38, 148, 84)
            if not indexPending and not contexts.preset and tradeShown and ready and ready:IsA("GuiButton") and visible(ready)
                and green and os.clock() >= nextReady then
                if clickButton(ctx, ready, false, function()
                    return not resumeIndexPreset() and not contexts.preset
                        and path(playerGui, {"MineGui", "TradeFrame"}) == tradeFrame
                        and path(tradeFrame, {"ContentV2", "Footer", "ReadyButton"}) == ready
                        and ready:FindFirstChild("Content") == content
                        and visible(tradeFrame) and visible(ready)
                        and colorIs(content.BackgroundColor3, 38, 148, 84)
                end) then
                    nextReady = os.clock() + CONFIG.TradeClickInterval
                    logRetry(ctx, "tradeReady", "Trade: green Ready button clicked.", "INFO")
                end
            end
            setStatus(ctx, "Auto Accept Trade ON. Request: " .. (requestShown and "visible" or "hidden")
                .. ". Trade: " .. (tradeShown and (green and "Ready is green" or "waiting for green") or "hidden") .. ".")
        end
        task.wait(CONFIG.TradePoll)
    end
end

-- Place Preset flow from scripts/auto.luau; retain main UI, lowercase matching and cancellation tracking.
local function waitPreset(ctx, label, getter, timeout)
    setStatus(ctx, label)
    local deadline = timeout and os.clock() + timeout
    while true do
        guard(ctx)
        local result = getter()
        if result then return result end
        assert(not deadline or os.clock() < deadline, label .. " (timed out)")
        task.wait(CONFIG.TradeBagPoll)
    end
end

local function tradePresetCards(scroll, preset)
    local priority, cards = {}, {}
    for index, name in ipairs(preset) do
        assert(type(name) == "string" and name ~= "", "Trade preset item names must be nonempty strings.")
        name = name:lower()
        if not priority[name] then priority[name] = index end
    end
    -- Keep every matching card, even when several cards have the same ItemName.Text or Name.
    for index, card in ipairs(scroll:GetChildren()) do
        local itemName = path(card, {"Content", "ItemName"})
        if card:IsA("GuiObject") and visible(card) and itemName
            and (itemName:IsA("TextLabel") or itemName:IsA("TextButton") or itemName:IsA("TextBox"))
            and priority[itemName.Text:lower()] then
            table.insert(cards, {object = card, itemName = itemName.Text,
                priority = priority[itemName.Text:lower()], order = card.LayoutOrder, index = index})
        end
    end
    table.sort(cards, function(a, b)
        if a.priority ~= b.priority then return a.priority < b.priority end
        if a.order ~= b.order then return a.order < b.order end
        return a.index < b.index
    end)
    return cards
end

local function clickPresetTarget(ctx, target, rightInset, beforeClick)
    guard(ctx)
    assert(target and target:IsA("GuiObject") and visible(target), "Preset click target is hidden.")
    local position, size = target.AbsolutePosition, target.AbsoluteSize
    assert(size.X > 1 and size.Y > 0, "Preset click target has no usable size.")
    local insetX = rightInset and math.min(rightInset, size.X / 2) or size.X / 2
    local x = math.floor(position.X + size.X - insetX)
    local y = math.floor(position.Y + size.Y / 2)
    local screenGui = target:FindFirstAncestorWhichIsA("ScreenGui")
    if screenGui then
        local inset = game:GetService("GuiService"):GetGuiInset()
        x, y = x + inset.X, y + inset.Y
    end
    local input = game:GetService("VirtualInputManager")
    local controls = gui
    local controlsEnabled = controls and controls.Enabled
    ctx.controlsEnabled = controlsEnabled
    ctx.mouseX, ctx.mouseY = x, y
    local pressed = false
    local ok, err = pcall(function()
        if controls then controls.Enabled = false end
        input:SendMouseMoveEvent(x, y, game)
        guard(ctx)
        assert(visible(target), "Preset click target was hidden before clicking.")
        assert(not beforeClick or beforeClick(), "Preset click target changed before clicking.")
        input:SendMouseButtonEvent(x, y, 0, true, game, 0)
        pressed = true
        ctx.mouseDown = true
        task.wait(0.05)
    end)
    -- Always release the mouse, including when Stop or an input error interrupts the click.
    local released, releaseError = true, nil
    if pressed then
        released, releaseError = pcall(function()
            if not ok or not alive or ctx.cancelled or contexts[ctx.kind] ~= ctx then
                x, y = 0, 0
                input:SendMouseMoveEvent(x, y, game)
            end
            input:SendMouseButtonEvent(x, y, 0, false, game, 0)
            ctx.mouseDown = false
        end)
    end
    if controls and controls.Parent then controls.Enabled = controlsEnabled end
    ctx.controlsEnabled = nil
    if not ok then error(err, 0) end
    if not released then error(releaseError, 0) end
    guard(ctx)
    log(target.Name .. ": mouse clicked at " .. tostring(x) .. ", " .. tostring(y) .. ".", "DEBUG", ctx)
end

local function presetItemCount(text)
    if type(text) ~= "string" then return nil end
    return tonumber((text:gsub(",", ""):match("^%s*[xX]?%s*(%d+)%s*$")))
end

local function presetActualItemCount(field, requireBlankForSingle)
    if not field or not (field:IsA("TextLabel") or field:IsA("TextButton") or field:IsA("TextBox")) then return nil end
    -- Bag: hidden means one. Offer: both hidden and blank means one.
    if field.Visible == false and (not requireBlankForSingle or field.Text == "") then return 1 end
    return presetItemCount(field.Text)
end

local function presetBagAmount(entry)
    local field = path(entry.object, {"Content", "ActualItemCount"})
    local amount = presetActualItemCount(field, false)
    assert(amount and amount > 0, "Bag quantity is missing or zero for " .. entry.itemName .. ".")
    return amount
end

local function presetTargetAmount(itemName, bagAmount)
    local name = itemName:lower()
    if name == "gems" or name == "enchanted dice" or name == "summon scroll" then return bagAmount end
    return math.min(CONFIG.TradeMaxAmount, bagAmount)
end

local function selectedPresetAmount(ctx, picker, itemName, bagAmount, alreadyPlaced)
    local wanted = presetTargetAmount(itemName, bagAmount)
    local nextClick = 0
    while true do
        guard(ctx)
        local placedOrder = alreadyPlaced and alreadyPlaced()
        if placedOrder ~= nil then return wanted, placedOrder end
        assert(ctx.presetTradeFrame:FindFirstChild("AmountPick") == picker and visible(picker),
            "Amount picker closed during the slider click; Add was not clicked.")
        local value = path(picker, {"Content", "Amount", "Slider", "Knob", "Row", "Value"})
        local amount = value and value:IsA("TextLabel")
            and presetItemCount(value.Text)
        if amount == wanted then
            task.wait(CONFIG.TradePresetItemDelay)
            guard(ctx)
            assert(ctx.presetTradeFrame:FindFirstChild("AmountPick") == picker and visible(picker),
                "Amount picker closed before Add could be clicked.")
            if path(picker, {"Content", "Amount", "Slider", "Knob", "Row", "Value"}) == value
                and presetItemCount(value.Text) == wanted then return wanted end
        end
        setStatus(ctx, "Setting " .. itemName .. ": " .. tostring(amount or "?") .. "/" .. tostring(wanted)
            .. ". Retrying Track every 1s...")
        local track = path(picker, {"Content", "Amount", "Slider", "Track", "Content"})
        if track and track:IsA("GuiObject") and visible(track) and track.AbsoluteSize.X > 1
            and os.clock() >= nextClick then
            nextClick = os.clock() + CONFIG.TradeTrackRetry
            clickPresetTarget(ctx, track, CONFIG.TradeTrackRightInset, function()
                return ctx.presetTradeFrame:FindFirstChild("AmountPick") == picker and visible(picker)
                    and path(picker, {"Content", "Amount", "Slider", "Track", "Content"}) == track
                    and visible(track)
            end)
        end
        task.wait(CONFIG.TradeAddPoll)
    end
end

-- These paths come from the saved TradeFrame UI scan. Observe only our offer.
local function presetOfferState(ctx)
    guard(ctx)
    local slots = path(ctx.presetTradeFrame, {"ContentV2", "Top", "MyPane", "Body", "Slots"})
    assert(slots and slots:IsA("GuiObject") and visible(slots), "Your Offer slots are unavailable; cannot confirm Add.")
    local state = {records = {}, counts = {}}
    for _, slot in ipairs(slots:GetChildren()) do
        if slot:IsA("GuiObject") and visible(slot) then
            local name = path(slot, {"Content", "ItemName"})
            local count = path(slot, {"Content", "ActualItemCount"})
            local amount = presetActualItemCount(count, true)
            if name and (name:IsA("TextLabel") or name:IsA("TextButton") or name:IsA("TextBox"))
                and amount and amount > 0 then
                local normalized = name.Text:lower()
                local signature = normalized .. "\0" .. tostring(amount) .. "\0" .. tostring(slot.LayoutOrder)
                table.insert(state.records, {name = normalized, amount = amount, order = slot.LayoutOrder,
                    signature = signature})
                state.counts[signature] = (state.counts[signature] or 0) + 1
            end
        end
    end
    return state
end

local function findPresetOffer(ctx, itemName, amount, before)
    local after = presetOfferState(ctx)
    for _, record in ipairs(after.records) do
        if record.name == itemName:lower() and record.amount == amount
            and after.counts[record.signature] > (before.counts[record.signature] or 0) then
            return record.order
        end
    end
    return nil
end

local function confirmPresetAdd(ctx, itemName, amount, before)
    setStatus(ctx, "Confirming " .. itemName .. " in Your Offer...")
    local deadline = os.clock() + CONFIG.TradeAddConfirmTimeout
    while true do
        guard(ctx)
        local order = findPresetOffer(ctx, itemName, amount, before)
        if order ~= nil then return order end
        if os.clock() >= deadline then return nil end
        task.wait(CONFIG.TradeAddPoll)
    end
end

local function dismissPresetPicker(ctx)
    local deadline, nextClick = os.clock() + CONFIG.TradeAddConfirmTimeout, 0
    while true do
        guard(ctx)
        local picker = ctx.presetTradeFrame:FindFirstChild("AmountPick")
        if not picker or not picker.Visible then return end
        local scrim = ctx.presetTradeFrame:FindFirstChild("AmountScrim")
        assert(scrim and scrim:IsA("GuiButton") and visible(scrim), "Cannot close the previous amount picker for a card retry.")
        if os.clock() >= nextClick then
            clickButton(ctx, scrim, false, function()
                return ctx.presetTradeFrame:FindFirstChild("AmountScrim") == scrim and visible(picker) and visible(scrim)
            end)
            nextClick = os.clock() + CONFIG.TradeTrackRetry
        end
        assert(os.clock() < deadline, "The previous amount picker did not close; stop and retry the preset.")
        task.wait(CONFIG.TradeAddPoll)
    end
end

local function saveIndexPlacement(ctx, lastUnit, itemName)
    guard(ctx)
    local placed = preferences.indexPlacedUnits
    if itemName then placed[itemName:lower()] = true end
    local complete = lastUnit and placed[lastUnit] == true
    if complete then preferences.indexPlacedUnits = {} end
    if (itemName or complete) and not savePreferences() then
        -- Keep confirmed progress in memory if writing or resetting the cache fails.
        preferences.indexPlacedUnits = placed
        error("Could not save index placement progress; check executor file access.", 0)
    end
    return complete == true
end

local function runTradePreset(ctx)
    local presetKey = ctx.presetKey or CONFIG.TradePreset
    local preset = presetsByName[presetKey]
    local indexPreset = presetKey:lower() == "index"
    assert(type(preset) == "table", "Unknown trade preset: " .. tostring(presetKey))
    if #preset == 0 then
        return "Done: preset " .. presetKey .. " is empty. Fill in CONFIG[\"trade-preset\"] first."
    end
    local bag = waitPreset(ctx, "Waiting for visible BagPane (checking every 1s)...", function()
        local pane = path(playerGui, {"MineGui", "TradeFrame", "ContentV2", "BagPane"})
        local scroll = path(pane, {"Body", "Bag", "Scroll"})
        return pane and pane:IsA("GuiObject") and visible(pane) and scroll and visible(scroll) and scroll
    end)
    ctx.presetTradeFrame = path(playerGui, {"MineGui", "TradeFrame"})
    if indexPreset then
        watchIndexFrame(ctx.presetTradeFrame)
        autoIndexTradeFrame = ctx.presetTradeFrame
    end
    local cards = tradePresetCards(bag, preset)
    local lastIndexUnit, indexCycleReset = nil, false
    if indexPreset then
        -- Find the final distinct item in configured order, not the end of this 8-card batch.
        local listed = {}
        for _, itemName in ipairs(preset) do
            local name = itemName:lower()
            if not listed[name] then listed[name], lastIndexUnit = true, name end
        end
        saveIndexPlacement(ctx, lastIndexUnit)
        -- Resume across runs/trades while keeping one offered card per item name.
        local seen, unique = {}, {}
        for name, placed in pairs(preferences.indexPlacedUnits) do if placed then seen[name] = true end end
        for _, offered in ipairs(presetOfferState(ctx).records) do seen[offered.name] = true end
        for _, entry in ipairs(cards) do
            local name = entry.itemName:lower()
            if not seen[name] then
                seen[name] = true
                table.insert(unique, entry)
            end
        end
        cards = unique
    end
    local count, limit = 0, math.min(8, #cards)
    for index = 1, limit do
        local entry = cards[index]
        local bagAmount = presetBagAmount(entry)
        local wanted = indexPreset and 1 or presetTargetAmount(entry.itemName, bagAmount)
        -- Keep the baseline for this card across retries; delayed successes count once.
        local before = presetOfferState(ctx)
        local placedOrder, attempts = nil, 0
        repeat
            guard(ctx)
            placedOrder = findPresetOffer(ctx, entry.itemName, wanted, before)
            if placedOrder ~= nil then break end
            attempts = attempts + 1
            dismissPresetPicker(ctx)
            waitPreset(ctx, "Waiting for BagPane before " .. entry.itemName .. "...", function()
                local pane = path(ctx.presetTradeFrame, {"ContentV2", "BagPane"})
                return pane and visible(pane) and visible(bag)
            end)
            local itemName = path(entry.object, {"Content", "ItemName"})
            assert(entry.object.Parent == bag and itemName and itemName.Text:lower() == entry.itemName:lower(),
                "Bag card changed while placing " .. entry.itemName .. ". Run the preset again.")
            setStatus(ctx, "Selecting " .. entry.itemName .. " (" .. tostring(index) .. "/" .. tostring(limit)
                .. ", attempt " .. tostring(attempts) .. ")...")
            assert(clickButton(ctx, entry.object, false, function()
                local currentName = path(entry.object, {"Content", "ItemName"})
                return entry.object.Parent == bag and currentName and currentName.Text:lower() == entry.itemName:lower()
                    and visible(entry.object)
            end), "Bag card could not be selected.")
            -- Single-copy cards are added directly by the card click.
            if bagAmount ~= 1 then
                local picker = waitPreset(ctx, "Waiting for AmountPick: " .. entry.itemName .. "...", function()
                    local current = ctx.presetTradeFrame:FindFirstChild("AmountPick")
                    return current and current:IsA("GuiObject") and visible(current) and current
                end)
                local amount, lateOrder
                if indexPreset then
                    -- Keep the picker's default quantity; index never clicks Track.
                    amount = waitPreset(ctx, "Waiting for index amount: " .. entry.itemName .. "...", function()
                        assert(ctx.presetTradeFrame:FindFirstChild("AmountPick") == picker and visible(picker),
                            "Amount picker closed before index Add could be clicked.")
                        local value = path(picker, {"Content", "Amount", "Slider", "Knob", "Row", "Value"})
                        local current = value and value:IsA("TextLabel") and presetItemCount(value.Text)
                        return current and current > 0 and current
                    end, CONFIG.TradeAddConfirmTimeout)
                    wanted = amount
                else
                    amount, lateOrder = selectedPresetAmount(ctx, picker, entry.itemName, bagAmount, function()
                        return findPresetOffer(ctx, entry.itemName, wanted, before)
                    end)
                    if lateOrder ~= nil then placedOrder = lateOrder; break end
                end
                local add = waitPreset(ctx, "Waiting for AddButton: " .. entry.itemName .. "...", function()
                    assert(ctx.presetTradeFrame:FindFirstChild("AmountPick") == picker and visible(picker),
                        "Amount picker closed before AddButton could be clicked.")
                    local current = path(picker, {"Content", "Buttons", "AddButton"})
                    return current and current:IsA("GuiButton") and visible(current) and current.Active and current
                end, CONFIG.TradeAddConfirmTimeout)
                -- The offer may have arrived while a previous attempt was being reopened.
                placedOrder = findPresetOffer(ctx, entry.itemName, amount, before)
                if placedOrder ~= nil then break end
                setStatus(ctx, "Adding " .. entry.itemName .. " (quantity " .. tostring(amount) .. ")...")
                clickPresetTarget(ctx, add, nil, function()
                    local value = path(picker, {"Content", "Amount", "Slider", "Knob", "Row", "Value"})
                    return ctx.presetTradeFrame:FindFirstChild("AmountPick") == picker and visible(picker)
                        and path(picker, {"Content", "Buttons", "AddButton"}) == add and visible(add) and add.Active
                        and value and presetItemCount(value.Text) == amount
                end)
            end
            placedOrder = confirmPresetAdd(ctx, entry.itemName, wanted, before)
            if placedOrder == nil then
                setStatus(ctx, entry.itemName .. " x" .. tostring(wanted) .. " not found in Slots. Retrying the same card...")
                logRetry(ctx, "presetRetry:" .. tostring(index), "No matching offer after Add; retrying " .. entry.itemName .. ".", "INFO")
                task.wait(CONFIG.TradeTrackRetry)
            end
        until placedOrder ~= nil
        if indexPreset then
            autoIndexHasOffers = true
            indexCycleReset = saveIndexPlacement(ctx, lastIndexUnit, entry.itemName) or indexCycleReset
        end
        dismissPresetPicker(ctx)
        count = count + 1
        log("Preset " .. presetKey .. ": confirmed " .. entry.itemName .. " x" .. tostring(wanted)
            .. " in Your Offer at LayoutOrder " .. tostring(placedOrder) .. ".", "INFO", ctx)
        if index < limit then
            task.wait(CONFIG.TradePresetItemDelay)
            guard(ctx)
        end
    end
    ctx.indexPlacementCount = count
    local result = string.format("Done: preset %s processed %d card(s), maximum 8 per run.", presetKey, count)
    return result .. (indexCycleReset and " Index cycle complete; saved progress reset." or "")
end

local keys = {}
local indexPresetKey
for _, entry in ipairs(CONFIG["trade-preset"]) do
    assert(type(entry) == "table" and type(entry.Name) == "string" and entry.Name ~= ""
        and type(entry.Items) == "table", "Each preset needs Name and Items fields.")
    local key = entry.Name
    assert(not presetsByName[key], "Duplicate trade preset name: " .. key)
    presetsByName[key] = entry.Items
    if key:lower() == "index" then indexPresetKey = indexPresetKey or key end
    table.insert(keys, key)
end
assert(#keys > 0, "Configure at least one ordered trade preset with Name and Items fields.")
local rows = math.ceil(#keys / 2)
local visibleRows = math.min(3, rows)
local height = visibleRows * 30 - 4
local grid = make("ScrollingFrame", minimizedControls, {
    Name = "TradePresetGrid", Position = UDim2.fromOffset(0, 128), Size = UDim2.new(1, 0, 0, height),
    CanvasSize = UDim2.fromOffset(0, rows * 30 - 4), ScrollBarThickness = rows > visibleRows and 3 or 0,
    ScrollingDirection = Enum.ScrollingDirection.Y, BackgroundTransparency = 1, BorderSizePixel = 0,
})
local cells = make("Frame", grid, {
    Name = "PresetButtons", Size = UDim2.new(1, rows > visibleRows and -6 or 0, 0, rows * 30 - 4),
    BackgroundTransparency = 1,
})
local presetButtons = {}
for index, key in ipairs(keys) do
    local column, row = (index - 1) % 2, math.floor((index - 1) / 2)
    local cell = make("Frame", cells, {
        Name = "PresetCell" .. tostring(index), BackgroundTransparency = 1,
        Position = UDim2.new(column * 0.5, column == 0 and 0 or 3, 0, row * 30), Size = UDim2.new(0.5, -3, 0, 26),
    })
    local isIndex = key:lower() == "index"
    local run = button(cell, key, UDim2.fromOffset(0, 0), UDim2.new(1, isIndex and -30 or 0, 1, 0))
    run.Name, run.TextSize, run.TextWrapped = "TradePreset_" .. key, 11, true
    local controls = {run = run}
    if isIndex then
        local reset = button(cell, "", UDim2.new(1, -26, 0, 0), UDim2.fromOffset(26, 26))
        reset.Name, reset.TextSize = "TradePresetReset", 18
        minimizedActions.drawButtonIcon(reset, "refresh")
        controls.reset = reset
    end
    presetButtons[key] = controls
end
minimizedActions.presetExtraHeight = (visibleRows - 1) * 30
local notification = minimizedControls:FindFirstChild("MinimizedNotificationBox")
if notification then notification.Position = UDim2.fromOffset(0, 158 + minimizedActions.presetExtraHeight) end
local updateStatus = minimizedControls:FindFirstChild("MinimizedUpdateStatus")
if updateStatus then updateStatus.Position = UDim2.fromOffset(0, 186 + minimizedActions.presetExtraHeight) end
if minimizedActions.refreshStatus then minimizedActions.refreshStatus() end

local emptyQueueColor, savedQueueColor = Color3.fromRGB(38, 148, 84), Color3.fromRGB(165, 67, 79)
local function refreshQueueColors()
    if not alive then return end
    for _, controls in pairs(presetButtons) do
        if controls.reset then controls.reset.BackgroundColor3 = indexQueueCached and savedQueueColor or emptyQueueColor end
    end
end
minimizedActions.refreshIndexQueue = refreshQueueColors

local function refreshControls()
    local accepting, placing = contexts.accept, contexts.preset
    local acceptingNow = accepting and not accepting.cancelled and not placing
    local canToggleAccept = not placing and (not accepting or not accepting.cancelled)
    accept.Text = acceptingNow and "Auto Accept Trade: ON" or "Auto Accept Trade: OFF"
    accept.Active, accept.AutoButtonColor = canToggleAccept, canToggleAccept
    accept.BackgroundColor3 = acceptingNow and colors.success or colors.idle
    for key, controls in pairs(presetButtons) do
        local ownRun = placing and placing.presetKey == key
        local enabled = not placing or (ownRun and not placing.cancelled)
        controls.run.Text = ownRun and (placing.cancelled and "Stopping..." or "Stop " .. key) or key
        controls.run.Active, controls.run.AutoButtonColor = enabled, enabled
        controls.run.BackgroundColor3 = ownRun and colors.error or (placing and colors.idle or colors.accent)
        if controls.reset then controls.reset.Active, controls.reset.AutoButtonColor = not placing, not placing end
    end
    refreshQueueColors()
end
local function indexTradeHasOffers(tradeFrame)
    local slots = path(tradeFrame, {"ContentV2", "Top", "MyPane", "Body", "Slots"})
    if not slots or not visible(slots) then return nil end
    for _, slot in ipairs(slots:GetChildren()) do
        local name = path(slot, {"Content", "ItemName"})
        if slot:IsA("GuiObject") and visible(slot) and name
            and (name:IsA("TextLabel") or name:IsA("TextButton") or name:IsA("TextBox"))
            and name.Text:match("%S") then return true end
    end
    return false
end
local function resetIndexTrade()
    autoIndexTradeFrame, autoIndexHasOffers, autoIndexTradeReady = nil, false, false
end
local watchedIndexFrame, indexFrameConnections = nil, {}
watchIndexFrame = function(tradeFrame)
    if watchedIndexFrame == tradeFrame then return end
    for _, connection in ipairs(indexFrameConnections) do connection:Disconnect() end
    table.clear(indexFrameConnections)
    watchedIndexFrame = tradeFrame
    resetIndexTrade()
    if not tradeFrame then return end
    table.insert(indexFrameConnections, connect(tradeFrame:GetPropertyChangedSignal("Visible"), function()
        if not tradeFrame.Visible then
            resetIndexTrade()
            local ctx = contexts.preset
            if ctx and ctx.automaticIndex and ctx.presetTradeFrame == tradeFrame then ctx.cancelled = true end
        end
    end))
end
local function startTrade(kind, callback, presetKey)
    if not alive or (busy and activeRun == "master") or contexts[kind] then return end
    local ctx = {kind = kind, presetKey = presetKey or CONFIG.TradePreset}
    contexts[kind] = ctx
    if kind == "preset" and ctx.presetKey:lower() == "index" then
        local tradeFrame = path(playerGui, {"MineGui", "TradeFrame"})
        if tradeFrame and tradeFrame:IsA("GuiObject") and visible(tradeFrame) then
            -- Manual index placement also counts as this trade's queue attempt.
            watchIndexFrame(tradeFrame)
            autoIndexTradeFrame = tradeFrame
            autoIndexTradeReady = false
            autoIndexHasOffers = indexTradeHasOffers(tradeFrame) == true
        end
    end
    refreshControls()
    local thread = task.defer(function()
        local ok, result = pcall(callback, ctx)
        local released, releaseError = pcall(releasePresetInput, ctx)
        runScope.background[coroutine.running()] = nil
        if contexts[kind] ~= ctx then return end
        contexts[kind] = nil
        if kind == "preset" and ctx.presetKey:lower() == "index" and autoIndexTradeFrame == ctx.presetTradeFrame then
            autoIndexTradeReady = ok or ctx.cancelled == true
            if not ok and not ctx.cancelled then
                resetIndexTrade()
                autoIndexRetryAt = os.clock() + CONFIG.TradeTrackRetry
            end
        end
        if not alive then return end
        refreshControls()
        if not released then ok, result = false, releaseError end
        if ctx.cancelled then result = kind == "accept" and "Auto Accept Trade: OFF." or "Trade preset stopped."
        elseif not ok then log(tostring(result), "ERROR", ctx); result = "Error: " .. tostring(result) end
        status[kind].TextColor3 = (ok or ctx.cancelled) and colors.muted or colors.error
        status[kind].Text = tostring(result)
    end)
    ctx.thread = thread
    runScope.background[thread] = true
end
resumeIndexPreset = function()
    local tradeFrame = path(playerGui, {"MineGui", "TradeFrame"})
    watchIndexFrame(tradeFrame)
    if not tradeFrame or not tradeFrame:IsA("GuiObject") or not visible(tradeFrame) then
        resetIndexTrade()
        return false
    end
    -- A new trade can reuse the same visible frame while clearing its offers.
    if not contexts.preset and autoIndexTradeFrame == tradeFrame and autoIndexHasOffers
        and indexTradeHasOffers(tradeFrame) == false then resetIndexTrade() end
    if not alive or not indexPresetKey or not indexQueueCached then return false end
    if (busy and activeRun == "master") or contexts.preset then return true end
    if autoIndexTradeFrame == tradeFrame then return not autoIndexTradeReady end
    if os.clock() < autoIndexRetryAt then return true end
    CONFIG.TradePreset = indexPresetKey
    startTrade("preset", function(ctx)
        ctx.automaticIndex, ctx.presetTradeFrame = true, tradeFrame
        while true do
            guard(ctx)
            local result = runTradePreset(ctx)
            if (ctx.indexPlacementCount or 0) > 0 or not indexQueueCached then return result end
            -- TradeFrame can appear before its bag cards finish loading.
            setStatus(ctx, "Saved index queue: waiting for unplaced bag cards...")
            task.wait(CONFIG.TradeBagPoll)
        end
    end, indexPresetKey)
    return true -- Block Ready until this trade's index placement finishes.
end
local nextIndexCheck = 0
connect(game:GetService("RunService").Heartbeat, function()
    if os.clock() < nextIndexCheck then return end
    nextIndexCheck = os.clock() + CONFIG.TradePoll
    resumeIndexPreset()
end)
connect(accept.Activated, function()
    if not alive or contexts.preset or (busy and activeRun == "master") then return end
    local ctx = contexts.accept
    preferences.autoAcceptTradeEnabled = ctx == nil
    savePreferences()
    if ctx then ctx.cancelled = true; refreshControls()
    else startTrade("accept", runAcceptTrade) end
end)
for _, key in ipairs(keys) do
    local controls = presetButtons[key]
    connect(controls.run.Activated, function()
        if not alive or (busy and activeRun == "master") then return end
        local ctx = contexts.preset
        if ctx then
            if ctx.presetKey ~= key or ctx.cancelled then return end
            ctx.cancelled = true
            refreshControls()
        else
            CONFIG.TradePreset = key
            startTrade("preset", runTradePreset, key)
        end
    end)
    if controls.reset then
        connect(controls.reset.Activated, function()
            if not alive or contexts.preset or (busy and activeRun == "master") then return end
            local previous = preferences.indexPlacedUnits
            preferences.indexPlacedUnits = {}
            if savePreferences() then
                status.preset.TextColor3 = colors.success
                status.preset.Text = "Index preset queue reset."
            else
                preferences.indexPlacedUnits = previous
                status.preset.TextColor3 = colors.error
                status.preset.Text = "Could not reset the cached queue. Check executor file access."
            end
            refreshQueueColors()
        end)
    end
end
modules.trade = {
    restorePreference = function()
        if preferences.autoAcceptTradeEnabled and not preferences.masterEnabled then
            startTrade("accept", runAcceptTrade)
        end
    end,
    cleanup = function()
        local complete = true
        for kind, ctx in pairs(contexts) do
            ctx.cancelled = true
            contexts[kind] = nil
            if ctx.thread then
                if coroutine.status(ctx.thread) ~= "dead" then pcall(task.cancel, ctx.thread) end
                runScope.background[ctx.thread] = nil
            end
            local ok, err = pcall(releasePresetInput, ctx)
            if not ok then complete = false; log(tostring(err), "ERROR", ctx) end
        end
        if alive then refreshControls() end
        return complete
    end,
}
refreshControls()

end)()
end


-- One-shot Trial -> Sell -> Events -> Mailbox -> Index; Sell reuses the existing full stage.
do
(function()
local CONFIG = {
    ConsoleLogs = true,
    VerboseLogs = false, -- Enable full UI paths, colors and polling diagnostics.
    LogRepeatInterval = 5,
    VisibilityRetry = 1,
    RefreshDelay = 0.2,
    SettleTime = 0.15,
    ClaimRetry = 0.1,
    EventClaimDelay = 0.03,
    TrialClaimDelay = 1,
    Poll = 0.1,
    LoadTimeout = 30,
    DefaultClickEvent = "MouseButton1Click",
}

local activeContext, logStartedAt
local stopReadyAt, autoRunning, startLockToken, startLockThread = 0, false, nil, nil
local run = button(minimizedControls, "Auto tasks: Run once", UDim2.fromOffset(0, 36), UDim2.new(0.5, -3, 0, 26))
run.Name, run.TextSize = "AutoTasksRun", 12
local nextButton = button(minimizedControls, "", UDim2.new(0.5, -29, 0, 36), UDim2.fromOffset(26, 26))
nextButton.Name, nextButton.TextSize = "AutoTasksNext", 18
nextButton.BackgroundColor3 = colors.surface
minimizedActions.drawButtonIcon(nextButton, "next")
local function refreshAutoTasksNext()
    if not alive then return end
    local ownRun = busy and activeRun == "autoSequence"
    local enabled = ownRun and activeContext ~= nil and not activeContext.cleaned
        and not activeContext.finished and not activeContext.skipRequested and os.clock() >= stopReadyAt
    nextButton.Visible = ownRun
    nextButton.Active, nextButton.AutoButtonColor = enabled, enabled
    if ownRun then
        local canStop = os.clock() >= stopReadyAt
        run.Active, run.AutoButtonColor = canStop, canStop
        run.Text = canStop and "Stop auto tasks" or "Starting..."
        stop.Active, stop.AutoButtonColor = canStop, canStop
        stop.BackgroundColor3 = canStop and Color3.fromRGB(165, 67, 79) or colors.idle
    end
    run.Size = UDim2.new(0.5, ownRun and -33 or -3, 0, 26)
    local altar = minimizedControls:FindFirstChild("TeleportAltar")
    if altar then
        altar.Position = UDim2.new(0.5, 3, 0, 36)
        altar.Size = UDim2.new(0.5, -3, 0, 26)
    end
end
refreshAutoTasksNext()
local statusLabel = minimizedActions.newStatus("")
pages.autoSequence = {name = "Auto tasks", run = run, status = statusLabel, runText = "Auto tasks: Run once"}

local function log(message, level, ctx)
    level = level or "INFO"
    if level == "DEBUG" and not CONFIG.VerboseLogs then return end
    if not CONFIG.ConsoleLogs and level ~= "ERROR" then return end
    ctx = ctx or activeContext
    local stage = ctx and ctx.stage and ctx.stage.name or "Controls"
    local elapsed = logStartedAt and (os.clock() - logStartedAt) or 0
    local line = string.format("[Automation][%s][+%.1fs][%s] %s", stage, elapsed, level, message)
    if level == "ERROR" then warn(line) else print(line) end
end

-- Conditions are polled frequently; print only when their values change.
local function logChanged(ctx, key, message, level)
    ctx.logStates = ctx.logStates or {}
    if ctx.logStates[key] ~= message then
        ctx.logStates[key] = message
        log(message, level or "DEBUG", ctx)
    end
end

local function logOnce(ctx, key, message, level)
    ctx.logSeen = ctx.logSeen or {}
    if not ctx.logSeen[key] then
        ctx.logSeen[key] = true
        log(message, level, ctx)
    end
end

-- Retrying actions still run at their normal rate; only their logs are limited.
local function logRetry(ctx, key, message, level)
    ctx.logTimes = ctx.logTimes or {}
    local now = os.clock()
    local last = ctx.logTimes[key]
    if not last or now - last >= CONFIG.LogRepeatInterval then
        ctx.logTimes[key] = now
        log(message, level or "RETRY", ctx)
    end
end

local function path(root, names)
    for _, name in ipairs(names) do
        root = root and root:FindFirstChild(name)
        if not root then return nil end
    end
    return root
end

local function setStatus(message, quiet)
    checkAlive()
    if not quiet then
        if activeContext then logChanged(activeContext, "status", message, "STATE")
        else log(message, "STATE") end
    end
    if alive and statusLabel then statusLabel.Text = message end
    if alive and overviewStatus then overviewStatus.Text = message end
end

-- Keep reward names readable while distinguishing identically named event cards.
local function rewardLabel(card)
    local name = card.Name
    if name == "RewardCard" and card.Parent then
        local index = 0
        for _, sibling in ipairs(card.Parent:GetChildren()) do
            if sibling.Name == "RewardCard" then index = index + 1 end
            if sibling == card then break end
        end
        name = "RewardCard #" .. tostring(index)
    end
    local ancestor = card.Parent
    while ancestor and ancestor ~= playerGui do
        if ancestor.Name:match("^Row_T%d+$") or ancestor.Name:match("^M%d+$") then
            return ancestor.Name .. " / " .. name
        end
        ancestor = ancestor.Parent
    end
    return name
end

local function guard(ctx)
    checkAlive()
    if ctx.skipRequested then error("Stage ended early.", 0) end
    if ctx ~= activeContext or ctx.cleaned then error("Run stopped.", 0) end
    if ctx.plot then
        local plots = path(workspace, {"MineWorld", "Plots"})
        if not plots or ctx.plot.Parent ~= plots
            or not ctx.plot:IsDescendantOf(workspace)
            or tonumber(ctx.plot:GetAttribute("OwnerUserId")) ~= player.UserId then
            error("Your MinePlot was removed or its ownership changed. Run again after your plot loads.", 0)
        end
    end
    if ctx.eventsFrame and path(playerGui, {"MineGui", "EventsFrameV2"}) ~= ctx.eventsFrame then
        error("EventsFrameV2 was replaced or removed. Run again.", 0)
    end
    if ctx.mailboxFrame and path(playerGui, {"MineGui", "MailboxFrame"}) ~= ctx.mailboxFrame then
        error("MailboxFrame was replaced or removed. Run again.", 0)
    end
    if ctx.indexFrame and path(playerGui, {"MineGui", "IndexFrame"}) ~= ctx.indexFrame then
        error("IndexFrame was replaced or removed. Run again.", 0)
    end
    if ctx.frame and path(playerGui, {"MineGui", "TrialFrame"}) ~= ctx.frame then
        error("TrialFrame was replaced or removed. Run again.", 0)
    end
end

local function colorIs(color, r, g, b)
    return math.floor(color.R * 255 + 0.5) == r
        and math.floor(color.G * 255 + 0.5) == g
        and math.floor(color.B * 255 + 0.5) == b
end

local function startContent(ctx)
    return path(ctx.frame, {"Body", "Actions", "StartButton", "Content"})
end

local function observeStart(ctx)
    local content = startContent(ctx)
    if not content or not content:IsA("GuiObject") then
        logChanged(ctx, "startColor", "StartButton.Content color source missing or not a GuiObject; waiting for Content.BackgroundColor3.")
        return nil, false, false
    end
    local color = content.BackgroundColor3
    local red = colorIs(color, 168, 46, 52)
    local green = colorIs(color, 38, 148, 84)
    logChanged(ctx, "startState", "Start button: " .. (green and "ready (green)"
        or red and "active (red)" or "waiting"), "INFO")
    logChanged(ctx, "startColor", string.format(
        "StartButton color at %s = RGB(%d, %d, %d); red=%s; green=%s; greenExitArmed=%s",
        content:GetFullName(), math.floor(color.R * 255 + 0.5),
        math.floor(color.G * 255 + 0.5), math.floor(color.B * 255 + 0.5),
        tostring(red), tostring(green), tostring(ctx.greenExitArmed)))
    return content, red, green
end

local function isGreen(ctx)
    -- Startup always requests, waits, and opens before checking completion.
    if not ctx.greenExitArmed then return false end
    if ctx.green then return true end
    local _, _, green = observeStart(ctx)
    ctx.green = green
    return ctx.green
end

local function waitFor(ctx, label, getter, watchGreen, timeout)
    setStatus(label)
    local deadline = os.clock() + (timeout or CONFIG.LoadTimeout)
    while true do
        guard(ctx)
        if watchGreen and isGreen(ctx) then
            log("Start is green; finishing the trial.", "INFO", ctx)
            return nil
        end
        local result = getter()
        if result then log("Ready: " .. label, "DEBUG", ctx); return result end
        if os.clock() >= deadline then error(label .. " (load timed out)", 0) end
        pause(CONFIG.Poll)
    end
end

local function visible(object)
    if not object or not object:IsDescendantOf(playerGui) then return false end
    while object and object ~= playerGui do
        if object:IsA("GuiObject") and not object.Visible then return false end
        if object:IsA("LayerCollector") and not object.Enabled then return false end
        object = object.Parent
    end
    return true
end

-- Check before writing; after each write let UI handlers run before confirming.
-- There is no overall timeout: a rejected transition is retried every second.
local function setVisibleAndWait(ctx, object, value)
    assert(object and object:IsA("GuiObject"), "Visibility target is not a GuiObject.")
    local nextAttempt = 0
    while true do
        guard(ctx)
        if not object:IsDescendantOf(playerGui) then
            error("Visibility target was removed: " .. object.Name, 0)
        end
        if object.Visible == value then return end
        if os.clock() >= nextAttempt then
            logRetry(ctx, "visible:" .. object:GetFullName(), "Setting " .. object.Name
                .. ".Visible=" .. tostring(value) .. "; retrying every "
                .. tostring(CONFIG.VisibilityRetry) .. "s until confirmed.")
            object.Visible = value
            nextAttempt = os.clock() + CONFIG.VisibilityRetry
        end
        pause(CONFIG.Poll)
    end
end

-- Cleanup can run after cancellation or UI replacement, so close both references.
local function closeStageFrames(ctx, frameName, original)
    local current = path(playerGui, {"MineGui", frameName})
    if current and current:IsA("GuiObject") then
        setVisibleAndWait(ctx, current, false)
    end
    if original and original ~= current and original:IsA("GuiObject") then
        setVisibleAndWait(ctx, original, false)
    end
end

-- Uses exactly one signal per click, as in the existing main.luau.
local function clickButton(ctx, object, watchGreen, beforeClick)
    guard(ctx)
    if watchGreen ~= false and isGreen(ctx) then return false end
    assert(type(firesignal) == "function", "Volt firesignal is required.")
    assert(object, "Click target is missing.")
    local target = object:IsA("GuiButton") and object or nil
    if not target then
        for _, child in ipairs(object:GetDescendants()) do
            if child:IsA("GuiButton") and visible(child) then
                assert(not target, "Multiple buttons inside " .. object:GetFullName())
                target = child
            end
        end
    end
    assert(target, "No clickable button inside " .. object:GetFullName())
    assert(visible(target), "Button is hidden: " .. target:GetFullName())
    local eventName = CONFIG.DefaultClickEvent
    if type(getconnections) == "function" then
        for _, name in ipairs({"Activated", "MouseButton1Click"}) do
            local ok, handlers = pcall(getconnections, target[name])
            local found = false
            if ok and type(handlers) == "table" then
                for _, handler in pairs(handlers) do
                    if handler.Enabled ~= false then found = true; break end
                end
            end
            if found then eventName = name; break end
        end
    end
    guard(ctx)
    if watchGreen ~= false and isGreen(ctx) then return false end
    logChanged(ctx, "click:" .. target:GetFullName(), "Click: " .. target:GetFullName() .. "; signal=" .. eventName
        .. "; Visible=" .. tostring(target.Visible) .. "; effectiveVisible=" .. tostring(visible(target)))
    if beforeClick and not beforeClick() then return false end
    if eventName == "Activated" then firesignal(target.Activated, nil, 1)
    else firesignal(target.MouseButton1Click) end
    return true
end

local function getOwnedPlot()
    local plots = path(workspace, {"MineWorld", "Plots"})
    if not plots then return nil end
    local owned
    for _, plot in ipairs(plots:GetChildren()) do
        if plot.Name:match("^MinePlot%d+$")
            and tonumber(plot:GetAttribute("OwnerUserId")) == player.UserId then
            assert(not owned, "Multiple MinePlots match your OwnerUserId; stopped.")
            owned = plot
        end
    end
    return owned
end

local function getRows(ctx)
    local rows = path(ctx.frame, {"Body", "Rows"})
    local result = {}
    if rows then
        for _, row in ipairs(rows:GetChildren()) do
            local number = tonumber(row.Name:match("^Row_T(%d+)$"))
            if number then table.insert(result, {object = row, number = number}) end
        end
    end
    table.sort(result, function(a, b) return a.number < b.number end)
    local names = {}
    for _, entry in ipairs(result) do table.insert(names, entry.object.Name) end
    logChanged(ctx, "rows", "Milestones: "
        .. (#names > 0 and table.concat(names, ", ") or "waiting for rows"), "INFO")
    return result
end

local function isItem(object)
    return object.Name:sub(1, 4) == "Item"
end

-- Only direct Item* children of this row's Body.RewardsHere are rewards.
local function rewardItems(rewards)
    local items = {}
    for _, child in ipairs(rewards:GetChildren()) do
        if isItem(child) then table.insert(items, child) end
    end
    return items
end

local function rewardStatus(item)
    local overlay = path(item, {"Content", "ClaimedOverlay"})
    local hasOverlay = overlay ~= nil and overlay:IsA("GuiObject")
    local claimed = hasOverlay and overlay.Visible == true or false
    local badge = path(item, {"Content", "ClaimBadge"})
    local claimable = badge ~= nil and badge:IsA("GuiObject") and badge.Visible == true
    return claimed, not claimed and claimable and visible(item), hasOverlay
end

local function inspectRow(ctx, row, state)
    local body = row:FindFirstChild("Body")
    local rewards = body and body:FindFirstChild("RewardsHere")
    if not rewards then
        logChanged(ctx, "rowBody:" .. row.Name, row.Name .. ": Body.RewardsHere missing; waiting.")
        state.quietSince = nil
        return false, {}
    end
    logChanged(ctx, "rowBody:" .. row.Name, row.Name .. ": Body.RewardsHere found.")
    local current = {}
    for _, item in ipairs(rewardItems(rewards)) do
        local key = item:GetFullName()
        current[key] = item
        local previous = state.items[key]
        if not previous or previous.object ~= item then
            log((previous and "Reward replaced: " or "Reward discovered: ") .. key, "DEBUG", ctx)
            -- A replacement must provide its own claimed evidence.
            state.items[key] = {object = item,
                clicked = false, nextClick = 0, complete = false,
                attempts = 0}
            state.quietSince = nil
        end
    end

    local allComplete = next(state.items) ~= nil
    local claimable = {}
    for key, itemState in pairs(state.items) do
        local item = current[key]
        if item then
            local claimed, canClick, hasOverlay = rewardStatus(item)
            if claimed and not itemState.complete then
                log(rewardLabel(item) .. ": claim confirmed", "CLAIM", ctx)
            end
            itemState.complete = claimed
            if canClick and not itemState.complete then
                table.insert(claimable, {item = item, key = key, state = itemState})
            end
            logChanged(ctx, "reward:" .. key, string.format(
                "Reward %s: present=true; Content.ClaimedOverlay.exists=%s; ClaimedOverlay.Visible=%s; canClick=%s; clicked=%s; complete=%s",
                key, tostring(hasOverlay), tostring(claimed), tostring(canClick),
                tostring(itemState.clicked), tostring(itemState.complete)))
        else
            -- Disappearance or a claim attempt cannot confirm an unclaimed reward.
            logChanged(ctx, "reward:" .. key, string.format(
                "Reward %s: present=false; clicked=%s; complete=%s; waiting for ClaimedOverlay confirmation if incomplete",
                key, tostring(itemState.clicked), tostring(itemState.complete)))
        end
        if not itemState.complete then allComplete = false end
    end

    if allComplete then
        state.quietSince = state.quietSince or os.clock()
        return os.clock() - state.quietSince >= CONFIG.SettleTime, claimable
    end
    state.quietSince = nil
    return false, claimable
end

local function setTrialVisible(ctx, value)
    setVisibleAndWait(ctx, ctx.frame, value)
    logChanged(ctx, "frameVisible", ctx.frame.Visible and "Trial panel opened." or "Trial panel closed.", "INFO")
end

local function openTrialFrame(ctx)
    setStatus("Opening TrialFrame; retrying until Visible is true...")
    setTrialVisible(ctx, true)
    ctx.opened = true
end

local function ensureRowsVisible(ctx)
    while true do
        guard(ctx)
        if isGreen(ctx) then return false end
        local rows = path(ctx.frame, {"Body", "Rows"})
        local ready = rows ~= nil and rows:IsA("GuiObject") and rows.Visible == true and visible(rows)
        logChanged(ctx, "rowsVisible", "Rows.Visible = " .. tostring(ready)
            .. "; exists=" .. tostring(rows ~= nil))
        if ready then return true end

        setStatus("Waiting for Rows.Visible=true; retrying Milestones every "
            .. tostring(CONFIG.VisibilityRetry) .. "s...")
        local button = path(ctx.frame, {"Body", "Actions", "MilestonesButton"})
        local canClick = button ~= nil and visible(button)
        logChanged(ctx, "milestones", "MilestonesButton: exists=" .. tostring(button ~= nil)
            .. "; effectiveVisible=" .. tostring(canClick))
        if canClick and os.clock() >= ctx.nextMilestonesClick then
            if not clickButton(ctx, button) then return false end
            ctx.nextMilestonesClick = os.clock() + CONFIG.VisibilityRetry
            ctx.milestonesAttempts = ctx.milestonesAttempts + 1
            logRetry(ctx, "milestonesRetry", "Opening milestones (attempt " .. tostring(ctx.milestonesAttempts) .. ").")
            -- After a successful click, wait only for the exact Rows container.
            -- Do not retry Milestones or finish on green while it is loading.
            waitFor(ctx, "Waiting for TrialFrame.Body.Rows.Visible=true...", function()
                local current = path(ctx.frame, {"Body", "Rows"})
                return current and current:IsA("GuiObject") and current.Visible == true and visible(current)
            end, false, math.huge)
            return true
        end
        pause(CONFIG.Poll)
    end
end

local function finish(ctx, reason)
    guard(ctx)
    log("Finishing: " .. (reason or "Start is green") .. ".", "DEBUG", ctx)
    setTrialVisible(ctx, false)
    return "Done: " .. (reason or "Start is green") .. ". Trial UI closed."
end

local function runTrial(ctx)
    log("Player: " .. player.Name .. " (" .. tostring(player.UserId) .. ")", "DEBUG", ctx)
    log("Start colors: red=RGB(168,46,52); green=RGB(38,148,84); green exit armed after opening.", "DEBUG", ctx)
    ctx.plot = waitFor(ctx, "Waiting for your owned MinePlot (OwnerUserId="
        .. tostring(player.UserId) .. ")...", getOwnedPlot)
    log("Owned plot: " .. ctx.plot.Name, "INFO", ctx)
    local title = waitFor(ctx, "Waiting for TrialStone title...", function()
        return path(ctx.plot, {"TrialStone", "Sign", "Board", "Title"})
    end)
    assert(title:IsA("GuiObject"), "TrialStone Title has no Visible property.")
    logChanged(ctx, "titleVisible", "TrialStone Title.Visible = " .. tostring(title.Visible))
    if not title.Visible then return "Skipped: TrialStone title is not visible." end

    assert(type(firesignal) == "function", "Volt firesignal is required.")
    local event = waitFor(ctx, "Waiting for GamestateEvent...", function()
        return path(ReplicatedStorage, {"Remotes", "GamestateEvent"})
    end)
    assert(event:IsA("RemoteEvent"), "GamestateEvent is not a RemoteEvent.")
    ctx.event = event
    guard(ctx)
    logChanged(ctx, "titleVisible", "TrialStone Title.Visible = " .. tostring(title.Visible))
    if not title.Visible then return "Skipped: TrialStone title is not visible." end
    log("Trial requested.", "INFO", ctx)
    ctx.trialRequested = true
    event:FireServer("MineTrialStart")
    local openAt = os.clock() + CONFIG.RefreshDelay
    waitFor(ctx, "Trial requested. Waiting " .. tostring(CONFIG.RefreshDelay)
        .. " seconds before opening TrialFrame...",
        function() return os.clock() >= openAt end, false, math.huge)

    ctx.frame = waitFor(ctx, "Waiting for TrialFrame...", function()
        return path(playerGui, {"MineGui", "TrialFrame"})
    end, false, math.huge)
    assert(ctx.frame:IsA("GuiObject"), "TrialFrame has no Visible property.")
    log("TrialFrame initial Visible = " .. tostring(ctx.frame.Visible)
        .. " (observed only; opening now follows the request delay).", "DEBUG", ctx)
    openTrialFrame(ctx)
    ctx.greenExitArmed = true
    if isGreen(ctx) then return finish(ctx) end

    local rows = waitFor(ctx, "Waiting for Row_T<number> milestones...", function()
        if not ensureRowsVisible(ctx) then return nil end
        local found = getRows(ctx)
        return #found > 0 and found or nil
    end, true, math.huge)
    if not rows or ctx.green then return finish(ctx) end

    local states, allClearSince = {}, nil
    local nextRewardClick = 0
    while true do
        guard(ctx)
        if isGreen(ctx) then return finish(ctx) end
        if not ensureRowsVisible(ctx) then return finish(ctx) end

        rows = getRows(ctx) -- Discover every row, even while a lower row is pending.
        local present, tracked = {}, {}
        for _, entry in ipairs(rows) do
            local row = entry.object
            present[row.Name] = true
            if not states[row.Name] or states[row.Name].row ~= row then
                log((states[row.Name] and "Row replaced: " or "Row discovered: ") .. row.Name, "DEBUG", ctx)
                states[row.Name] = {row = row, number = entry.number,
                    items = {}, complete = false}
                allClearSince = nil
            end
        end
        for name, state in pairs(states) do
            table.insert(tracked, {name = name, state = state})
        end
        table.sort(tracked, function(a, b) return a.state.number < b.state.number end)

        local pending, claimable
        for _, entry in ipairs(tracked) do
            local state = entry.state
            local cleared, visibleItems = state.complete, {}
            if present[entry.name] then
                cleared, visibleItems = inspectRow(ctx, state.row, state)
                state.complete = cleared
            end
            logChanged(ctx, "row:" .. entry.name, entry.name .. ": "
                .. (cleared and "complete" or present[entry.name] and "pending" or "waiting for row"), "INFO")
            if not cleared then
                pending = entry
                claimable = visibleItems
                break
            end
        end

        if pending then
            allClearSince = nil
            setStatus(present[pending.name] and ("Waiting/claiming " .. pending.name .. "...")
                or ("Waiting for " .. pending.name .. " to reappear..."))
            -- Space all Trial reward clicks one second apart, including retries and row changes.
            for _, reward in ipairs(claimable) do
                if os.clock() >= nextRewardClick and os.clock() >= reward.state.nextClick then
                    -- Recheck both the claimed overlay and claim badge before clicking.
                    local claimed, canClick = rewardStatus(reward.item)
                    if canClick and not claimed
                        and clickButton(ctx, reward.item, true, function()
                            local latestClaimed, latestCanClick = rewardStatus(reward.item)
                            return not latestClaimed and latestCanClick
                        end) then
                        reward.state.clicked = true
                        reward.state.attempts = reward.state.attempts + 1
                        nextRewardClick = os.clock() + CONFIG.TrialClaimDelay
                        reward.state.nextClick = nextRewardClick
                        logRetry(ctx, "claimRetry:" .. reward.key, rewardLabel(reward.item)
                            .. ": claim requested (attempt " .. tostring(reward.state.attempts) .. ").")
                    end
                end
            end
        elseif #tracked > 0 and #rows > 0 then
            allClearSince = allClearSince or os.clock()
            setStatus("All rewards confirmed. Checking for remaining rows...")
            if os.clock() - allClearSince >= CONFIG.SettleTime then
                if isGreen(ctx) then return finish(ctx) end
                return finish(ctx, "all milestone rewards are claimed")
            end
        else
            allClearSince = nil
            setStatus("Waiting for milestone rows to reappear...")
        end
        -- Reward waits intentionally have no timeout. Stop cancels them.
        pause(CONFIG.Poll)
    end
end

-- Events use their own context so Trial's green Start cannot stop this stage.
local function eventIsActive(ctx, header)
    local strip = path(ctx.eventsFrame, {"Safe", "Strip"})
    local when = path(header, {"Info", "When"})
    local hasText = when and (when:IsA("TextLabel") or when:IsA("TextButton")
        or when:IsA("TextBox"))
    if not strip or header.Parent ~= strip or not hasText then return false, "<missing>" end
    local raw = when.Text
    if not header:IsA("GuiObject") or not header.Visible or not visible(header) then
        return false, raw
    end
    local text = when.RichText and raw:gsub("<[^>]*>", "") or raw
    text = string.lower(text)
    return string.find(text, "ends", 1, true) ~= nil, raw
end

local function eventHeaders(ctx)
    local strip = path(ctx.eventsFrame, {"Safe", "Strip"})
    local headers = {}
    if strip then
        for _, child in ipairs(strip:GetChildren()) do
            if child:IsA("GuiObject") and eventIsActive(ctx, child) then
                local hasButton = child:IsA("GuiButton")
                if not hasButton then
                    for _, descendant in ipairs(child:GetDescendants()) do
                        if descendant:IsA("GuiButton") and visible(descendant) then
                            hasButton = true
                            break
                        end
                    end
                end
                if hasButton then table.insert(headers, child) end
            end
        end
    end
    table.sort(headers, function(a, b)
        if a.LayoutOrder ~= b.LayoutOrder then return a.LayoutOrder < b.LayoutOrder end
        return a.Name < b.Name
    end)
    return headers
end

local function eventRewardState(card)
    local overlay = path(card, {"Content", "LockedOverlay"})
    local badge = path(card, {"Content", "ClaimBadge"})
    -- Missing lock information is still loading, never permission to claim.
    if not overlay or not overlay:IsA("GuiObject") then return nil end
    return {object = card, locked = overlay.Visible == true, shown = visible(card),
        claimBadgeVisible = badge ~= nil and badge:IsA("GuiObject") and badge.Visible == true}
end

local function eventSnapshot(ctx)
    local milestones = path(ctx.eventsFrame, {"Safe", "Body", "Main", "Pages", "Milestones"})
    if not milestones or not visible(milestones) then return nil end
    local rows = {}
    for _, child in ipairs(milestones:GetChildren()) do
        local number = tonumber(child.Name:match("^M(%d+)$"))
        if number and child:IsA("GuiObject") then
            -- Confirm every M1, M2, ... before reading any rewards.
            if not child.Visible or not visible(child) then return nil end
            table.insert(rows, {object = child, number = number})
        end
    end
    if #rows == 0 then return nil end
    table.sort(rows, function(a, b) return a.number < b.number end)
    local cards = {}
    for _, row in ipairs(rows) do
        local rewards = path(row.object, {"Body", "Rewards"})
        if not rewards then return nil end
        local count = 0
        for _, child in ipairs(rewards:GetChildren()) do
            if child.Name == "RewardCard" and child:IsA("GuiObject") then
                local state = eventRewardState(child)
                if not state then return nil end
                table.insert(cards, state)
                count = count + 1
            end
        end
        if count == 0 then return nil end
    end
    return {page = milestones, rows = rows, cards = cards}
end

local function sameEventSnapshot(a, b)
    if not a or not b or a.page ~= b.page
        or #a.rows ~= #b.rows or #a.cards ~= #b.cards then return false end
    for index, row in ipairs(a.rows) do
        if row.object ~= b.rows[index].object then return false end
    end
    for index, card in ipairs(a.cards) do
        local other = b.cards[index]
        if card.object ~= other.object or card.locked ~= other.locked
            or card.shown ~= other.shown
            or card.claimBadgeVisible ~= other.claimBadgeVisible then return false end
    end
    return true
end

local function claimEvent(ctx, header)
    -- Allow opening handlers to refresh placeholder countdown text first.
    local activeSince = os.clock()
    local ready = waitFor(ctx, "Confirming Ends countdown: " .. header.Name .. "...", function()
        local active, text = eventIsActive(ctx, header)
        logChanged(ctx, "eventWhen:" .. header.Name, "Event header " .. header:GetFullName()
            .. "; Info.When.Text=" .. string.format("%q", text) .. "; eligible=" .. tostring(active))
        if not active then return {active = false} end
        if os.clock() - activeSince >= CONFIG.SettleTime then return {active = true} end
        return nil
    end, false)
    if not ready.active then return nil end
    setStatus("Opening event: " .. header.Name .. "...")
    -- Recheck both visibility and the current countdown immediately before clicking.
    local selected = clickButton(ctx, header, false, function()
        local active, text = eventIsActive(ctx, header)
        log("Header " .. header.Name .. ": " .. string.format("%q", text)
            .. "; allowed=" .. tostring(active), "DEBUG", ctx)
        return active
    end)
    if not selected then return nil end
    log("Selected event: " .. header.Name, "INFO", ctx)
    local clicked, total = {}, 0
    local previous, stableSince
    local deadline = os.clock() + CONFIG.LoadTimeout
    local nextClick = os.clock() + CONFIG.SettleTime
    while true do
        guard(ctx)
        if not eventIsActive(ctx, header) then
            log(header.Name .. ": no longer eligible; moving on.", "INFO", ctx)
            return total
        end
        assert(visible(ctx.eventsFrame), "Events UI was hidden during claiming. Run again.")
        local snapshot = eventSnapshot(ctx)
        local now = os.clock()
        if not sameEventSnapshot(previous, snapshot) then stableSince = now end
        previous = snapshot
        local settleDelay = total > 0 and CONFIG.EventClaimDelay or CONFIG.SettleTime
        if snapshot and stableSince and now - stableSince >= settleDelay then
            logOnce(ctx, "eventLoaded:" .. header.Name, string.format("%s: milestones=%d, reward cards=%d.",
                header.Name, #snapshot.rows, #snapshot.cards), "INFO")
            deadline = now + CONFIG.LoadTimeout
            local pending
            for _, state in ipairs(snapshot.cards) do
                if state.shown and not state.locked and state.claimBadgeVisible
                    and not clicked[state.object] then
                    pending = state.object
                    break
                end
            end
            if not pending then
                if now - stableSince >= CONFIG.SettleTime then
                    log(header.Name .. ": finished; claim clicks=" .. tostring(total) .. ".", "INFO", ctx)
                    return total
                end
            elseif now >= nextClick then
                -- Skip other cards without a claim delay; recheck both conditions before firing.
                local current = eventRewardState(pending)
                if current and current.shown and not current.locked and current.claimBadgeVisible then
                    local didClick = clickButton(ctx, pending, false, function()
                        local latest = eventRewardState(pending)
                        return latest and latest.shown and not latest.locked and latest.claimBadgeVisible
                    end)
                    if didClick then
                        clicked[pending] = true
                        total = total + 1
                        nextClick = os.clock() + CONFIG.EventClaimDelay
                        stableSince = os.clock()
                        log(header.Name .. " / " .. rewardLabel(pending) .. ": claim clicked", "CLAIM", ctx)
                    end
                end
            end
        elseif now >= deadline then
            error("Event " .. header.Name .. ": milestones/reward locks did not finish loading.", 0)
        end
        setStatus("Checking/claiming " .. header.Name .. ": waiting for visible M1, M2... and reward locks...")
        pause(CONFIG.EventClaimDelay)
    end
end

local function closeEvents(ctx, reason)
    -- Also close on Stop, errors, or closing the automation controls.
    if not ctx or not ctx.eventsFrame then return end
    closeStageFrames(ctx, "EventsFrameV2", ctx.eventsFrame)
    logChanged(ctx, "eventsVisible", "Events panel closed.", "INFO")
end

local function runEvents(ctx)
    assert(type(firesignal) == "function", "Volt firesignal is required.")
    ctx.eventsFrame = waitFor(ctx, "Waiting for EventsFrameV2...", function()
        return path(playerGui, {"MineGui", "EventsFrameV2"})
    end, false)
    assert(ctx.eventsFrame:IsA("GuiObject"), "EventsFrameV2 has no Visible property.")
    setStatus("Opening events UI; waiting for Visible=true...")
    setVisibleAndWait(ctx, ctx.eventsFrame, true)
    logChanged(ctx, "eventsVisible", "Events panel opened.", "INFO")
    waitFor(ctx, "Waiting for visible event headers whose lowercase Info.When contains ends...", function()
        return #eventHeaders(ctx) > 0
    end, false)

    local processed, count, claims = {}, 0, 0
    local quietSince
    while true do
        guard(ctx)
        local pending
        for _, header in ipairs(eventHeaders(ctx)) do
            if not processed[header] then pending = header; break end
        end
        if pending then
            quietSince = nil
            local claimed = claimEvent(ctx, pending)
            if claimed ~= nil then
                claims = claims + claimed
                processed[pending] = true
                count = count + 1
            else
                pause(CONFIG.Poll)
            end
        else
            quietSince = quietSince or os.clock()
            if os.clock() - quietSince >= CONFIG.SettleTime then break end
            pause(CONFIG.Poll)
        end
    end
    closeEvents(ctx)
    return string.format("Done: checked %d events; clicked %d unlocked rewards. Events UI closed.", count, claims)
end

local function mailIsClaimable(ctx, mail)
    local list = ctx.mailboxFrame:FindFirstChild("List")
    if not list or mail.Parent ~= list or mail.Name:sub(1, 4) ~= "Mail" then return false end
    local claimable = mail:FindFirstChild("Claimable", true)
    return claimable ~= nil and (claimable:IsA("TextLabel") or claimable:IsA("TextButton")
        or claimable:IsA("TextBox"))
        and claimable.Visible == true
        and string.find(string.lower(claimable.Text), "claimable", 1, true) ~= nil
end

local function mailboxMails(ctx)
    local list = ctx.mailboxFrame:FindFirstChild("List")
    local mails = {}
    if list then
        for _, mail in ipairs(list:GetChildren()) do
            if mail:IsA("GuiObject") and mailIsClaimable(ctx, mail) then
                table.insert(mails, mail)
            end
        end
    end
    table.sort(mails, function(a, b)
        if a.LayoutOrder ~= b.LayoutOrder then return a.LayoutOrder < b.LayoutOrder end
        return a.Name < b.Name
    end)
    return mails
end

local function mailboxRewardHasBadge(reward)
    -- Item names vary; each reward's eligibility comes only from its own ClaimBadge.Visible.
    for _, descendant in ipairs(reward:GetDescendants()) do
        if descendant.Name == "ClaimBadge" and descendant:IsA("GuiObject")
            and descendant.Parent.Name == "Content" and descendant.Visible == true then
            return true
        end
    end
    return false
end

local function mailboxBadgeRewards(ctx)
    local list = path(ctx.mailboxFrame, {"Detail", "Rewards", "List"})
    if not list then return nil, {} end
    local rewards = {}
    for _, reward in ipairs(list:GetChildren()) do
        local number = tonumber(reward.Name:match("^Reward(%d+)$"))
        if number and reward:IsA("GuiObject") and mailboxRewardHasBadge(reward) then
            table.insert(rewards, {object = reward, number = number})
        end
    end
    table.sort(rewards, function(a, b) return a.number < b.number end)
    return list, rewards
end

local function claimMail(ctx, mail)
    setStatus("Opening mail: " .. mail.Name .. "...")
    if not clickButton(ctx, mail, false, function() return mailIsClaimable(ctx, mail) end) then
        return nil
    end
    log("Selected mail: " .. mail.Name, "INFO", ctx)
    local nextSelection = os.clock() + CONFIG.VisibilityRetry
    local detailReady = waitFor(ctx, "Waiting for MailboxFrame.Detail.Visible: " .. mail.Name .. "...", function()
        local detail = ctx.mailboxFrame:FindFirstChild("Detail")
        if detail and detail:IsA("GuiObject") and detail.Visible == true then return detail end
        if os.clock() >= nextSelection then
            -- Selecting the mail populates Detail; retry the selection instead of
            -- forcing an empty Detail panel visible.
            if not clickButton(ctx, mail, false, function() return mailIsClaimable(ctx, mail) end) then
                return {selectionLost = true}
            end
            nextSelection = os.clock() + CONFIG.VisibilityRetry
        end
        return nil
    end, false, math.huge)
    if type(detailReady) == "table" and detailReady.selectionLost then return nil end

    local emptySince, previousList, previousRewards
    local lastProgressAt = os.clock()
    local nextClick, clicked, total = {}, {}, 0
    while true do
        guard(ctx)
        local list, rewards = mailboxBadgeRewards(ctx)
        local now = os.clock()
        local changed = list ~= previousList or not previousRewards or #rewards ~= #previousRewards
        if not changed then
            for index, reward in ipairs(rewards) do
                if reward.object ~= previousRewards[index].object then changed = true; break end
            end
        end
        if changed then lastProgressAt = now end
        previousList, previousRewards = list, rewards
        if list then
            if #rewards == 0 then
                emptySince = emptySince or now
                if now - emptySince >= CONFIG.SettleTime then
                    log(mail.Name .. ": no visible ClaimBadge remains.", "INFO", ctx)
                    return total
                end
            else
                emptySince = nil
                -- Click eligible Reward<number> in numeric order, then rescan their current badges.
                for _, entry in ipairs(rewards) do
                    local reward = entry.object
                    if reward.Parent == list and visible(reward) and mailboxRewardHasBadge(reward)
                        and os.clock() >= (nextClick[reward] or 0) then
                        local didClick = clickButton(ctx, reward, false, function()
                            return path(ctx.mailboxFrame, {"Detail", "Rewards", "List"}) == list
                                and reward.Parent == list and visible(reward) and mailboxRewardHasBadge(reward)
                        end)
                        if didClick then
                            nextClick[reward] = os.clock() + CONFIG.ClaimRetry
                            if not clicked[reward] then
                                clicked[reward] = true
                                total = total + 1
                                lastProgressAt = os.clock()
                            end
                            logRetry(ctx, "mailClaim:" .. mail.Name .. ":" .. reward.Name,
                                mail.Name .. " / " .. reward.Name .. ": claim requested", "CLAIM")
                        end
                    end
                end
            end
            setStatus("Claiming " .. mail.Name .. ": " .. tostring(#rewards) .. " visible ClaimBadge(s) remaining...")
        else
            emptySince = nil
            setStatus("Waiting for Detail.Rewards.List in " .. mail.Name .. "...")
        end
        if os.clock() - lastProgressAt >= CONFIG.LoadTimeout then
            error("Mail " .. mail.Name .. ": reward ClaimBadge state stopped updating.", 0)
        end
        -- Badge disappearance, including an initially empty list, completes this mail.
        pause(CONFIG.Poll)
    end
end

local function closeMailbox(ctx, reason)
    if not ctx or not ctx.mailboxFrame then return end
    closeStageFrames(ctx, "MailboxFrame", ctx.mailboxFrame)
    logChanged(ctx, "mailboxVisible", "Mailbox panel closed.", "INFO")
end

local function closeMailboxAndWait(ctx)
    setStatus("Confirming mailbox is closed...")
    closeMailbox(ctx)
end

local function runMailbox(ctx)
    assert(type(firesignal) == "function", "Volt firesignal is required.")
    ctx.mailboxFrame = waitFor(ctx, "Waiting for MailboxFrame...", function()
        return path(playerGui, {"MineGui", "MailboxFrame"})
    end, false)
    assert(ctx.mailboxFrame:IsA("GuiObject"), "MailboxFrame has no Visible property.")
    local completed, count, claims = {}, 0, 0
    while true do
        guard(ctx)
        setStatus("Opening mailbox UI; waiting for Visible=true...")
        setVisibleAndWait(ctx, ctx.mailboxFrame, true)
        logChanged(ctx, "mailboxVisible", "Mailbox panel opened.", "INFO")
        waitFor(ctx, "Waiting for mailbox List...", function()
            local list = ctx.mailboxFrame:FindFirstChild("List")
            return list and visible(list) and list
        end, false)

        -- Every opening refreshes the list; select only one mail from its current Claimable.Text.
        local openedAt = os.clock()
        waitFor(ctx, "Refreshing mailbox entries...", function()
            return os.clock() - openedAt >= CONFIG.RefreshDelay
        end, false)
        assert(visible(ctx.mailboxFrame), "Mailbox UI was hidden during claiming. Run again.")
        local pending
        for _, mail in ipairs(mailboxMails(ctx)) do
            -- Reopening can leave a stale Claimable label or recreate the same mail instance.
            if not completed[mail.Name] then pending = mail; break end
        end
        if not pending then
            closeMailboxAndWait(ctx)
            break
        end

        local claimed = claimMail(ctx, pending)
        if claimed ~= nil then
            completed[pending.Name] = true
            count = count + 1
            claims = claims + claimed
        end
        closeMailboxAndWait(ctx)
        -- Let close handlers run before reopening and checking the refreshed list again.
        pause(CONFIG.Poll)
    end
    return string.format("Done: checked %d mail; clicked %d rewards. Mailbox UI closed.", count, claims)
end


-- Index categories select Tier_<category>_<number> groups in the shared reward track.
local function indexCategories(ctx)
    local scroll = path(ctx.indexFrame, {"Content", "Categories", "Scroll"})
    local categories = {}
    if scroll then
        for _, category in ipairs(scroll:GetChildren()) do
            local badge = path(category, {"Content", "Container", "Badge"})
            if category:IsA("GuiObject") and badge and badge:IsA("GuiObject")
                and badge.Visible == true then
                table.insert(categories, category)
            end
        end
    end
    table.sort(categories, function(a, b)
        if a.LayoutOrder ~= b.LayoutOrder then return a.LayoutOrder < b.LayoutOrder end
        return a.Name < b.Name
    end)
    return categories
end

local function indexRewardBadge(reward)
    return path(reward, {"Card", "Content", "ClaimBadge"})
end

local function indexSnapshot(ctx, categoryName)
    local track = path(ctx.indexFrame, {"Content", "Scroll", "Rewards", "Track"})
    if not track or not visible(track) then return nil end
    -- Include the separator so Z1 cannot match Z12 or Z13.
    local prefix = "Tier_" .. categoryName .. "_"
    local tiers, rewards = {}, {}
    for _, tier in ipairs(track:GetChildren()) do
        if tier.Name:sub(1, #prefix) == prefix and tier:IsA("GuiObject") then
            if not visible(tier) then return nil end
            table.insert(tiers, tier)
        end
    end
    if #tiers == 0 then return nil end
    table.sort(tiers, function(a, b)
        local aNumber = tonumber(a.Name:sub(#prefix + 1)) or math.huge
        local bNumber = tonumber(b.Name:sub(#prefix + 1)) or math.huge
        if aNumber ~= bNumber then return aNumber < bNumber end
        return a.Name < b.Name
    end)
    for _, tier in ipairs(tiers) do
        local cards = tier:FindFirstChild("Cards")
        if not cards or not visible(cards) then return nil end
        local tierRewards = {}
        for _, reward in ipairs(cards:GetChildren()) do
            local number = tonumber(reward.Name:match("^Reward_?(%d+)$"))
            if number and reward:IsA("GuiObject") then
                local badge = indexRewardBadge(reward)
                -- Missing rewards or badges mean the selected category is still loading.
                if not badge or not badge:IsA("GuiObject") then return nil end
                table.insert(tierRewards, {object = reward, number = number, cards = cards,
                    badge = badge, claimable = badge.Visible == true, shown = visible(reward)})
            end
        end
        if #tierRewards == 0 then return nil end
        table.sort(tierRewards, function(a, b) return a.number < b.number end)
        for _, entry in ipairs(tierRewards) do table.insert(rewards, entry) end
    end
    return {track = track, tiers = tiers, rewards = rewards}
end

local function sameIndexSnapshot(a, b)
    if not a or not b or a.track ~= b.track
        or #a.tiers ~= #b.tiers or #a.rewards ~= #b.rewards then return false end
    for index, tier in ipairs(a.tiers) do
        if tier ~= b.tiers[index] then return false end
    end
    for index, reward in ipairs(a.rewards) do
        local other = b.rewards[index]
        if reward.object ~= other.object or reward.badge ~= other.badge
            or reward.cards ~= other.cards or reward.claimable ~= other.claimable
            or reward.shown ~= other.shown then return false end
    end
    return true
end

local function claimIndexCategory(ctx, category)
    setStatus("Opening Index category: " .. category.Name .. "...")
    clickButton(ctx, category, false)
    local selectedAt = os.clock()
    local nextSelection = selectedAt + CONFIG.VisibilityRetry
    local nextClick = selectedAt + CONFIG.RefreshDelay
    local previous, stableSince
    local attemptedAt, total, categoryReady = {}, 0, false
    while true do
        guard(ctx)
        assert(visible(ctx.indexFrame), "Index UI was hidden during claiming. Run again.")
        local snapshot = indexSnapshot(ctx, category.Name)
        local now = os.clock()
        if not sameIndexSnapshot(previous, snapshot) then stableSince = now end
        previous = snapshot
        if snapshot and now - selectedAt >= CONFIG.RefreshDelay
            and stableSince and (categoryReady or now - stableSince >= CONFIG.SettleTime) then
            categoryReady = true
            local remaining, pending = 0, nil
            for _, entry in ipairs(snapshot.rewards) do
                if entry.claimable then
                    remaining = remaining + 1
                    -- Prefer unclicked rewards, then retry the oldest outstanding claim.
                    if entry.shown and (not pending or (attemptedAt[entry.object] or -math.huge)
                        < (attemptedAt[pending.object] or -math.huge)) then
                        pending = entry
                    end
                end
            end
            if remaining == 0 and now - stableSince >= CONFIG.SettleTime then
                log(category.Name .. ": no reward ClaimBadge remains visible.", "INFO", ctx)
                return total
            end
            setStatus("Claiming Index " .. category.Name .. ": " .. tostring(remaining) .. " badge(s) remaining...")
            if pending and now >= nextClick then
                local didClick = clickButton(ctx, pending.object, false, function()
                    return path(ctx.indexFrame, {"Content", "Scroll", "Rewards", "Track"}) == snapshot.track
                        and pending.cards:IsDescendantOf(snapshot.track)
                        and pending.object.Parent == pending.cards and visible(pending.object)
                        and indexRewardBadge(pending.object) == pending.badge
                        and pending.badge.Visible == true
                end)
                if didClick then
                    if not attemptedAt[pending.object] then total = total + 1 end
                    attemptedAt[pending.object] = os.clock()
                    nextClick = os.clock() + CONFIG.ClaimRetry
                    logRetry(ctx, "indexClaim:" .. pending.object:GetFullName(),
                        category.Name .. " / " .. pending.cards.Parent.Name .. " / " .. pending.object.Name
                            .. ": claim requested", "CLAIM")
                end
            end
        else
            setStatus("Waiting for visible Index tiers and rewards: " .. category.Name .. "...")
            if not snapshot then categoryReady = false end
            if not snapshot and now >= nextSelection then
                clickButton(ctx, category, false)
                nextSelection = os.clock() + CONFIG.VisibilityRetry
                selectedAt = os.clock()
            end
        end
        -- Rescan after every click; a click alone never marks a reward as claimed.
        task.wait(CONFIG.Poll)
    end
end

local function closeIndex(ctx, reason)
    if not ctx or not ctx.indexFrame then return end
    closeStageFrames(ctx, "IndexFrame", ctx.indexFrame)
    logChanged(ctx, "indexVisible", "Index panel closed.", "INFO")
end

local function runIndex(ctx)
    assert(type(firesignal) == "function", "Volt firesignal is required.")
    ctx.indexFrame = waitFor(ctx, "Waiting for IndexFrame...", function()
        return path(playerGui, {"MineGui", "IndexFrame"})
    end, false)
    assert(ctx.indexFrame:IsA("GuiObject"), "IndexFrame has no Visible property.")
    setVisibleAndWait(ctx, ctx.indexFrame, true)
    waitFor(ctx, "Waiting for Index categories...", function()
        local scroll = path(ctx.indexFrame, {"Content", "Categories", "Scroll"})
        return scroll and visible(scroll) and scroll
    end, false)
    task.wait(CONFIG.RefreshDelay)
    local completed, count, claims = {}, 0, 0
    local quietSince
    while true do
        guard(ctx)
        assert(visible(ctx.indexFrame), "Index UI was hidden during claiming. Run again.")
        local pending
        for _, category in ipairs(indexCategories(ctx)) do
            if not completed[category.Name] then pending = category; break end
        end
        if pending then
            quietSince = nil
            claims = claims + claimIndexCategory(ctx, pending)
            completed[pending.Name] = true
            count = count + 1
        else
            quietSince = quietSince or os.clock()
            if os.clock() - quietSince >= CONFIG.SettleTime then break end
            task.wait(CONFIG.Poll)
        end
    end
    closeIndex(ctx)
    return string.format("Done: checked %d Index categories; clicked %d rewards. Index UI closed.", count, claims)
end

-- No waits or retry workers in cancellation: invalidate first, then attempt each
-- cleanup independently so a missing/replaced panel cannot block Stop or unload.
local function cancelTrialRequest(ctx)
    local ok, message = pcall(function()
        local event = path(ReplicatedStorage, {"Remotes", "GamestateEvent"})
        if not event or not event:IsA("RemoteEvent") then event = ctx and ctx.event end
        assert(event and event:IsA("RemoteEvent"), "GamestateEvent is unavailable for trial cancellation.")
        event:FireServer("MineTrialCancel")
        if ctx then ctx.cancelSent = true end
    end)
    if ok then log("MineTrialCancel end request sent.", "INFO", ctx)
    else log("Trial end request failed: " .. tostring(message), "ERROR", ctx) end
    return ok
end

local function closeContext(ctx)
    if not ctx or ctx.cleaned then return true end
    ctx.cleaned = true
    local complete = true
    local function attempt(callback)
        local ok, message = pcall(callback)
        if not ok then
            complete = false
            log("Cleanup failed: " .. tostring(message), "ERROR", ctx)
        end
    end
    if ctx.stageWorker then
        local thread = ctx.stageWorker
        if thread ~= coroutine.running() then
            attempt(function() if coroutine.status(thread) ~= "dead" then task.cancel(thread) end end)
        end
        runScope.threads[thread] = nil
        ctx.stageWorker = nil
    end
    if ctx.trialRequested and not ctx.cancelSent and not cancelTrialRequest(ctx) then complete = false end
    local frameName = ctx.stage.frameName
    local original = ctx[ctx.stage.frameKey]
    local current = path(playerGui, {"MineGui", frameName})
    local function hide(frame)
        if frame and frame:IsA("GuiObject") and frame:IsDescendantOf(playerGui) then
            attempt(function()
                frame.Visible = false
                assert(not frame.Visible, frame.Name .. " did not close.")
            end)
        end
    end
    hide(current)
    if original ~= current then hide(original) end
    if ctx.stage.name == "Sell" then
        hide(path(playerGui, {"MineGui", "ChestFrame"}))
        attempt(releaseInputs)
        attempt(restorePosition)
        if activeRun == "autoSequence" and activeStage == "sell" then activeStage = "autoSequence" end
    end
    return complete
end
local function cleanupSequence()
    local ctx = activeContext
    activeContext = nil
    local closed = closeContext(ctx)
    if alive then refreshAutoTasksNext() end
    return closed
end
connect(nextButton.Activated, function()
    local ctx = activeContext
    if not alive or not busy or activeRun ~= "autoSequence" or not ctx
        or ctx.cleaned or ctx.finished or ctx.skipRequested or os.clock() < stopReadyAt then return end
    ctx.skipRequested = true
    ctx.skipClosed = closeContext(ctx)
    if ctx.stage.name == "Trial" and not ctx.cancelSent then
        ctx.skipClosed = cancelTrialRequest(ctx) and ctx.skipClosed
    end
    ctx.finished = true
    refreshAutoTasksNext()
    statusLabel.Text = ctx.stage.name .. " ended early. "
        .. (ctx.lastStage and "Finishing Auto tasks..." or "Moving to the next stage...")
end)
local sequence = {
    {name = "Trial", run = runTrial, frameName = "TrialFrame", frameKey = "frame"},
    {name = "Sell", frameName = "SellFrame", frameKey = "sellFrame", run = function()
        local previousStage = activeStage
        activeStage = "sell"
        local ok, result = pcall(modules.sell.run)
        checkAlive()
        releaseInputs()
        restorePosition()
        activeStage = previousStage
        if not ok then error(result, 0) end
        return result
    end},
    {name = "Events", run = runEvents, frameName = "EventsFrameV2", frameKey = "eventsFrame"},
    {name = "Mailbox", run = runMailbox, frameName = "MailboxFrame", frameKey = "mailboxFrame"},
    {name = "Index", run = runIndex, frameName = "IndexFrame", frameKey = "indexFrame"},
}
modules.autoSequence = {
    cleanup = cleanupSequence,
    canStop = function() return not autoRunning or os.clock() >= stopReadyAt end,
    stop = function()
        -- Explicit Stop always sends the end request, even before Trial set its request flag.
        local cancelled = cancelTrialRequest(activeContext)
        local closed = cleanupSequence()
        return cancelled and closed
    end,
    run = function()
        logStartedAt = os.clock()
        for index, stage in ipairs(sequence) do
            checkAlive()
            local ctx = {stage = stage, green = false, nextMilestonesClick = 0,
                milestonesAttempts = 0, greenExitArmed = false, lastStage = index == #sequence}
            activeContext = ctx
            refreshAutoTasksNext()
            setStatus(string.format("%d/%d: %s...", index, #sequence, stage.name))
            -- A separate stage worker lets Next interrupt every wait, including Sell.
            local owner = runScope.threads[coroutine.running()]
            ctx.stageWorker = task.defer(function()
                runScope.threads[coroutine.running()] = owner
                ctx.ok, ctx.result = pcall(stage.run, ctx)
                ctx.finished = true
                refreshAutoTasksNext()
            end)
            while not ctx.finished do
                checkAlive()
                task.wait(CONFIG.Poll)
            end
            local ok, result = ctx.ok, ctx.result
            -- A cancelled worker must never close the panels of a newer run.
            checkAlive()
            local closed = cleanupSequence()
            if ctx.skipRequested then
                assert(ctx.skipClosed, stage.name .. " cleanup failed; sequence stopped.")
                result = ctx.stage.name .. " ended early; continuing remaining auto tasks."
            elseif not ok then error(result, 0) end
            assert(closed, stage.name .. " cleanup failed; sequence stopped.")
            log(tostring(result), "DONE", ctx)
        end
        return "Finished: Trial > Sell > Events > Mailbox > Index."
    end,
    setBusy = function(running)
        local ownRun = running and activeRun == "autoSequence"
        if ownRun and not autoRunning then
            stopReadyAt = os.clock() + 1
            local token = {}
            startLockToken = token
            startLockThread = task.defer(function()
                task.wait(1)
                runScope.background[coroutine.running()] = nil
                if alive and startLockToken == token then
                    startLockThread = nil
                    refreshAutoTasksNext()
                end
            end)
            runScope.background[startLockThread] = true
        elseif not ownRun then
            startLockToken, stopReadyAt = nil, 0
            if startLockThread then
                if coroutine.status(startLockThread) ~= "dead" then pcall(task.cancel, startLockThread) end
                runScope.background[startLockThread] = nil
                startLockThread = nil
            end
        end
        autoRunning = ownRun
        run.Active, run.AutoButtonColor = not running or ownRun, not running or ownRun
        run.Text = ownRun and "Stop auto tasks" or pages.autoSequence.runText
        run.BackgroundColor3 = ownRun and Color3.fromRGB(165, 67, 79)
            or (running and colors.idle or colors.accent)
        refreshAutoTasksNext()
    end,
}
connect(run.Activated, function()
    if not alive then return end
    if busy and activeRun == "autoSequence" then stopRun(); return end
    if busy then return end
    if minimizedActions.openBusy then
        statusLabel.Text = "Wait for the crate batch to finish."
        return
    end
    startRun("autoSequence")
end)
end)()
end

local function runPage(id)
    return id == "hotbarUpgrade" and modules.hotbarUpgrade.page or pages[id]
end
-- Master locks other action controls; tabs, guides, logs, refresh, and window controls remain usable.
do
    local saved = {}
    for _, control in ipairs({minimizedMaster, pages.master.run, title, close, minimize, stop}) do
        runScope.masterAllowed[control] = true
    end
    minimizedActions.setMasterLocked = function(locked)
        if locked then
            for _, control in ipairs(panel:GetDescendants()) do
                if control:IsA("GuiButton") and not runScope.masterAllowed[control] then
                    if not saved[control] then
                        saved[control] = {active = control.Active, auto = control.AutoButtonColor,
                            color = control.BackgroundColor3}
                    end
                    control.Active, control.AutoButtonColor = false, false
                    if control.Name ~= "TradePresetReset" then control.BackgroundColor3 = colors.idle end
                end
            end
        else
            for control, state in pairs(saved) do
                if control.Parent then
                    control.Active, control.AutoButtonColor = state.active, state.auto
                    control.BackgroundColor3 = state.color
                end
            end
            table.clear(saved)
        end
    end
    minimizedActions.cancelOngoing = function()
        local current = coroutine.running()
        for thread in pairs(runScope.callbacks) do
            if thread ~= current then
                if coroutine.status(thread) ~= "dead" then pcall(task.cancel, thread) end
                runScope.callbacks[thread] = nil
            end
        end
        minimizedActions.setRollEnabled(false)
        minimizedActions.stopOpeningCrates()
        releaseInputs()
        restorePosition()
        preferences.autoAcceptTradeEnabled = false
        return modules.trade.cleanup()
    end
end
local function setControls(running)
    local masterRunning = running and activeRun == "master"
    if not masterRunning then minimizedActions.setMasterLocked(false) end
    refreshStageToggles(running)
    for _, page in pairs(pages) do
        page.run.Active = not running
        page.run.AutoButtonColor = not running
        page.run.BackgroundColor3 = running and colors.idle or colors.accent
        page.run.Text = page.runText
    end
    if running and activeRun then runPage(activeRun).run.Text = "Running..." end
    local tutorialRunning = running and activeRun == "tutorial"
    pages.tutorial.run.Active = not running or tutorialRunning
    pages.tutorial.run.AutoButtonColor = not running or tutorialRunning
    pages.tutorial.run.Text = tutorialRunning and "Stop tutorial" or pages.tutorial.runText
    if tutorialRunning then pages.tutorial.run.BackgroundColor3 = Color3.fromRGB(165, 67, 79) end

    pages.master.run.Active, pages.master.run.AutoButtonColor = true, true
    pages.master.run.Text = masterRunning and "Stop Master" or pages.master.runText
    pages.master.run.BackgroundColor3 = masterRunning and Color3.fromRGB(165, 67, 79) or colors.accent
    minimizedMaster.Active = pages.master.run.Active
    minimizedMaster.AutoButtonColor = pages.master.run.AutoButtonColor
    minimizedMaster.Text = masterRunning and "Master: ON" or "Master: OFF"
    minimizedMaster.BackgroundColor3 = pages.master.run.BackgroundColor3
    stop.Active, stop.AutoButtonColor = running, running
    stop.BackgroundColor3 = running and Color3.fromRGB(165, 67, 79) or colors.idle
    if modules.autoSequence then modules.autoSequence.setBusy(running) end
    if modules.hotbarUpgrade then modules.hotbarUpgrade.setBusy(running) end
    if modules.pickaxe and modules.pickaxe.setBusy then modules.pickaxe.setBusy(running) end
    if modules.upgrades and modules.upgrades.setBusy then modules.upgrades.setBusy(running) end
    if masterRunning then minimizedActions.setMasterLocked(true) end
end

local function resetRun()
    table.clear(scriptErrors.retries)
    if modules.gameSettings and modules.gameSettings.cleanup then pcall(modules.gameSettings.cleanup) end
    if modules.chestRecovery then pcall(modules.chestRecovery.cleanup) end
    runScope.current = nil
    releaseInputs()
    if modules.autoSequence then modules.autoSequence.cleanup() end
    if modules.pickaxe and modules.pickaxe.cleanupWaiting then pcall(modules.pickaxe.cleanupWaiting) end
    if modules.upgrades and modules.upgrades.cleanup then pcall(modules.upgrades.cleanup) end
    if modules.tutorial then modules.tutorial.cleanup() end
    if modules.mutation and modules.mutation.cleanup then pcall(modules.mutation.cleanup) end
    if modules.masterFly then pcall(modules.masterFly.stop) end
    local unitUpgrade = rawget(modules, "upgradingUnit")
    if unitUpgrade and unitUpgrade.cleanup then pcall(unitUpgrade.cleanup) end
    restorePosition()
    busy, activeRun, activeStage = false, nil, nil
    cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone, cycleSkipUnitsReason = nil, nil, nil
    cycleUnitCooldown = nil
    worker = nil
    cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady, cycleBestEquipped = nil, nil, nil, false, false
    if alive then
        setControls(false)
        refreshUnitCooldown()
    end
end

local function closeGamePanel(name)
    local mine = playerGui:FindFirstChild("MineGui")
    local frame = mine and mine:FindFirstChild(name)
    if frame and frame:IsA("GuiObject") then frame.Visible = false end
end

local function skipCycleUnitStages(reason)
    cycleSkipUnitsReason = reason
    cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone = nil, nil
    if activeRun == "master" then
        for _, stage in ipairs({"units", "mutation", "upgradingUnit"}) do
            if preferences.stages[stage] and stage ~= activeStage then
                pages[stage].status.Text = "Skipped this cycle: " .. reason
                pages[stage].status.TextColor3 = colors.muted
                setMasterStageState(stage, "Skipped", colors.muted)
            end
        end
    end
end

do
local completedUnlockPlot

local function slotPrompt(plot, name)
    local holders = plot:FindFirstChild("Holders")
    local holder = holders and holders:FindFirstChild(name)
    local pad = holder and holder:FindFirstChild("Pad")
    return pad and pad:FindFirstChild("HolderPrompt"), holder
end
local function slotReady(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return false end
    local action = prompt.ActionText:match("^%s*(.-)%s*$"):lower()
    return action == "place" or action == "pick up"
end
local function slotUnlockPrompt(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return false end
    local action = prompt.ActionText:match("^%s*(.-)%s*$"):lower()
    return action == "unlock" or action == "unlock at the hub"
end
modules.unlockSlots = {
isComplete = function()
    return completedUnlockPlot ~= nil and completedUnlockPlot == getMyPlot()
end,
invalidate = function() completedUnlockPlot = nil end,
run = function()
    if getCycleZone() ~= "Z4" then return "Skipped: Unlock slots runs only in Z4." end
    local plot = getMyPlot()
    checkPlot(plot)
    if completedUnlockPlot == plot then return "Skipped: all holder slots are already unlocked for this plot." end
    local reportRetry = newRetryMonitor("Unlocking all Z4 holder slots")
    local attempts, lastAngles = {}, {}
    local pendingTarget, pendingNumber
    local function stopAtSlot(name)
        local reason = name .. ": still locked after five unlock attempts."
        skipCycleUnitStages(reason)
        return "Skipped: " .. reason .. " Stages 6-8 skipped this cycle."
    end
    while true do
        checkAlive()
        checkPlot(plot)
        local holders = plot:FindFirstChild("Holders")
        local slots = {}
        for _, holder in ipairs(holders and holders:GetChildren() or {}) do
            local number = tonumber(holder.Name:match("^M(%d+)$"))
            if number and number >= 1 then table.insert(slots, {name = holder.Name, number = number}) end
        end
        table.sort(slots, function(a, b) return a.number < b.number end)
        local target, targetNumber
        local allReady = #slots > 0
        for _, slot in ipairs(slots) do
            local prompt = slotPrompt(plot, slot.name)
            if not slotReady(prompt) then allReady = false end
            if not target and slotUnlockPrompt(prompt) then target, targetNumber = slot.name, slot.number end
        end
        if not target then
            reportRetry(nil, true)
            if allReady then
                completedUnlockPlot = plot
                return "Z4: all " .. #slots .. " holder slots are unlocked."
            end
            return "Skipped: no Unlock / Unlock at the hub prompts found. Stages 6-8 continue normally."
        end
        if pendingNumber and pendingNumber < targetNumber and not slotReady(slotPrompt(plot, pendingTarget)) then
            local reason = pendingTarget .. ": previously locked lower slot is not confirmed unlocked."
            skipCycleUnitStages(reason)
            return "Skipped: " .. reason .. " Higher slots and stages 6-8 skipped this cycle."
        end
        pendingTarget, pendingNumber = target, targetNumber
        local name = target
        if (attempts[name] or 0) >= 5 then return stopAtSlot(name) end
        attempts[name] = (attempts[name] or 0) + 1
        pages.unlockSlots.status.Text = "Unlocking " .. name .. "; attempt " .. attempts[name] .. "/5..."
        local ok, unlocked = pcall(function()
            local prompt, holder = slotPrompt(plot, target)
            if slotReady(prompt) then return true end
            assert(slotUnlockPrompt(prompt), target .. ": no matching unlock prompt.")
            local upgrade = holder and holder:FindFirstChild("UpgradePart")
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            assert(root and upgrade and upgrade:IsA("BasePart"), target .. ": character or UpgradePart is unavailable.")
            if originalRoot ~= root then originalRoot, originalCFrame = root, root.CFrame end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:UnequipTools() end
            local angle = math.random(0, 359)
            if angle == lastAngles[name] then angle = (angle + 1) % 360 end
            lastAngles[name] = angle
            local radians = math.rad(angle)
            local offset = Vector3.new(math.cos(radians), 0, math.sin(radians))
            root.CFrame = CFrame.new(upgrade.Position + Vector3.new(0, CONFIG.Units.TeleportHeight, 0) + offset, upgrade.Position)
            root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
            pause(CONFIG.Units.TeleportDelay)
            checkPlot(plot)
            assert(player.Character == character and root:IsDescendantOf(character), "Character changed during slot unlocking.")
            prompt = slotPrompt(plot, target)
            if slotReady(prompt) then return true end
            assert(slotUnlockPrompt(prompt) and prompt.Enabled,
                target .. ": waiting for its enabled unlock prompt.")
            heldPrompt = prompt
            prompt:InputHoldBegin()
            pause(2)
            releaseInputs()
            local deadline = os.clock() + CONFIG.General.SettleTime
            while true do
                checkAlive()
                checkPlot(plot)
                if slotReady(slotPrompt(plot, target)) then return true end
                if os.clock() >= deadline then return false end
                pause(CONFIG.General.WaitPoll)
            end
        end)
        releaseInputs()
        checkAlive()
        if ok and unlocked then
            reportRetry(nil, true)
        else
            reportRetry(not ok and unlocked or name .. ": still locked after its unlock prompt.")
            -- Every failed unlock sends a fresh request, independent of cycle-end equip caching.
            local equipped, message = pcall(function()
                checkAlive()
                checkPlot(plot)
                getGameEvent():FireServer("MineEquipBest")
                pause(CONFIG.Units.BestEquipDelay)
            end)
            checkAlive()
            if not equipped then reportRetry(message) end
            -- Rescan before the attempt limit so no matching prompts allows normal continuation.
            if attempts[name] < 5 then pause(CONFIG.General.RetryInterval) end
        end
    end
end}
end

modules.cycleEnd = {run = function()
    checkAlive()
    checkPlot(getMyPlot())
    requestCycleBestEquip()
    modules.upgrades.selectZones()
end}

local function runStage(id, cacheZoneOnly)
    checkAlive()
    activeStage = id
    local page = runPage(id)
    page.status.TextColor3 = colors.muted
    page.status.Text = "Preparing " .. page.name .. "..."
    footer.Text = "Running: " .. page.name
    if activeRun == "master" then
        setMasterStageState(id, "Running", colors.accent)
        pages.master.status.Text = page.name .. ": preparing..."
    end
    local result
    if cacheZoneOnly then
        assert(id == "upgrades", "Zone/Density scans belong to the Upgrades step.")
        result = modules.upgrades.cacheCurrentZone()
    else
        result = modules[id].run()
    end
    checkAlive()
    releaseInputs()
    restorePosition()
    scriptErrors.clearStage(id)
    page.status.Text = tostring(result or "Finished.")
    page.status.TextColor3 = colors.success
    if id == "hotbarUpgrade" or id == "tutorial" or id == "autoSequence" then logInfo(page.name, page.status.Text)
    else logStageResult(id, page.status.Text) end
    if activeRun == "master" then
        local enabled = preferences.stages[id]
        setMasterStageState(id, enabled and "Done" or "OFF", enabled and colors.success or colors.muted)

        if id == "sell" then closeGamePanel("SellFrame") end
        if id ~= "cycleEnd" then pause(CONFIG.Flow.StageDelay) end
    end
    return result
end

startRun = function(id)
    if not alive then return end
    -- Master takes over immediately, including an in-progress Auto tasks stage.
    if id == "master" and busy and activeRun ~= "master" then stopRun(true) end
    if busy or (id ~= "master" and os.clock() - lastRun < CONFIG.General.ButtonDebounce) then
        if alive and (id == "upgradingUnit" or id == "upgradingOldUnit" or id == "master") then
            logUnitUpgradeDetail(string.format("Start ignored for %s: busy=%s; active run=%s; active stage=%s; debounce remaining=%.2fs",
                id, tostring(busy), tostring(activeRun), tostring(activeStage),
                math.max(0, CONFIG.General.ButtonDebounce - (os.clock() - lastRun))))
        end
        return
    end
    if id == "tutorial" and (preferences.tutorialHidden or minimizedActions.openBusy) then return end
    if id == "autoSequence" and minimizedActions.openBusy then return end

    if (id == "pickaxe" or (id == "master" and preferences.stages.pickaxe)) and not modules.pickaxe.prepare() then
        pages.master.status.Text = "Check the Pickaxe tab: its limit could not be saved."
        pages.master.status.TextColor3 = colors.error
        selectTab("pickaxe")
        return
    end
    if not alive or busy then return end
    if id == "master" and not minimizedActions.cancelOngoing() then
        pages.master.status.Text = "Could not release the previous trade input. Try Master again."
        pages.master.status.TextColor3 = colors.error
        return
    end
    scriptErrors.clearAll()
    local token = {id = id}
    runScope.current = token
    busy, activeRun, activeStage = true, id, nil
    cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone, cycleSkipUnitsReason = nil, nil, nil
    cycleUnitCooldown = nil
    cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady, cycleBestEquipped = nil, nil, nil, false, false
    lastRun = os.clock()
    local page = runPage(id)
    page.status.TextColor3 = colors.muted
    if id == "hotbarUpgrade" or id == "tutorial" or id == "autoSequence" then minimizedActions.setRollEnabled(false) end
    if id == "master" then
        minimizedActions.setRollEnabled(false)
        preferences.masterEnabled = true
        resetStageRows()
    end
    if not actionIsCurrent(token) then return end
    setControls(true)
    if id == "master" then savePreferences() end
    if not actionIsCurrent(token) then return end
    worker = task.defer(function()
        runScope.threads[coroutine.running()] = token
        if not actionIsCurrent(token) then return end
        local ok, result = pcall(function()
            if id == "master" then
                local cycle = 0
                while actionIsCurrent(token) do
                    checkAlive()
                    cycle = cycle + 1
                    refreshUnitCooldown()
                    cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone, cycleSkipUnitsReason = nil, nil, nil
                    cycleUnitCooldown = nil
                    cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady, cycleBestEquipped = nil, nil, nil, false, false
                    resetStageRows()
                    local cycleOK, cycleError = pcall(function()
                        pages.master.status.Text = "Cycle " .. cycle .. ": reading the current zone..."
                        local zoneId = getCycleZone()
                        syncUnitSequenceZone(zoneId)
                        if cycle == 1 then modules.workspaceCleanup.onMasterEnabled() end
                        modules.workspaceCleanup.beginCycle(zoneId)
                        if cycle == 1 then
                            savePreferences()
                            modules.masterFly.start()
                            modules.gameSettings.apply(nil, pages.master.status)
                        end
                        modules.dailyRewards.runCycle()
                        for _, stage in ipairs(order) do
                            -- Always visit Upgrades; OFF still opens the frame through Visible and scans fresh values.
                            if stage == "upgrades" then
                                runStage(stage, not preferences.stages.upgrades)
                            elseif stage == "units" then
                                modules.workspaceCleanup.runForCycle()
                                if preferences.stages.units and not cycleSkipUnitsReason then runStage(stage) end
                            elseif stage == "unlockSlots" and preferences.stages[stage]
                                and cycleZoneId == "Z4" and modules.unlockSlots.isComplete() then
                                pages.unlockSlots.status.Text = "Skipped: all holder slots are already unlocked for this plot."
                                pages.unlockSlots.status.TextColor3 = colors.muted
                                setMasterStageState(stage, "Skipped", colors.muted)
                            elseif stage ~= "cycleEnd" and preferences.stages[stage] then
                                if not (cycleSkipUnitsReason and (stage == "units" or stage == "mutation" or stage == "upgradingUnit")) then
                                    runStage(stage)
                                    if stage == "sell" then
                                        modules.plotCleanup.start()
                                    end
                                end
                            end
                        end
                    end)
                    checkAlive()
                    releaseInputs()
                    if modules.mutation.cleanup then pcall(modules.mutation.cleanup) end
                    if modules.upgradingUnit.cleanup then pcall(modules.upgradingUnit.cleanup) end
                    restorePosition()
                    if not cycleOK then
                        local failed = activeStage
                        logError(failed and pages[failed].name or "Master", cycleError)
                        if failed then
                            pages[failed].status.Text = "Error: " .. tostring(cycleError)
                            pages[failed].status.TextColor3 = colors.error
                            setMasterStageState(failed, "Error; retry next cycle", colors.error)
                        end
                        if failed == "units" or failed == "unlockSlots" then
                            skipCycleUnitStages(pages[failed].name .. " failed.")
                        end

                        closeGamePanel("SellFrame")
                        closeGamePanel("SkillTreeFullFrame")
                        closeGamePanel("InventoryFrame")
                        if failed == "units" and cycleZoneId == "Z4" and preferences.stages.unlockSlots
                            and tostring(cycleError):find("waiting for its unlocked placement prompt", 1, true) then
                            modules.unlockSlots.invalidate()
                            local recovered, message = pcall(runStage, "unlockSlots")
                            checkAlive()
                            releaseInputs()
                            restorePosition()
                            if not recovered then
                                logError("Unlock slots", message)
                                pages.unlockSlots.status.Text = "Error: " .. tostring(message)
                                pages.unlockSlots.status.TextColor3 = colors.error
                                setMasterStageState("unlockSlots", "Error; retry next cycle", colors.error)
                            end
                        end
                    end
                    activeStage = nil
                    pages.master.status.Text = "Cycle " .. cycle .. (cycleBestEquipped
                        and ": selecting zones; Equip Best already requested..."
                        or ": equipping best, then selecting zones...")
                    local equipOK, equipError = true, nil
                    if preferences.stages.cycleEnd then
                        equipOK, equipError = pcall(runStage, "cycleEnd")
                    end
                    checkAlive()
                    if not equipOK then
                        logError("Cycle Finish", equipError)
                        pages.cycleEnd.status.Text = "Error: " .. tostring(equipError)
                        pages.cycleEnd.status.TextColor3 = colors.error
                        setMasterStageState("cycleEnd", "Error; retry next cycle", colors.error)
                    end
                    pages.master.status.Text = (cycleOK and equipOK)
                        and string.format("Cycle %d complete. Master ON; next cycle in %g seconds.", cycle, CONFIG.Flow.CycleDelay)
                        or string.format("Cycle %d had an error. Master ON; retrying in %g seconds.", cycle, CONFIG.Flow.CycleDelay)
                    pages.master.status.TextColor3 = (cycleOK and equipOK) and colors.success or colors.error
                    footer.Text = string.format("Master ON | Cycle %d | Next cycle in %g seconds", cycle, CONFIG.Flow.CycleDelay)
                    modules.pickaxe.waitBetweenCycles(CONFIG.Flow.CycleDelay)
                end
                return "Master OFF."
            end
            local result = runStage(id)

            if id == "upgrades" then modules.upgrades.selectZones() end
            return result
        end)
        if not actionIsCurrent(token) then return end
        releaseInputs()
        if modules.upgradingUnit.cleanup then pcall(modules.upgradingUnit.cleanup) end
        restorePosition()
        if alive and gui.Parent then
            page.status.Text = ok and tostring(result) or ("Error: " .. tostring(result))
            page.status.TextColor3 = ok and colors.success or colors.error
            if not ok and activeStage then
                runPage(activeStage).status.Text = "Error: " .. tostring(result)
                runPage(activeStage).status.TextColor3 = colors.error
                if id == "master" then
                    setMasterStageState(activeStage, "Error; flow stopped", colors.error)
                    pages.master.status.Text = "Stopped at " .. runPage(activeStage).name .. ": " .. tostring(result)
                end
            end
            footer.Text = ok and "Finished. Ready for another run." or "Stopped after an error. See the active stage's tab."
            if not ok then
                logError(activeStage and runPage(activeStage).name or page.name, result)
            end
        end
        resetRun()
    end)
end

stopRun = function(force)
    if not alive or not busy then return end
    if activeRun == "autoSequence" and not force and modules.autoSequence and not modules.autoSequence.canStop() then return end
    scriptErrors.clearAll()
    local stoppedRun, stoppedStage = activeRun, activeStage
    if stoppedRun == "master" then
        preferences.masterEnabled = false
    end
    runScope.current = nil
    if stoppedRun == "autoSequence" and modules.autoSequence then
        local ok, message = pcall(modules.autoSequence.stop)
        if not ok then logError("Auto tasks", message) end
    end
    logInfo(stoppedStage and runPage(stoppedStage).name or "Master", "Stopped by user.")
    logging.flush()
    if worker then pcall(task.cancel, worker) end
    resetRun()
    if stoppedStage == "sell" then closeGamePanel("SellFrame") end
    if stoppedRun == "master" then savePreferences() end
    if stoppedRun then
        runPage(stoppedRun).status.Text = stoppedRun == "master"
            and "Master OFF. Already-sent requests are retained."
            or "Stopped. Already-sent requests are retained."
        runPage(stoppedRun).status.TextColor3 = colors.muted
    end
    if stoppedStage then
        runPage(stoppedStage).status.Text = "Stopped. Press Run to start this stage again."
        runPage(stoppedStage).status.TextColor3 = colors.muted
        if stoppedRun == "master" then
            setMasterStageState(stoppedStage, "Stopped")
        end
    end
    footer.Text = stoppedRun == "autoSequence" and "Auto tasks stopped." or "Stopped. Master OFF."
end
connect(stop.Activated, function() stopRun() end)

setControls(false)
refreshUnitCooldown()
do

    local parents = {}
    if type(gethui) == "function" then
        local ok, hiddenGui = pcall(gethui)
        if ok and typeof(hiddenGui) == "Instance" then table.insert(parents, hiddenGui) end
    end
    local ok, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if ok then table.insert(parents, coreGui) end
    table.insert(parents, playerGui)
    for _, parent in ipairs(parents) do
        if pcall(function() gui.Parent = parent end) then break end
    end

end
resize()
modules.workspaceCleanup.refresh()
if preferences.masterEnabled and not busy then startRun("master") end
if not busy then modules.trade.restorePreference() end