import QtQuick 1.1

Item {
    id: container

    property bool disabled;
    property bool checked;
    property bool pressed;
    property bool slideUp: false;
    
    width: 76
    height: 76
    
    Rectangle {
        x: 10
        y: 10
        width: 52
        height: 52
        radius: 52/2
        color: "#0B0B0B"
        border.color: "#333333"
        border.width: 2
        smooth: true
        
        Rectangle {
            id: outerDot
            height: 40
            width: 40
            radius: 20
            x: 6
            y: 6
            smooth: true
            border.color: "#333333"
            border.width: 2
            gradient:
                Gradient {
                    GradientStop { id: dotStopOut1; position: 0.0; color: "#3F3F3F" }
                    GradientStop { id: dotStopOut2; position: 1.0; color: "#262626" }
                }
            Rectangle {
                id: dot
                height: 40
                width: 40
                radius: 20
                x: 0
                y: 0
                smooth: true
                border.color: "#333333"
                border.width: 2
                gradient:
                    Gradient {
                        GradientStop { id: dotStop1; position: 0.0; color: "#3F3F3F" }
                        GradientStop { id: dotStop2; position: 1.0; color: "#262626" }
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
        }
    }
    

    states: [
        State {
            name: "Checked"
            when: container.checked == true
            PropertyChanges { target: dotStop1; color: "#20C8FF" }
            PropertyChanges { target: dotStop2; color: "#00A8DF" }
        }, 
        State {
            name: "Pressed"
            when: container.pressed == true
            PropertyChanges { target: dotStopOut1; color: "#4000689F" }
            PropertyChanges { target: dotStopOut2; color: "#4000A8DF" }
            PropertyChanges { target: outerDot; scale: 0.9 }
        }, 
        State {
            name: "Disabled"
            when: container.disabled == true
            PropertyChanges { target: centerDot; color: "#666666" }
        }
    ] 
    
    transitions: [
        Transition {
            from: ""
            to: "Checked"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: dot; properties: "y"; from: (container.slideUp ? 41 : -1); to: 0; easing.type: Easing.InQuad;}
                    NumberAnimation { target: dot; properties: "x"; from: 11; to: 0; easing.type: Easing.InQuad;}
                    NumberAnimation { target: dot; properties: "height"; from: 0; to: 40; easing.type: Easing.InQuad;}  
                    NumberAnimation { target: dot; properties: "width"; from: 20; to: 40; easing.type: Easing.InQuad;}  
                }
                ParallelAnimation {
                    PropertyAction { target: centerDot; property: "opacity"; value: 1 }
                    NumberAnimation { target: centerDot; properties: "width,height"; from: 0; to: 18; }
                    NumberAnimation { target: centerDot; properties: "radius"; from: 0; to: 9; }
                    NumberAnimation { target: centerDot; properties: "x,y"; from: 20; to: 11; }
                }
            }
        },
        Transition {
            from: "Checked"
            to: ""
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAction { target: centerDot; property: "opacity"; value: 0 }
                    NumberAnimation { target: dot; properties: "y"; to: (container.slideUp ? 41 : -1); from: 0; easing.type: Easing.InQuad;}
                    NumberAnimation { target: dot; properties: "x"; to: 11; from: 0; easing.type: Easing.InQuad;}
                    NumberAnimation { target: dot; properties: "height"; to: 0; from: 40; easing.type: Easing.InQuad;}  
                    NumberAnimation { target: dot; properties: "width"; to: 20; from: 40; easing.type: Easing.InQuad;}  
                }
                ParallelAnimation {
                    NumberAnimation { target: centerDot; properties: "width,height"; from: 0; to: 18; }
                    NumberAnimation { target: centerDot; properties: "radius"; from: 0; to: 9; }
                    NumberAnimation { target: centerDot; properties: "x,y"; from: 20; to: 11; }
                }
            }
        }
    ]
}
