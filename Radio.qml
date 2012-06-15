import QtQuick 1.1

Item {
    id: container

    property bool disabled;
    property bool checked;
    property bool pressed;
    
    width: 76
    height: 76
    
    Image {
        x: 10
        y: 10
        source: 'radiocontainer.png'
        smooth: true
    }
    
    Rectangle {
        id: dot
        height: 40
        width: 40
        radius: 20
        x: 19
        y: 19
        color: 'transparent'
        smooth: true
        gradient:
            Gradient {
                GradientStop { id: dotStop1; position: 0.0; color: "#00000000" }
                GradientStop { id: dotStop2; position: 1.0; color: "#00000000" }
            }
        
        Rectangle {
            id: centerDot
            height: 18
            width: 18
            radius: 9
            color: 'white'
            smooth: true
            opacity: 0
            y: 11
            x: 11
        }
    }
    states: [
        State {
            name: "Checked"
            when: container.checked == true
            PropertyChanges { target: centerDot; opacity: 1 }
            PropertyChanges { target: dotStop1; color: "#20C8FF" }
            PropertyChanges { target: dotStop2; color: "#00A8DF" }
        }, 
        State {
            name: "Pressed"
            when: container.pressed == true
            PropertyChanges { target: dotStop1; color: "#4000689F" }
            PropertyChanges { target: dotStop2; color: "#4000A8DF" }
        }, 
        State {
            name: "Disabled"
            when: container.disabled == true
            PropertyChanges { target: centerDot; color: "#666666" }
        }
    ] 
    
    transitions: [
        Transition {
            to: "Checked"
            NumberAnimation { target: centerDot; properties: "width,height"; from: 0; to: 18; }
            NumberAnimation { target: centerDot; properties: "radius"; from: 0; to: 9; }
            NumberAnimation { target: centerDot; properties: "x,y"; from: 20; to: 11; }
        }
    ]
}
