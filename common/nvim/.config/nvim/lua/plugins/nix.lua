return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    table.insert(opts.sources, nls.builtins.formatting.nixpkgs_fmt)
    table.insert(opts.sources, nls.builtins.code_actions.statix)
    table.insert(opts.sources, nls.builtins.diagnostics.deadnix)
  end,
}
