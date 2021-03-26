cmake_minimum_required(VERSION 3.17)

project(animation)

add_executable(parent_animation
	${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/src/VideoLayoutModel.cpp)

target_link_libraries(parent_animation PRIVATE Qt5::Core Qt5::Gui Qt5::Quick Qt5::Qml Qt5::QuickControls2 Qt5::Widgets)

set_target_properties(parent_animation
	PROPERTIES 
		AUTOMOC ON
		AUTOUIC ON
		AUTORCC ON)
