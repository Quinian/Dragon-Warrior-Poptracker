## TODO

- [ ] Add support for slot_data.options when DW starts sending it

## Known Issues

- Toggle buttons for options are manual due to AP limitations
- Items switching to completed/turn-in/checked don't auto toggle

## Notes for Future Devs

- The option toggle block is in `archipelago.lua` it jsut doesn't work yet
- There's a folder of unused or base assets for you
- The items ARE listed twice in the items/items.json on purpose. That's because both shopsanity and the equipment toggles use the same objects, so I duplicated and renamed them to prevent conflicts.
