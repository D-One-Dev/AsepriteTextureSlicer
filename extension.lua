local slicer = dofile("./slicer.lua")

function init(plugin)

    plugin:newMenuGroup{
        id = "edit_texture_slicer",
        title = "Texture Slicer",
        group = "edit_fx"
    }

    plugin:newCommand{
        id = "SliceTexture",
        title = "Slice Texture",
        group = "edit_texture_slicer",
        onclick = function()
            slicer:showMain(plugin)
        end
    }

end    