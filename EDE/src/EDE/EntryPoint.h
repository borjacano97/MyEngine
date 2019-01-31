#pragma once

#ifdef EDE_PLATFORM_WINDOWS

extern EDE::Application* EDE::createApplication();

int main(int argc, char** argv) 
{
	auto app = EDE::createApplication();
	app->init();
	app->run();
	delete app;
	return 0;
}

#endif // EDE_PLATFORM_WINDOWS

