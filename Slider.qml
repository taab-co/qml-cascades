import QtQuick 1.1
import "effects"

Item {
    id: container
    height: 75
    width: 768
    
    Rectangle {
        id: track
        radius: 17
        color: "#070707"
        height: 17
        width: parent.width - 56
        anchors.centerIn: parent
        border.color: "#333333"
        border.width: 2
        z: -1
        
        Rectangle {
            id: fill
            width: indicator.x + indicator.width/2
            height: parent.height
            radius: parent.radius
            border.width: 1
            border.color: "#595959"
            anchors.verticalCenter: parent.verticalCenter
            z: 1
            gradient: 
                Gradient {
                    GradientStop { position: 0.0; color: "#10B8EF" }
                    GradientStop { position: 1.0; color: "#00A8DF" }
                }
        }
        
        Rectangle {
            id: indicator
            width: 52
            height: 52
            radius: 52/2
            border.width: 1
            border.color: "#595959"
            anchors.verticalCenter: parent.verticalCenter
            smooth: true
            x: 234
            z: 2
            gradient: 
                Gradient {
                    GradientStop { position: 0.0; color: "#3F3F3F" }
                    GradientStop { position: 1.0; color: "#262626" }
                }
        }
        
        Rectangle {
            id: indicatorActive
            width: indicator.width
            height: indicator.height
            radius: indicator.radius
            border.width: indicator.border.width
            border.color: "black"
            smooth: true
            anchors.centerIn: indicator
            opacity: 0
            color: "#00A8DF"
            z: 3
        }
        
        Rectangle {
            id: halo
            width: 100
            height: 100
            radius: 50
            color: 'black'
            anchors.centerIn: indicator
            opacity: 1.0
            scale: 0.01
            RadialGradient {
                anchors.fill: parent
                source: halo
                gradient: Gradient {
                    GradientStop { position: 1.0; color: "#00000000" }
                    GradientStop { position: 0.1; color: "#00A8DF" }
                    GradientStop { position: 0.0; color: "#00A8DF" }
                }
            }
        }
                    
        MouseArea {
            id: indicatorMouseArea
            anchors.centerIn: indicator
            width: indicator.width * 2.5
            height: indicator.height * 2.5
            drag.target: indicator
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: track.width - indicator.width

            onPositionChanged: indicator.x
        }
    }
    states: [
        State {
            name: "Pressed"
            when: indicatorMouseArea.pressed == true
        }
    ] 
    
    transitions: [
        Transition {
            from: ""
            to: "Pressed"
            ParallelAnimation {
                PropertyAction { target: indicatorActive; property: "opacity"; value: "1"}
                NumberAnimation { target: halo; properties: "scale"; from: 0; to: 1; easing.type: Easing.OutBack; easing.overshoot: 2.0; duration: 300}
            }
        },
        Transition {
            from: "Pressed"
            to: ""
            ParallelAnimation {
                PropertyAction { target: indicatorActive; property: "opacity"; value: "0"}
                NumberAnimation { target: halo; properties: "scale"; to: 0; from: 1; easing.type: Easing.InBack; easing.overshoot: 2.0; duration: 300}
            }
        }
    ]
}

