import "mathUtil"

W = 640
H = 480

raylib.InitWindow W,H, "Terrain Test"
raylib.SetTargetFPS 60
raylib.DisableCursor

v3 = function(x=0,y=0,z=0)
    return {"x" : x, "y" : y, "z" : z}
end function

v3add = function(v1, v2)
	return {"x" : v1.x + v2.x, "y" : v1.y + v2.y, "z" : v1.z + v2.z }
end function

orientationToForward = function(orientation)
	return v3(cos(orientation.pitch) * sin(orientation.yaw), sin(orientation.pitch), cos(orientation.pitch) * cos(orientation.yaw))
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




cameraOrientation = {"yaw" : 0, "pitch" : 0}
cameraPosition = v3(0,1.5,0)
forward = orientationToForward(cameraOrientation)
cameraTarget = v3add(cameraPosition, forward)
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
	mouseDelta = raylib.GetMouseDelta
	mdx = mouseDelta.x
	mdy = mouseDelta.y

	fx = sin(cameraOrientation.yaw)
	fz = cos(cameraOrientation.yaw)
	speed = 0.1
	if raylib.IsKeyDown(raylib.KEY_W) then
    	camera.position.x += fx * speed
	    camera.position.z += fz * speed
	end if
	if raylib.IsKeyDown(raylib.KEY_S) then
    	camera.position.x -= fx * speed
	    camera.position.z -= fz * speed
	end if
	if raylib.IsKeyDown(raylib.KEY_A) then
    	camera.position.x += fz * speed
	    camera.position.z -= fx * speed
	end if
	if raylib.IsKeyDown(raylib.KEY_D) then
    	camera.position.x -= fz * speed
    	camera.position.z += fx * speed
	end if


	cameraOrientation.yaw -= mdx * 0.003
	cameraOrientation.pitch -= mdy * 0.003
	cameraOrientation.pitch = mathUtil.clamp(cameraOrientation.pitch, mathUtil.degToRad(-89.0), mathUtil.degToRad(89.0))

	camera.target = v3add(camera.position , orientationToForward(cameraOrientation))



    raylib.BeginDrawing
    raylib.ClearBackground raylib.BLUE
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