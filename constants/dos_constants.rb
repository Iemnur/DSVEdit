
GAME = "dos"
LONG_GAME_NAME = "Dawn of Sorrow"

AREA_LIST_RAM_START_OFFSET = 0x02006FC4 # Technically not a list, this points to code that has the the area hard coded, since DoS only has one area.

EXTRACT_EXTRA_ROOM_INFO = Proc.new do |last_4_bytes_of_room_metadata|
  number_of_doors    = (last_4_bytes_of_room_metadata & 0b00000000_00000000_11111111_11111111)
  room_xpos_on_map   = (last_4_bytes_of_room_metadata & 0b00000000_00111111_00000000_00000000) >> 16
  room_ypos_on_map   = (last_4_bytes_of_room_metadata & 0b00011111_10000000_00000000_00000000) >> 23
 #unknown_1          = (last_4_bytes_of_room_metadata & 0b00100000_00000000_00000000_00000000) >> 29
  palette_page_index = 0 # always 0 in dos, and so not stored in these 4 bytes
  [number_of_doors, room_xpos_on_map, room_ypos_on_map, palette_page_index]
end

# Overlays 6 to 22.
AREA_INDEX_TO_OVERLAY_INDEX = {
   0 => {
     0 => 14, # lost village
     1 => 11, # demon guest house
     2 =>  6, # wizardry lab
     3 => 16, # garden of madness
     4 =>  8, # dark chapel
     5 =>  7, # condemned tower and mine of judgement
     6 => 17, # subterranean hell
     7 => 15, # silenced ruins
     8 =>  9, # clock tower
     9 => 10, # the pinnacle
    10 => 12, # menace's room
    11 => 13, # the abyss
    12 => 18, # prologue area (in town)
    13 => 19, # epilogue area (overlooking castle)
    14 => 20, # boss rush
    15 => 21, # enemy set mode
    16 => 22, # final room of julius mode where you fight soma
   }
}

AREA_INDEX_TO_AREA_NAME = {
   0 => "Dracula's Castle"
}

SECTOR_INDEX_TO_SECTOR_NAME = {
   0 => {
     0 => "The Lost Village",
     1 => "Demon Guest House",
     2 => "Wizardry Lab",
     3 => "Garden of Madness",
     4 => "The Dark Chapel",
     5 => "Condemned Tower & Mine of Judgment",
     6 => "Subterranean Hell",
     7 => "Silenced Ruins",
     8 => "Cursed Clock Tower",
     9 => "The Pinnacle",
    10 => "Menace",
    11 => "The Abyss",
    12 => "Prologue",
    13 => "Epilogue",
    14 => "Boss Rush",
    15 => "Enemy Set Mode",
    16 => "Throne Room",
  }
}

CONSTANT_OVERLAYS = [0, 1, 2, 3, 4, 5]

INVALID_ROOMS = []

MAP_TILE_METADATA_LIST_START_OFFSET = nil
MAP_TILE_METADATA_START_OFFSET = 0x0207708C
MAP_TILE_LINE_DATA_LIST_START_OFFSET = nil
MAP_TILE_LINE_DATA_START_OFFSET = 0x02076AAC
MAP_LENGTH_DATA_START_OFFSET = nil
MAP_NUMBER_OF_TILES = 3008
MAP_SECRET_DOOR_LIST_START_OFFSET = nil
MAP_SECRET_DOOR_DATA_START_OFFSET = 0x02076408
ABYSS_MAP_TILE_METADATA_START_OFFSET = 0x020788F4
ABYSS_MAP_TILE_LINE_DATA_START_OFFSET = 0x02078810
ABYSS_MAP_NUMBER_OF_TILES = 448
ABYSS_MAP_SECRET_DOOR_DATA_START_OFFSET = 0x0207880C

MAP_FILL_COLOR = [160, 120, 88, 255]
MAP_SAVE_FILL_COLOR = [248, 0, 0, 255]
MAP_WARP_FILL_COLOR = [0, 0, 248, 255]
MAP_SECRET_FILL_COLOR = [0, 128, 0, 255]
MAP_ENTRANCE_FILL_COLOR = [0, 0, 0, 0] # Area entrances don't exist in DoS.
MAP_LINE_COLOR = [248, 248, 248, 255]
MAP_DOOR_COLOR = [16, 216, 32, 255]
MAP_DOOR_CENTER_PIXEL_COLOR = MAP_DOOR_COLOR
MAP_SECRET_DOOR_COLOR = [248, 248, 0, 255]

