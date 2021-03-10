-- a Client is used to connect this app to a Place. arg[2] is the URL of the place to
-- connect to, which Assist sets up for you.
local client = Client(
    arg[2], 
    "place"
)
local app = ui.App(client)

-- load all the assets
local assetNames = {
    {name = "cofee_table_01_v05.glb",  },
    {name = "confrence_chairs_table_v05.glb",  },
    {name = "couch01_v05.glb",  },
    {name = "couch02_v05.glb",  },
    {name = "couch_chairs_v05.glb",  },
    {name = "couch_wall_v05.glb",  },
    {name = "house_shell_sidewings_v05.glb", hasTransparency = true },
    {name = "house_shell_v05_1.glb",  },
    {name = "lamp_v02.glb", hasTransparency = true },
    {name = "outdoor_terrace_glass_V02.glb", hasTransparency = true },
    {name = "plants_pot_floor_v05.glb",  },
    {name = "podium_v05.glb",  },
    {name = "stairs_balcony_v05.glb", hasTransparency = true },
    {name = "tv_TV_stand_v05.glb",  },
    {name = "wall_divider_with_plants_v05.glb",  },
}

-- Create assets and views for each
for _, spec in ipairs(assetNames) do
    local asset = ui.Asset.File("assets/house/"..spec.name)
    app.assetManager:add(asset, true)

    local view = ui.Asset.View(asset)
    view.hasTransparency = spec.hasTransparency
    view.customSpecAttributes = {
        material = {
            shader_name = spec.shader or "pbr"
        }
    }
    app.mainView:addSubview(view)
end

-- Connect to the designated remote Place server
if app:connect() then app:run() end
