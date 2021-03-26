import QtQuick 2.15
import QtQuick.Layouts 1.15

import models.singletons 1.0

import "VideoPanePrivate"

Item {
	id: root

    QtObject {
        id: internal

        property var videoViewMap: {
            "bucket": bucketView,
            "rear": rearView,
            "left": leftView,
            "right": rightView
        }
    }

    VideoView {
        id: bucketView
        color: "blue"

        anchors.fill: parent
    }

    VideoView {
        id: rearView
        color: "red"

        anchors.fill: parent
    }

    VideoView {
        id: leftView
        color: "green"

        anchors.fill: parent
    }

    VideoView {
        id: rightView
        color: "yellow"

        anchors.fill: parent
    }

    FocusedLayout {
        id: focusedView

        anchors.fill: parent
        visible: VideoLayoutModel.state === "focused"

        onClicked: {
            if (VideoLayoutModel.state === "focused") {
                VideoLayoutModel.click(focuseView)
            }
        }
    }

    TiledLayout {
        id: tiledView

        width: parent.width * 1440 / 1920
        height: parent.height
        anchors.top: parent.top
        anchors.right: parent.right
        visible: VideoLayoutModel.state === "tiled"

        onClicked: {
            if (VideoLayoutModel.state === "tiled") {
                VideoLayoutModel.click(tileView)
            }
        }
    }

    Connections {
        target: VideoLayoutModel
        function onStateChanged(newState) {
            if (newState !== "focused" && newState !== "tiled") {
                console.exception("VideoPane.qml -- received unexpected state '" + newState +  "' from VideoLayoutModel")
            }

            root.state = newState
        }

        function onSwapped() {
            if (root.state === "focused") {
                root.state = "swapped"
            } else if (root.state === "swapped") {
                root.state = "focused"
            }
        }
    }

    states: [
        State {
            name: "tiled"

            ParentChange { target: bucketView; parent: tiledView.topLeftPane; }
            ParentChange { target: rearView; parent: tiledView.topRightPane; }
            ParentChange { target: leftView; parent: tiledView.bottomLeftPane; }
            ParentChange { target: rightView; parent: tiledView.bottomRightPane; }
        },
        State {
            name: "focused"

            ParentChange { target: internal.videoViewMap[VideoLayoutModel.largeView]; parent: focusedView.largePane; }
            ParentChange { target: internal.videoViewMap[VideoLayoutModel.topView]; parent: focusedView.topPane; }
            ParentChange { target: internal.videoViewMap[VideoLayoutModel.middleView]; parent: focusedView.middlePane; }
            ParentChange { target: internal.videoViewMap[VideoLayoutModel.bottomView]; parent: focusedView.bottomPane; }
        },
        State {
            name: "swapped"

            ParentChange { target: internal.videoViewMap[VideoLayoutModel.largeView]; parent: focusedView.largePane; }
            ParentChange { target: internal.videoViewMap[VideoLayoutModel.topView]; parent: focusedView.topPane; }
            ParentChange { target: internal.videoViewMap[VideoLayoutModel.middleView]; parent: focusedView.middlePane; }
            ParentChange { target: internal.videoViewMap[VideoLayoutModel.bottomView]; parent: focusedView.bottomPane; }
        }
    ]

    // TODO PUYA: Debug why this is not working
    transitions: Transition {
        ParentAnimation {
            NumberAnimation { properties: "x,y"; duration: 1000; }
        }
    }

    Component.onCompleted: {
        root.state = VideoLayoutModel.state
    }
}
