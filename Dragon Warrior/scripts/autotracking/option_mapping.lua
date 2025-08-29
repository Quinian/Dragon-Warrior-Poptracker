
-- This file maps Archipelago option keys to internal tracker logic flags
-- Used for automatically enabling tracker logic based on seed options
-- Currently broken. Keep for future use

-- Example AP YAML options:
-- shopsanity: 50
-- searchsanity: 0
-- levelsanity: 50

return {
  ["shopsanity"]     = "shopsanity",
  ["ShopSanity"]     = "shopsanity",
  ["shop_sanity"]    = "shopsanity",

  ["searchsanity"]   = "searchsanity",
  ["SearchSanity"]   = "searchsanity",
  ["search_sanity"]  = "searchsanity",
 
  ["levelsanity"]    = "levelsanity",
  ["LevelSanity"]    = "levelsanity",
  ["level_sanity"]   = "levelsanity"
}


