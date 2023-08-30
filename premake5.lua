workspace "UntitledWorkspace"
    architecture "x64"
    configurations { "Debug", "Release" }

    outDir = "%{cfg.buildcfg}_%{cfg.system}_%{cfg.architecture}"

    project "UntitledProject"
        location "Build"
        language "C"
        kind "ConsoleApp"

        targetdir   ( "Binaries/" .. outDir .. "/%{prj.name}" )
        objdir      ( "Binaries/Objects/" .. outDir .. "/%{prj.name}" )

        files { "Build/Source/**.c", "Build/Include/**.h" }
        includedirs { "Build/Source", "Build/Include" }

        filter "system:Windows"
            staticruntime "On"
            systemversion "latest"
            system "windows"
            defines { "UNT_WIN" }

        filter "system:Macosx"
            system "macosx"
            defines { "UNT_MACOS" }

        filter "system:Linux"
            pic "On"
            system "Linux"
            defines { "UNT_LINUX" }

        filter { "configurations:Debug" }
            defines { "UNT_DEBUG", "DEBUG" }
            optimize "Debug"
            symbols "On"

        filter { "configurations:Release" }
            defines { "UNT_RELEASE", "NDEBUG" }
            optimize "Full"
            symbols "Off"
