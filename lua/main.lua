-- a Client is used to connect this app to a Place. arg[2] is the URL of the place to
-- connect to, which Assist sets up for you.
local client = Client(
    arg[2], 
    "place"
)
local app = ui.App(client)

-- All the assets
local house = {
    path = "assets/house/",
    
    -- Walls
    {name = "house_shell_sidewings_v06.glb", },
    {name = "house_shell_v06.glb", },
    {name = "stairs_balcony_v05.glb", hasTransparency = true},
    {name = "ceilings_beams.glb", hasTransparency = true},
    
    -- Transparent details are limited to same-plane surfaces as we can only sort by model, 
    -- so here's all the windows of the house
    {name = "windows_balcony.glb", hasTransparency = true, backfaceCulling = false },
    {name = "windows_facade_back.glb", hasTransparency = true, },
    {name = "windows_facade_front-door01.glb", hasTransparency = true, },
    {name = "windows_facade_front-door02.glb", hasTransparency = true, },
    {name = "windows_facade_front.glb", hasTransparency = true, },
    {name = "windows_front_01 v2.glb", hasTransparency = true, },
    {name = "windows_front_01-open.glb", hasTransparency = true, },
    {name = "windows_front_door01.glb", hasTransparency = true, },
    {name = "windows_front_door02.glb", hasTransparency = true, },
    {name = "windows_wingL_01.glb", hasTransparency = true, },
    {name = "windows_wingL_02.glb", hasTransparency = true, },
    {name = "windows_wingR_01.glb", hasTransparency = true, },
    {name = "windows_wingR_02.glb", hasTransparency = true, },
}


local decorations = {
    path = 'assets/decorations/',

    -- {name = "chandelier.glb", hasTransparency = true },
    {name = "tv_TV_stand_v05.glb",  },
    {name = "wall_divider_with_plants_v05.glb",  },
    {name = "plants_pot_floor_v05.glb",  },
    {name = "podium_v05.glb",  },
    {name = "lamp_v02.glb", hasTransparency = true },
    {name = "cofee_table_01_v05.glb",  },
    {name = "confrence_chairs_table_v05.glb",  },
    {name = "couch01_v05.glb",  },
    {name = "couch02_v05.glb",  },
    {name = "couch_chairs_v05.glb",  },
    {name = "couch_wall_v05.glb",  },
}

function load(assets)
    -- Create assets and views for each
    for _, spec in ipairs(assets) do
        local asset = ui.Asset.File(assets.path..spec.name)
        app.assetManager:add(asset, true)

        local view = ui.Asset.View(asset)
        view.hasTransparency = spec.hasTransparency
        view.customSpecAttributes = {
            material = {
                shader_name = spec.shader or "pbr",
            }
        }

        if spec.backfaceCulling then
            view.customSpecAttributes.material.backfaceCulling = true
        end
        app.mainView:addSubview(view)
    end
end

load(house)
load(decorations)

-- Connect to the designated remote Place server
if app:connect() then app:run() end
