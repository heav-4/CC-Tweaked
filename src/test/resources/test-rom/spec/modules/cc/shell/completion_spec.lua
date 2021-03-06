describe("cc.shell.completion", function()
    local c = require "cc.shell.completion"

    describe("dirOrFile", function()
        it("completes both", function()
            expect(c.dirOrFile(shell, "rom/")):same {
                "apis/", "apis", "autorun/", "autorun", "help/", "help",
                "modules/", "modules", "motd.txt", "programs/", "programs", "startup.lua",
            }
        end)

        it("adds a space", function()
            expect(c.dirOrFile(shell, "rom/", nil, true)):same {
                "apis/", "apis ", "autorun/", "autorun ", "help/", "help ",
                "modules/", "modules ", "motd.txt ", "programs/", "programs ", "startup.lua ",
            }
        end)
    end)

    describe("build", function()
        it("completes multiple arguments", function()
            local spec = c.build(
                function() return { "a", "b", "c" } end,
                nil,
                { c.choice, { "d", "e", "f" } }
            )

            expect(spec(shell, 1, "")):same { "a", "b", "c" }
            expect(spec(shell, 2, "")):same(nil)
            expect(spec(shell, 3, "")):same { "d", "e", "f" }
            expect(spec(shell, 4, "")):same(nil)
        end)

        it("supports variadic completions", function()
            local spec = c.build({ function() return { "a", "b", "c" } end, many = true })

            expect(spec(shell, 1, "")):same({ "a", "b", "c" })
            expect(spec(shell, 2, "")):same({ "a", "b", "c" })
        end)
    end)
end)
