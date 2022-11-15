-- P helper to inspec whats inside something
P = function(v)
    print(vim.inspect(v))
    return v
end


-- attempt to force-reload all lua modules
UNLOAD_PACKAGES = function()
    for key, _ in pairs(package.loaded) do
        package.loaded[key] = nil
    end
end

vim.keymap.set(
    "n",
    "<Leader><F4>",
    function()
        UNLOAD_PACKAGES()
        require('entry')
        print("reloaded all modules at " .. os.date('%X'))
    end
)
