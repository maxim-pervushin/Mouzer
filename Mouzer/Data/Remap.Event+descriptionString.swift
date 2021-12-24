//
// Created by Maxim Pervushin on 06.12.2021.
//

import Foundation

extension Remap.Event {

    var descriptionString: String {
        switch self {
        case let .otherMouse(buttonNumber):
            return otherMouseDescriptionString(buttonNumber: buttonNumber)
        case let .hotkey(virtualKey, flags):
            return hotkeyDescriptionString(virtualKey: virtualKey, flags: flags)
        }
    }

    private func otherMouseDescriptionString(buttonNumber: Int64) -> String {
        "\("Button".localized) \(buttonNumber)"
    }

    private func hotkeyDescriptionString(virtualKey: CGKeyCode, flags: CGEventFlags) -> String {
        var componentList = [String]()

        flags.contains(.maskAlphaShift) ? componentList.append("Alpha Shift") : ()
        flags.contains(.maskShift) ? componentList.append("Shift") : ()
        flags.contains(.maskControl) ? componentList.append("Control") : ()
        flags.contains(.maskAlternate) ? componentList.append("Alt") : ()
        flags.contains(.maskCommand) ? componentList.append("Command") : ()
        // flags.contains(.maskHelp) ? componentList.append("Help") : ()
        flags.contains(.maskSecondaryFn) ? componentList.append("Fn") : ()
        // flags.contains(.maskNumericPad) ? componentList.append("NumericPad") : ()
        // flags.contains(.maskNonCoalesced) ? componentList.append("NonCoalesced") : ()

        switch virtualKey {
        case 0:
            componentList.append("A")
        case 1:
            componentList.append("S")
        case 2:
            componentList.append("D")
        case 3:
            componentList.append("F")
        case 4:
            componentList.append("H")
        case 5:
            componentList.append("G")
        case 6:
            componentList.append("Z")
        case 7:
            componentList.append("X")
        case 8:
            componentList.append("C")
        case 9:
            componentList.append("V")

//        case 10:
//            componentList.append("?10?")
        case 11:
            componentList.append("B")
        case 12:
            componentList.append("Q")
        case 13:
            componentList.append("W")
        case 14:
            componentList.append("E")
        case 15:
            componentList.append("R")
        case 16:
            componentList.append("Y")
        case 17:
            componentList.append("T")
        case 18:
            componentList.append("1")
        case 19:
            componentList.append("2")

        case 20:
            componentList.append("3")
        case 21:
            componentList.append("4")
        case 22:
            componentList.append("6")
        case 23:
            componentList.append("5")
        case 24:
            componentList.append("=")
        case 25:
            componentList.append("9")
        case 26:
            componentList.append("7")
        case 27:
            componentList.append("-")
        case 28:
            componentList.append("8")
        case 29:
            componentList.append("0")

        case 30:
            componentList.append("]")
        case 31:
            componentList.append("O")
        case 32:
            componentList.append("U")
        case 33:
            componentList.append("[")
        case 34:
            componentList.append("I")
        case 35:
            componentList.append("P")
        case 36:
            componentList.append("Return")
        case 37:
            componentList.append("L")
        case 38:
            componentList.append("J")
        case 39:
            componentList.append("'")

        case 40:
            componentList.append("K")
        case 41:
            componentList.append(";")
        case 42:
            componentList.append("\\")
        case 43:
            componentList.append(",")
        case 44:
            componentList.append("/")
        case 45:
            componentList.append("N")
        case 46:
            componentList.append("M")
        case 47:
            componentList.append(".")
        case 48:
            componentList.append("Tab")
        case 49:
            componentList.append("Space")

        case 50:
            componentList.append("`")
        case 51:
            componentList.append("Delete")
//        case 52:
//            componentList.append("?52?")
        case 53:
            componentList.append("Esc")
//        case 54:
//            componentList.append("?54?")
        case 55:
            componentList.append("Command")
        case 56:
            componentList.append("Left Shift")
        case 57:
            componentList.append("Caps Lock")
        case 58:
            componentList.append("Left Option")
        case 59:
            componentList.append("Control")

        case 60:
            componentList.append("Right Shift")
        case 61:
            componentList.append("Right Option")
//        case 62:
//            componentList.append("??")
        case 63:
            componentList.append("Fn")
//        case 64:
//            componentList.append("")
//        case 65:
//            componentList.append("")
//        case 66:
//            componentList.append("")
//        case 67:
//            componentList.append("")
//        case 68:
//            componentList.append("")
//        case 69:
//            componentList.append("")

//        case 70:
//            componentList.append("")
//        case 71:
//            componentList.append("")
//        case 72:
//            componentList.append("")
//        case 73:
//            componentList.append("")
//        case 74:
//            componentList.append("")
//        case 75:
//            componentList.append("")
        case 76:
            componentList.append("Enter")
//        case 77:
//            componentList.append("")
//        case 78:
//            componentList.append("")
//        case 79:
//            componentList.append("")

//        case 80:
//            componentList.append("")
//        case 81:
//            componentList.append("")
//        case 82:
//            componentList.append("")
//        case 83:
//            componentList.append("")
//        case 84:
//            componentList.append("")
//        case 85:
//            componentList.append("")
//        case 86:
//            componentList.append("")
//        case 87:
//            componentList.append("")
//        case 88:
//            componentList.append("")
//        case 89:
//            componentList.append("")

        default:
            componentList.append("?\(virtualKey)?")
        }

        return componentList.joined(separator: " + ")
    }
}
