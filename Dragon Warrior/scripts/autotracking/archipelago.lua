
-- This is a bit jank at the moment.. I was having issues getting half of it to work

local ITEM_MAPPING = require "autotracking.item_mapping"
local LOCATION_MAPPING = require "autotracking.location_mapping"
local OPTION_MAPPING = require "autotracking.option_mapping"

CUR_INDEX = -1
AP_INDEX = -1
SAVED_SLOT_DATA = {}


-- Equipment dock display logic
local EQUIPMENT_UPGRADES = {
    ["Progressive Weapon Upgrade"] = "equipment_weapon",
    ["Progressive Armor Upgrade"] = "equipment_armor",
    ["Progressive Shield Upgrade"] = "equipment_shield"
}

local SHOP_LOCATIONS_TO_IMAGES = {
    ["Purchased: Bamboo Pole"] = "bamboo_pole",
    ["Purchased: Club"] = "club",
    ["Purchased: Copper Sword"] = "copper_sword",
    ["Purchased: Hand Axe"] = "hand_axe",
    ["Purchased: Broad Sword"] = "broad_sword",
    ["Purchased: Flame Sword"] = "flame_sword",
    ["Purchased: Clothes"] = "clothes",
    ["Purchased: Leather Armor"] = "leather_armor",
    ["Purchased: Chain Mail"] = "chain_mail",
    ["Purchased: Half Plate"] = "half_plate",
    ["Purchased: Full Plate"] = "full_plate",
    ["Purchased: Magic Armor"] = "magic_armor",
    ["Purchased: Small Shield"] = "small_shield",
    ["Purchased: Large Shield"] = "large_shield",
    ["Purchased: Silver Shield"] = "silver_shield"
}

function ClearItem(code, type)
    local item = Tracker:FindObjectForCode(code)
    if not item then return end
    if type == "toggle" then
        item.Active = false
    elseif type == "consumable" then
        item.AcquiredCount = 0
    elseif type == "progressive" then
        item.CurrentStage = 0
        item.Active = false
    end
end

function ClearItems(slot_data)
    AP_INDEX = -1
    CUR_INDEX = -1

    for _, v in pairs(ITEM_MAPPING) do
        ClearItem(v[1], v[2])
    end

    -- Also clear dock display items directly
    local dock_codes = {
        "equipment_weapon", "equipment_armor", "equipment_shield"
    }
    for _, code in ipairs(dock_codes) do
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            obj.CurrentStage = 0
            obj.Active = true
        end
    end

    -- Option toggles using SAVED_SLOT_DATA (flat keys)
    local opts = SAVED_SLOT_DATA or {}
    local mapping = require("scripts/autotracking/option_mapping")
    for key, mapped in pairs(mapping) do
        local isEnabled = opts[key] == 1 or opts[key] == 50 or opts[key] == true
        if type(mapped) == "table" then
            for _, code in ipairs(mapped) do
                local obj = Tracker:FindObjectForCode(code)
                if obj and obj.Type == "toggle" then obj.Active = isEnabled end
            end
        else
            local obj = Tracker:FindObjectForCode(mapped)
            if obj and obj.Type == "toggle" then obj.Active = isEnabled end
        end
    end
end



function SetItem(code, type)
    local item = Tracker:FindObjectForCode(code)
    if not item then return end

    if type == "toggle" then
        item.Active = true
    elseif type == "progressive" then
        item.CurrentStage = (item.CurrentStage or 0) + 1
        item.Active = true
    elseif type == "consumable" then
        item.AcquiredCount = (item.AcquiredCount or 0) + 1
    end
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then return end
    if player_number ~= Archipelago.PlayerNumber then return end
    CUR_INDEX = index

    local mapped = ITEM_MAPPING[item_id]
    if mapped then
        local code, mode = mapped[1], mapped[2]
        SetItem(code, mode)
    end

    local alt_code = EQUIPMENT_UPGRADES[item_name]
    if alt_code then
        local dock_item = Tracker:FindObjectForCode(alt_code)
        if dock_item then
            dock_item.CurrentStage = (dock_item.CurrentStage or 0) + 1
            dock_item.Active = true
        end
    end
end

function onLocationHandler(index, location_id)
    if index < 0 then return end

    local location_path = LOCATION_MAPPING[tonumber(location_id)]
    if not location_path and type(location_id) == "string" then
        for _, v in pairs(LOCATION_MAPPING) do
            local clean_name = v:match("([^/]+)$")
            if clean_name == location_id then
                location_path = v
                break
            end
        end
    end

    if not location_path then return end


-- Harp turn-in logic: flip image when staff location is completed
if location_id == 7260 or tonumber(location_id) == 7260 then
    local harp = Tracker:FindObjectForCode("silver_harp")
    if harp and harp.CurrentStage ~= 2 then
        harp.CurrentStage = 2
        harp.Active = true
    end
end









    local obj = Tracker:FindObjectForCode(location_path)
    if obj then
        obj.AvailableChestCount = 0

        local loc_name = location_path:match(".-/Shopsanity/(Purchased: .+)$")
        if loc_name then
            local image_code = SHOP_LOCATIONS_TO_IMAGES[loc_name]
            if image_code then
                local dock_item = Tracker:FindObjectForCode(image_code)
                if dock_item and not dock_item.Active then
                    dock_item.Active = true
                end
            end
        end

        local parent = obj.Parent
        if parent then
            parent:UpdateVisibility()
        end
    end
end

function reset_all_locations()
    for _, v in pairs(LOCATION_MAPPING) do
        local code = (type(v) == "table") and v[1] or v
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            if code:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.ChestCount
            else
                obj.Active = false
            end
        end
    end
end

function onClearHandler(slot_data)
    SAVED_SLOT_DATA = slot_data or {}
    ClearItems(SAVED_SLOT_DATA)
    reset_all_locations()
end




function UpdateReceivedItems()
    if not Archipelago or not Archipelago.ReceivedItems then return end

    for _, item in pairs(Archipelago.ReceivedItems) do
        local index = item.index
        if index <= AP_INDEX then goto continue end
        if item.player ~= Archipelago.PlayerNumber then goto continue end

        AP_INDEX = index

        local id = item.item
        local mapping = ITEM_MAPPING[id]
        if mapping then
            local code, type = mapping[1], mapping[2]
            SetItem(code, type)
        end

        ::continue::
    end
end

function UpdateCheckedLocations()
    if not Archipelago or not Archipelago.CheckedLocations then return end

    for _, id in pairs(Archipelago.CheckedLocations) do
        local code = LOCATION_MAPPING[id]
        if code then
            local obj = Tracker:FindObjectForCode(code)
            if obj then
                obj.AvailableChestCount = 0
            end
        end
    end
end

function ResetItems()
    ClearItems(Archipelago.SlotData or {})
    UpdateReceivedItems()
    UpdateCheckedLocations()
end

Archipelago:AddItemHandler("itemHandler", onItem)
Archipelago:AddLocationHandler("locationHandler", onLocationHandler)
Archipelago:AddClearHandler("clearHandler", onClearHandler)
