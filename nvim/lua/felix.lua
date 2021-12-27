local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

local server_name = "felix"
local bin_name = "/usr/bin/php"

configs[server_name] = {
  default_config = {
    cmd = {bin_name, "/tmp/php-language-server/bin/php-language-server.php"};
    filetypes = {"php"};
    root_dir = function (pattern)
      local cwd  = vim.loop.cwd();
      local root = util.root_pattern("composer.json", ".git")(pattern);

      -- prefer cwd if root is a descendant
      return util.path.is_descendant(cwd, root) and cwd or root;
    end;
  };
  docs = {
    description = [[
https://github.com/phpactor/phpactor
Installation: https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation
]];
    default_config = {
      cmd = {"phpactor", "language-server"};
      root_dir = [[root_pattern("composer.json", ".git")]];
    };
  };
}
