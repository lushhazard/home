import QtQuick
import "../"

BarBlock {
    id: text
    content: BarText {
        symbolText: `${Datetime.date}`

        font.pixelSize: 16
    }
}
