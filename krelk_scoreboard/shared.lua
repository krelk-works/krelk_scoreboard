Config = {}

Config.ColorHUD = { r = 153, g = 102, b = 255 } --> Default color is purple
Config.AutoHide = false
Config.HideSeconds = 5
Config.EnableAdminsOnline = true
Config.PoliceJobs = {
    "police",
    --"sheriff", --Example
}
Config.AmbulanceJobs = {
    "ambulance",
    --"doctor" --Example
}
Config.MechanicJobs = {
    "mechanic",
    --"mechanic2" --Example
}
Config.TaxiJob = "taxi"
Config.TaxiJobs = {
    "taxi",
    --"uber", --Example
}
Config.ScoreBoardKey = "F9"
Config.ShowServerName = true
Config.ServerName = "Server Name Here"
Config.ServerNameColor = "white" --> CSS colors -> rgb, hex, name.

-- AntiSpam Config
Config.AntiSpamEvent = true --> [ IMPROVE PERFORMANCE FOR BIG SERVERS ] | May cause more than 0.4ms on server side without AntiSpamEvent
Config.TimeoutEvent = 30 --> Seconds to prevent spam event (getOnlinePlayers) / Seconds to refresh client cache of players online