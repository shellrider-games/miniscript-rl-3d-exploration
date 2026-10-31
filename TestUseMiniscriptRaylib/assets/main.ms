W = 320
H = 240

raylib.InitWindow W,H, "Test Window"
raylib.SetTargetFPS 60

reset
while not raylib.WindowShouldClose
    raylib.BeginDrawing
    raylib.ClearBackground raylib.RAYWHITE
    raylib.EndDrawing
    yield
end while
raylib.CloseWindow