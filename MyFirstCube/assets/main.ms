W = 640
H = 480

raylib.InitWindow W,H, "My First Cube"
raylib.SetTargetFPS 60

v3 = function(x=0,y=0,z=0)
    return {"x" : x, "y" : y, "z" : z}
end function

cameraPosition = v3(4,4,4)
cameraTarget = v3(0,0,0)
cameraUp = v3(0,1,0)

camera = {}
camera.position = cameraPosition
camera.target = cameraTarget
camera.up = cameraUp
camera.fovy = 45
camera.projection = raylib.CAMERA_PERSPECTIVE

cubeMesh = raylib.GenMeshCube(2, 2, 2)
cubeModel = raylib.LoadModelFromMesh(cubeMesh)

cubeRotation = 0
cubeRotationSpeed = -0.25

while not raylib.WindowShouldClose

    deltaTime = raylib.GetFrameTime
    cubeRotation += 360 * cubeRotationSpeed * deltaTime

    raylib.BeginDrawing
    raylib.ClearBackground raylib.RAYWHITE

    raylib.BeginMode3D(camera)
        raylib.DrawModelEx cubeModel, v3(0,0,0), v3(0,1,0), cubeRotation, v3(1,1,1), raylib.MAROON
        raylib.DrawModelWiresEx cubeModel, v3(0,0,0), v3(0,1,0), cubeRotation, v3(1,1,1), raylib.BLACK
    raylib.EndMode3D


    raylib.EndDrawing
    yield
end while
raylib.CloseWindow