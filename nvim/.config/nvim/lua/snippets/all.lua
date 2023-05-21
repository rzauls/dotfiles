local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")


local function get_date()
    return os.date("%d/%m/%Y")
end

-- TODO(09/12/2022): Write something you should do in the future here
-- coloring stuff to signal that ur in a snippet
local ext_opts = {
    active = {
        virt_text = { { "<-", "DiffAdd" } }
    },
    passive = {
        hl_group = 'Folded'
    }
}

-- global snippets
require("luasnip").add_snippets("all", {
    s({
        trig = "todo",
        dscr = "A thing you should probabbly do now, but are actually too lazy\n or dont have enough time for it now."
    }
    , {
        c(1, {
            t("TODO: "),
            f(function() return "TODO(" .. get_date() .. "): " end),
        }),
        i(2, 'Write something you should do in the future here.')
    }, { node_ext_opts = ext_opts })
})

require("luasnip").add_snippets("blade", {
    s("sect", fmt(
        [[
        @section('{}')
            {}
        @stop
        ]],
        {
            i(1, 'section_name'),
            i(0)
        }, { node_ext_opts = ext_opts })
    )
})

require("luasnip").add_snippets("php", {
    s("oa-prop", fmt(
        [[
     /**
     * @OA\Property(
     *     format="string",
     *     example="{}"
     * )
     *
     * @var string
     */
    private ${};
        ]],
        {
            i(0, 'example'),
            i(1, 'field-name')
        }, { node_ext_opts = ext_opts })
    )
})


-- TODO: add more snippets as required.
