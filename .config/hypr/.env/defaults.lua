hl.monitor({
	output = "HDMI-A-2",
	mode = "1600x900@60",
	position = "auto-right",
	scale = "1",
})

hl.monitor({
	output = "HEADLESS-2",
	mode = "1600x900@60",
	position = "0x0",
	scale = "1",
})

hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-2", default = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-2" })

hl.workspace_rule({ workspace = "0", monitor = "HEADLESS-2", default = true })
