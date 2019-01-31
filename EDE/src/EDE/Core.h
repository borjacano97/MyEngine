#pragma once

#ifdef EDE_PLATFORM_WINDOWS
	#ifdef EDE_BUILD_DLL
		#define EDE_API __declspec(dllexport)
	#else
		#define EDE_API __declspec(dllimport)
	#endif
#else
	#error EDE only supports Windows for now!
#endif // EDE_PLATFORM_WINDOWS

#define BIT(x) (1 << x)
