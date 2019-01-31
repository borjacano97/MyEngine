workspace "EDE"
    architecture "x64"
    configurations
    {
        "Debug",
        "Release",
        "Distribution"
    }

outputdir = "%{cfg.buildcfg}_%{cfg.system}_%{cfg.architecture}"

IncludeDir = {}
IncludeDir["ImGui"] = "EDE/vendor/imgui/"
IncludeDir["Box2D"] = "EDE/vendor/Box2D/Box2D"

include "EDE/vendor/Box2D"
include "EDE/vendor/imgui"
 
project "EDE"
    location "EDE"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "stdpch.h"
    pchsource "EDE/src/stdpch.cpp"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{prj.name}/src",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.Box2D}"
    }

    links
    {
        "ImGui",
        "Box2D"
	}

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "EDE_PLATFORM_WINDOWS",
            "EDE_BUILD_DLL",
            "_WINDLL"
        }
        postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

    filter "configurations:Debug"
        defines "EDE_DEBUG"
        buildoptions "/MDd"
        symbols "On"

    filter "configurations:Release"
        defines "EDE_RELEASE"
        buildoptions "/MD"
        optimize "On"
        
    filter "configurations:Distribution"
        defines "EDE_DISTRIBUTION"
        buildoptions "/MD"
        optimize "On"
    

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"

    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "EDE/src"
    }

    links
    {
       "EDE"
    }
    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "EDE_PLATFORM_WINDOWS"
        }



    filter "configurations:Debug"
        defines "EDE_DEBUG"
        buildoptions "/MD"
        symbols "On"

    filter "configurations:Release"
        defines "EDE_RELEASE"
        buildoptions "/MD"
        optimize "On"
        
    filter "configurations:Distribution"
        defines "EDE_DISTRIBUTION"
        buildoptions "/MD"
        optimize "On"