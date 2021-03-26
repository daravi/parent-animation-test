import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
	id: root

	property alias topLeftPane: topLeftPane
	property alias topRightPane: topRightPane
	property alias bottomLeftPane: bottomLeftPane
	property alias bottomRightPane: bottomRightPane

	/** tileView is one of "topLeft", "topRight", "bottomLeft", "bottomRight" */
	signal clicked(string tileView)

	GridLayout {
		id: tiledLayout
		
		anchors.fill: parent	
		rows: 2
		columns: 2
		rowSpacing: 0
		columnSpacing: 0
		
		Item {
			id: topLeftPane
			
			Layout.fillWidth: true
			Layout.fillHeight: true

			MouseArea {
				id: topLeftPaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("topLeft")
			}
		}

		Item {
			id: topRightPane

			Layout.fillWidth: true
			Layout.fillHeight: true

			MouseArea {
				id: topRightPaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("topRight")
			}
		}

		Item {
			id: bottomLeftPane

			Layout.fillWidth: true
			Layout.fillHeight: true

			MouseArea {
				id: bottomLeftPaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("bottomLeft")
			}
		}

		Item {
			id: bottomRightPane

			Layout.fillWidth: true
			Layout.fillHeight: true

			MouseArea {
				id: bottomRightPaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("bottomRight")
			}
		}
	}
}
