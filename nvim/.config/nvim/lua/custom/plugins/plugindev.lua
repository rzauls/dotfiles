-- helper functions for lua and lua plugin development

---Print a human-readable representation of v and return it afterwards
P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

---Re-require a lua module
R = function(name)
	RELOAD(name)
	return require(name)
end

return {}
