import QtQuick.Controls 2.15

ApplicationWindow {
	id: wrapperWindow
	visible: true
	title: qsTr("Parent Animation Test")
	width: 1600
	height: 900

	VideoPane {
        id: videoPane
		anchors.fill: parent
    }
}
