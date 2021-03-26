import QtQuick 2.15

Item {
	id: root

	property alias color: placeholder.color

	Rectangle {
		id: placeholder
		anchors.fill: parent
	}
}