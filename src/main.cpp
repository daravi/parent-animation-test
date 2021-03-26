#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "VideoLayoutModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
	app.setApplicationName("Parent Animation Test");
	app.setOrganizationName("");
	app.setOrganizationDomain("");

	auto video_layout_model = std::make_unique<VideoLayoutModel>();
	
	QQmlApplicationEngine engine;
	qmlRegisterSingletonInstance<VideoLayoutModel>("models.singletons", 1, 0, "VideoLayoutModel", video_layout_model.get());
	
	engine.load("../parent-animation/src/main.qml");
	if (engine.rootObjects().isEmpty())
	{
		throw std::runtime_error("ModelManager::ModelManager() -- Engine failed to load Mail.qml");
	}

    return app.exec();
}