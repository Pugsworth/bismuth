// SPDX-FileCopyrightText: 2021 Mikhail Zolotukhin <mail@gikari.com>
// SPDX-License-Identifier: MIT

import QtQuick 2.12
import QtQuick.Controls 2.12 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.7 as Kirigami

QQC2.SpinBox {
    id: spinbox

    property string settingName: ""
    property int decimals: 2
    property real realValue: 0.0
    property real realFrom: 0.0
    property real realTo: 100.0
    property real realStepSize: 0.1
    property real factor: Math.pow(10, decimals)

    stepSize: realStepSize * factor
    value: realValue * factor
    from: realFrom * factor
    to: realTo * factor

    validator: DoubleValidator {
        bottom: Math.min(from, to)
        top: Math.max(from, to)
    }

    implicitWidth: Kirigami.Units.gridUnit * 5
    implicitHeight: Kirigami.Units.gridUnit * 1.75

    textFromValue: function(value, locale) {
        return parseFloat(value*1.0/factor).toFixed(decimals);
    }

    valueFromText: function(text, locale) {
        return Number.fromLocaleString(locale, text) * factor
    }

    Component.onCompleted: () => {
        value = kcm.config[settingName] * factor
    }

    onValueModified: () => {
        kcm.config[settingName] = value / factor
    }
}