RAM_START_FOR_ROOM_OVERLAYS = 0x022DA4A0
RAM_END_FOR_ROOM_OVERLAYS = 0x022DA4A0 + 152864
LIST_OF_FILE_RAM_LOCATIONS_START_OFFSET = 0x0208CC6C
LIST_OF_FILE_RAM_LOCATIONS_END_OFFSET = 0x0209A0C3
LIST_OF_FILE_RAM_LOCATIONS_ENTRY_LENGTH = 0x28

COLOR_OFFSETS_PER_256_PALETTE_INDEX = 16

ENEMY_DNA_RAM_START_OFFSET = 0x02078CAC
ENEMY_DNA_LENGTH = 36
ENEMY_DNA_FORMAT = [
  [4, "Init AI"],
  [4, "Running AI"],
  [2, "Item 1"],
  [2, "Item 2"],
  [1, "Unknown 1"],
  [1, "Unknown 2"],
  [2, "HP"],
  [2, "MP"],
  [2, "EXP"],
  [1, "Soul Chance"],
  [1, "Attack"],
  [1, "Defense"],
  [1, "Item Chance"],
  [2, "Unknown 3"],
  [1, "Soul"],
  [1, "Unknown 4"],
  [2, "Weaknesses", :bitfield],
  [2, "Unknown 5"],
  [2, "Resistances", :bitfield],
  [2, "Unknown 6"],
]
ENEMY_DNA_BITFIELD_ATTRIBUTES = {
  "Weaknesses" => [
    "Clubs",
    "Spears",
    "Swords",
    "Fire",
    "Water",
    "Lightning",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Earth",
    "Weakness 12",
    "Weakness 13",
    "Weakness 14",
    "Weakness 15",
    "Made of flesh",
  ],
  "Resistances" => [
    "Clubs",
    "Spears",
    "Swords",
    "Fire",
    "Water",
    "Lightning",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Earth",
    "Resistance 12",
    "Time Stop",
    "Resistance 14",
    "Backstab",
    "Resistance 16",
  ],
}

# Overlays 23 to 40 used for enemies.
OVERLAY_FILE_FOR_ENEMY_AI = {
  # Enemies not listed here use one of the constant overlays like 0.
   14 => 28, # golem
   18 => 27, # manticore
   25 => 32, # catoblepas
   34 => 28, # treant
   37 => 24, # great armor
   47 => 31, # devil
   77 => 32, # gorgon
   81 => 27, # musshusu
   91 => 31, # flame demon
   93 => 31, # arc demon
   97 => 24, # final guard
  100 => 28, # iron golem
  101 => 30, # flying armor
  102 => 23, # balore
  103 => 29, # malphas
  104 => 40, # dmitrii
  105 => 25, # dario
  106 => 25, # puppet master
  107 => 26, # rahab
  108 => 36, # gergoth
  109 => 33, # zephyr
  110 => 37, # bat company
  111 => 35, # paranoia
  113 => 34, # death
  114 => 39, # abaddon
  115 => 38, # menace
}

