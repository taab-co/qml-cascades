/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/
**
** This file is part of the Qt Graphical Effects module.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.1
import Qt.labs.shaders 1.0
import "internal"

Item {
    id: rootItem
    property variant source
    property variant displacementSource
    property real displacement: 0.0
    property bool cached: false

    SourceProxy {
        id: sourceProxy
        input: rootItem.source
    }

    SourceProxy {
        id: displacementSourceProxy
        input: rootItem.displacementSource
    }

    ShaderEffectSource {
        id: cacheItem
        anchors.fill: parent
        visible: rootItem.cached
        smooth: true
        sourceItem: shaderItem
        live: true
        hideSource: visible
    }

    ShaderEffectItem {
        id: shaderItem
        property variant source: sourceProxy.output
        property variant displacementSource: displacementSourceProxy.output
        property real displacement: rootItem.displacement
        property real xPixel: 1.0/width
        property real yPixel: 1.0/height

        anchors.fill: parent

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform lowp sampler2D source;
            uniform lowp sampler2D displacementSource;
            uniform highp float displacement;
            uniform highp float xPixel;
            uniform highp float yPixel;

            highp float linearstep(highp float e0, highp float e1, highp float x) {
                return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
            }

            void main() {
                lowp vec4 offset = texture2D(displacementSource, qt_TexCoord0);
                offset.xy -= vec2(0.5, 0.5);
                offset.xy = offset.xy * step(vec2(1.0/256.0), abs(offset.xy));
                highp vec2 tx = qt_TexCoord0 + (vec2(-offset.x, offset.y) * displacement);

                lowp float e1 = linearstep(0.0, xPixel, tx.x);
                lowp float e2 = linearstep(0.0, yPixel, tx.y);
                lowp float e3 = 1.0 - linearstep(1.0, 1.0 + xPixel, tx.x);
                lowp float e4 = 1.0 - linearstep(1.0, 1.0 + yPixel, tx.y);

                lowp vec4 sample = texture2D(source, tx);
                sample.rgb *= e1 * e2 * e3 * e4;
                gl_FragColor = sample * qt_Opacity * offset.a;
            }
        "
    }
}
