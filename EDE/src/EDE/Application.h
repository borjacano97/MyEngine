#pragma once

#include "Core.h"

namespace EDE 
{
	class EDE_API Application
	{
	public:
		Application();
		virtual ~Application();


		void init();
		void run();
		void stop();


	private:
		void release();
	private:
		bool running;


	};

	//To be defined from the user
	Application* createApplication();

}