// SPDX-FileCopyrightText: 2021 Mikhail Zolotukhin <mail@gikari.com>
// SPDX-License-Identifier: MIT

import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.7 as Kirigami

Item {
    id: root

    property string settingName: ""
    property int decimals: 2
    property real realValue: 0.0
    property real realFrom: 0.0
    property real realTo: 100.0
    property real realStepSize: 1.0

    QQC2.SpinBox {
        id: spinbox

        property real factor: Math.pow(10, root.decimals)

        stepSize: root.realStepSize*factor
        value: root.realValue*factor

        from: root.realFrom*factor
        to: root.realTo*factor

        validator: DoubleValidator {
            bottom: Math.min(spinbox.from, spinbox.to)
            top: Math.max(spinbox.from, spinbox.to)
        }

        implicitWidth: Kirigami.Units.gridUnit * 5
        implicitHeight: Kirigami.Units.gridUnit * 1.75

        textFromValue: function(value, locale) {
            return parseFloat(spinbox.value*1.0/spinbox.factor).toFixed(root.decimals);
        }


        // textFromValue: function(value, locale) {
        //     return Number(value / 100).toLocaleString(locale, 'f', root.decimals)
        // }

        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text) * 100
        }

        Component.onCompleted: () => {
            value = kcm.config[settingName]
        }

        value: kcm.config[settingName]
        onValueModified: () => {
            kcm.config[settingName] = value
        }

    }
}
