local status, neoterm = pcall(require, "neoterm")
if not status then
	return
end

neoterm.setup()
