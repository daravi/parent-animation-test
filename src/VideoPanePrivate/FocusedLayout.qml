import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
	id: root

	property alias largePane: largePane
	property alias topPane: topPane
	property alias middlePane: middlePane
	property alias bottomPane: bottomPane

	/** focusView is one of "large", "top", "middle", "bottom" */
	signal clicked(string focuseView)

	GridLayout {
        id: focusedLayout
        
        anchors.fill: parent
        rows: 3
        columns: 2
		rowSpacing: 0
		columnSpacing: 0

        Item {
			id: largePane
            
            Layout.rowSpan: 3
            Layout.preferredWidth: parent.width / 4 * 3
            Layout.fillHeight: true

			Rectangle {
				id: helper
				color: "blue"
				
				anchors.fill: parent
				
			}

			MouseArea {
				id: largePaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("large")
			}
        }

        Item {
            id: topPane

            Layout.preferredWidth: parent.width / 4
            Layout.fillHeight: true

            MouseArea {
				id: topPaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("top")
			}
        }

        Item {
            id: middlePane

            Layout.preferredWidth: parent.width / 4
            Layout.fillHeight: true

			MouseArea {
				id: middlePaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("middle")
			}
        }

        Item {
            id: bottomPane

            Layout.preferredWidth: parent.width / 4
            Layout.fillHeight: true

			MouseArea {
				id: bottomPaneMouseArea
				anchors.fill: parent
				onClicked: root.clicked("bottom")
			}
        }
    }
}
