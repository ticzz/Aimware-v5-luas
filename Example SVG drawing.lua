local svgData = http.Get( "https://upload.wikimedia.org/wikipedia/commons/f/fd/Ghostscript_Tiger.svg" );

local imgRGBA, imgWidth, imgHeight = common.RasterizeSVG( svgData );

local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );

local function ExampleTextureDrawing()
    draw.SetTexture( texture );
    draw.FilledRect( 20, 20, imgWidth, imgHeight );
end

callbacks.Register( "Draw", "ExampleTextureDrawing", ExampleTextureDrawing );







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

