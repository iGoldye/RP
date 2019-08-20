Config                            = {}
Config.DrawDistance               = 100.0
--language currently available EN and SV
Config.Locale                     = 'en'

Config.Zones = {

  PoliceDuty = {
    Pos   = { x = 441.425, y = -1000.343, z = 29.85 },
    Size  = { x = 2.5, y = 2.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },  
    Type  = 27,
    Job   = "police",
  },

  AmbulanceDuty = {
    Pos = { x = 334.51, y = -585.13, z = 27.86 },
    Size = { x = 2.5, y = 2.5, z = 1.5 },
    Color = { r = 0, g = 255, b = 0 },
    Type = 27,
    Job  = "ambulance",
  },
}