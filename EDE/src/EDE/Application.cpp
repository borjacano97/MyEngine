#include "stdpch.h"
#include "Application.h"
namespace EDE 
{
	Application::Application()
	{
	}
	Application::~Application()
	{
		release();
	}
	void Application::init()
	{
	}
	void Application::run()
	{
		running = true;
		while (running) 
		{
			std::cout << "Running...\n";
		}
	}
	void Application::stop()
	{
		running = false;
	}
	void Application::release() 
	{
	}
}
