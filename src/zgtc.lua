-- SPDX-License-Identifier: GPL-3.0-or-later
--
-- zgtc.lua -- helper functions
-- Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>

local zgtc = { }

function zgtc.lines(path)
	local path = kpse.find_file(path)

	local lines = 0
	for line in io.lines(path) do
		if line:match('.*SPDX%-License%-Identifier:.*') then
			lines = lines - 1
			break
		end
		lines = lines + 1
	end

	return lines
end

return zgtc