REUSED_ENEMY_INFO = {
  # Enemies that had parts of them reused from another enemy.
  # init_code: The init code of the original enemy. This is where to look for gfx/palette/sprite data, not the reused enemy's init code.
  # gfx_sheet_ptr_index: The reused enemy uses a different gfx sheet than the original enemy. This value is which one to use.
  # palette_offset: The reused enemy uses different palettes than the original, but they're still in the same list of palettes. This is the offset of the new palette in the list.
  # palette_list_ptr_index: The reused enemy uses a completely different palette list from the original. This value is which one to use.
  26 => {init_code: 0x0223266C, gfx_sheet_ptr_index: 0, palette_offset: 2, palette_list_ptr_index: 0}, # ghoul and zombie
  77 => {init_code:        nil, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 1}, # gorgon and catoblepas
  84 => {init_code: 0x02270704, gfx_sheet_ptr_index: 0, palette_offset: 1, palette_list_ptr_index: 0, sprite_ptr_index: 1}, # erinys and valkyrie
  92 => {init_code: 0x02288FBC, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # tanjelly and slime
  91 => {init_code: 0x022FF9F0, gfx_sheet_ptr_index: 1, palette_offset: 0, palette_list_ptr_index: 1, sprite_ptr_index: 1}, # flame demon and devil
  93 => {init_code:        nil, gfx_sheet_ptr_index: 2, palette_offset: 0, palette_list_ptr_index: 2, sprite_ptr_index: 2}, # arc demon and devil
}

BEST_SPRITE_FRAME_FOR_ENEMY = {
  # Enemies not listed here default to frame 0.
    0 =>   8, # zombie
    5 =>  38, # peeping eye
    9 =>  17, # spin devil
   14 =>  19, # golem
   16 =>   7, # une
   18 =>  78, # manticore
   21 =>  14, # mandragora
   23 =>  13, # skeleton farmer
   25 =>  36, # catoblepas
   26 =>   8, # ghoul
   27 =>  17, # corpseweed
   34 =>  15, # treant
   35 =>  17, # amalaric sniper
   37 =>  20, # great armor
   38 =>  27, # killer doll
   41 =>   5, # witch
   43 =>   8, # lilith
   44 =>   3, # killer clown
   46 =>   6, # fleaman
   48 =>  37, # guillotiner
   49 =>  17, # draghignazzo
   54 =>  27, # wakwak tree
   60 =>  10, # larva
   61 =>   4, # heart eater
   64 =>   2, # medusa head
   67 =>   1, # mimic
   74 =>  39, # bugbear
   76 =>  42, # bone ark
   77 =>  36, # gorgon
   78 =>  10, # alura une
   79 =>   6, # great axe armor
   83 =>   5, # dead warrior
   85 =>   9, # succubus
   86 =>  16, # ripper
   92 =>  11, # tanjelly
   97 =>  20, # final guard
   98 =>  31, # malacoda
   99 =>   1, # alastor
  100 =>  15, # iron golem
  101 =>   6, # flying armor
  102 =>   5, # balore
  107 => 113, # rahab
  108 =>  16, # gergoth
  110 =>   5, # bat company
  111 =>  23, # paranoia
  113 =>  22, # death
  115 =>  31, # menace
  116 =>  22, # soma
}

ENEMY_FILES_TO_LOAD_LIST = 0x0208CA90
OVERLAY_FILES_WITH_SPRITE_DATA = [2]

SPECIAL_OBJECT_IDS = (0..0x75)
SPECIAL_OBJECT_CREATE_CODE_LIST = 0x0222C714
SPECIAL_OBJECT_UPDATE_CODE_LIST = 0x0222C8F0
OVERLAY_FILE_FOR_SPECIAL_OBJECT = {}
REUSED_SPECIAL_OBJECT_INFO = {
  0x01 => {init_code: 0x0222BAAC, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # destructible
  0x09 => {init_code: 0x0222BD04, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # chair
  0x26 => {init_code: 0x021A8FC8, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # slot machine
  0x27 => {init_code: 0x021A8434, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # condemned tower gate
  0x29 => {init_code: 0x021A7FC4, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # dark chapel gate
  0x47 => {init_code: 0x0222CC10, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # hammer shopkeeper
  0x48 => {init_code: 0x0222CC00, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # yoko shopkeeper
  0x4F => {init_code: 0x0222CBE0, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # mina event actor
  0x50 => {init_code: 0x0222CC10, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # hammer event actor
  0x51 => {init_code: 0x0222CBF0, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # arikado event actor
  0x52 => {init_code: 0x0222CC20, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # julius event actor
  0x53 => {init_code: 0x0222CC30, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # celia event actor
  0x54 => {init_code: 0x0222CC40, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # dario event actor
  0x55 => {init_code: 0x0222CC50, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # dmitrii event actor
  0x5B => {init_code: 0x0222CC60, gfx_sheet_ptr_index: 0, palette_offset: 0, palette_list_ptr_index: 0}, # alucard event actor
}
BEST_SPRITE_FRAME_FOR_SPECIAL_OBJECT = {
  0x3A => 0x08,
}
SPECIAL_OBJECT_FILES_TO_LOAD_LIST = 0x0209B88C

OTHER_SPRITES = [
  {pointer: 0x0222E474, desc: "Soma player"},
  {pointer: 0x0222E4CC, desc: "Julius player"},
  {pointer: 0x0222E524, desc: "Yoko player"},
  {pointer: 0x0222E57C, desc: "Alucard player"},
  
  {pointer: 0x0222BAAC, desc: "Destructibles 0"},
  {pointer: 0x0222BAB8, desc: "Destructibles 1"},
  {pointer: 0x0222BAC4, desc: "Destructibles 2"},
  {pointer: 0x0222BAD0, desc: "Destructibles 3"},
  {pointer: 0x0222BADC, desc: "Destructibles 4"},
  {pointer: 0x0222BAE8, desc: "Destructibles 5"},
  {pointer: 0x0222BAF4, desc: "Destructibles 6"},
  {pointer: 0x0222BB00, desc: "Destructibles 7"},
  {pointer: 0x0222BB0C, desc: "Destructibles 8"},
  {pointer: 0x0222BD04, desc: "Chair 1"},
  {pointer: 0x0222BD10, desc: "Chair 2"},
  {pointer: 0x0222BD1C, desc: "Chair 3"},
  {pointer: 0x0222BD28, desc: "Chair 4"},
  
  {pointer: 0x0203D4A0, desc: "Nintendo splash screen"},
  {pointer: 0x0203D564, desc: "Konami splash screen"},
  {pointer: 0x0203D8A8, desc: "Main menu"},
  {pointer: 0x0203DAB0, desc: "Castlevania logo"},
  {pointer: 0x0203ED3C, desc: "Credits"},
  {pointer: 0x0203ED58, desc: "Characters used during credits"},
  {pointer: 0x0203ED70, desc: "BGs used during credits"},
  {pointer: 0x0203F410, desc: "Game over screen"},
  {pointer: 0x02046714, desc: "Name signing screen"},
  {pointer: 0x02046ACC, desc: "File select menu"},
  {pointer: 0x020489A4, desc: "Choose course - unused?"},
  {pointer: 0x02049078, desc: "Enemy set mode menu"},
  {pointer: 0x0204908C, desc: "Enemy set retry/complete"},
  {pointer: 0x020490A0, desc: "Wi-fi menu"},
  
  {pointer: 0x02304B98, desc: "Iron maiden", overlay: 25},
]

TEXT_LIST_START_OFFSET = 0x0222F300
TEXT_RANGE = (0..0x50A)
TEXT_REGIONS = {
  "Character Names" => (0..0xB),
  "Item Names" => (0xC..0xD9),
  "Item Descriptions" => (0xDA..0x1A7),
  "Enemy Names" => (0x1A8..0x21D),
  "Enemy Descriptions" => (0x21E..0x293),
  "Soul Names" => (0x294..0x30E),
  "Soul Descriptions" => (0x30F..0x389),
  "Area Names" => (0x38A..0x395),
  "Music Names" => (0x396..0x3B2),
  "Misc" => (0x3B3..0x3D8),
  "Menus" => (0x3D9..0x477),
  "Library" => (0x478..0x4A5),
  "Events" => (0x4A6..0x50A)
}
TEXT_REGIONS_OVERLAYS = {
  "Character Names" => 0,
  "Item Names" => 0,
  "Item Descriptions" => 0,
  "Enemy Names" => 0,
  "Enemy Descriptions" => 0,
  "Soul Names" => 0,
  "Soul Descriptions" => 0,
  "Area Names" => 0,
  "Music Names" => 0,
  "Misc" => 0,
  "Menus" => 0,
  "Library" => 0,
  "Events" => 0
}
STRING_DATABASE_START_OFFSET = 0x02217E14
STRING_DATABASE_ORIGINAL_END_OFFSET = 0x0222B8CA
STRING_DATABASE_ALLOWABLE_END_OFFSET = STRING_DATABASE_ORIGINAL_END_OFFSET

NAMES_FOR_UNNAMED_SKILLS = {
  0x2E => "Bat Form",
  0x2F => "Holy Flame",
  0x30 => "Blue Splash",
  0x31 => "Holy Lightning",
  0x32 => "Cross",
  0x33 => "Holy Water",
  0x34 => "Grand Cross",
}

ENEMY_IDS = (0x00..0x75)
COMMON_ENEMY_IDS = (0x00..0x64).to_a
BOSS_IDS = (0x65..0x75).to_a
FINAL_BOSS_IDS = (0x73..0x75).to_a
RANDOMIZABLE_BOSS_IDS = BOSS_IDS - FINAL_BOSS_IDS

BOSS_DOOR_SUBTYPE = 0x25
BOSS_ID_TO_BOSS_DOOR_VAR_B = {
  0x65 => 0x01,
  0x66 => 0x02,
  0x67 => 0x04,
  0x68 => 0x03,
  0x69 => 0x05,
  0x6A => 0x06,
  0x6B => 0x08,
  0x6C => 0x07,
  0x6D => 0x09,
  0x6E => 0x0A,
  0x6F => 0x0C,
  0x70 => 0x0B,
  0x71 => 0x0D,
  0x72 => 0x0F,
}

ITEM_LOCAL_ID_RANGES = {
  0x02 => (0x00..0x41), # consumable
  0x03 => (0x01..0x4E), # weapon
  0x04 => (0x00..0x3C), # body armor
}
ITEM_GLOBAL_ID_RANGE = (1..0xCE)
SOUL_GLOBAL_ID_RANGE = (0..0x7A)

PICKUP_SUBTYPES_FOR_ITEMS = (0x02..0x04)
PICKUP_SUBTYPES_FOR_SKILLS = (0x05..0x05)

NEW_GAME_STARTING_AREA_INDEX_OFFSET = nil
NEW_GAME_STARTING_SECTOR_INDEX_OFFSET = 0x0202FB84
NEW_GAME_STARTING_ROOM_INDEX_OFFSET = 0x0202FB90

TRANSITION_ROOM_LIST_POINTER = 0x0208AD8C
FAKE_TRANSITION_ROOMS = []

ITEM_ICONS_PALETTE_POINTER = 0x022C4684
EXTRACT_ICON_INDEX_AND_PALETTE_INDEX = Proc.new do |icon_data|
  icon_index    = (icon_data & 0b00000000_11111111)
  palette_index = (icon_data & 0b11111111_00000000) >> 8
  [icon_index, palette_index]
end
PACK_ICON_INDEX_AND_PALETTE_INDEX = Proc.new do |icon_index, palette_index|
  icon_data  = icon_index
  icon_data |= palette_index << 8
  icon_data
end

ITEM_TYPES = [
  {
    name: "Consumables",
    list_pointer: 0x0209BA68,
    count: 66,
    format: [
      [2, "Item ID"],
      [2, "Icon"],
      [4, "Price"],
      [1, "Type"],
      [1, "Unknown 1"],
      [2, "Var A"],
      [4, "Unused"],
    ]
  },
  {
    name: "Weapons",
    list_pointer: 0x0209C34C,
    count: 79,
    format: [
      [2, "Item ID"],
      [2, "Icon"],
      [4, "Price"],
      [1, "Swing Anim"],
      [1, "Unknown 1"],
      [1, "Attack"],
      [1, "Defense"],
      [1, "Strength"],
      [1, "Constitution"],
      [1, "Intelligence"],
      [1, "Luck"],
      [2, "Effects", :bitfield],
      [1, "Unknown 2"],
      [1, "Unknown 3"],
      [1, "Sprite"],
      [1, "Super Anim"],
      [2, "Unknown 4"],
      [2, "Swing Modifiers", :bitfield],
      [2, "Swing Sound"],
    ]
  },
  {
    name: "Body Armor",
    list_pointer: 0x0209BE88,
    count: 61,
    format: [
      [2, "Item ID"],
      [2, "Icon"],
      [4, "Price"],
      [1, "Type"],
      [1, "Unknown 1"],
      [1, "Attack"],
      [1, "Defense"],
      [1, "Strength"],
      [1, "Constitution"],
      [1, "Intelligence"],
      [1, "Luck"],
      [2, "Resistances", :bitfield],
      [1, "Unknown 2"],
      [1, "Unknown 3"],
    ]
  },
]

ITEM_BITFIELD_ATTRIBUTES = {
  "Resistances" => [
    "Clubs",
    "Spears",
    "Swords",
    "Fire",
    "Water",
    "Lightning",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Earth",
    "Resistance 12",
    "Resistance 13",
    "Resistance 14",
    "Resistance 15",
    "Resistance 16",
  ],
  "Effects" => [
    "Clubs",
    "Spears",
    "Swords",
    "Fire",
    "Water",
    "Lightning",
    "Dark",
    "Holy",
    "Poison",
    "Curse",
    "Earth",
    "Effect 12",
    "Effect 13",
    "Effect 14",
    "Effect 15",
    "Effect 16",
  ],
  "Swing Modifiers" => [
    "No interrupt on land",
    "Weapon floats in place",
    "Modifier 3",
    "Player can move",
    "Modifier 5",
    "Modifier 6",
    "Transparent weapon",
    "Shaky weapon",
    "No interrupt on anim end",
    "Modifier 10",
    "Modifier 11",
    "Modifier 12",
    "Modifier 13",
    "Modifier 14",
    "Modifier 15",
    "Modifier 16",
  ],
}
