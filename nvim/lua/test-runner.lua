require('neotest').setup({
    log_level = vim.log.levels.DEBUG,
    adapters = {
        -- require('neotest-pest'),
        require('neotest-docker-phpunit').setup({
            log_level = vim.log.levels.DEBUG,
            phpunit_cmd = "/Users/praem90/personal/packages/rust/neotest-docker-phpunit/target/debug/neotest-docker-phpunit",
            docker_phpunit = {
                default = {
                    container = "php",
                    volume = "/Users/praem90/projects/track-payments:/app",
                }
            }
        }),
        require("neotest-go"),
    },
    diagnostic = {
        enabled = true
    },
    watch = {
        symbol_queries = {
            php = [[
                ;query
                ;captures imported classes
                ((namespace_use_clause (qualified_name)) @symbol)
            ]],
        }
    }
})
