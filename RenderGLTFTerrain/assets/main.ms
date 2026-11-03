W = 640
H = 480

raylib.InitWindow W,H, "Terrain Test"
raylib.SetTargetFPS 60

v3 = function(x=0,y=0,z=0)
    return {"x" : x, "y" : y, "z" : z}
end function

cameraPosition = v3(0,20,20)
cameraTarget = v3(0,0,0)
cameraUp = v3(0,1,0)

camera = {}
camera.position = cameraPosition
camera.target = cameraTarget
camera.up = cameraUp
camera.fovy = 45
camera.projection = raylib.CAMERA_PERSPECTIVE

terrainModel = raylib.LoadModel("assets/Models/Terrain.gltf")

while not raylib.WindowShouldClose

    raylib.BeginDrawing
    raylib.ClearBackground raylib.RAYWHITE

    raylib.BeginMode3D(camera)
        raylib.DrawModel terrainModel, v3(0,0,0), 1, raylib.WHITE
    raylib.EndMode3D
    raylib.DrawFPS 10,10
    raylib.EndDrawing
    yield
end while
raylib.CloseWindow