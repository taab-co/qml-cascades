import QtQuick 1.1

Item {
    id: container

    signal clicked

    property string text
    property bool disabled;
    
    width: 350
    height: 139
    
    Rectangle {
        id: btnContainer
        color: "#0B0B0B"
        anchors.margins: 20
        border.color: "#333333"
        border.width: 4
        height: container.height - 40
        width: container.width - 40
        anchors.centerIn: container
        radius: 10
        
        Rectangle {
            id: btn
            border.width: 1
            radius: 5
            height: btnContainer.height - 6
            width: btnContainer.width - 6
            border.color: "#5C5C5C"
            x: 2
            y: 2.5
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#3F3F3F" }
                GradientStop { position: 1.0; color: "#262626" }
            }
        }
        
        Rectangle {
            id: pressed
            border.width: 1
            radius: 5
            height: btnContainer.height - 6
            width: btnContainer.width - 6
            border.color: "#53514F"
            x: 2
            y: 2.5
            opacity: 0
            gradient: Gradient {
                GradientStop { position: 1.0; color: "#00A8DF" }
                GradientStop { position: 0.0; color: "#003067" }
            }
        }   
             
        Rectangle {
            id: disabled
            border.width: 1
            radius: 5
            height: btnContainer.height - 6
            width: btnContainer.width - 6
            border.color: "#262626"
            color: "#262626"
            x: 2
            y: 2.5
            opacity: 0
        }


        MouseArea {
            id: mouseRegion
            anchors.fill: btn
            onClicked: { 
                if (container.disabled == false)
                    container.clicked()
            }
        }

        Text {
            id: btnText
            color: "#FFFFFF"
            anchors.centerIn: btn
            text: container.text
            font.pointSize: 28
            font.family: "Slate"
        }

        states: [
            State {
                name: "Pressed"
                when: mouseRegion.pressed == true && container.disabled == false
                PropertyChanges { target: pressed; opacity: 1 }
            }, 
            State {
                name: "Disabled"
                when: container.disabled == true
                PropertyChanges { target: disabled; opacity: 1 }
                PropertyChanges { target: btnText; color: "#666666" }
            }
        ]   
    }
}
    
