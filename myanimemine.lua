-- MAINTENANCE: Whenever a new Workspace path is used anywhere in this script,
-- add it to WORLD_KEEP or PLOT_KEEP below (unless its subtree is already kept).
-- Workspace auto deletion and Run once must never delete paths the script uses.
local scriptLoadedAt = os.time()

local CONFIG = {
    General = {
        DeleteOtherPlots = true,
        WorkspaceCleanupEnabled = true,
        MasterFlySpeed = 40,
        LoadTimeout = math.huge, -- Unlimited waits; retry reports are configured under Logging.
        RetryInterval = 1,
        SettleTime = 0.75,
        StartupTeleportClickInterval = 1,
        StartupCollectDelay = 0.5,
        StartupTeleportMinDistance = 10,
        ScanPoll = 0.1,
        WaitPoll = 0.05,
        ButtonDebounce = 0.25,
        DefaultClickEvent = "MouseButton1Click",
    },
    Flow = {

        DefaultMasterEnabled = true,
        DefaultStages = {
            sell = true,
            pickaxe = true,
            upgrades = true,
            upgradingOldUnit = true,
            units = true,
            mutation = true,
            upgradingUnit = true,
            cycleEnd = true,
        },

        Order = { "sell", "pickaxe", "upgrades", "upgradingOldUnit", "units", "mutation", "upgradingUnit", "cycleEnd" },
        StageDelay = 0.75,
        CycleDelay = 20,
    },
    Sell = {
        TeleportDelay = 1.5,
        ChestDelay = 1.0,
        StandDelay = 0.6,
        PromptHold = 0.05,
        PromptDelay = 0.3,
        ShopTimeout = math.huge,
        ShopDelay = 0.3,
        SelectAllDelay = 0.6,
        SellDelay = 1.2,
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
        DamageTargetLevel = 130,
        IdentitySettleTime = 0.2,
        Placement = {
            TeleportDelay = 0.35, KeyHold = 0.05, EquipDelay = 0.3, AfterPromptDelay = 0.6,
        },
    },
    UpgradingOldUnit = {
        TargetLevel = 70,
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
                RequiredUnitCount = 7,
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
                RequiredUnitCount = 7,
                Names = { "Petal Storm Noble", "Hypnosis Usurper", "Almighty Quincy King" },
            },
            Z7 = {
                DisplayName = "Dawnvault",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 4,
                    Rainbow = 1,
                    Frozen = 2,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 7,
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
                RequiredUnitCount = 7,
                Names = { "Witch of Greed", "Forbidden Librarian", "One Arm Pirates (Prime)", "Golden Gate King" },
            },
            Z9 = {
                DisplayName = "Stillstorm",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 4,
                    Rainbow = 1,
                    Frozen = 2,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 7,
                Names = {"Royal Guard", "Child The Liar Shiny", "Silver Spirit Princess"},
            },
            Z10 = {
                DisplayName = "Worldheart",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 4,
                    Rainbow = 1,
                    Frozen = 1,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 7,
                Names = { "Vampire Emperor", "Martial Demon", "King Of Namek" },
            },
            Z11 = {
                DisplayName = "Soulforge",
                MaxLevelCap = 40,
                DamageBatchSize = 5, -- Damage upgrades per unit before reselecting.
                RequiredMutations = {
                    Platinum = 4,
                    Rainbow = 1,
                    Frozen = 2,
                    Inferno = 0,
                    Nightmare = 0,
                    Unreal = 0,
                },
                RequiredUnitCount = 7,
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
                    Unreal = 5,
                },
                RequiredUnitCount = 5,
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
        MinimizedWidth = 360, MinimizedHeight = 192,
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
        RetryReportSeconds = 15,
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
local runScope = {current = nil, threads = setmetatable({}, {__mode = "k"}), background = {}}
local connections, shownPrompts = {}, {}
local heldPrompt, heldKey, mouseHeld = nil, nil, nil
local originalRoot, originalCFrame = nil, nil
local dragging, touchPointer, dragStart, panelStart = false, nil, nil, nil
local modules, pages, tabs, stageRows = {}, {}, {}, {}
local order = CONFIG.Flow.Order
local validStages, seenStages = {sell=true, pickaxe=true, upgrades=true, upgradingOldUnit=true, units=true, mutation=true, upgradingUnit=true, cycleEnd=true}, {}
assert(#order == 8 and order[8] == "cycleEnd", "CONFIG.Flow.Order must contain all eight stages, with cycleEnd last.")
for _, id in ipairs(order) do
    assert(validStages[id] and not seenStages[id], "CONFIG.Flow.Order has an invalid or duplicate stage: " .. tostring(id))
    seenStages[id] = true
end
local selectedTab = CONFIG.UI.InitialTab
local lastRun = -math.huge
local unloadScript, startRun, stopRun
local gameEvent
local consolePrint, consoleWarn = print, warn
local scriptLogs = {}
do
    local originalPrint, originalWarn = consolePrint, consoleWarn
    local function record(level, ...)
        local parts = {}
        for index = 1, select("#", ...) do
            local value = select(index, ...)
            parts[index] = tostring(value)
        end
        table.insert(scriptLogs, os.date("[%H:%M:%S] ") .. level .. " " .. table.concat(parts, "\t"))
        -- Keep recent logs in memory without changing the preferences cache.
        if #scriptLogs > 2000 then table.remove(scriptLogs, 1) end
    end
    consolePrint = function(...)
        record("INFO", ...)
        originalPrint(...)
    end
    consoleWarn = function(...)
        record("WARN", ...)
        originalWarn(...)
    end
end
local consoleStageLabels = {
    sell = "Sell", pickaxe = "Pickaxe", upgrades = "Upgrades", upgradingOldUnit = "Upgrade Old Units",
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
local function logInfo(scope, message)
    if not CONFIG.Logging.ShowInfo or scope == "Master" then return end
    consolePrint(consolePrefix(scope) .. " " .. tostring(message))
end
local function logWarning(message)
    if not CONFIG.Logging.ShowWarnings then return end
    local text = tostring(message)
    local scope = text:match("^%[([^%]]+)%]")
    local clean = text:gsub("^%[[^%]]+%]%s*", "")
    consoleWarn(consolePrefix(scope) .. " Warning: " .. clean)
end
local function logError(scope, message)
    consoleWarn(consolePrefix(scope) .. " Error: " .. tostring(message))
end
local function logUnitUpgradeDetail(message)
    if CONFIG.Logging.ShowUnitUpgradeDetails then logInfo("Unit Upgrade Debug", message) end
end

local function newRetryMonitor(operation)
    local started, lastReport, attempts = os.clock(), os.clock(), 0
    local nextReport = CONFIG.Logging.RetryReportAttempts
    return function(detail)
        attempts = attempts + 1
        local now = os.clock()
        if attempts >= nextReport and now - lastReport >= CONFIG.Logging.RetryReportSeconds then
            logError("Retry", string.format("%s | %d failed checks/retries over %.1fs; still retrying.%s",
                operation, attempts, now - started, detail and (" Last issue: " .. tostring(detail)) or ""))
            nextReport = attempts + CONFIG.Logging.RetryReportAttempts
            lastReport = now
        end
    end
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
    tutorialHidden = false,
    firstLoadedAt = scriptLoadedAt,
    discordNotifications = {maxZone = {}, colossus = {}},
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
            tutorialHidden = preferences.tutorialHidden,
            firstLoadedAt = preferences.firstLoadedAt,
            discordNotifications = preferences.discordNotifications,
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
        preferences.tutorialHidden = booleanOrDefault(data.tutorialHidden, false)
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
            or not validFirstLoadedAt then
            savePreferences()
        end
    end
    loadPreferences()
end

local lastStageSkip = {}
local function logStageResult(id, message)
    if message:match("^Skipped:") then

        local key = message:gsub("cooldown %d+:%d+ remaining", "cooldown active")
        if lastStageSkip[id] == key then return end
        lastStageSkip[id] = key
    else
        lastStageSkip[id] = nil
    end
    logInfo(consoleStageLabels[id], message)
end
local colors = CONFIG.UI.Colors

local function connect(signal, callback)
    local connection = signal:Connect(callback)
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
    local reportRetry = newRetryMonitor(message or "Waiting for an operation to complete")
    local nextRetry = os.clock() + CONFIG.General.RetryInterval
    local problem
    while true do
        checkAlive()
        local result = test()
        if result then return result end
        if retryAction and os.clock() >= nextRetry then
            local ok, response = pcall(retryAction)
            checkAlive()
            problem = not ok and response or nil
            nextRetry = os.clock() + CONFIG.General.RetryInterval
        end
        reportRetry(problem)
        pause(CONFIG.General.WaitPoll)
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

local function releaseInputs()
    local prompt, key, mouse = heldPrompt, heldKey, mouseHeld
    heldPrompt, heldKey, mouseHeld = nil, nil, nil
    if prompt then pcall(function() prompt:InputHoldEnd() end) end
    if key then pcall(function() VIM:SendKeyEvent(false, key, false, game) end) end
    if mouse then pcall(function() VIM:SendMouseButtonEvent(mouse.X, mouse.Y, 0, false, game, 0) end) end
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

do
    local enabled, currentToken, focused = false, nil, true
    local movementConnections, created, collisions = {}, {}, {}
    local character, root, humanoid, savedHumanoid, velocity, orientation
    local function detachCharacter()
        for _, instance in ipairs(created) do pcall(function() instance:Destroy() end) end
        table.clear(created)
        velocity, orientation = nil, nil
        for part, original in pairs(collisions) do
            pcall(function() part.CanCollide = original end)
        end
        table.clear(collisions)
        if root then
            pcall(function()
                root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
            end)
        end
        if humanoid and savedHumanoid then
            pcall(function()
                humanoid.PlatformStand = savedHumanoid.PlatformStand
                humanoid.AutoRotate = savedHumanoid.AutoRotate
                if not savedHumanoid.PlatformStand and humanoid.Health > 0 then
                    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end)
        end
        character, root, humanoid, savedHumanoid = nil, nil, nil, nil
    end
    local function stopMovement()
        enabled, currentToken = false, nil
        for _, connection in ipairs(movementConnections) do connection:Disconnect() end
        table.clear(movementConnections)
        detachCharacter()
        focused = true
    end
    local function create(class, name)
        local instance = Instance.new(class)
        table.insert(created, instance)
        instance.Name = name
        return instance
    end
    local function step()
        local nextCharacter = player.Character
        local nextRoot = nextCharacter and nextCharacter:FindFirstChild("HumanoidRootPart")
        local nextHumanoid = nextCharacter and nextCharacter:FindFirstChildOfClass("Humanoid")
        if character ~= nextCharacter or root ~= nextRoot or humanoid ~= nextHumanoid then
            detachCharacter()
        end
        if not nextRoot or not nextRoot:IsA("BasePart") or not nextHumanoid or nextHumanoid.Health <= 0 then
            detachCharacter()
            return
        end
        if not root then
            character, root, humanoid = nextCharacter, nextRoot, nextHumanoid
            savedHumanoid = {PlatformStand = humanoid.PlatformStand, AutoRotate = humanoid.AutoRotate}
            local attachment = create("Attachment", "AutomationFlightAttachment")
            attachment.Parent = root
            velocity = create("LinearVelocity", "AutomationFlightVelocity")
            velocity.Attachment0 = attachment
            velocity.RelativeTo = Enum.ActuatorRelativeTo.World
            velocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            velocity.ForceLimitsEnabled = false
            velocity.VectorVelocity = Vector3.zero
            velocity.Parent = root
            orientation = create("AlignOrientation", "AutomationFlightOrientation")
            orientation.Attachment0 = attachment
            orientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
            orientation.RigidityEnabled = true
            orientation.MaxTorque, orientation.Responsiveness = math.huge, 200
            orientation.CFrame = root.CFrame.Rotation
            orientation.Parent = root
        end

        for part, original in pairs(collisions) do
            if not part:IsDescendantOf(character) then
                pcall(function() part.CanCollide = original end)
                collisions[part] = nil
            end
        end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if collisions[part] == nil then collisions[part] = part.CanCollide end
                part.CanCollide = false
            end
        end
        humanoid.PlatformStand, humanoid.AutoRotate = true, false
        local direction = Vector3.zero
        if focused and not heldPrompt and not heldKey and not UserInputService:GetFocusedTextBox() then
            local camera = workspace.CurrentCamera
            local basis = camera and camera.CFrame or root.CFrame
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + basis.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - basis.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + basis.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - basis.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.yAxis end
        end
        local speed = CONFIG.General.MasterFlySpeed
        if type(speed) ~= "number" or speed ~= speed or speed <= 0 or speed == math.huge then
            error("General.MasterFlySpeed must be a finite positive number.", 0)
        end
        local movement = direction.Magnitude > 0 and direction.Unit * speed or Vector3.zero
        velocity.VectorVelocity = movement
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = movement, Vector3.zero
        orientation.CFrame = root.CFrame.Rotation
    end
    modules.masterMovement = {
        stop = stopMovement,
        start = function(token)
            if enabled and currentToken == token then return end
            stopMovement()
            if not actionIsCurrent(token) or (token.id ~= "master" and token.id ~= "hotbarUpgrade") then return end
            enabled, currentToken = true, token
            table.insert(movementConnections, UserInputService.WindowFocusReleased:Connect(function()
                focused = false
                if velocity then velocity.VectorVelocity = Vector3.zero end
                if root then root.AssemblyLinearVelocity = Vector3.zero end
            end))
            table.insert(movementConnections, UserInputService.WindowFocused:Connect(function() focused = true end))
            table.insert(movementConnections, game:GetService("RunService").PreSimulation:Connect(function()
                if currentToken ~= token then return end
                if not actionIsCurrent(token) then stopMovement(); return end
                local ok, reason = pcall(step)
                if not ok then
                    stopMovement()
                    logError("Run Movement", reason)
                    if stopRun then stopRun() end
                end
            end))
            step()
        end,
    }
end

local gui = Instance.new("ScreenGui")
gui.Name = "AutomationUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 2147483647
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function cleanup(destroyGui)
    if not alive then return end
    runScope.current, minimizedActions.rollToken, minimizedActions.openToken = nil, nil, nil
    alive, busy, dragging = false, false, false
    if modules.masterMovement then modules.masterMovement.stop() end
    if modules.plotCleanup then modules.plotCleanup.stop() end
    if modules.hotbarUpgrade then modules.hotbarUpgrade.cleanup() end
    touchPointer, dragStart, panelStart = nil, nil, nil
    for _, connection in ipairs(connections) do connection:Disconnect() end
    table.clear(connections)
    if worker and worker ~= coroutine.running() then pcall(task.cancel, worker) end
    worker = nil
    for thread in pairs(runScope.background) do pcall(task.cancel, thread) end
    table.clear(runScope.background)
    minimizedActions.rollEnabled = false
    if minimizedActions.rollWorker then pcall(task.cancel, minimizedActions.rollWorker) end
    minimizedActions.rollWorker = nil
    minimizedActions.openBusy = false
    if minimizedActions.openWorker then pcall(task.cancel, minimizedActions.openWorker) end
    minimizedActions.openWorker = nil
    releaseInputs()
    if modules.pickaxe and modules.pickaxe.cleanupWaiting then pcall(modules.pickaxe.cleanupWaiting) end
    if modules.tutorial then modules.tutorial.cleanup() end
    if modules.mutation and modules.mutation.cleanup then pcall(modules.mutation.cleanup) end
    local unitUpgrade = rawget(modules, "upgradingUnit")
    if unitUpgrade and unitUpgrade.cleanup then pcall(unitUpgrade.cleanup) end
    restorePosition()
    table.clear(shownPrompts)
    if _G.__AUTOMATION_KILL == unloadScript then _G.__AUTOMATION_KILL = nil end
    if destroyGui then gui:Destroy() end
end
unloadScript = function() cleanup(true) end
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
    return object
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
local minimizedMaster = button(minimizedControls, "Master: OFF", UDim2.fromOffset(0, 0), UDim2.new(0.5, -3, 0, 40))
minimizedMaster.Name = "MinimizedMaster"
minimizedMaster.TextSize = 14
do
    local tutorialButton = button(minimizedControls, "Auto complete tutorial", UDim2.new(0.5, 3, 0, 0), UDim2.new(0.5, -3, 0, 40))
    tutorialButton.Name = "AutoCompleteTutorial"
    tutorialButton.TextSize = 14
    tutorialButton.TextWrapped = true
    local tutorialStatus = label(minimizedControls, "", UDim2.fromOffset(0, 156), UDim2.new(1, 0, 0, 36), 11)
    tutorialStatus.TextWrapped = true
    pages.tutorial = {name = "Auto complete tutorial", run = tutorialButton, status = tutorialStatus, runText = "Auto complete tutorial"}
    minimizedActions.getHeight = function()
        return CONFIG.UI.MinimizedHeight + (tutorialStatus.Visible and 42 or 0)
    end
    minimizedActions.refreshTutorial = function()
        tutorialButton.Visible = not preferences.tutorialHidden
        minimizedMaster.Size = UDim2.new(preferences.tutorialHidden and 1 or 0.5, preferences.tutorialHidden and 0 or -3, 0, 40)
        tutorialStatus.Visible = not preferences.tutorialHidden and tutorialStatus.Text ~= ""
        if minimized then
            local height = minimizedActions.getHeight()

            panel.Size = UDim2.fromOffset(CONFIG.UI.MinimizedWidth, height)
            resize()
        end
    end
    connect(tutorialStatus:GetPropertyChangedSignal("Text"), minimizedActions.refreshTutorial)
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
local flowLabels = {sell="Sell", pickaxe="Buy Pickaxe", upgrades="Upgrades", upgradingOldUnit="Upgrade Old Units", units="Required Units", mutation="Mutate Units", upgradingUnit="Upgrade Units", cycleEnd="Cycle end"}
local flowParts = {}
for _, id in ipairs(order) do table.insert(flowParts, flowLabels[id]) end
local flowDescription = table.concat(flowParts, " > ")
assert(({master=true, sell=true, pickaxe=true, upgrades=true, upgradingOldUnit=true, units=true, mutation=true, upgradingUnit=true, cycleEnd=true})[CONFIG.UI.InitialTab], "Invalid CONFIG.UI.InitialTab")

local specs = {
    {"master", "Master", "Master: OFF - Click to turn ON", flowDescription .. " | Equip Best at cycle end."},
    {"sell", "Sell", "Run Auto Sell", "1. Collect the chest at your plot.\n2. Teleport to the Hub and open the sell stand.\n3. Click Select All, then Sell.\n4. Return to your plot."},
    {"pickaxe", "Pickaxe", "Buy Best Pickaxe", "1. Open the shop, wait for it to refresh, then close it.\n2. Find the highest unlocked pickaxe.\n3. Check its saved limit and whether its buy button is green.\n4. Record and send one purchase request if eligible."},
    {"upgrades", "Upgrades", "Run Upgrades", "1. Open the skill tree and scan the current zone.\n2. Recheck Colossus Pips as upgrades run.\n3. Prioritize eligible Density, then other available nodes.\n4. Turn stages 3-7 OFF as soon as Colossus Pips reach 1 or higher in the current zone; otherwise turn them ON.\nTurn Unlimited Best Pickaxe ON at the max zone and OFF in other zones. Check zone/Density fresh every cycle, including while OFF."},
    {"upgradingOldUnit", "Upgrade Old Units", "Run Upgrade Old Units", "1. Check that current-zone Density is 0.\n2. Find displayed units matching the previous zone's required names.\n3. Upgrade Damage toward the target, starting with the lowest level.\n4. Stop when the target is reached or further upgrades are unavailable."},
    {"units", "Required Units", "Run Required Units", "1. Check cooldown and clear the hotbar.\n2. Count whitelisted inventory copies plus displayed units.\n3. If eligible, remove displayed units.\n4. Fill empty unlocked pads using one stack at a time through hotbar 1."},
    {"mutation", "Mutate Units", "Run Mutate Units", "1. Check zone rules, Density, and Required Units preparation.\n2. Scan mutations in the first required unlocked holders.\n3. Roll eligible units below the active targets.\n4. Rescan until the targets are met or further rolls are unavailable."},
    {"upgradingUnit", "Upgrade Units", "Run Upgrade Units", "1. Check cooldown and scan the required lineup.\n2. Upgrade Damage to the allowed cap, with stat catch-up between batches.\n3. Finish Speed and MineSpeed catch-up on eligible units."},
    {"cycleEnd", "Cycle end", "Run Cycle end", "1. Equip Best and wait for the equip delay.\n2. Select Current Zone if enabled.\n3. Select Next Zone if enabled.\n4. Attempt to unlock remaining holder slots."},
}
for index, spec in ipairs(specs) do
    local id, name, runText, description = spec[1], spec[2], spec[3], spec[4]
    local tab = button(tabBar, name, UDim2.new((index - 1) / #specs, 2, 0, 0), UDim2.new(1 / #specs, -4, 1, 0))
    tab.TextSize = (id == "units" or id == "mutation" or id == "upgradingUnit" or id == "upgradingOldUnit") and 11 or 13
    tab.TextWrapped = true
    if id == "units" then
        make("Frame", tabBar, {
            Name = "DecisionStageDivider", Position = UDim2.new((index - 1) / #specs, -1, 0, 5),
            Size = UDim2.new(0, 2, 1, -10), BackgroundColor3 = colors.accent, BorderSizePixel = 0,
        })
    end
    tabs[id] = tab
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
    local heading = label(frame, name == "Master" and "Run the complete flow" or name, UDim2.fromOffset(18, 16), UDim2.new(1, -36, 0, 24), 19)
    heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.text
    label(frame, description, UDim2.fromOffset(18, 48), UDim2.new(1, -36, 0, id == "master" and 40 or 84), 13)
    local run = button(frame, runText, UDim2.fromOffset(18, id == "master" and 94 or 140), UDim2.new(1, -36, 0, 38))
    local status = label(frame, "Idle. Press the button to run once.", UDim2.fromOffset(18, id == "master" and 144 or 188), UDim2.new(1, -36, 0, id == "master" and 40 or 58), 12)
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
pages.master.cooldown = label(pages.master.frame, "Unit sequence: Ready",
    UDim2.new(0.5, 0, 0, 18), UDim2.new(0.5, -18, 0, 22), 12)
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
pages.master.status.Text = "OFF. Turn Master ON to repeat the cycle; click again to turn OFF."
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
local function resetStageRows()
    for index, id in ipairs(order) do
        stageRows[id].Text = tostring(index) .. ". " .. pages[id].name .. (preferences.stages[id] and " / Waiting" or " / OFF")
        stageRows[id].TextColor3 = colors.muted
    end
end
local masterStageBottom = 188
do
    local heading = label(pages.master.frame, "GENERAL STAGES",
        UDim2.fromOffset(22, masterStageBottom), UDim2.new(0.5, -28, 0, 14), 11)
    heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.muted
end
masterStageBottom = masterStageBottom + 18
for index, id in ipairs(order) do
    if id == "units" then
        make("Frame", pages.master.frame, {
            Name = "DecisionStageDivider", Position = UDim2.fromOffset(18, masterStageBottom + 4),
            Size = UDim2.new(0.5, -36, 0, 1), BackgroundColor3 = colors.accent, BorderSizePixel = 0,
        })
        local heading = label(pages.master.frame, "DECISION MAKING",
            UDim2.fromOffset(22, masterStageBottom + 8), UDim2.new(0.5, -28, 0, 14), 11)
        heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.accent
        masterStageBottom = masterStageBottom + 28
    end
    local row = label(pages.master.frame, "",
        UDim2.fromOffset(22, masterStageBottom + 2), UDim2.new(0.5, -76, 0, 20), 11)
    stageRows[id] = row
    local toggle = button(pages.master.frame, "", UDim2.new(0.5, -58, 0, masterStageBottom), UDim2.fromOffset(40, 20))
    toggle.Name, toggle.TextSize = id .. "StageToggle", 11
    stageToggles[id] = toggle
    connect(toggle.Activated, function()
        if not alive or busy then return end
        preferences.stages[id] = not preferences.stages[id]
        savePreferences()
        refreshStageToggles(false)
        resetStageRows()
    end)
    masterStageBottom = masterStageBottom + 22
end
refreshStageToggles(false)
resetStageRows()
do
    local guides = {
        master = [[MASTER FLOW
Run enabled stages in the configured order. Each stage button can also run its stage once. Master repeats until stopped; saved Master/stage toggles are restored on load.

Before starting, save any pending Pickaxe limit edit when Pickaxe is enabled. Reject overlapping runs and rapid repeat clicks. Master turns off enchant rolling and enables noclip/flight; failure to start movement stops the run.

Start each cycle with fresh cycle state. In the first cycle, enabled automatic Workspace cleanup runs once at the start, after startup teleport is confirmed. Skip disabled stages, except Upgrades still prepares cached zone/Density values. Restore temporary movement and release held inputs after each stage. Pause between stages.

On a stage error, show its error, close Sell/skill-tree/inventory panels, and retry on the next cycle. Still attempt Cycle end if enabled. During the cycle delay, visit the pickaxe shop and click its first two purchase rows; see the Pickaxe guide.

Stop, Master OFF, unload, or the relevant shortcuts cancel active work and clean up movement, prompts, keys, and focused panels.

MASTER CONTROLS
Stage toggles select the repeated flow. Reset Cooldown is in Required Units. A confirmed zone change resets the unit-sequence cooldown. The zone card shows cached requirements and observed progress.

Unlimited Best Pickaxe bypasses the saved limit for the highest unlocked pickaxe, while retaining request counts. Delete other plots / weather removes other plots and weather effects while enabled; rejoin to restore removed plots.

Ctrl+1 toggles Master; Ctrl+2 toggles enchant rolling; Ctrl+3 opens Altar; Ctrl+4 Events Board; Ctrl+5 Mailbox; Ctrl+6 Trial. Rolling/teleport shortcuts turn Master OFF and are ignored while typing.

HOTBAR UPGRADES
Refresh and select hotbar entries to process their copies through M1. This is a separate run, outside the eight-stage cycle. Place each selected copy, check its identity, upgrade Damage toward the configured target and Speed/Mining to their available maxima, then pick it up before the next copy. Stop on changed hotbar identity/count, missing M1 controls, unavailable upgrades, or failed placement/removal confirmation.]],
        sell = [[ACTIONS
1. Startup clicks OfflineFrame.Content.CollectButton when the offline popup is visible, waits 0.5 seconds, then clicks TeleportButton. Each click is observed for up to one second; attempts continue until the same character moves more than 10 studs after a teleport click. A hidden or absent offline popup does not block retries. A missing/hidden TeleportButton or a click without confirmed movement triggers a chest prompt/open-close recovery before retrying; chest recovery movement never confirms a teleport.
2. Teleport to your plot, wait, and collect the plot chest.
3. Teleport to the Hub. Move in front of the sell stand, face the camera toward it, and activate its prompts.
4. Hold the enabled sell prompt for its required duration, then wait for the game to open the sell window with visible ancestors.
5. Wait for a visible, active Select All button with a usable size, checking its name, text, or child caption. Click it once, wait, then wait for and click the separate Sell button. Wait for the sale, teleport back to your plot, and wait again.
6. Master closes the sell window after this stage.

CONDITIONS / STOPS
Only act while this Sell run remains active. Click buttons only when visible and with a usable size. Missing stand parts or SellFrame stop the stage with an error. Select All and Sell controls are polled until ready or stopped; prolonged retries report the buttons found. Configured delays separate teleports, prompts, selection, and sale.]],
        pickaxe = [[ACTIONS
1. Save pending limit edits before starting; the limit must be a whole number of zero or more.
2. Teleport to the pickaxe stand, wait for its enabled prompt, hold it long enough to open the shop, and wait for tiles to settle. Close the shop and restore position.
3. Scan stable tile identities/colors. Tile IDs start at 2 in child order. Choose the highest unlocked ID, including an unlocked tile that is currently sold out or unaffordable.
4. Load this account/game's saved per-ID request counts. Check the saved limit unless Unlimited Best Pickaxe is ON.
5. Require the chosen tile to remain present and buyable (green). Reserve one count, save it, read it back to verify, recheck the tile, and send one purchase request.

CONDITIONS / STOPS
No lower-ID fallback is purchased when the highest unlocked tile is unavailable. No request is sent if the limit is reached or the selected tile is not buyable. Unlimited mode bypasses the limit only; requests are still counted.

Unavailable file functions, invalid or unreadable count data, a disappearing previously seen file, or unverifiable saves stop purchases. A count saved before a later cancellation or color change remains reserved. Counts represent reserved requests, rather than confirmed inventory purchases.

BETWEEN MASTER CYCLES
During the cycle delay, open the shop and click visible buy buttons on rows with LayoutOrder 1 then 2 at the configured click interval. These are direct UI clicks, separate from this stage's best-pickaxe limit/count reservation. Close the shop and restore position when the wait ends or is stopped. A shop-wait error uses the rest of the cycle delay.]],
        upgrades = [[ZONE / DENSITY SCAN
Open the skill tree. Detect the highest numbered loaded Zone_Z<number> folder after it settles. Cache its zone ID, folder name, and confirmed Density for the cycle. A changed zone clears the unit-sequence cooldown. The maximum configured zone is the highest numeric Z key in RequiredByZone, with no fixed zone-number limit.

Density is the highest green/upgraded Density node. Unknown node colors or an unsettled/missing tree are retried until ready or stopped; prolonged retries log errors. Confirmed Density 2+ stops mutation for that zone; a later confirmed lower Density clears a stale stop flag. Hide and save the tutorial button at Z2+ or at Z1 with Density 1+.

UPGRADE SELECTION
Recheck Colossus progress before and during upgrades. Prioritize the next available Density node. Density II requires every exact required slot M1..M<RequiredUnitCount> to hold a current-zone whitelisted unit at Diamond or higher, plus configured mutation quotas. RequiredUnitCount zero passes this gate.

Before Density is fully upgraded, other available nodes must be above its next-node row or on the same row within the configured tolerance. Rank them by horizontal distance, then row height, then name. When Density is maxed, consider all available non-Density nodes.

Use configured node-category mappings, falling back to the node base name. Skip invalid categories. Recheck the node, its color, and the Density II gate before each purchase. Retry while the node remains available, respecting the request delay and reporting prolonged retries. Stop processing a node when it disappears, becomes unavailable, or valid Colossus Pips reach 1 or higher in the current zone. Rescan Density and count confirmed green upgrades; repeat while upgrades are confirmed.

COLOSSUS / NOTIFICATIONS
Positive valid Colossus Pips confirms the unlock. Turn stages 3-7 OFF as soon as valid Colossus Pips reach 1 or higher (for example 1/5), in any current zone; otherwise turn stages 3-7 ON. Turn Unlimited Best Pickaxe ON at the max zone, even without positive Colossus Pips, and OFF in other zones. Send a Colossus alert with username, zone name/ID, and Pips. Reaching the highest configured zone sends a separate max-zone alert to the same webhook.

Both messages end their elapsed-time line with @everyone. Time is measured from the account/game's cached first script load, including restarts and offline time. Old caches missing a valid timestamp start tracking on their next load. Under one hour displays unknown. A valid saved timestamp is retained.

Each notification type has its own sent flag per zone. Pending requests suppress duplicates in the current run; successful HTTP responses save the sent flag in the preferences cache. Failed requests can be retried on later checks. Missing webhook/request support skips sending. A cache-save failure is warned because it can allow a repeat after restarting.

WHEN UPGRADES IS OFF
In Master, open the skill tree and freshly scan the Canvas zone, Density, and Colossus Pips every cycle, including while Upgrades is OFF. Recheck Colossus progress in the current zone. If valid Colossus Pips have not reached 1, turn stages 3-7 ON and resume Upgrades in the same cycle. Turn Unlimited Best Pickaxe ON at the max zone and OFF in other zones. These scans also prepare zone selection and tutorial hiding.

FINISH
Close the skill tree and keep the zone/Density values ready for Cycle end. Current/next selection follows its toggles; a standalone Upgrades run selects zones immediately after finishing.]],
        upgradingOldUnit = [[ENTRY CONDITIONS
Use the cached current zone and Density. Run only at Density 0. Z1 has no previous zone and is skipped. Skip if the previous numbered zone has no configured Names.

ACTIONS
1. Check plot ownership and scan displayed numbered holders.
2. Read each unit's displayed name. Include only exact matches in the previous zone's Names list; skip other or unreadable names.
3. Upgrade Damage only, toward UpgradingOldUnit.TargetLevel. Work on the lowest Damage level first, breaking ties by holder number, in batches of up to five requests.
4. Open the correct unit panel and require a green Damage button. Recheck unit identity/ownership and confirm a level or button-color response after each request. Close focus between batches.

STOPS
Skip if no displayed unit matches. Stop a unit at the target or when Damage is unavailable; stop with an error if ownership, identity, character, required controls, or expected response is lost. This stage does not run Speed/MineSpeed catch-up.]],
        units = [[ENTRY CONDITIONS
Check the shared unit-sequence cooldown before refreshing anything. If active, keep displayed units and skip. Reset Cooldown clears it; a new zone resets it. Validate the equipment mode, use cached zone/Density, check plot ownership, and start the sequence cooldown.

AVAILABILITY CHECK
Clear occupied hotbar assignments, open inventory, and count current-zone whitelisted copies directly from inventory, including stack quantities. At Density 2+, require a nonempty animation tag; Density 0-1 accepts either. Skip unreadable Damage values. Add matching displayed units to this inventory count; no inventory card is selected during the check. If insufficient, FinalEquipMode is Best, or Density is 0, keep displayed units and skip replacement/mutation preparation. Equip Best is handled at Cycle end.

REPLACEMENT / PLACEMENT
Once eligible, require a ready character, close panels, and remove all displayed units with confirmed pickup retries. Clear occupied hotbar assignments again, open inventory, and recheck available matching copies plus units already placed in required pads.

Rank eligible inventory stacks by highest Damage, prefer _AnimTag on equal Damage, then preserve inventory order. Select only the highest ranked stack into hotbar 1. Confirm its stack quantity and that other hotbar slots are empty, keep inventory open, and place its copies in empty unlocked pads in holder-number order. Finish placing the selected stack before fetching another inventory card; confirm hotbar 1 is empty before loading another stack. Continue until every unlocked empty pad is filled, including pads beyond RequiredUnitCount, or no eligible inventory copies remain. RequiredUnitCount stays the minimum count gate. Keep inventory open between placement batches and close it when placement finishes or stops for insufficient copies.

If selection confirmation fails, recheck for delayed success, reacquire the same card, and retry without clearing the selected stack or cycling inventory closed and open. Unreadable quantities, UI waits, pickup, and placement retry without timeouts and report periodic errors. Preserve character, plot, hotbar identity, focus/text-field, and held-input checks.

MUTATION READINESS
Confirm whitelisted units occupy every required pad and provide that displayed-unit count to later stages. Partial/failed preparation, cooldown skips, and Density 0 keep Mutate Units locked.]],
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
Use the current cycle's Required Units sequence allowance when present. Otherwise check the shared cooldown and start a new sequence only when ready. Consume that allowance for this run. Validate cached Density, check plot ownership, close previous focus, and scan displayed units.

FULL DAMAGE GATE
The exact required slots must all be displayed, match current-zone Names, and be Diamond or higher. Configured mutation quotas must pass. If the gate fails, only displayed current-zone whitelisted units receive Damage toward level 10; no other units receive Damage in that branch.

WHEN THE GATE PASSES
Upgrade matching required units toward the zone MaxLevelCap. Confirm required units at cap before allowing Damage on cached extra displayed holders. Recheck the required lineup/quotas after core upgrades. Extras must still be displayed and cached. Their Damage target is half their own actual maximum from the Stats panel, rounded down; the zone MaxLevelCap does not limit extra Damage. The gate can fail when required count is zero; that does not grant unrestricted Damage upgrades.

BATCHES / STAT CATCH-UP
Choose the lowest Damage level first, then holder number, with up to the current zone's DamageBatchSize requests per batch (default 5). Require a green button and confirm each level/color response. On the full-cap path, use DamageBatchSize for Damage catch-up boundaries and pause until eligible Speed and MineSpeed reach current Damage levels or their own maxima.

Cache identities and Damage/Speed/Mining levels once for this run. Include current-zone whitelisted units, units already at the configured stat minimum, and extras when a valid core exists. After Damage processing, catch up Speed and MineSpeed for cached displayed units at or above the minimum Damage level, regardless of their name. Balance the lowest stat levels in batches of up to five; cap each at the lesser of current Damage and that stat's maximum.

STOPS
Unavailable upgrade buttons stop progress rather than sending requests. Unfinished stat catch-up pauses further Damage. Identity, plot, character, display, focus-target, unreadable-level, or invalid-response failures stop the stage. Close the focused unit panel on exit.]],
        cycleEnd = [[ACTIONS
1. Check plot ownership. Request Equip Best, wait the configured delay, and refresh observed mutation progress when a zone is known. A repeated cycle-end request in the same cycle is skipped.
2. Select the cached current zone if its toggle is ON.
3. Select the next numbered zone if its toggle is ON.
4. Scan numbered holders for unlock prompts. Move to each holder, unequip tools, and hold enabled Unlock / Unlock at the hub prompts for at least one second plus padding.

ZONE-SELECTION CONDITIONS
Selection runs only if Upgrades has prepared zone/Density values. It can use the scan prepared while Upgrades is OFF. Both toggles OFF skips zone selection. Next means the cached zone number plus one; this requests selection without claiming the next zone is unlocked.

HOLDER CONDITIONS
Skip missing holders and unavailable/disabled prompts. If prompts are missing or still say Unlock, try again on later cycles. After a scan confirms at least one numbered holder and no remaining unlock/missing prompts, skip future unlock scans for this script execution.

MASTER / STANDALONE
Master attempts this stage after normal stages, including after a stage error, when Cycle end is enabled. Its own failure is reported and retried in later cycles. A standalone run may Equip Best and unlock holders while zone selection is skipped because no cycle scan is ready.]],
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
    connect(back.Activated, function() stageGuide.Visible = false end)
    for _, spec in ipairs(specs) do
        local id, page = spec[1], pages[spec[1]]
        local position = id == "master" and UDim2.fromOffset(18, masterStageBottom + 8) or UDim2.new(1, -196, 0, 14)
        local size = id == "master" and UDim2.new(0.5, -36, 0, 28) or UDim2.fromOffset(178, 28)
        local open = button(page.frame, "Actions & conditions", position, size)
        open.Name, open.TextSize = "OpenStageGuide", 11
        connect(open.Activated, function()
            local settings = {}
            if id == "master" then
                table.insert(settings, string.format("Stage delay: %gs. Cycle delay: %gs. Flight speed: %g. Hotbar Damage target: %d.",
                    CONFIG.Flow.StageDelay, CONFIG.Flow.CycleDelay, CONFIG.General.MasterFlySpeed, CONFIG.HotbarUpgrade.DamageTargetLevel))
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
                table.insert(settings, string.format("Old-unit Damage target: %d.", CONFIG.UpgradingOldUnit.TargetLevel))
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
    local refresh = button(pages.master.frame, "Refresh Script (Run Once)",
        UDim2.new(0.5, 0, 0, masterStageBottom + 8), UDim2.new(0.5, -18, 0, 28))
    refresh.Name, refresh.TextSize = "RefreshScriptOnce", 12
    local refreshing = false
    connect(refresh.Activated, function()
        if not alive or refreshing then return end
        refreshing = true
        refresh.Active, refresh.AutoButtonColor = false, false
        refresh.Text = "Refreshing script..."
        -- Unload the current instance without changing or deleting its preferences cache.
        unloadScript()
        local ok, message = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/championsDecay/s/refs/heads/main/main.luau"))()
        end)
        if not ok then consoleWarn("[Refresh Script] " .. tostring(message)) end
    end)
end

do
    local copyLogs = button(pages.master.frame, "Copy Script Logs",
        UDim2.fromOffset(18, masterStageBottom + 48), UDim2.new(1, -36, 0, 28))
    copyLogs.Name, copyLogs.TextSize = "CopyScriptLogs", 12
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
        local ok, message = pcall(copy, table.concat(scriptLogs, "\n"))
        if not alive then return end
        if ok then
            footer.Text = string.format("Copied %d script log entries (latest 2000 this session).", #scriptLogs)
        else
            footer.Text = "Could not copy script logs: " .. tostring(message)
        end
    end)
end
masterStageBottom = masterStageBottom + 36

do
    local toggle = button(pages.master.frame, "", UDim2.fromOffset(18, masterStageBottom + 116), UDim2.new(1, -36, 0, 30))
    toggle.Name, toggle.TextSize = "WorkspaceCleanupToggle", 12
    local function refresh()
        local enabled = CONFIG.General.WorkspaceCleanupEnabled
        toggle.Text = "Auto delete workspace extras: " .. (enabled and "ON" or "OFF")
        toggle.BackgroundColor3 = enabled and colors.accent or colors.bg
    end
    connect(toggle.Activated, function()
        if not alive then return end
        CONFIG.General.WorkspaceCleanupEnabled = not CONFIG.General.WorkspaceCleanupEnabled
        savePreferences()
        refresh()
        modules.workspaceCleanup.refresh()
    end)
    refresh()
    label(pages.master.frame, "Runs once at the start of the first Master cycle. Run once also works while OFF.",
        UDim2.fromOffset(18, masterStageBottom + 150), UDim2.new(1, -36, 0, 28), 11)
end

label(pages.master.frame,
    "SHORTCUTS (expanded or minimized)\nCtrl+1: Master ON/OFF   |   Ctrl+2: Enchant Roll ON/OFF\nCtrl+3: Altar   |   Ctrl+4: Events Board\nCtrl+5: Mailbox   |   Ctrl+6: Trial\nRoll and teleport shortcuts turn Master OFF. Ignored while typing.",
    UDim2.fromOffset(18, masterStageBottom + 184), UDim2.new(1, -36, 0, 72), 12)

do
    local toggle = button(pages.master.frame, "", UDim2.fromOffset(18, masterStageBottom + 48), UDim2.new(1, -36, 0, 30))
    toggle.Name, toggle.TextSize = "DeleteOtherPlotsToggle", 12
    local function refresh()
        local enabled = CONFIG.General.DeleteOtherPlots
        toggle.Text = "Delete other plots / weather: " .. (enabled and "ON" or "OFF")
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
    label(pages.master.frame, "Also clears weather effects. Keeps your plot; rejoin to restore removed plots.",
        UDim2.fromOffset(18, masterStageBottom + 82), UDim2.new(1, -36, 0, 28), 11)
end

do
    local card = make("Frame", pages.master.frame, {
        Name = "ZoneRequirements", Position = UDim2.new(0.5, 6, 0, 188),
        Size = UDim2.new(0.5, -24, 0, 200), BackgroundColor3 = colors.bg, BorderSizePixel = 0,
    })
    corner(card)
    local heading = label(card, "ZONE REQUIREMENTS", UDim2.fromOffset(8, 8), UDim2.new(1, -16, 0, 16), 12)
    heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.accent
    local zone = label(card, "Zone: --", UDim2.fromOffset(8, 28), UDim2.new(1, -16, 0, 32), 12)
    zone.TextColor3 = colors.text
    local density = label(card, "Density level: --", UDim2.fromOffset(8, 62), UDim2.new(1, -16, 0, 16), 12)
    density.TextColor3 = colors.text
    local count = label(card, "Required count: --", UDim2.fromOffset(8, 82), UDim2.new(1, -16, 0, 16), 12)
    count.TextColor3 = colors.text
    local mutation = label(card, "Waiting for Upgrades to detect the zone.",
        UDim2.fromOffset(8, 100), UDim2.new(1, -16, 0, 48), 11)
    local quotas = label(card, "", UDim2.fromOffset(8, 152), UDim2.new(1, -16, 0, 40), 11)
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
            heading.Text = lastZone and (lastZone .. " requirements (cached)") or "ZONE REQUIREMENTS"
            count.Text = "Required count: --"
            mutation.Text = lastZone and "No requirements configured for this zone." or "Waiting for Upgrades to detect the zone."
            quotas.Text = ""
            return
        end
        local settings = rule.RequiredMutations or {}
        heading.Text = lastZone .. " requirements (cached)"
        local progress = masterRequirementProgress[lastZone] or {}
        local required = rule.RequiredUnitCount or 0
        count.Text = string.format("Required count: %s/%s", progress.matched == nil and "--" or tostring(progress.matched), tostring(required))
        local mutations = progress.mutations
        local diamondCurrent = mutations and tostring(mutations.Diamond) or "--"
        local quotaTotal = 0
        for _, name in ipairs({"Platinum", "Rainbow", "Frozen", "Inferno", "Nightmare", "Unreal"}) do
            quotaTotal = quotaTotal + (settings[name] or 0)
        end
        local diamondGoal = math.max(0, required - quotaTotal)
        local state = hasMutationRequirements(settings) and "Tier counts configured" or "No tier quotas"
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
        quotas.Text = table.concat(rows, "\n")
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

local function recoverUnitPanelThroughChest(checkCurrent, operation)
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
    local function chestFrame()
        local mine = playerGui:FindFirstChild("MineGui")
        return mine and mine:FindFirstChild("ChestFrame")
    end
    local function findChestRecoveryStand(position, maxDistance)
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
        -- Measure the whole avatar around its root so its body also clears the chest.
        local bodyFrame, bodySize = character:GetBoundingBox()
        local clearance = math.max(root.Size.X, root.Size.Z) * 0.5
        for x = -1, 1, 2 do
            for y = -1, 1, 2 do
                for z = -1, 1, 2 do
                    local corner = bodyFrame:PointToWorldSpace(Vector3.new(bodySize.X * x * 0.5,
                        bodySize.Y * y * 0.5, bodySize.Z * z * 0.5))
                    local localCorner = root.CFrame:PointToObjectSpace(corner)
                    clearance = math.max(clearance, Vector3.new(localCorner.X, 0, localCorner.Z).Magnitude)
                end
            end
        end
        clearance = clearance + 0.75
        local height = math.min(CONFIG.Units.TeleportHeight, math.max(0.1, maxDistance * 0.5))
        local standY = position.Y + height
        local nearestX = math.clamp(position.X, minimum.X, maximum.X)
        local nearestZ = math.clamp(position.Z, minimum.Z, maximum.Z)
        local candidates = {
            Vector3.new(minimum.X - clearance, standY, nearestZ),
            Vector3.new(maximum.X + clearance, standY, nearestZ),
            Vector3.new(nearestX, standY, minimum.Z - clearance),
            Vector3.new(nearestX, standY, maximum.Z + clearance),
        }
        local best, bestDistance
        for _, candidate in ipairs(candidates) do
            local distance = (candidate - position).Magnitude
            if distance <= maxDistance - 0.25 and (not bestDistance or distance < bestDistance) then
                best, bestDistance = candidate, distance
            end
        end
        if best then return best end
        return nil, "No position outside the chest and avatar bounds is within prompt range."
    end

    local function triggerChest()
        checkTarget()
        local prompt = waitUntil(function()
            checkTarget()
            local found
            for _, candidate in ipairs(chest:GetDescendants()) do
                if candidate:IsA("ProximityPrompt") and candidate.Enabled then
                    if found then error("Multiple enabled chest prompts found during " .. recoveryName .. ".", 0) end
                    found = candidate
                end
            end
            return found
        end, nil, recoveryName .. ": waiting for your chest proximity prompt")
        local reportStand = newRetryMonitor(recoveryName .. ": finding a safe position beside the chest")
        local stand, position
        while not stand do
            checkTarget()
            local parent = prompt.Parent
            position = parent:IsA("Attachment") and parent.WorldPosition or base.Position
            local problem
            stand, problem = findChestRecoveryStand(position, prompt.MaxActivationDistance)
            if not stand then reportStand(problem); pause(CONFIG.General.ScanPoll) end
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
        triggerChest()
        waitUntil(function()
            checkTarget()
            return visible(chestFrame())
        end, nil, recoveryName .. ": waiting for the chest UI to open", triggerChest)
        -- This interaction only resets the UI; it never requests chest contents.
        pcall(closeChest)
        waitUntil(function()
            checkTarget()
            return not visible(chestFrame())
        end, nil, recoveryName .. ": closing the chest UI", closeChest)
    end)
    releaseInputs()
    local stillCurrent = pcall(check)
    if stillCurrent and player.Character == character and root:IsDescendantOf(character) then
        pcall(function()
            root.CFrame = savedCFrame
            root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        end)
    end
    if stillCurrent and ownsPosition and originalRoot == root and originalCFrame == savedCFrame then
        originalRoot, originalCFrame = nil, nil
    end
    if not ok then error(message, 0) end
end

local function tryUnitExit(focus, method)
    local object = focus:FindFirstChild("ExitButton")
    if not object then error("ExitButton is missing from " .. focus:GetFullName(), 0) end
    local exit, reason = resolveButton(object)
    if not exit then error("Cannot activate ExitButton: " .. tostring(reason), 0) end
    if not visible(exit) then error("ExitButton is hidden: " .. exit:GetFullName(), 0) end
    if type(firesignal) ~= "function" then error("ExitButton signal activation needs firesignal.", 0) end
    if method == "Activated" then firesignal(exit.Activated, nil, 1)
    else firesignal(exit.MouseButton1Click) end
end

local function closeUnitPanel(operation, checkCurrent)
    local methods = {"MouseButton1Click", "Activated"}
    local reportRetry = newRetryMonitor(operation or "Closing unit panel with ExitButton")
    local attempt, nextAttempt, hiddenSince, sawPanel = 0, 0, nil, false
    while true do
        checkAlive()
        if checkCurrent then checkCurrent() end
        local mine = playerGui:FindFirstChild("MineGui")
        local focus = mine and mine:FindFirstChild("SlotFocusFrame")
        if not visible(focus) then
            if not sawPanel then return end
            hiddenSince = hiddenSince or os.clock()
            if os.clock() - hiddenSince >= 0.1 then return end
        else
            sawPanel, hiddenSince = true, nil
            if os.clock() >= nextAttempt then
                attempt = attempt + 1
                local method = methods[(attempt - 1) % #methods + 1]
                local ok, message = pcall(tryUnitExit, focus, method)
                checkAlive()
                if checkCurrent then checkCurrent() end
                pause(SETTLE_TIME)
                local currentMine = playerGui:FindFirstChild("MineGui")
                local currentFocus = currentMine and currentMine:FindFirstChild("SlotFocusFrame")
                if visible(currentFocus) then
                    local recovered, recoveryMessage = pcall(recoverUnitPanelThroughChest, checkCurrent)
                    checkAlive()
                    if checkCurrent then checkCurrent() end
                    currentMine = playerGui:FindFirstChild("MineGui")
                    currentFocus = currentMine and currentMine:FindFirstChild("SlotFocusFrame")
                    if visible(currentFocus) or not recovered then
                        reportRetry(not recovered and recoveryMessage or (not ok and message)
                            or ("Tried " .. method .. " and chest recovery; unit panel is still visible."))
                    end
                end
                nextAttempt = os.clock() + CONFIG.General.RetryInterval
            end
        end
        pause(CONFIG.General.WaitPoll)
    end
end

-- Collect visible offline rewards before each startup teleport attempt.
-- Only movement after TeleportButton is clicked confirms startup readiness.
do
    local startupReady = false
    modules.gameReady = {
        isReady = function() return startupReady end,
        wait = function()
            if startupReady then return true end
            local nextAttempt = 0
            local reportRetry = newRetryMonitor("Startup collection and teleport")
            local pendingCharacter, pendingRoot, pendingPosition
            local teleportFailed = false
            local lastMessage
            local function movedAfterClick()
                return pendingPosition and player.Character == pendingCharacter
                    and pendingRoot.Parent == pendingCharacter
                    and pendingRoot:IsDescendantOf(workspace)
                    and (pendingRoot.Position - pendingPosition).Magnitude > CONFIG.General.StartupTeleportMinDistance
            end
            local function confirmTeleport()
                startupReady = true
                logInfo("Startup", "TeleportButton changed character position; starting automation.")
                return true
            end
            local function recoverTeleportUi()
                -- Discard the failed click's baseline before moving to the chest.
                -- Recovery movement must never confirm a TeleportButton click.
                pendingCharacter, pendingRoot, pendingPosition = nil, nil, nil
                pages.master.status.Text = "TeleportButton unavailable/unresponsive; refreshing the UI through your chest..."
                footer.Text = pages.master.status.Text
                local ok, message = pcall(recoverUnitPanelThroughChest, nil, "TeleportButton recovery")
                if not ok and alive then reportRetry("TeleportButton chest recovery: " .. tostring(message)) end
            end
            local function attemptTeleport()
                teleportFailed = false
                local currentGui = player:FindFirstChildOfClass("PlayerGui")
                if currentGui then playerGui = currentGui end
                local mine = currentGui and currentGui:FindFirstChild("MineGui")
                local offline = mine and mine:FindFirstChild("OfflineFrame")
                if offline and visible(offline) then
                    local content = offline:FindFirstChild("Content")
                    local collect = content and content:FindFirstChild("CollectButton")
                    assert(collect, "Offline CollectButton is not available yet.")
                    clickButton(collect)
                end
                -- A dismissed/absent offline popup must not prevent further teleport retries.
                task.wait(CONFIG.General.StartupCollectDelay)
                checkAlive()
                if movedAfterClick() then return true end
                -- Capture the position AFTER collection and immediately BEFORE teleporting.
                currentGui = player:FindFirstChildOfClass("PlayerGui")
                if currentGui then playerGui = currentGui end
                mine = currentGui and currentGui:FindFirstChild("MineGui")
                local teleport = mine and mine:FindFirstChild("TeleportButton")
                local character = player.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                assert(root and root:IsA("BasePart") and root:IsDescendantOf(workspace), "Character position is not available yet.")
                teleportFailed = true
                assert(teleport, "TeleportButton is not available yet.")
                local before = root.Position
                clickButton(teleport)
                teleportFailed = false
                checkAlive()
                if player.Character == character and root.Parent == character then
                    pendingCharacter, pendingRoot, pendingPosition = character, root, before
                    nextAttempt = os.clock() + CONFIG.General.StartupTeleportClickInterval
                    return movedAfterClick()
                end
                pendingCharacter, pendingRoot, pendingPosition = nil, nil, nil
                return false
            end
            while alive do
                checkAlive()
                local character = player.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if character ~= pendingCharacter or root ~= pendingRoot then
                    pendingCharacter, pendingRoot, pendingPosition = nil, nil, nil
                end
                if movedAfterClick() then return confirmTeleport() end
                if os.clock() >= nextAttempt then
                    if pendingPosition then
                        recoverTeleportUi()
                        if not alive then return false end
                    end
                    nextAttempt = os.clock() + CONFIG.General.StartupTeleportClickInterval
                    pages.master.status.Text = "Collecting offline rewards, then teleporting after 0.5 seconds..."
                    footer.Text = pages.master.status.Text
                    pages.master.run.Text = preferences.masterEnabled and "Master: ON - Waiting for teleport" or pages.master.runText
                    minimizedMaster.Text = preferences.masterEnabled and "Master: Waiting" or "Master: OFF"
                    local ok, result = pcall(attemptTeleport)
                    if not alive then return false end
                    if ok and result then return confirmTeleport() end
                    local message
                    if ok then
                        message = "TeleportButton has not moved your character; retrying with chest UI recovery."
                    else
                        pendingCharacter, pendingRoot, pendingPosition = nil, nil, nil
                        if teleportFailed then
                            recoverTeleportUi()
                            if not alive then return false end
                        end
                        message = "Startup retry: " .. tostring(result)
                    end
                    if message ~= lastMessage then
                        logInfo("Startup", message)
                        lastMessage = message
                    end
                    reportRetry(message)
                    pages.master.status.Text = message
                    footer.Text = message
                end
                task.wait(CONFIG.General.ScanPoll)
            end
            return false
        end,
    }
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
        local buttonIndex = ({4, 2, 3, 1})[index]
        local shortcut = button(minimizedControls, destination[1], UDim2.new((buttonIndex - 1) / 4, buttonIndex - 1, 0, 74),
            UDim2.new(1 / 4, -3, 0, 24))
        shortcut.Name = "Teleport" .. destination[1]:gsub(" ", "")
        shortcut.TextSize = 11
        shortcut.TextWrapped = true
        shortcut.BackgroundColor3 = colors.surface
        local function teleportOnce()
            if not alive then return end
            if busy and (activeRun == "master" or activeRun == "hotbarUpgrade" or activeRun == "tutorial") and stopRun then stopRun() end
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
        connect(shortcut.Activated, teleportOnce)
        if teleportKeys[index] then hotkeyActions[teleportKeys[index]] = teleportOnce end
    end

    local rollToggle = button(minimizedControls, "Enchant Roll: OFF", UDim2.fromOffset(0, 44), UDim2.new(0.5, -3, 0, 26))
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
        if not alive then return end
        if busy and (activeRun == "master" or activeRun == "hotbarUpgrade" or activeRun == "tutorial") and stopRun then stopRun() end
        setRollEnabled(not minimizedActions.rollEnabled)
    end
    connect(rollToggle.Activated, toggleRoll)
    hotkeyActions[Enum.KeyCode.Two] = toggleRoll

    local openCrates = button(minimizedControls, "Open crates", UDim2.new(0.5, 3, 0, 44), UDim2.new(0.5, -3, 0, 26))
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

    local function startOpeningCrates()
        if not alive or minimizedActions.openBusy or (busy and activeRun == "hotbarUpgrade") then return end
        local token = {kind = "open"}
        minimizedActions.openToken, minimizedActions.openBusy = token, true
        openCrates.Text = "Opening Crates"
        openCrates.Active, openCrates.AutoButtonColor = false, false
        openCrates.BackgroundColor3 = colors.idle
        if busy and (activeRun == "master" or activeRun == "hotbarUpgrade" or activeRun == "tutorial") and stopRun then stopRun() end
        setRollEnabled(false)
        if not actionIsCurrent(token) then return end
        minimizedActions.openWorker = task.defer(function()
            runScope.threads[coroutine.running()] = token
            local inventory, openedInventory, sent = nil, false, 0
            local ok, result = pcall(function()
                checkAlive()
                inventory = path(playerGui, {"MineGui", "InventoryFrame"})
                if not visible(inventory) then
                    clickButton(path(playerGui, {"MineGui", "HotbarFrame", "Content", "Container", "InventoryButton"}))
                    openedInventory = true
                end
                waitUntil(function() return visible(inventory) end,
                    CONFIG.Units.ActionTimeout, "Waiting for inventory to open for crate counting.", function()
                        clickButton(path(playerGui, {"MineGui", "HotbarFrame", "Content", "Container", "InventoryButton"}))
                    end)
                pause(CONFIG.Units.UISettleTime)
                local count = waitUntil(function()
                    if not visible(inventory) then error("Inventory closed before Petalfall Crates could be counted.", 0) end
                    return readPetalfallCrateCount(path(inventory, {"Content", "Scroll"}))
                end, CONFIG.Units.ActionTimeout, "Petalfall Crate count did not finish loading.")
                clickButton(path(inventory, {"Content", "Actions", "Close"}))
                waitUntil(function() return not visible(inventory) end,
                    CONFIG.Units.ActionTimeout, "Waiting for inventory to close before opening crates.", function()
                        clickButton(path(inventory, {"Content", "Actions", "Close"}))
                    end)
                openedInventory = false
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
                pcall(function() clickButton(path(inventory, {"Content", "Actions", "Close"})) end)
                if not actionIsCurrent(token) then return end
            end
            minimizedActions.openBusy, minimizedActions.openToken, minimizedActions.openWorker = false, nil, nil
            openCrates.Text = "Open crates"
            openCrates.Active, openCrates.AutoButtonColor = true, true
            openCrates.BackgroundColor3 = colors.accent
            if ok then logInfo("Crates", result)
            else logError("Crates", string.format("Stopped after %d requests: %s", sent, tostring(result))) end
        end)
    end
    connect(openCrates.Activated, startOpeningCrates)

    connect(UserInputService.InputBegan, function(input, gameProcessedEvent)
        if not alive or gameProcessedEvent or UserInputService:GetFocusedTextBox() then return end
        if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
            or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then return end
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

-- Automatic Workspace cleanup runs once at the start of the first Master cycle, after startup teleport confirmation.
-- It never polls or retries automatically; Run once remains a separate manual pass.
-- Other MinePlots/weather use the independent automatic plotCleanup worker above.
do
    local runOnce = button(minimizedControls, "Workspace cleanup - Run once", UDim2.fromOffset(0, 104), UDim2.new(1, 0, 0, 26))
    runOnce.Name, runOnce.TextSize = "WorkspaceCleanupRunOnce", 12
    local status = label(minimizedControls, "Keeps script paths and prompts. Rejoin to restore.", UDim2.fromOffset(0, 134), UDim2.new(1, 0, 0, 18), 10)
    status.Name, status.TextWrapped = "WorkspaceCleanupStatus", false
    local running, completed = false, false
    local automaticAttempted = false

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
    {"TrialStone", "Plinth1"},
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
        if automaticAttempted then return end
        status.Text = CONFIG.General.WorkspaceCleanupEnabled
            and "Auto cleanup: once at the start of the first Master cycle."
            or "Auto cleanup: OFF. Run once is available until used."
        status.TextColor3 = colors.muted
    end
    modules.workspaceCleanup = {
        refresh = refreshAutomaticStatus,
        onCycleStart = function(cycle)
            if not alive or cycle ~= 1 or automaticAttempted or not CONFIG.General.WorkspaceCleanupEnabled then return end
            automaticAttempted = true
            local ok, removed, failed = pcall(scan, true)
            if not alive then return end
            if ok and failed == 0 then
                status.Text = string.format("Auto cleanup done: removed %d branches.", removed)
                status.TextColor3 = colors.success
                logInfo("Workspace Cleanup", status.Text)
            else
                status.Text = "Auto cleanup incomplete. Use Run once to retry."
                status.TextColor3 = colors.error
                local reason = ok and string.format("%d branches could not be removed.", failed) or tostring(removed)
                logWarning("[Workspace Cleanup] " .. reason)
            end
        end,
    }

    connect(runOnce.Activated, function()
        if not alive or running or completed then return end
        running = true
        runOnce.Active, runOnce.AutoButtonColor = false, false
        runOnce.Text = "Workspace cleanup - Running..."
        local ok, removed, failed = pcall(scan)
        running = false
        if not alive then return end
        if ok and failed == 0 then
            completed = true
            runOnce.Text = "Workspace cleanup - Done"
            runOnce.BackgroundColor3 = colors.idle
            status.Text = string.format("Removed %d branches. Rejoin to restore.", removed)
            status.TextColor3 = colors.success
            logInfo("Workspace Cleanup", status.Text)
        else
            runOnce.Active, runOnce.AutoButtonColor = true, true
            runOnce.Text = "Workspace cleanup - Retry"
            status.Text = "Cleanup incomplete. Try again when your plot is ready."
            status.TextColor3 = colors.error
            local reason = ok and string.format("Removed %d branches; %d failed.", removed, failed) or tostring(removed)
            footer.Text = "Workspace cleanup: " .. reason
            logWarning("[Workspace Cleanup] " .. reason)
        end
    end)
end

local function checkPlot(plot)
    checkAlive()
    if not plot:IsDescendantOf(workspace)
        or tonumber(plot:GetAttribute("OwnerUserId")) ~= player.UserId then
        error("Plot ownership changed. Run again after your plot loads.", 0)
    end
end

local function waitForZone(cachedZoneName)
    local canvas = path(playerGui, {"MineGui", "SkillTreeFullFrame", "Tree", "Canvas"})
    if cachedZoneName then return path(canvas, {cachedZoneName}) end
    local reportRetry = newRetryMonitor("Detecting the current Upgrades zone")
    local lastSignature = nil
    local stableSince = os.clock()

    while true do
        checkAlive()
        if not canvas:IsDescendantOf(playerGui) then
            error("Skill tree Canvas was removed while detecting the zone.", 0)
        end
        local highestNumber = 0
        local highestZone = nil
        local names = {}
        for _, child in ipairs(canvas:GetChildren()) do
            local number = tonumber(child.Name:match("^Zone_Z(%d+)$"))
            if number and number >= 1 then
                table.insert(names, child.Name)
                if number > highestNumber then
                    highestNumber = number
                    highestZone = child
                end
            end
        end
        table.sort(names)
        local signature = table.concat(names, "|")
        if signature ~= lastSignature then
            lastSignature = signature
            stableSince = os.clock()
        elseif highestZone and os.clock() - stableSince >= SETTLE_TIME then
            local zoneId = "Z" .. tostring(highestNumber)

            return highestZone, zoneId
        end
        reportRetry("Canvas zone folders are missing or still changing.")
        pause(CONFIG.General.ScanPoll)
    end
end

local function openUpgrades()
    local reportRetry = newRetryMonitor("Opening Upgrades UI")
    local nextClick, attempted = 0, false
    local lastProblem = "UpgradesButton is not available."
    while true do
        checkAlive()
        local currentGui = player:FindFirstChildOfClass("PlayerGui")
        if currentGui then playerGui = currentGui end
        local mine = playerGui:FindFirstChild("MineGui")
        local frame = mine and mine:FindFirstChild("SkillTreeFullFrame")
        if visible(frame) then return attempted end
        if os.clock() >= nextClick then
            local object = mine
            for _, name in ipairs({"LeftBar", "Content", "Container", "UpgradesButton"}) do
                object = object and object:FindFirstChild(name)
            end
            local target, reason = resolveButton(object)
            if target and visible(target) and target.Active then
                attempted = true
                local ok, message = pcall(clickButton, target)
                lastProblem = ok and "UpgradesButton was clicked, but SkillTreeFullFrame did not open."
                    or tostring(message)
            else
                lastProblem = reason or "UpgradesButton is hidden or inactive."
            end
            reportRetry(lastProblem)
            nextClick = os.clock() + math.max(CONFIG.General.RetryInterval, SETTLE_TIME)
        end
        pause(CONFIG.General.ScanPoll)
    end
end

local function closeSkillTree()
    local mine = playerGui:FindFirstChild("MineGui")
    local frame = mine and mine:FindFirstChild("SkillTreeFullFrame")
    if not visible(frame) then return end
    clickButton(path(frame, {"Footer", "Close"}))
    waitUntil(function() return not frame.Parent or not visible(frame) end,
        LOAD_TIMEOUT, "Waiting for skill tree to close after clicking Footer.Close.", function()
            clickButton(path(frame, {"Footer", "Close"}))
        end)
end

local cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady
local cycleBestEquipped = false
local readCycleDensity
-- Keep the last confirmed scan across cycles, but start fresh on each script execution.
local savedZoneScan
local function useSavedZoneScan()
    if not savedZoneScan then return false end
    cycleZoneId, cycleZoneName, cycleDensityLevel = savedZoneScan.zoneId, savedZoneScan.zoneName, savedZoneScan.densityLevel
    refreshMasterRequirements(cycleZoneId, cycleDensityLevel)
    return true
end
local function getCycleZone()
    if not cycleZoneId and activeStage ~= "upgrades" and not preferences.stages.upgrades then useSavedZoneScan() end
    if not cycleZoneId then

        local opened = openUpgrades()
        local zone, zoneId = waitForZone()
        cycleZoneId, cycleZoneName = zoneId, zone.Name

        cycleDensityLevel = assert(readCycleDensity, "Density reader is not initialized.")(zone)
        refreshMasterRequirements(cycleZoneId, cycleDensityLevel)
        logUnitUpgradeDetail(string.format("%s (%s), density %d cached for this cycle.",
            cycleZoneId, cycleZoneName, cycleDensityLevel))

        if opened and activeStage ~= "upgrades" then
            closeSkillTree()
        end
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
local function unitSequenceCooldownReason()
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
    lastUnitSequence = os.clock()
    unitSequenceZone = zoneId
    cycleUnitUpgradeReadyZone = zoneId
    refreshUnitCooldown()
end
connect(pages.units.resetCooldown.Activated, function()
    if not alive then return end
    lastUnitSequence = -math.huge
    cycleUnitUpgradeReadyZone = nil
    refreshUnitCooldown()
    logInfo("Required Units", "Sequence cooldown cleared. Next Required Units stage can refresh units/hotbar and check matches.")
end)
local function syncUnitSequenceZone(zoneId)
    local previous = unitSequenceZone
    unitSequenceZone = zoneId
    if not previous or previous == zoneId then return end
    lastUnitSequence = -math.huge
    unitCountSnapshot, cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone = nil, nil, nil
    masterRequirementProgress[zoneId] = {}
    refreshMasterRequirements(zoneId)
    lastStageSkip.units, lastStageSkip.mutation, lastStageSkip.upgradingUnit = nil, nil, nil
    refreshUnitCooldown()
    logInfo("Upgrades", previous .. " -> " .. zoneId .. ": unit sequence cooldown reset for the new zone.")
end
local function unitsPreparedThisCycle(zoneId)
    if cycleUnitsPreparedZone ~= zoneId then
        return false, "Full Required Units preparation did not complete in this cycle (placement skipped / density 0 / cooldown)."
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
        and (activeRun == "sell" or (activeRun == "master" and preferences.masterEnabled))
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

local function normalizedSellText(text)
    return text:gsub("<[^>]*>", ""):lower():gsub("[^%w]", "")
end
local function findByText(root, needle, excluded)
    needle = normalizedSellText(needle)
    for _, candidate in ipairs(root:GetDescendants()) do
        if candidate ~= excluded and candidate:IsA("GuiButton") and visible(candidate) and candidate.Active
            and candidate.AbsoluteSize.X >= 1 and candidate.AbsoluteSize.Y >= 1 then
            local text = candidate:IsA("TextButton") and candidate.Text or ""
            if normalizedSellText(candidate.Name .. " " .. text):find(needle, 1, true) then return candidate end
            -- ImageButtons and generic buttons can put their caption in a child label.
            for _, child in ipairs(candidate:GetDescendants()) do
                if (child:IsA("TextLabel") or child:IsA("TextButton")) and visible(child) then
                    local owner = child:IsA("GuiButton") and child or child.Parent
                    while owner and owner ~= candidate and not owner:IsA("GuiButton") do owner = owner.Parent end
                    if owner == candidate and normalizedSellText(child.Text):find(needle, 1, true) then return candidate end
                end
            end
        end
    end
    return nil
end
local function waitForSellButton(root, text, excluded)
    local reportRetry = newRetryMonitor("Finding Sell UI button: " .. text)
    local nextDetails = 0
    while sellIsActive() do
        local target = findByText(root, text, excluded)
        if target then return target end
        if os.clock() >= nextDetails then
            local available = {}
            for _, candidate in ipairs(root:GetDescendants()) do
                if candidate:IsA("GuiButton") then
                    local caption = candidate:IsA("TextButton") and candidate.Text or ""
                    table.insert(available, string.format("%s [%s; visible=%s; active=%s; size=%gx%g]",
                        candidate.Name, caption, tostring(visible(candidate)), tostring(candidate.Active),
                        candidate.AbsoluteSize.X, candidate.AbsoluteSize.Y))
                    if #available >= 10 then break end
                end
            end
            reportRetry("Buttons found: " .. (#available > 0 and table.concat(available, "; ") or "none"))
            nextDetails = os.clock() + CONFIG.General.RetryInterval
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
    GameEvent:FireServer("MineTakeChest")
    if not sleepSell(CONFIG.Sell.ChestDelay) then return end
    status.Text = "Going to the sell stand..."
    checkAlive()
    GameEvent:FireServer("MineTeleport", "Hub")
    if not sleepSell(CONFIG.Sell.TeleportDelay) then return end

    local sellStand = workspace:FindFirstChild("SellStand")
    if not sellStand then error("SellStand is missing.", 0) end
    local standPart = sellStand:IsA("BasePart") and sellStand
        or (sellStand.PrimaryPart or sellStand:FindFirstChildWhichIsA("BasePart"))
    if not standPart then error("SellStand has no BasePart.", 0) end
    local standPos = standPart.Position
    local facing = standPart.CFrame.LookVector
    local standSpot = standPos - facing * CONFIG.Sell.StandDistance + Vector3.new(0, CONFIG.Sell.StandHeight, 0)
    hrp.CFrame = CFrame.new(standSpot, standPos)
    local cam = workspace.CurrentCamera
    if cam then cam.CFrame = CFrame.new(standSpot + Vector3.new(0, CONFIG.Sell.CameraHeight, 0), standPos) end
    if not sleepSell(CONFIG.Sell.StandDelay) then return end

    for _, d in ipairs(sellStand:GetDescendants()) do
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
    local sf = waitUntil(function()
        mineGui = playerGui:FindFirstChild("MineGui")
        local frame = mineGui and mineGui:FindFirstChild("SellFrame")
        return visible(frame) and frame or nil
    end, LOAD_TIMEOUT, "Waiting for Sell window after activating the stand prompt.", function()
        for _, prompt in ipairs(sellStand:GetDescendants()) do
            checkAlive()
            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                heldPrompt = prompt
                prompt:InputHoldBegin()
                pause(math.max(CONFIG.Sell.PromptHold, prompt.HoldDuration))
                releaseInputs()
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
local unlimitedPickaxeId = nil
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

local unlimitedToggle = button(pages.master.frame, "", UDim2.new(0.5, 6, 0, 342), UDim2.new(0.5, -24, 0, 32))
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
local unlimitedHint = label(pages.master.frame, "Highest unlocked; purchase counts still saved.",
    UDim2.new(0.5, 6, 0, 376), UDim2.new(0.5, -24, 0, 16), 10)
unlimitedHint.TextColor3 = colors.muted

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
        local unlimited = CONFIG.Pickaxe.UnlimitedBestPickaxe and tonumber(id) == unlimitedPickaxeId
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
        local ready = true
        local bestId = nil
        local bestTile = nil
        local id = 2
        for index = 1, #children do
            local tile = children[index]
            if tile.Name == "Tile" then
                local state, reason = tileState(tile)
                table.insert(tiles, tile)
                table.insert(states, state or "unknown")
                if not state then
                    ready = false
                    problem = string.format("Pickaxe ID %d: %s", id, reason)
                elseif isAvailable(state) then

                    bestId = id
                    bestTile = tile
                end

                id = id + 1
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
                    if previousTiles[index] ~= tile or previousStates[index] ~= states[index] then
                        unchanged = false
                        break
                    end
                end
            end
            if not unchanged then
                previousTiles = tiles
                previousStates = states
                stableSince = os.clock()
            elseif os.clock() - stableSince >= SETTLE_TIME then

                for index, tile in ipairs(tiles) do
                    local color = tile.BuyButton.Content.BackgroundColor3

                end
                return bestId, bestTile
            end
            problem = "Pickaxe tiles or colors are still changing."
        else
            previousTiles = nil
            previousStates = nil
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
        return waitUntil(function()
            if deadline and os.clock() >= deadline then error("Inter-cycle shop wait ended.", 0) end
            return test()
        end, timeout, message, retryAction)
    end
    local function shopPath(parent, names)
        for _, name in ipairs(names) do
            parent = shopWait(function() return parent:FindFirstChild(name) end,
                LOAD_TIMEOUT, "Missing pickaxe shop path component: " .. name)
        end
        return parent
    end
    local function shopPause(seconds)
        pause(deadline and math.max(0, math.min(seconds, deadline - os.clock())) or seconds)
        if deadline and os.clock() >= deadline then error("Inter-cycle shop wait ended.", 0) end
    end

    status.Text = "Refreshing the pickaxe shop..."
    local stand = shopPath(workspace, {"PickaxesStand"})
    local prompt = stand:FindFirstChildWhichIsA("ProximityPrompt", true)
    if not prompt then error("PickaxesStand has no ProximityPrompt.", 0) end
    local part = prompt.Parent
    while part and part ~= stand and not part:IsA("BasePart") do part = part.Parent end
    if not part or not part:IsA("BasePart") then
        part = stand:IsA("BasePart") and stand or stand:FindFirstChildWhichIsA("BasePart", true)
    end
    if not part then error("PickaxesStand has no BasePart to teleport to.", 0) end
    local character = shopWait(function() return player.Character end, LOAD_TIMEOUT, "Character is missing.")
    local root = shopPath(character, {"HumanoidRootPart"})
    originalRoot, originalCFrame = root, root.CFrame
    local position = prompt.Parent:IsA("Attachment") and prompt.Parent.WorldPosition or part.Position
    local distance = math.min(CONFIG.Pickaxe.StandDistance, math.max(0.5, prompt.MaxActivationDistance * 0.5))
    root.CFrame = CFrame.new(position - part.CFrame.LookVector * distance + Vector3.new(0, CONFIG.Pickaxe.StandHeight, 0), position)
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    shopPause(CONFIG.Pickaxe.ShopTeleportDelay)
    if not player.Character or not root:IsDescendantOf(player.Character) then
        error("Character changed while opening the pickaxe shop. Run again after respawning.", 0)
    end
    shopWait(function() return prompt.Parent and prompt.Enabled end,
        LOAD_TIMEOUT, "PickaxesStand proximity prompt is disabled.")
    heldPrompt = prompt
    prompt:InputHoldBegin()
    shopPause(math.max(prompt.HoldDuration, CONFIG.Pickaxe.MinimumPromptHold) + CONFIG.Pickaxe.PromptHoldPadding)
    releaseInputs()
    local shop = shopWait(function()
        local mine = playerGui:FindFirstChild("MineGui")
        local current = mine and mine:FindFirstChild("PickaxeShopFrame")
        return visible(current) and current or nil
    end, LOAD_TIMEOUT, "Waiting for Pickaxe shop to open after activating its proximity prompt.", function()
        if not prompt.Parent or not prompt.Enabled then return end
        heldPrompt = prompt
        prompt:InputHoldBegin()
        shopPause(math.max(prompt.HoldDuration, CONFIG.Pickaxe.MinimumPromptHold) + CONFIG.Pickaxe.PromptHoldPadding)
        releaseInputs()
    end)
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
        refreshPickaxeShop()

            local event = getGameEvent()
            if not event:IsA("RemoteEvent") then
                error("Remotes.GamestateEvent is not a RemoteEvent.", 0)
            end
            local list = path(playerGui, {"MineGui", "PickaxeShopFrame", "List"})
            status.Text = "Finding the highest available pickaxe ID..."
            local id, tile = scanBestPickaxe(list)
            unlimitedPickaxeId = id
            if not alive then return "Unloaded." end
            if not id then
                return "Cannot buy the best pickaxe at the moment."
            end

            local data = readPickaxeCounts()
            maxPickaxes = data.maxPickaxes
            maxInput.Text = tostring(maxPickaxes)
            refreshCountsUI(data)
            local savedCount = data.requestCounts[string.format("%.0f", id)] or 0
            if not CONFIG.Pickaxe.UnlimitedBestPickaxe and savedCount >= maxPickaxes then
                return string.format("Pickaxe ID %d: limit reached (%d/%d).", id, savedCount, maxPickaxes)
            end
            local selectedState = tileState(tile)
            if tile.Parent ~= list or selectedState ~= "buyable" then
                return "Cannot buy the best pickaxe at the moment."
            end

            local count, limitCount, limit = reservePickaxe(id, CONFIG.Pickaxe.UnlimitedBestPickaxe)
            maxInput.Text = tostring(limit)
            if not count then
                return string.format("Pickaxe ID %d: limit reached (%d/%d).", id, limitCount, limit)
            end

            if not alive then return "Unloaded; saved slot retained." end

            if tile.Parent ~= list or tileState(tile) ~= "buyable" then
                return "Cannot buy the best pickaxe at the moment."
            end
            checkAlive()
            event:FireServer("MineBuyPickaxe", id)

            if CONFIG.Pickaxe.UnlimitedBestPickaxe then
                return string.format("ID %d: request sent. Saved %d requests; best-pickaxe buy limit disabled.", id, count)
            end
            return string.format("ID %d: request sent. Saved %d/%d.", id, count, limit)
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

        zone = waitForZone(zone.Name)
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
    local content
    if kind == "maxZone" then
        content = string.format("**%s** reached **MAX zone: %s (%s)**!", player.Name, zoneName, zoneId)
    else
        content = string.format("**%s** unlocked **Colossus** in **%s (%s)**!\nColossus progress: **%s**.",
            player.Name, zoneName, zoneId, pips)
    end
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
local function notifyMaxZoneReached(zoneId)
    if isMaxZone(zoneId) then notifyUpgradeMilestone("maxZone", zoneId) end
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
        notifyUpgradeMilestone("colossus", zone.Name:match("^Zone_(Z%d+)$"), progress)
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
    local changed = false
    for index = 3, 7 do
        local id = order[index]
        local enabled = not complete
        if preferences.stages[id] ~= enabled then changed = true end
        preferences.stages[id] = enabled
        stageRows[id].Text = tostring(index) .. ". " .. pages[id].name .. (enabled and " / Waiting" or " / OFF")
        stageRows[id].TextColor3 = colors.muted
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
        .. (complete and " Stages 3-7 OFF." or " Stages 3-7 ON.")
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
        zone = waitForZone(zone.Name)
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
        zone = waitForZone(zone.Name)

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
    cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady = nil, nil, nil, false
    status.Text = "Opening Upgrades for a fresh zone and Density scan..."
    openUpgrades()
    pause(SETTLE_TIME)
    local zone, zoneId = waitForZone()
    cycleZoneId, cycleZoneName = zoneId, zone.Name
    local level
    level, zone = scanDensity(zone)
    syncUnitSequenceZone(zoneId)
    notifyMaxZoneReached(zoneId)
    logInfo("Upgrades", string.format("Fresh UI scan: %s, Density %d.", zoneId, level))
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
modules.upgrades = {setBusy = refreshZoneToggles, getDensity = function()

    getCycleZone()
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
    status.Text = "Closing the skill tree; zone selection waits until the end..."
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
        closeUnitPanel("Closing unit panel with ExitButton before unit interaction")
        return
    end
    local reportRetry = newRetryMonitor("Closing unit/inventory panel " .. frame.Name)
    while frame.Parent and visible(frame) do
        checkAlive()
        local button = frame
        for _, name in ipairs(buttonPath) do
            button = button and button:FindFirstChild(name)
        end
        if button and visible(button) then clickButton(button) end
        reportRetry()
        pause(retryDelay)
    end
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
    return resolveButton(row)
end

local function inventoryTargets(scroll, includeAll)
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
        for _, row in ipairs(scroll:GetChildren()) do
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

local function taggedInventoryName(itemName)
    local tag = itemName and itemName:GetAttribute("_AnimTag")
    return tag ~= nil and tag ~= ""
end

local function higherInventoryPriority(a, b)
    if a.damage.power ~= b.damage.power then return a.damage.power > b.damage.power end
    local width = math.max(#a.damage.digits, #b.damage.digits)
    local left = a.damage.digits .. string.rep("0", width - #a.damage.digits)
    local right = b.damage.digits .. string.rep("0", width - #b.damage.digits)
    if left ~= right then return left > right end
    if a.tagged ~= b.tagged then return a.tagged end
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
                if os.clock() - stableSince >= UI_SETTLE then return summary end
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
    logInfo("Required Units", string.format("Verified hotbar: %d occupied slots, %d unit copies (including stacks). %s",
        occupied, total, #details > 0 and table.concat(details, "; ") or "Hotbar is empty."))
    return summary
end

local function closeRequiredInventory()
    local function close()
        local frame = inventoryFrame()
        if visible(frame) then clickButton(path(frame, {"Content", "Actions", "Close"})) end
    end
    close()
    waitUntil(function() return not visible(inventoryFrame()) end, nil,
        "Closing Required Units inventory", close)
end

local function openRequiredInventory()
    if visible(inventoryFrame()) then return end
    local function open()
        if not visible(inventoryFrame()) then
            clickButton(path(playerGui, {"MineGui", "HotbarFrame", "Content", "Container", "InventoryButton"}))
        end
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

local function scanRequiredInventory(densityLevel, zoneId)
    local rule = RequiredUnitsByZone[zoneId] or {Names = {}}
    local allowed, rows = {}, {}
    for _, name in ipairs(rule.Names) do allowed[name] = true end
    local scroll = inventoryScroll()
    for _, row in ipairs(scroll:GetChildren()) do
        if row:IsA("GuiObject") then rows[row.Name .. "\0" .. tostring(row.LayoutOrder)] = row end
    end
    local candidates, signature = {}, {}
    local total, skippedNames, skippedTags, skippedDamage = 0, 0, 0, 0
    -- An empty inventory is a valid zero count; it may still pass with displayed units.
    local targets = inventoryTargets(scroll, true) or {}
    for index, target in ipairs(targets) do
        checkAlive()
        local row = rows[target.name .. "\0" .. tostring(target.order)]
        if not row then return nil, "Inventory rows changed while counting; waiting for a fresh scan." end
        local content = row:FindFirstChild("Content")
        local itemName = content and content:FindFirstChild("ItemName")
        local name, tagged = inventoryText(itemName), taggedInventoryName(itemName)
        if not allowed[name] then
            skippedNames = skippedNames + 1
        elseif densityLevel >= 2 and not tagged then
            skippedTags = skippedTags + 1
        else
            local damage = inventoryDamageKey(inventoryText(content and content:FindFirstChild("Damage")))
            if not damage then
                skippedDamage = skippedDamage + 1
            else
                local count = parseRequiredStackCount(inventoryText(content and content:FindFirstChild("ActualItemCount")))
                if not count then return nil, "Unreadable inventory stack count for " .. name .. "; waiting for its quantity." end
                table.insert(candidates, {target = target, row = row, name = name, tagged = tagged,
                    damage = damage, index = index, count = count, source = "inventory"})
                total = total + count
            end
        end
    end
    table.sort(candidates, higherInventoryPriority)
    for _, entry in ipairs(candidates) do
        table.insert(signature, string.format("%q:%s:%q:%s:%s:%s:%d", entry.target.name,
            tostring(entry.target.order), entry.name, tostring(entry.tagged), tostring(entry.damage.power), entry.damage.digits, entry.count))
    end
    return {summary = candidates, total = total, skippedNames = skippedNames,
        skippedTags = skippedTags, skippedDamage = skippedDamage}, table.concat(signature, "|")
end

local function readRequiredInventory(densityLevel, zoneId, operation)
    local reportRetry = newRetryMonitor(operation)
    local lastSignature, stableSince
    while true do
        checkAlive()
        if not visible(inventoryFrame()) then openRequiredInventory() end
        local result, signature = scanRequiredInventory(densityLevel, zoneId)
        local problem = signature
        if result then
            if signature ~= lastSignature then lastSignature, stableSince = signature, os.clock() end
            if os.clock() - stableSince >= UI_SETTLE then
                logInfo("Required Units", string.format("%s density %d inventory count: %d whitelisted copies across %d stacks; skipped %d other names, %d untagged matches, %d unreadable Damage values.",
                    zoneId, densityLevel, result.total, #result.summary, result.skippedNames, result.skippedTags, result.skippedDamage))
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
        if inventoryText(itemName) ~= candidate.name or taggedInventoryName(itemName) ~= candidate.tagged
            or not damage or damage.power ~= candidate.damage.power or damage.digits ~= candidate.damage.digits then
            error("Inventory name/tag/Damage changed before selecting " .. candidate.name .. ".", 0)
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
        if alreadyPlaced(attempt) then return true end
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
        if alreadyPlaced(attempt) then return true end
        if UserInputService:GetFocusedTextBox() then error("Leave the text field before placing units.", 0) end
        if attempt > 1 then

            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:UnequipTools() end
            pause(EQUIP_SLOT_SETTLE)
            if alreadyPlaced(attempt) then return true end
        end
        local valid, reason = pcall(validatePlacementHotbar, entry)
        if not valid then
            if alreadyPlaced(attempt) then return true end
            error(reason, 0)
        end
        if alreadyPlaced(attempt) then return true end
        heldKey = Enum.KeyCode[HOTBAR_KEYS[entry.slot]]
        VIM:SendKeyEvent(true, heldKey, false, game)
        pause(PLACEMENT_KEY_HOLD)
        VIM:SendKeyEvent(false, heldKey, false, game)
        heldKey = nil
        pause(EQUIP_SLOT_SETTLE)
        local current = holderPrompt(plot, holderName, true)
        if hasPickUpAction(current) then return true end
        if current.Parent and current.Enabled then
            setStatus("Activating placement prompt for " .. holderName .. "...")
            heldPrompt = current
            current:InputHoldBegin()
            pause(math.max(current.HoldDuration, CONFIG.Units.PlacementMinimumHold))
            releaseInputs()
            pause(PLACEMENT_SETTLE)
            if hasPickUpAction(holderPrompt(plot, holderName, true)) then return true end
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

local function finishEquipping(event, plot, zoneId, densityLevel)
    local required = requiredSlotCount(zoneId)
    local function skipPlacement(reason)
        setStatus("Placement skipped: " .. reason)
        logUnitUpgradeDetail("Required Units skipped serial placement: " .. reason)
        return "Placement skipped: " .. reason .. " Equip Best is handled at cycle end.", false, reason
    end
    if FinalEquipMode == "Best" then return skipPlacement("FinalEquipMode is Best.") end
    if densityLevel == 0 then return skipPlacement("density level is 0.") end
    if required == 0 then return skipPlacement("RequiredUnitCount is zero; no required pads to fill.") end
    local placed, batches = 0, 0
    local reportRetry = newRetryMonitor("Filling empty unlocked pads through hotbar 1")
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
            reportRetry(problem)
            pause(CONFIG.General.RetryInterval)
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
                end)
            end
            logInfo("Required Units", string.format("%s hotbar 1 batch %d: %s; placed %d copies; %d empty unlocked pads remain.",
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
    if not available or FinalEquipMode == "Best" or densityLevel == 0 then
        local reason = availabilityReason or (FinalEquipMode == "Best" and "FinalEquipMode is Best." or "density level is 0.")
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
    closeUnitPanel("Closing mutation/unit panel with ExitButton")
    ownsFocus = false
end
local function cleanupFocus()
    if not ownsFocus then return end
    local focus = focusFrame()
    if visible(focus) then pcall(tryUnitExit, focus, "MouseButton1Click") end
    if visible(focus) then pcall(tryUnitExit, focus, "Activated") end
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
            if os.clock() - stableSince >= CONFIG.Mutation.RescanSettleTime then return slots end
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
    logInfo("Mutate Units", string.format("%s: refreshed current mutation from its unit panel: saved=%s, displayed=%s, current=%s.",
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
local function mutateHotbarUnitToUnreal(slot, plot, checkTarget, report)
    local unreal = assert(ranks.unreal, "CONFIG.Mutation.Priority needs Unreal.")
    checkTarget(slot, false)
    slot.pad = path(slot.holder, {"Pad"})
    slot.detector = path(slot.holder, {"UpgradePart", "UpgradeClick"})
    openSlot(slot, plot)
    local rolls = 0
    local reportRetry = newRetryMonitor("M1: rolling mutations until Unreal")
    while true do
        checkAlive()
        checkTarget(slot, true)
        if readFocusedRank() >= unreal then break end
        local panel = assert(mutationPanel(), "Mutation panel is unavailable.")
        if not canRoll(path(panel, {"Side", "RollButton"})) then
            error("M1 mutation roll unavailable (red means no money); batch stopped before upgrades.", 0)
        end
        report(string.format("%s: mutating to Unreal. Roll: %d", slot.hotbarName or slot.expectedName, rolls + 1))
        checkTarget(slot, true)
        checkAlive()
        getGameEvent():FireServer("MineRollMutation", slot.holder.Name)
        rolls = rolls + 1
        reportRetry()
        pause(CONFIG.Mutation.RapidRollSettleTime)
        if readFocusedRank() >= unreal then break end
        pause(CONFIG.Mutation.RapidRollDelay)
    end
    closeFocus()
end
modules.mutation = {cleanup = cleanupFocus, mutateHotbarUnitToUnreal = mutateHotbarUnitToUnreal, upgradeTargets = upgradeTargets, densityReady = densityReady, observeProgress = function(zoneId, plot)

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
    local rolls, loggedFirstRequest = 0, false
    local reportMutationRetries = newRetryMonitor("Meeting mutation quotas in " .. zoneId)
    local observedRanks = {}
    local function sendRoll(choice)
        checkPlot(plot)
        if densityIIZones[zoneId] then error("Density II stopped mutation for " .. zoneId .. ". No new roll sent.", 0) end
        local _, selected, scopeReason = requiredHolderTargets(plot, RequiredUnitCount)
        if scopeReason or not selected[choice.holder.Name] then
            error(scopeReason or "Refusing to mutate a holder outside the first required slots.", 0)
        end
        if not choice.holder:IsDescendantOf(plot) then error("Selected holder was removed. No roll sent.", 0) end
        status.Text = string.format("Rolling %s (%s). Roll: %d", choice.holder.Name, choice.mutation, rolls + 1)
        checkAlive()
        getGameEvent():FireServer("MineRollMutation", choice.holder.Name)
        if not loggedFirstRequest then
            logInfo("Mutate Units", "MineRollMutation request sent for " .. choice.holder.Name .. ".")
            loggedFirstRequest = true
        end
        rolls = rolls + 1
        reportMutationRetries("Rolling " .. choice.holder.Name .. "; total rolls: " .. rolls)
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
            report(slots, "The first RequiredUnitCount unlocked slots meet mutation quotas. Other slots were excluded.")
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
    local holderLabel = pad and pad:FindFirstChild("HolderLabel")
    if holderLabel and holderLabel:IsA("LayerCollector") then return holderLabel.Enabled end
    return holderLabel and holderLabel:IsA("GuiObject") and holderLabel.Visible or false
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
    closeUnitPanel("Closing unit Stats panel with ExitButton")
    ownsStatFocus = false
    pause(CONFIG.Units.StatUpgrade.PanelSettleTime)
end
local function cleanupStatFocus()
    if not ownsStatFocus then return end
    local focus = statFocusFrame()
    if visible(focus) then pcall(tryUnitExit, focus, "MouseButton1Click") end
    if visible(focus) then pcall(tryUnitExit, focus, "Activated") end
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
        local label = path(statFocusFrame(), {"Tabs", "StatsTab", "Content", "Row", "Label"})

        local tab = path(statFocusFrame(), {"Tabs", "StatsTab"})
        local button = label
        while button ~= tab and not button:IsA("GuiButton") do button = button.Parent end
        clickButton(button)
        waitUntil(statsPanel, CONFIG.Units.ActionTimeout, "Waiting for Stats tab to open.", function() clickButton(button) end)
        pause(settings.PanelSettleTime)
    end
    return {open = open, readStat = readStat, canUpgrade = canUpgrade, checkTarget = checkTarget}
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
    local damageBatchTarget, statsReady = nil, true
    local cache = options.cache or (minimum and getUnitUpgradeCache(plot))
    if cache then session = cache.session end
    local function checkSlot(slot)
        local currentName = waitForDisplayedUnit(plot, holders, slot)
        slot.expectedName = slot.expectedName or currentName
    end
    logUnitUpgradeDetail(heading .. ": " .. #slots .. " displayed units.")
    for _, slot in ipairs(slots) do
        checkSlot(slot)
        if cache then attachCachedUnit(cache, slot) end
        local level = slot.cachedStats and slot.cachedStats.Damage.level or readLevel(slot.holder)
        slot.startLevel, slot.level = level, level
        slot.damageCap = cap
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
        local choice, lowestLevel
        for _, slot in ipairs(slots) do
            if not cache then checkSlot(slot) end
            slot.level = slot.cachedStats and slot.cachedStats.Damage.level or readLevel(slot.holder)
            if slot.level >= slot.damageCap then slot.remaining = 0 end
            -- Extras can have different caps. Finished low-cap units must not
            -- hold the next Damage/catch-up batch below another extra's target.
            if not options.halfDamageMaximum or (slot.remaining > 0 and not slot.damageUnavailable) then
                lowestLevel = math.min(lowestLevel or slot.level, slot.level)
            end
            if slot.remaining > 0 and not slot.damageUnavailable and (not choice or slot.level < choice.level
                or (slot.level == choice.level and slot.number < choice.number)) then choice = slot end
        end
        if minimum and ((lowestLevel and lowestLevel >= minimum) or (options.halfDamageMaximum and not choice))
            and (not damageBatchTarget or not choice or lowestLevel >= damageBatchTarget) then
            local _, _, _, ready = upgradeDisplayedStats(plot, cache)
            statsReady = ready
            if not ready then
                stageText.Text = "Damage paused: eligible Speed/MineSpeed have not caught up to current Damage levels."
                break
            end
            damageBatchTarget = (lowestLevel or minimum) + damageBatchSize
        end
        if not choice then break end

        if minimum and choice.level >= minimum
            and (not damageBatchTarget or choice.level >= damageBatchTarget) then break end
        session = session or createUnitStatSession(plot, 1)
        session.open(choice)
        local batchSize = math.min(damageBatchSize, choice.remaining)
        if minimum then
            batchSize = math.min(batchSize, (damageBatchTarget or minimum) - choice.level)
        end
        local batchStartLevel = choice.level
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

        if cache and choice.level > batchStartLevel then
            for _, stat in ipairs({"Speed", "MineSpeed"}) do
                if choice.cachedStats[stat].maximum < choice.level then
                    choice.cachedStats[stat] = session.readStat(choice, stat == "MineSpeed" and "Mining" or stat)
                end
            end
        end
        pause(settings.BeforeExitDelay)
        closeStatFocus()
    end
    if options.confirmCap and damageRequests > 0 then pause(settings.PanelSettleTime) end
    if not cache then
        for _, slot in ipairs(slots) do
            local summary = string.format("Unit slot %d done upgrading: Damage requested %d times; level %d -> %d (target %d)",
                slot.number, slot.damageRequests, slot.startLevel, slot.cachedStats and slot.cachedStats.Damage.level or readLevel(slot.holder), slot.damageCap)
            if slot.damageUnavailable then summary = summary .. "; stopped because Damage button is not green" end
            logInfo(options.scope or "Upgrade Units", summary .. ".")
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
    local cap = CONFIG.UpgradingOldUnit.TargetLevel
    if type(cap) ~= "number" or cap ~= cap or cap < 1 or cap % 1 ~= 0 or cap == math.huge then
        error("CONFIG.UpgradingOldUnit.TargetLevel must be a finite positive whole number.", 0)
    end
    local plot = getMyPlot()
    checkPlot(plot)
    local holders = path(plot, {"Holders"})
    local slots = {}
    logInfo("Upgrade Old Units", string.format("Current zone=%s; density=%d; ONLY previous zone %s Names are eligible; old-unit target level=%d.",
        zoneId, densityLevel, previousZoneId, cap))
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
    local damageRequests = upgradeDisplayedSlots(plot, slots, cap, oldStatus,
        "Upgrading ONLY " .. previousZoneId .. " required units (Damage only)", {scope = "Upgrade Old Units"})
    return string.format("%s: processed %d displayed units from %s Names only; sent %d Damage requests. Old-unit target level: %d.",
        zoneId, #slots, previousZoneId, damageRequests, cap)
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

upgradeDisplayedStats = function(plot, cache)
    closeStatFocus()
    local settings = CONFIG.Units.StatUpgrade
    local minimum = minimumStatDamageLevel()
    cache = getUnitUpgradeCache(plot, cache)
    local eligible = {}
    for _, entry in ipairs(cache.slots) do
        if entry.cachedStats.Damage.level >= minimum then
            table.insert(eligible, {holder = entry.holder, number = entry.number, expectedName = entry.expectedName,
                cachedStats = entry.cachedStats, target = entry.cachedStats.Damage.level})
        end
    end
    if #eligible == 0 then return 0, 0, 0, true end
    local session = cache.session
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
    local card = make("Frame", pages.master.frame, {
        Name = "HotbarUpgrades", Position = UDim2.fromOffset(18, masterStageBottom + 268),
        Size = UDim2.new(1, -36, 0, 226), BackgroundColor3 = colors.bg, BorderSizePixel = 0,
    })
    corner(card)
    local heading = label(card, "HOTBAR UPGRADES / M1", UDim2.fromOffset(12, 10), UDim2.new(1, -24, 0, 20), 14)
    heading.Font, heading.TextColor3 = Enum.Font.GothamBold, colors.accent
    label(card, "Run once for all selected copies. Max Speed/Mining; Damage target from config.",
        UDim2.fromOffset(12, 34), UDim2.new(1, -24, 0, 30), 12)
    local dropdown = button(card, "Select hotbar units v", UDim2.fromOffset(12, 68), UDim2.new(0.64, -18, 0, 36))
    dropdown.Name, dropdown.TextSize = "HotbarUpgradeDropdown", 18
    dropdown.TextTruncate = Enum.TextTruncate.AtEnd
    local run = button(card, "Run Upgrades", UDim2.fromOffset(12, 112), UDim2.fromOffset(160, 32))
    run.Name, run.TextSize = "RunHotbarUpgrades", 16
    local refresh = button(card, "Refresh", UDim2.new(0.64, 2, 0, 68), UDim2.new(0.36, -14, 0, 36))
    refresh.Name, refresh.TextSize = "RefreshHotbarUnits", 18
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
        card.Size = UDim2.new(1, -36, 0, value and 416 or 226)
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
    local function readEntry(index)
        local container = find(playerGui, {"MineGui", "HotbarFrame", "Content", "Container"})
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
        if busy and activeRun == "master" then stopRun() end
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
        local event, completed = getGameEvent(), 0
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

        local function moveToM1()
            checkAlive()
            checkPlot(plot)
            if not player.Character or not root:IsDescendantOf(player.Character) then
                error("Character changed during M1 placement/pickup.", 0)
            end
            local base = holder:FindFirstChild("Pad")
            if not base or not base:IsA("BasePart") then base = holder:FindFirstChild("UpgradePart") end
            if not base or not base:IsA("BasePart") then base = holder:FindFirstChildWhichIsA("BasePart") end
            if not base then error("M1 has no placement base.", 0) end
            root.CFrame = CFrame.new(base.Position + Vector3.new(0, 3, 0), base.Position)
            root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
            pause(CONFIG.HotbarUpgrade.Placement.TeleportDelay)
        end
        local function placeIntoM1(entry, copy)
            closeStatFocus()
            pause(0.2)
            moveToM1()
            if waitForM1Action() ~= "place" then error("M1 must be empty before placing the next selected copy.", 0) end
            if UserInputService:GetFocusedTextBox() then error("Leave the text field before placing units.", 0) end
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:UnequipTools() end
            local source = readStableEntry(entry.slot)
            if source.name ~= entry.name or source.count == 0 then
                error("Selected hotbar slot " .. entry.slot .. " changed before placement; refresh and select again.", 0)
            end
            local keyName = CONFIG.Units.HotbarKeys[entry.slot]
            if not keyName or not Enum.KeyCode[keyName] then error("Selected hotbar slot has no number key.", 0) end
            report(string.format("Placing slot %d: %s (%d/%d) in M1...", entry.slot, entry.name, copy, entry.count))
            checkAlive()
            heldKey = Enum.KeyCode[keyName]
            VIM:SendKeyEvent(true, heldKey, false, game)
            pause(CONFIG.HotbarUpgrade.Placement.KeyHold)
            VIM:SendKeyEvent(false, heldKey, false, game)
            heldKey = nil
            pause(CONFIG.HotbarUpgrade.Placement.EquipDelay)
            local current = waitUntil(function()
                local value = prompt()
                if action() ~= "place" then error("M1 occupancy changed before placement; stopped.", 0) end
                return value.Enabled and value
            end, math.huge, "M1 placement prompt did not become available.")
            local beforePrompt = readStableEntry(entry.slot)
            if beforePrompt.name ~= entry.name or beforePrompt.count ~= source.count then
                error("Selected hotbar slot changed while equipping; stopped before placement.", 0)
            end
            checkAlive()
            heldPrompt = current
            current:InputHoldBegin()
            pause(math.max(current.HoldDuration or 0, 0.05))
            releaseInputs()
            pause(CONFIG.HotbarUpgrade.Placement.AfterPromptDelay)
            waitUntil(function()
                if action() ~= "pick up" then return nil end
                local remaining = readEntry(entry.slot)

                return remaining.name == "" or remaining.name == entry.name and remaining.count < source.count
            end, math.huge, "M1: waiting for placement and consumption of the selected hotbar copy.", function()
                if action() ~= "place" then return end
                local remaining = readEntry(entry.slot)
                if remaining.name ~= entry.name or remaining.count ~= source.count then return end
                local retryPrompt = prompt()
                if retryPrompt.Enabled then
                    heldPrompt = retryPrompt
                    retryPrompt:InputHoldBegin()
                    pause(math.max(retryPrompt.HoldDuration or 0, 0.05))
                    releaseInputs()
                end
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
            while true do
                if waitForM1Action() == "place" then return end
                waitForDisplayedUnit(plot, path(plot, {"Holders"}), guard)
                if not player.Character or not root:IsDescendantOf(player.Character) then error("Character changed during pickup.", 0) end
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:UnequipTools() end
                moveToM1()
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
                event:FireServer("MineUpgradeCharacter", "M1", stat)
                pause(math.max(CONFIG.Units.UpgradeRequestDelays[stat], CONFIG.Units.StatUpgrade.PanelSettleTime))
                local after
                waitUntil(function()
                    after = session.readStat(slot, row)
                    return after.level > before.level
                end, math.huge, "M1: waiting for " .. stat .. " level response.", function()
                    session.checkTarget(slot, true)
                    local latest = session.readStat(slot, row)
                    if latest.level <= before.level and latest.upgradeable then
                        event:FireServer("MineUpgradeCharacter", "M1", stat)
                    end
                end)
                before = after
            end
            return before
        end
        closeStatFocus()
        local mine = playerGui:FindFirstChild("MineGui")
        local inventory = mine and mine:FindFirstChild("InventoryFrame")
        if visible(inventory) then
            clickButton(path(inventory, {"Content", "Actions", "Close"}))
            waitUntil(function() return not visible(inventory) end, math.huge, "Waiting for inventory to close before Hotbar Upgrades.", function() clickButton(path(inventory, {"Content", "Actions", "Close"})) end)
        end
        for _, entry in ipairs(queue) do
            for copy = 1, entry.count do
                checkAlive()
                local current = readStableEntry(entry.slot)
                if current.count == 0 and (current.name == "" or current.name == entry.name) then break end
                if current.name ~= entry.name then return "Stopped: selected hotbar slot " .. entry.slot .. " changed. Completed " .. completed .. " units." end
                clearM1()

                current = readStableEntry(entry.slot)
                if current.name ~= entry.name or current.count == 0 then return "Stopped: selected hotbar slot " .. entry.slot .. " changed. Completed " .. completed .. " units." end
                local slot = placeIntoM1(entry, copy)
                modules.mutation.mutateHotbarUnitToUnreal(slot, plot, session.checkTarget, report)
                session.open(slot)
                pause(0.3)
                while true do
                    upgradeTo(slot, "Speed")
                    upgradeTo(slot, "MineSpeed")
                    local damage = session.readStat(slot, "Damage")
                    if damage.level >= target then break end
                    if damage.level >= damage.maximum then error("M1 Damage maximum is below the configured target; batch stopped.", 0) end

                    upgradeTo(slot, "Damage", damage.level + 1)
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
                if nextEntry.name == entry.name and nextEntry.count >= current.count then
                    return "Stopped: hotbar stack did not decrease after pickup. Completed " .. completed .. " units."
                end
            end
        end
        return string.format("Finished %d units: Speed/Mining max; Damage %d.", completed, target)
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
local CLICK_RANGE = 5
local TELEPORT_OFFSET = Vector3.new(0, 2, 2)
local enabled = false
local running = false
local closed = false
local ignoreUiUntil = 0
local miningConnections = {}
local function clearMiningConnections()
    for _, connection in ipairs(miningConnections) do connection:Disconnect() end
    table.clear(miningConnections)
end
local savedCamera
local savedCameraType
local savedCameraCFrame

local function restoreCamera()
    if savedCamera then
        savedCamera.CFrame = savedCameraCFrame
        savedCamera.CameraType = savedCameraType
        savedCamera = nil
        savedCameraType = nil
        savedCameraCFrame = nil
    end
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
    local selected, lowest = nil, math.huge
    for _, child in ipairs(nodes:GetChildren()) do
        local number = tonumber(child.Name:match("^Node(%d+)$"))
        if number and number < lowest and getTargetPart(child) then
            selected, lowest = child, number
        end
    end
    return selected
end

local function mine()
    if closed or running then return end
    clearMiningConnections()
    running = true
    local plot = nil
    local nodes = nil
    local target = nil
    local targetName = ""
    local targetRemoved = false
    local nextClick = 0

    local function targetGone()

        return target and (targetRemoved or nodes:FindFirstChild(targetName) ~= target
            or target.Parent ~= nodes or plot:FindFirstChild("Nodes") ~= nodes
            or not target:IsDescendantOf(workspace))
    end
    local function finish()
        setEnabled(false, "Done: " .. targetName .. " is gone")
        ignoreUiUntil = 0
        restoreCamera()
    end

    local ok, reason = pcall(function()
        local plots = path(workspace, {"MineWorld", "Plots"})
        while enabled and not closed do
            checkAlive()
            if targetGone() then finish(); break end

            if not target then
                if not plot or plot.Parent ~= plots then
                    for _, candidate in ipairs(plots:GetChildren()) do
                        if tonumber(candidate:GetAttribute("OwnerUserId")) == player.UserId then
                            plot = candidate
                            break
                        end
                    end
                end
                nodes = plot and plot:FindFirstChild("Nodes")
                target = nodes and chooseTarget(nodes)
                if target then
                    targetName = target.Name
                    local function markRemoved()
                        targetRemoved = true
                        if enabled and not closed then finish() end
                    end
                    miningConnections[#miningConnections + 1] = nodes.ChildRemoved:Connect(function(child)
                        if child == target then markRemoved() end
                    end)
                    miningConnections[#miningConnections + 1] = target.Destroying:Connect(markRemoved)
                    miningConnections[#miningConnections + 1] = target.AncestryChanged:Connect(function()
                        if target.Parent ~= nodes then markRemoved() end
                    end)
                end
                if targetGone() then finish(); break end
                setEnabled(true, target and "Mining: " .. targetName or "Waiting for a node...")
            end

            if target and os.clock() >= nextClick then
                local part = getTargetPart(target)
                local character = player.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                local camera = workspace.CurrentCamera
                if part and root and humanoid and humanoid.Health > 0 and camera then
                    assert(tonumber(plot:GetAttribute("OwnerUserId")) == player.UserId, "Plot ownership changed")
                    if (root.Position - part.Position).Magnitude > CLICK_RANGE then
                        root.CFrame = CFrame.lookAt(part.Position + TELEPORT_OFFSET, part.Position)
                        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
                    end
                    if camera ~= savedCamera then
                        restoreCamera()
                        savedCamera, savedCameraType, savedCameraCFrame = camera, camera.CameraType, camera.CFrame
                    end
                    camera.CameraType = Enum.CameraType.Scriptable
                    camera.CFrame = CFrame.lookAt(part.Position + Vector3.new(0, 6, 8), part.Position)
                    game:GetService("RunService").RenderStepped:Wait()

                    if targetGone() then finish(); break end
                    if enabled and not closed and player.Character == character
                        and root:IsDescendantOf(character) and humanoid.Health > 0
                        and part:IsDescendantOf(nodes)
                        and (root.Position - part.Position).Magnitude <= CLICK_RANGE then
                        local point, onScreen = camera:WorldToScreenPoint(part.Position)
                        if onScreen then
                            setEnabled(true, "Mining: " .. targetName)
                            ignoreUiUntil = os.clock() + 0.1

                            local detector = target:FindFirstChild("NodeClick", true)
                            assert(detector and detector:IsA("ClickDetector"), "Selected node has no NodeClick ClickDetector")
                            checkAlive()
                            VIM:SendMouseMoveEvent(point.X, point.Y, game)
                            VIM:SendMouseButtonEvent(point.X, point.Y, 0, true, game, 0)
                            VIM:SendMouseButtonEvent(point.X, point.Y, 0, false, game, 0)
                            nextClick = os.clock() + 0.15
                        end
                    end
                end
            end

            if targetGone() then finish(); break end
            task.wait()
        end
    end)
    clearMiningConnections()
    running = false
    restoreCamera()
    if not ok then
        setEnabled(false, "Mining failed: " .. tostring(reason))
        error(reason, 0)
    end
end

local ACTION_TIMEOUT = math.huge

local UI_TIMING = {
    BeforeOpen = 0.25,
    AfterOpen = 0.75,
    BeforeClose = 0.25,
    AfterClose = 0.75,
    AfterTab = 0.35,
    ChestMinimumHold = 2.0,
    ChestHoldPadding = 0.5,
}
local flowActive = false
local pendingConfirmation = false
local confirmed = false
local heldKey
local heldPrompt
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
local function waitFor(label, predicate, _timeout, retryAction)
    flowStatus.Text = label
    local reportRetry = newRetryMonitor("Tutorial: " .. label)
    local nextRetry = os.clock() + CONFIG.General.RetryInterval
    local problem
    while true do
        checkFlow()
        local value = predicate()
        if value then return value end
        if retryAction and os.clock() >= nextRetry then
            local ok, response = pcall(retryAction)
            checkFlow()
            problem = not ok and response or nil
            nextRetry = os.clock() + CONFIG.General.RetryInterval
        end
        reportRetry(problem)
        task.wait(0.05)
    end
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

    local halfHeight = (math.abs(cf.RightVector.Y) * size.X
        + math.abs(cf.UpVector.Y) * size.Y + math.abs(cf.LookVector.Y) * size.Z) / 2
    local destination = cf.Position + Vector3.new(0, halfHeight + 3.5, 0)
    local root = rootPart()
    root.CFrame = CFrame.new(destination) * cf.Rotation
    root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
    waitFor("Confirming teleport", function()
        return root == rootPart() and (root.Position - destination).Magnitude < 3
    end, nil, function()
        local currentRoot = rootPart()
        currentRoot.CFrame = CFrame.new(destination) * cf.Rotation
        currentRoot.AssemblyLinearVelocity, currentRoot.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        root = currentRoot
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

local function confirmResult(label, predicate)
    flowStatus.Text = label
    if predicate then return waitFor(label, predicate) end
    confirmed, pendingConfirmation = false, true
    confirmButton.Visible = true
    flowStatus.Text = label .. " — verify in game, then Confirm & continue (or Stop)."
    local reportRetry = newRetryMonitor("Tutorial: waiting for manual confirmation: " .. label)
    while not confirmed do checkFlow(); reportRetry(); task.wait(0.05) end
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
    assert(type(isfile) == "function" and type(readfile) == "function" and type(writefile) == "function",
        "Stage 0 needs isfile/readfile/writefile to save completion")
    local http = game:GetService("HttpService")

    local filename = "MineStageBrowser_Stage0_" .. tostring(player.UserId) .. ".json"
    local settingNames = {"CutsceneMythical", "CutsceneExotic", "CutsceneSummons", "CutsceneMutations", "NightMode"}
    local state = {version = 1, userId = player.UserId, done = false, sent = {}}
    if isfile(filename) then
        local ok, saved = pcall(function() return http:JSONDecode(readfile(filename)) end)
        assert(ok and type(saved) == "table" and saved.version == 1 and saved.userId == player.UserId
            and type(saved.done) == "boolean" and type(saved.sent) == "table",
            "Stage 0 save is unreadable or invalid: " .. filename .. "; no toggles were sent")
        state = saved
    end
    local allSent = true
    for _, name in ipairs(settingNames) do
        assert(state.sent[name] == nil or type(state.sent[name]) == "boolean", "Invalid Stage 0 saved setting: " .. name)
        if state.sent[name] ~= true then allSent = false end
    end
    local function save()
        local encoded = http:JSONEncode(state)
        writefile(filename, encoded)
        assert(readfile(filename) == encoded, "Stage 0 save verification failed: " .. filename)
    end
    assert(not state.done or allSent, "Stage 0 save has inconsistent completion data: " .. filename)
    if allSent then
        if not state.done then state.done = true; save() end
        flowStatus.Text = "Stage 0 already completed (saved); skipping"
        return
    end

    save()
    local event = waitFor("Stage 0: waiting for Remotes.GamestateEvent", function()
        return path(game:GetService("ReplicatedStorage"), {"Remotes", "GamestateEvent"})
    end)
    assert(event:IsA("RemoteEvent"), "GamestateEvent is not a RemoteEvent")
    for index, name in ipairs(settingNames) do
        checkFlow()
        if not state.sent[name] then
            flowStatus.Text = "Stage 0: requesting " .. name .. " (" .. index .. "/5)"
            event:FireServer("ToggleSetting", name)
            state.sent[name] = true
            save()
            pause(0.25)
        end
    end
    state.done = true
    save()
    flowStatus.Text = "Stage 0 completed and saved"
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
    local reportRetry = newRetryMonitor("Tutorial chest recovery")
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

                heldPrompt = prompt
                prompt:InputHoldBegin()
                pause(math.max(prompt.HoldDuration, UI_TIMING.ChestMinimumHold) + UI_TIMING.ChestHoldPadding)
                releaseInputs()
                waitFor("Confirming tutorial chest opened", function() return visible(ui("ChestFrame")) end, nil, function()
                    validatePlot(plot)
                    heldPrompt = prompt
                    prompt:InputHoldBegin()
                    pause(math.max(prompt.HoldDuration, UI_TIMING.ChestMinimumHold) + UI_TIMING.ChestHoldPadding)
                    releaseInputs()
                end)
            end
            pause(UI_TIMING.AfterOpen)
            if takeLoot and not lootRequested then
                validatePlot(plot)
                checkFlow()
                flowStatus.Text = "Taking tutorial chest contents..."
                getGameEvent():FireServer("MineTakeChest")
                lootRequested = true
                pause(CONFIG.Sell.ChestDelay)
            end
            if visible(ui("ChestFrame")) then
                local close = waitFor("Waiting for tutorial chest close button", tutorialChestCloseTarget)
                pause(UI_TIMING.BeforeClose)
                click(close)
                waitFor("Confirming tutorial chest closed", function() return not visible(ui("ChestFrame")) end, nil, function() click(close) end)
            end
            pause(UI_TIMING.AfterClose)
        end)
        checkFlow()
        if ok then return end
        releaseInputs()
        retryPrompt = true
        reportRetry(message)
        flowStatus.Text = "Chest error; retrying its proximity prompt: " .. tostring(message)
        consoleWarn("[MineStageBrowser] Tutorial chest retry:", message)
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
    assert(not occupied(), "M1 is already occupied; placement stopped to avoid picking it up")
    if visible(ui("SlotFocusFrame")) then
        pause(UI_TIMING.BeforeClose)
        closeUnitPanel("Tutorial: closing unit panel before placement", checkFlow)
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
    local attempt = 0
    local reportRetry = newRetryMonitor("Tutorial M1 placement")
    while true do
        checkFlow()
        attempt = attempt + 1
        if occupied() then
            assert(attempt > 1, "M1 became occupied before placement")
            waitFor("Confirming hotbar 1 supplied the placed unit", function() return consumed(source) end)
            return
        end
        local current = readFirstHotbarUnit()
        assert(current.name == source.name and current.count == source.count,
            "Hotbar slot 1 changed before placement")

        flowStatus.Text = "Selecting hotbar 1; placement attempt " .. attempt
        slot = ui("HotbarFrame", "Content", "Container", "1")
        selectHotbarUnit(slot)
        validatePlot(plot)
        local base = holder:FindFirstChild("Pad")
        if not base or not base:IsA("BasePart") then base = holder:FindFirstChild("UpgradePart") end
        assert(base and base:IsA("BasePart"), "M1 placement base is missing")
        root.CFrame = CFrame.new(base.Position + Vector3.new(0, 3, 0), base.Position)
        root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
        pause(0.35)
        waitFor("Waiting for tutorial M1 placement prompt", function()
            return occupied() or prompt().Enabled
        end, nil, function() selectHotbarUnit(slot) end)
        local currentPrompt = prompt()
        if not occupied() and currentPrompt.Enabled then
            current = readFirstHotbarUnit()
            assert(current.name == source.name and current.count == source.count,
                "Hotbar slot 1 changed while equipping")
            assert(not action():match("^unlock") and not action():match("^locked"), "M1 is locked")

            flowStatus.Text = "Activating M1 HolderPrompt"
            heldPrompt = currentPrompt
            currentPrompt:InputHoldBegin()
            pause(math.max(currentPrompt.HoldDuration, 0.05))
            releaseInputs()
            pause(0.6)
        end
        if occupied() then
            waitFor("Confirming hotbar 1 supplied the placed unit", function() return consumed(source) end)
            return
        end
        reportRetry("HolderPrompt.ActionText=" .. prompt().ActionText)
        pause(0.35)
    end
end
actions[1] = function()
    setEnabled(true)
    mine()
    checkFlow()
    assert(statusLabel.Text:match("^Done:"), "Mining stage ended without confirming a removed node")
end
local function teleportButtonTo(destination)
    local reportRetry = newRetryMonitor("Tutorial TeleportButton to " .. destination)
    while true do
        checkFlow()
        pause(UI_TIMING.BeforeClose)
        local root = rootPart()
        local before = root.Position
        local clicked, message = pcall(function() click(ui("TeleportButton")) end)
        checkFlow()
        local moved = false
        if clicked then
            -- Observe this click before choosing recovery; this never limits total retries.
            local settleUntil = os.clock() + math.max(CONFIG.General.StartupTeleportClickInterval, SETTLE_TIME)
            repeat
                checkFlow()
                if rootPart() == root and (root.Position - before).Magnitude > CONFIG.General.StartupTeleportMinDistance then
                    moved = true
                    break
                end
                pause(CONFIG.General.WaitPoll)
            until os.clock() >= settleUntil
        end
        if moved then break end
        reportRetry(clicked and "TeleportButton did not change your character position." or tostring(message))
        local recovered, recoveryMessage = pcall(recoverUnitPanelThroughChest, checkFlow, "Tutorial TeleportButton recovery")
        checkFlow()
        if not recovered then reportRetry("Chest recovery: " .. tostring(recoveryMessage)) end
        -- The next actual click gets a fresh baseline after chest recovery has finished.
        pause(CONFIG.General.WaitPoll)
    end
    pause(UI_TIMING.AfterClose)

    local anchor
    if destination == "Base" then anchor = path(ownedPlot(), {"Chest", "ChestBase"})
    else anchor = workspace:FindFirstChild("SellStand") end
    local target = anchor and getTargetPart(anchor)
    assert(target and (rootPart().Position - target.Position).Magnitude < 250,
        "TeleportButton did not reach " .. destination .. "; check starting location")
end
actions[4] = actions[1]
actions[5] = function()
    teleportButtonTo("Shops")
    local stand = waitFor("Waiting for SellStand", function() return workspace:FindFirstChild("SellStand") end)

    local prompt = promptUnder(stand)
    local anchor = prompt.Parent:IsA("Attachment") and prompt.Parent.Parent or prompt.Parent
    teleport(anchor)
    pause(UI_TIMING.BeforeOpen)
    pressE(prompt)
    waitFor("Confirming sell UI opened", function() return visible(ui("SellFrame")) end, nil, function() pressE(prompt) end)
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
    waitFor("Confirming unit UI opened", function() return visible(ui("SlotFocusFrame")) end, nil, function() fireclickdetector(detector) end)
    pause(UI_TIMING.AfterOpen)
    click(ui("SlotFocusFrame", "Tabs", "StatsTab"))
    waitFor("Confirming Stats opened", function()
        return visible(ui("SlotFocusFrame", "BottomPanels", "StatsPanel"))
    end, nil, function() click(ui("SlotFocusFrame", "Tabs", "StatsTab")) end)
    pause(UI_TIMING.AfterTab)
    local function level()
        local label = ui("SlotFocusFrame", "BottomPanels", "StatsPanel", "Scroll", "Damage", "LevelTitle")
        return label and tonumber(label.Text:gsub("<[^>]*>", ""):match("Level%s+(%d+)"))
    end
    local before = level()
    assert(before, "Cannot read Damage.LevelTitle; no upgrade sent")
    click(ui("SlotFocusFrame", "BottomPanels", "StatsPanel", "Scroll", "Damage", "UpgradeButton"))
    waitFor("Confirming Damage level increased", function() return level() and level() > before end, nil, function() click(ui("SlotFocusFrame", "BottomPanels", "StatsPanel", "Scroll", "Damage", "UpgradeButton")) end)
    pause(UI_TIMING.BeforeClose)
    closeUnitPanel("Tutorial: closing unit panel after upgrades", checkFlow)
    pause(UI_TIMING.AfterClose)
end
actions[7] = function()
    local function depositNode()
        return ui("SkillTreeFullFrame", "Tree", "Canvas", "Zone_Z1", "Node_Deposits1")
    end
    local function readPips()

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
        waitFor("Confirming skill tree closed", function() return not visible(ui("SkillTreeFullFrame")) end, nil, function() click(ui("SkillTreeFullFrame", "Footer", "Close")) end)
        pause(UI_TIMING.AfterClose)
    end
    local function refreshUpgradesThroughChest()
        useTutorialChest(false)
    end
    local needsChestRefresh = false

    local pendingPurchase
    local reportRetry = newRetryMonitor("Tutorial Stage 7 recovery")
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
                waitFor("Confirming skill tree opened", function() return visible(ui("SkillTreeFullFrame")) end, nil, function() click(ui("LeftBar", "Content", "Container", "UpgradesButton")) end)
                pause(UI_TIMING.AfterOpen)
            end
            local before = waitFor("Reading Z1 Node_Deposits1.Content.Pips", readPips)
            if before.current >= before.maximum or pendingPurchase
                and before.maximum == pendingPurchase.maximum and before.current > pendingPurchase.current then
                exitSkillTree()
                return true
            end
            if not pendingPurchase then

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
            end, nil, function()
                local current = readPips()
                if current and current.maximum == pendingPurchase.maximum and current.current == pendingPurchase.current then
                    getGameEvent():FireServer("MineBuySkill", "Z1", "NodeCount", "Deposits1")
                end
            end)
            exitSkillTree()
            return true
        end)
        checkFlow()
        if ok and result then return end
        reportRetry(not ok and result or "Waiting for Stage 7 to complete.")
        if not ok then
            releaseInputs()
            needsChestRefresh = true
            flowStatus.Text = "Stage 7 will retry: " .. tostring(result)
            consoleWarn("[MineStageBrowser] Stage 7 recovery:", result)
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
        restoreCamera()
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
        return "Tutorial stages 0–7 completed. Stage 0 settings are saved."
    end,
}
end

local function runPage(id)
    return id == "hotbarUpgrade" and modules.hotbarUpgrade.page or pages[id]
end
local function setControls(running)
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

    local masterRunning = running and activeRun == "master"
    pages.master.run.Active = not running or masterRunning
    pages.master.run.AutoButtonColor = not running or masterRunning
    pages.master.run.Text = masterRunning and "Master: ON - Click to turn OFF" or pages.master.runText
    if masterRunning then pages.master.run.BackgroundColor3 = Color3.fromRGB(165, 67, 79) end
    minimizedMaster.Active = pages.master.run.Active
    minimizedMaster.AutoButtonColor = pages.master.run.AutoButtonColor
    minimizedMaster.Text = masterRunning and "Master: ON" or (running and "Master: Busy" or "Master: OFF")
    minimizedMaster.BackgroundColor3 = pages.master.run.BackgroundColor3
    stop.Active, stop.AutoButtonColor = running, running
    stop.BackgroundColor3 = running and Color3.fromRGB(165, 67, 79) or colors.idle
    if modules.hotbarUpgrade then modules.hotbarUpgrade.setBusy(running) end
    if modules.pickaxe and modules.pickaxe.setBusy then modules.pickaxe.setBusy(running) end
    if modules.upgrades and modules.upgrades.setBusy then modules.upgrades.setBusy(running) end
end

local function resetRun()
    runScope.current = nil
    modules.masterMovement.stop()
    releaseInputs()
    if modules.pickaxe and modules.pickaxe.cleanupWaiting then pcall(modules.pickaxe.cleanupWaiting) end
    if modules.tutorial then modules.tutorial.cleanup() end
    if modules.mutation and modules.mutation.cleanup then pcall(modules.mutation.cleanup) end
    local unitUpgrade = rawget(modules, "upgradingUnit")
    if unitUpgrade and unitUpgrade.cleanup then pcall(unitUpgrade.cleanup) end
    restorePosition()
    busy, activeRun, activeStage = false, nil, nil
    cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone = nil, nil
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

local holdersFullyUnlocked = false
local function unlockCycleHolders(plot)
    if holdersFullyUnlocked then return end
    local holders = plot:FindFirstChild("Holders")
    if not holders then return end
    local complete, found = true, false
    for _, holder in ipairs(holders:GetChildren()) do
        if (tonumber(holder.Name:match("^M(%d+)$")) or 0) >= 1 then
            found = true
            local pad = holder:FindFirstChild("Pad")
            local prompt = pad and pad:FindFirstChild("HolderPrompt")
            if not prompt or not prompt:IsA("ProximityPrompt") then
                complete = false
            elseif (prompt.ActionText == "Unlock" or prompt.ActionText == "Unlock at the hub") then
                checkAlive()
                local upgrade = holder:FindFirstChild("UpgradePart")
                local character = player.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if root and upgrade and upgrade:IsA("BasePart") then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:UnequipTools() end
                    root.CFrame = CFrame.new(upgrade.Position + Vector3.new(0, CONFIG.Units.TeleportHeight, 0), upgrade.Position)
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                    pause(CONFIG.Units.TeleportDelay)
                    if prompt.Parent and prompt.Enabled and (prompt.ActionText == "Unlock" or prompt.ActionText == "Unlock at the hub") then
                        heldPrompt = prompt
                        prompt:InputHoldBegin()
                        pause(math.max(1, prompt.HoldDuration) + CONFIG.Units.RemovalHoldPadding)
                        releaseInputs()
                        pause(CONFIG.General.WaitPoll)
                    end
                end
                if not prompt.Parent or (prompt.ActionText == "Unlock" or prompt.ActionText == "Unlock at the hub") then complete = false end
            end
        end
    end
    holdersFullyUnlocked = found and complete
end

modules.cycleEnd = {run = function()
    checkAlive()
    checkPlot(getMyPlot())
    requestCycleBestEquip()
    modules.upgrades.selectZones()
    unlockCycleHolders(getMyPlot())
end}

local function runStage(id, cacheZoneOnly)
    checkAlive()
    activeStage = id
    local page = runPage(id)
    page.status.TextColor3 = colors.muted
    page.status.Text = "Preparing " .. page.name .. "..."
    footer.Text = "Running: " .. page.name
    if activeRun == "master" then
        stageRows[id].Text = page.name .. "  /  Running..."
        stageRows[id].TextColor3 = colors.accent
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
    page.status.Text = tostring(result or "Finished.")
    page.status.TextColor3 = colors.success
    if id == "hotbarUpgrade" or id == "tutorial" then logInfo(page.name, page.status.Text)
    else logStageResult(id, page.status.Text) end
    if activeRun == "master" then
        local enabled = preferences.stages[id]
        stageRows[id].Text = page.name .. (enabled and "  /  Done" or "  /  OFF")
        stageRows[id].TextColor3 = enabled and colors.success or colors.muted

        if id == "sell" then closeGamePanel("SellFrame") end
        if id ~= "cycleEnd" then pause(CONFIG.Flow.StageDelay) end
    end
    return result
end

startRun = function(id)
    if alive and not modules.gameReady.isReady() then
        if id == "master" then
            preferences.masterEnabled = not preferences.masterEnabled
            savePreferences()
            pages.master.run.Text = preferences.masterEnabled and "Master: ON - Waiting for game" or pages.master.runText
            minimizedMaster.Text = preferences.masterEnabled and "Master: Waiting" or "Master: OFF"
        end
        runPage(id).status.Text = "Waiting for offline collection and TeleportButton to change your character position."
        return
    end
    if not alive or busy or os.clock() - lastRun < CONFIG.General.ButtonDebounce then
        if alive and (id == "upgradingUnit" or id == "upgradingOldUnit" or id == "master") then
            logUnitUpgradeDetail(string.format("Start ignored for %s: busy=%s; active run=%s; active stage=%s; debounce remaining=%.2fs",
                id, tostring(busy), tostring(activeRun), tostring(activeStage),
                math.max(0, CONFIG.General.ButtonDebounce - (os.clock() - lastRun))))
        end
        return
    end
    if id == "tutorial" and (preferences.tutorialHidden or minimizedActions.openBusy) then return end

    if (id == "pickaxe" or (id == "master" and preferences.stages.pickaxe)) and not modules.pickaxe.prepare() then
        pages.master.status.Text = "Check the Pickaxe tab: its limit could not be saved."
        pages.master.status.TextColor3 = colors.error
        selectTab("pickaxe")
        return
    end
    if not alive or busy then return end
    local token = {id = id}
    runScope.current = token
    busy, activeRun, activeStage = true, id, nil
    cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone = nil, nil
    cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady, cycleBestEquipped = nil, nil, nil, false, false
    lastRun = os.clock()
    local page = runPage(id)
    page.status.TextColor3 = colors.muted
    if id == "hotbarUpgrade" or id == "tutorial" then minimizedActions.setRollEnabled(false) end
    if id == "master" then
        minimizedActions.setRollEnabled(false)
        preferences.masterEnabled = true
        resetStageRows()
    end
    if not actionIsCurrent(token) then return end
    setControls(true)
    if id == "master" or id == "hotbarUpgrade" then

        local movementOK, movementError = pcall(modules.masterMovement.start, token)
        if not movementOK then
            if id == "master" then preferences.masterEnabled = false end
            resetRun()
            page.status.Text = "Could not enable noclip/flight: " .. tostring(movementError)
            page.status.TextColor3 = colors.error
            footer.Text = "Stopped: noclip/flight could not start."
            logError(page.name, movementError)
            if id == "master" then savePreferences() end
            return
        end
    end
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
                    cycleUnitsPreparedZone, cycleUnitUpgradeReadyZone = nil, nil
                    cycleZoneId, cycleZoneName, cycleDensityLevel, cycleZoneReady, cycleBestEquipped = nil, nil, nil, false, false
                    resetStageRows()
                    local cycleOK, cycleError = pcall(function()
                        if cycle == 1 then modules.workspaceCleanup.onCycleStart(cycle) end
                        for _, stage in ipairs(order) do
                            -- Always visit Upgrades; OFF still opens the UI and scans fresh values.
                            if stage == "upgrades" then
                                runStage(stage, not preferences.stages.upgrades)
                            elseif stage ~= "cycleEnd" and preferences.stages[stage] then
                                runStage(stage)
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
                            stageRows[failed].Text = pages[failed].name .. "  /  Error - retry next cycle"
                            stageRows[failed].TextColor3 = colors.error
                        end

                        closeGamePanel("SellFrame")
                        closeGamePanel("SkillTreeFullFrame")
                        closeGamePanel("InventoryFrame")
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
                    if not equipOK then logError("Cycle Finish", equipError) end
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
                    stageRows[activeStage].Text = runPage(activeStage).name .. "  /  Error - flow stopped"
                    stageRows[activeStage].TextColor3 = colors.error
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

stopRun = function()
    if not alive or not busy then return end
    local stoppedRun, stoppedStage = activeRun, activeStage
    if stoppedRun == "master" then
        preferences.masterEnabled = false
    end
    runScope.current = nil
    modules.masterMovement.stop()
    logInfo(stoppedStage and runPage(stoppedStage).name or "Master", "Stopped by user.")
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
            stageRows[stoppedStage].Text = runPage(stoppedStage).name .. "  /  Stopped"
            stageRows[stoppedStage].TextColor3 = colors.muted
        end
    end
    footer.Text = "Stopped. Master OFF."
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

    local uiParent = gui.Parent
    local watched = setmetatable({}, {__mode = "k"})
    local function watch(other)
        if other == gui or not other:IsA("ScreenGui") or watched[other] then return end
        watched[other] = true
        local function bringToFront()
            if alive and gui.Parent == uiParent and other:IsDescendantOf(uiParent)
                and other.DisplayOrder >= gui.DisplayOrder then
                gui.Parent = nil
                gui.Parent = uiParent
            end
        end
        connect(other:GetPropertyChangedSignal("DisplayOrder"), bringToFront)
        bringToFront()
    end
    connect(uiParent.DescendantAdded, watch)
    for _, other in ipairs(uiParent:GetDescendants()) do watch(other) end
end
resize()
modules.workspaceCleanup.refresh()
if modules.gameReady.wait() then
    modules.plotCleanup.start()
    if preferences.masterEnabled and not busy then startRun("master") end
end
