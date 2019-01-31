#include "EDE.h"

class SandboxApp :
	public EDE::Application
{
public:
	SandboxApp();
	~SandboxApp();


};

EDE::Application* EDE::createApplication()
{
	return new SandboxApp();
}