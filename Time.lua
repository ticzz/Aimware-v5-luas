local function ExampleDrawingHook()
    draw.Color( 220, 50, 50 );
    draw.Text( 128, 128, os.date() );
end

callbacks.Register( "Draw", "ExampleDrawingHook", ExampleDrawingHook );