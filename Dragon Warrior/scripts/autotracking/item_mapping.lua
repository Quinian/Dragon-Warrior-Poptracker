ITEM_MAPPING = {
    [0000] = {"no_weapon", "toggle"},
    [7100] = {"bamboo_pole", "toggle"},
    [7101] = {"club", "toggle"},
    [7102] = {"copper_sword", "toggle"},
    [7103] = {"hand_axe", "toggle"},
    [7104] = {"broad_sword", "toggle"},
    [7105] = {"flame_sword", "toggle"},
    [7106] = {"erdricks_sword", "toggle"},

    [0000] = {"no_armor", "toggle"},
    [7110] = {"clothes", "toggle"},
    [7111] = {"leather_armor", "toggle"},
    [7112] = {"chain_mail", "toggle"},
    [7113] = {"half_plate", "toggle"},
    [7114] = {"full_plate", "toggle"},
    [7115] = {"magic_armor", "toggle"},
    [7116] = {"erdricks_armor", "toggle"},

    [0000] = {"no_shield", "toggle"},
    [7120] = {"small_shield", "toggle"},
    [7121] = {"large_shield", "toggle"},
    [7122] = {"silver_shield", "toggle"},

    -- Progressive Upgrades
[3616] = {"weapon_chain", "progressive"},
[3588] = {"armor_chain", "progressive"},
[3585] = {"shield_chain", "progressive"},





    -- Key Items
    [5] = { "fairy_flute", "toggle" },
    [6] = { "erdricks_tablet", "toggle" },
    [7] = { "erdricks_token", "progressive" },
    [8] = { "gwaelins_love", "toggle" },
    [10] = { "silver_harp", "progressive" },
    [12] = { "stones_of_sunlight", "progressive" },
    [13] = { "staff_of_rain", "progressive" },
    [14] = { "rainbow_drop", "toggle" },
    [212] = { "magic_key", "toggle" },
    [74565] = { "ball_of_light", "toggle" },
 


    -- Shopsanity Location 
    -- These are not directly used right now, but exist for future support or override fallback
    ["Purchased: Bamboo Pole"] = {"bamboo_pole", "toggle"},
    ["Purchased: Club"] = {"club", "toggle"},
    ["Purchased: Copper Sword"] = {"copper_sword", "toggle"},
    ["Purchased: Hand Axe"] = {"hand_axe", "toggle"},
    ["Purchased: Broad Sword"] = {"broad_sword", "toggle"},
    ["Purchased: Flame Sword"] = {"flame_sword", "toggle"},

    ["Purchased: Clothes"] = {"clothes", "toggle"},
    ["Purchased: Leather Armor"] = {"leather_armor", "toggle"},
    ["Purchased: Chain Mail"] = {"chain_mail", "toggle"},
    ["Purchased: Half Plate"] = {"half_plate", "toggle"},
    ["Purchased: Full Plate"] = {"full_plate", "toggle"},
    ["Purchased: Magic Armor"] = {"magic_armor", "toggle"},

    ["Purchased: Small Shield"] = {"small_shield", "toggle"},
    ["Purchased: Large Shield"] = {"large_shield", "toggle"},
    ["Purchased: Silver Shield"] = {"silver_shield", "toggle"},


    -- Spam stoppers, mostly just to quiet the console
    [209] = {"gold", "consumable"},
    [210] = {"gold_high", "consumable"},
    [15] = {"medicinal_herb", "consumable"},


}


return ITEM_MAPPING