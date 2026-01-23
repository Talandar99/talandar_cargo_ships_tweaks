-- ignore cargo ships powerpole settings to save some collision layers
local function force_setting(setting_type, setting_name, value)
	local setting = data.raw[setting_type .. "-setting"][setting_name]
	if setting then
		if setting_type == "bool" then
			setting.forced_value = value
		else
			setting.allowed_values = { value }
		end
		setting.default_value = value
		setting.hidden = true
	end
end
data.raw["double-setting"]["fuel_modifier"].hidden = true

force_setting("bool", "floating_pole_fulgora", true)
force_setting("bool", "floating_pole_aquilo", true)
force_setting("int", "oil_rig_capacity", 500)
force_setting("int", "tanker_capacity", 250)
force_setting("string", "oil_rigs_require_external_power", "only-when-moduled")
force_setting("bool", "offshore_oil_enabled", true)
