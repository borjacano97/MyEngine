workspace "EDE"
    architecture "x64"
    configurations
    {
        "Debug",
        "Release",
        "Distribution"
    }


outputdir = "%{cfg.buildcfg}_%{cfg.system}_%{cfg.architecture}"

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
        "EDE/src"
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
        symbols "On"

    filter "configurations:Release"
        defines "EDE_RELEASE"
        optimize "On"
        
    filter "configurations:Distribution"
        defines "EDE_DISTRIBUTION"
        optimize "On"
    
    filter { "system:windows" , "configurations:Release"}
        buildoptions "/MT"

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

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "EDE_PLATFORM_WINDOWS"
        }

        links
        {
            "EDE"
        }

    filter "configurations:Debug"
        defines "EDE_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "EDE_RELEASE"
        optimize "On"
        
    filter "configurations:Distribution"
        defines "EDE_DISTRIBUTION"
        optimize "On"
    
    filter { "system:windows" , "configurations:Release"}
        buildoptions "/MT"