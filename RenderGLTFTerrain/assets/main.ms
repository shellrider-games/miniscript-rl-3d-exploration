W = 640
H = 480

raylib.InitWindow W,H, "Terrain Test"
raylib.SetTargetFPS 60

v3 = function(x=0,y=0,z=0)
    return {"x" : x, "y" : y, "z" : z}
end function

loadShaderPair = function(vsPath, fsPath)
	vs = raylib.LoadFileText(vsPath)
	fs = raylib.LoadFileText(fsPath)
	if vs == "" or fs == "" then
		print "Failed to load shader files"
		return null
	end if
	sh = raylib.LoadShaderFromMemory(vs, fs)
	if sh == null or not raylib.IsShaderValid(sh) then
		print "Failed to compile shader"
		return null
	end if
	return sh
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

lambertShader = loadShaderPair("assets/Shaders/lambert.vs", "assets/Shaders/lambert.fs")
terrainModel = raylib.LoadModel("assets/Models/Terrain.gltf")

if lambertShader != null then
	for i in range(0, terrainModel.materialCount - 1)
		raylib.SetModelMaterialShader terrainModel, i, lambertShader
	end for
end if

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

raylib.UnloadModel terrainModel
if lambertShader != null then raylib.UnloadShader lambertShader
raylib.CloseWindow