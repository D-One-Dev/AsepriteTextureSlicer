local slicer = {}

--search in an array
function slicer:FindInArray(arg, table)
    local i = 0
    for k, v in pairs(table) do
        i = i + 1
        if v == arg then
            --if found return index
            return i
        end
    end
    --if not found return false
    return false
end

function slicer:showMain(pl)

    slicer.dlg = Dialog{
        title = "Slice Texture"
    }

    slicer.dlg
    :button{id = "Slice", text = "Slice Texture", onclick = function() slicer:Slice() end}

    slicer.dlg:show{wait = false, bounds = ColorShadingWindowBounds}
end

function slicer:Slice()
    --getting input layer
    local inputLayer = app.layer
    if inputLayer == nil then
        app.alert("No layer selected")
        return
    end

    local cel = inputLayer:cel(1)
    local image = cel.image

    --creating array of all colors in image
    local colorsArray = {}
    --array with an image for each color
    local layers = {}

    --going through each pixel on image
    local i = 1
    for x = 0, image.width - 1 do
        for y = 0, image.height - 1 do
            color = Color(image:getPixel(x,y))
            local colorIndex = slicer:FindInArray(color, colorsArray)
            --if color is new and is not transparent
            if color.alpha > 0 and colorIndex == false then
                --adding color to array
                colorsArray[#colorsArray+1] = color
                --creating according image
                layers[#layers+1] = Image(image.spec)
                layers[#layers]:drawPixel(x, y, color)
            else
                layers[colorIndex]:drawPixel(x, y, color)
            end
        end
    end

    --crating a new layer for each image
    for i = 1, #layers do
        local layer = app.activeSprite:newLayer()
        layer.name = "Color " .. tostring(i)
        app.activeSprite:newCel(layer, 1, layers[i], cel.position)
    end
end

return slicer