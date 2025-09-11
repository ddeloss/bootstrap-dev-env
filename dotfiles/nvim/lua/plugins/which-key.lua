return {
  "folke/which-key.nvim",
  config = function()
    local which_key_ok, which_key = pcall(require, "which-key")
    if which_key_ok then
      -- Apply the patch to disable healthcheck
      which_key.health = which_key.health or {}
      which_key.health.check = function() end
    end
  end
}
