require('neotest').setup({
    adapters = {
        -- require('neotest-pest'),
        require('neotest-docker-phpunit').setup({
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
    }
})
