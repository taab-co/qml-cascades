import QtQuick 1.1

Item {
    id: container

    signal clicked

    property string text
    property bool disabled;
    property bool checked;
    
    width: 350
    height: 120
    
    Radio { id: radioCircle }
    
    MouseArea {
        id: mouseRegion
        anchors.fill: container
        onClicked: { 
            if (container.disabled == false)
            {
                container.clicked()
                container.checked = true
            }
        }
    }

    Text {
        id: btnText
        color: "#FFFFFF"
        anchors.left: radioCircle.right
        anchors.verticalCenter: radioCircle.verticalCenter
        text: container.text
        font.pointSize: 28
        font.family: "Slate"
    }

    states: [
        State {
            name: "Pressed"
            when: mouseRegion.pressed == true && container.disabled == false
            PropertyChanges { target: radioCircle; pressed: true }
        }, 
        State {
            name: "Checked"
            when: container.checked == true && container.disabled == false
            PropertyChanges { target: radioCircle; checked: true }
        }, 
        State {
            name: "Disabled"
            when: container.disabled == true
            PropertyChanges { target: disabled; opacity: 1 }
            PropertyChanges { target: btnText; color: "#666666" }
        }
    ] 
}
