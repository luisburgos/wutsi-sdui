import 'action.dart';
import 'button.dart';
import 'column.dart';
import 'container.dart';
import 'flexible.dart';
import 'form.dart';
import 'icon.dart';
import 'image.dart';
import 'input.dart';
import 'listview.dart';
import 'radio.dart';
import 'row.dart';
import 'screen.dart';
import 'text.dart';
import 'widget.dart';

//-- Core ------------------------------------
class SDUIParser {
  static SDUIWidget fromJson(Map<String, dynamic>? json) {
    // Widget
    var type = json?["type"].toString().toLowerCase();
    SDUIWidget? widget;
    switch (type) {
      case "button":
        widget = SDUIButton();
        break;
      case "column":
        widget = SDUIColumn();
        break;
      case "container":
        widget = SDUIContainer();
        break;
      case "flexible":
        widget = SDUIFlexible();
        break;
      case "form":
        widget = SDUIForm();
        break;
      case "icon":
        widget = SDUIIcon();
        break;
      case "image":
        widget = SDUIImage();
        break;
      case "input":
        widget = SDUInput();
        break;
      case "listview":
        widget = SDUIListView().fromJson(json);
        break;
      case "listitem":
        widget = SDUIListItem().fromJson(json);
        break;
      case "radio":
        widget = SDUIRadio();
        break;
      case "radiogroup":
        widget = SDUIRadioGroup();
        break;
      case "listitemswitch":
        widget = SDUIListItemSwitch().fromJson(json);
        break;
      case "screen":
        widget = SDUIScreen();
        break;
      case "row":
        widget = SDUIRow();
        break;
      case "text":
        widget = SDUIText();
        break;

      default:
        throw Exception("Unsupported node: $type");
    }

    // Attributes
    var attributes = json?["attributes"];
    if (attributes is Map<String, dynamic>) {
      widget.fromJson(attributes);
    }

    // Action
    var action = json?["action"];
    if (action is Map<String, dynamic>) {
      widget.action = SDUIAction().fromJson(action);
    }

    // Children
    if (widget is SDUIComposite) {
      var child = json?["child"];
      if (child is Map<String, dynamic>) {
        widget.children = [SDUIParser.fromJson(child)];
      } else {
        var children = json?["children"];
        if (children is List<dynamic>) {
          widget.children = children.map((e) => _fromJson(e)).toList();
        }
      }
    }

    return widget;
  }

  static SDUIWidget _fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return SDUIParser.fromJson(json);
    } else {
      throw Exception("Bad Json: $json");
    }
  }
}