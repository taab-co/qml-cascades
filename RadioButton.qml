import QtQuick 1.1

Item {
    id: container

    signal clicked

    property alias text: btnText.text
    property alias checked: checkable.checked;
    property alias platformExclusiveGroup: checkable.exclusiveGroup
    property alias slideUp: checkable.slideUp
    property bool enabled: true;
    
    width: 350
    height: 100
    
    Radio { 
        id: radioCircle 
        anchors.right: container.right
        slideUp: container.slideUp
    }
    
    MouseArea {
        id: mouseRegion
        anchors.fill: container
        onClicked: { 
            if (container.enabled == true)
            {
                container.clicked()
                checkable.toggle()
            }
        }
    }

    Text {
        id: btnText
        color: "#FFFFFF"
        anchors.left: container.left
        anchors.leftMargin: 20
        anchors.verticalCenter: radioCircle.verticalCenter
        font.pointSize: 38
        font.family: "Slate"
    }

    states: [
        State {
            name: "Pressed"
            when: mouseRegion.pressed == true && container.enabled == true
            PropertyChanges { target: radioCircle; pressed: true }
        }, 
        State {
            name: "Checked"
            when: container.checked == true && container.enabled == true
            PropertyChanges { target: radioCircle; checked: true }
        }, 
        State {
            name: "Disabled"
            when: container.enabled == false
            PropertyChanges { target: disabled; opacity: 1 }
            PropertyChanges { target: btnText; color: "#666666" }
        }
    ] 

    Checkable {
        id: checkable
        value: btnText.text
        enabled: true
    }
}
