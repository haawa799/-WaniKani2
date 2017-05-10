// HHH - Height
// WWW - Width
// FFF - Font scale

var characterStyle = document.createElement("style");
characterStyle.type = "text/css";
characterStyle.innerHTML = "div#character {vertical-align: middle;text-align: center;} div.vocabulary span {font-size: FFF%;height: HHHpx;width: WWWpx;display:table-cell;  vertical-align: middle;  text-align: center;} div.kanji span {font-size: FFF%;height: HHHpx;width: WWWpx;display:table-cell;  vertical-align: middle;  text-align: center;} div.radical span {font-size: FFF%;height: HHHpx;width: WWWpx;display:table-cell;  vertical-align: middle;  text-align: center;}  #question #character.vocabulary {line-height: 0;}";
function ExecuteJavascriptString()
{
  document.getElementsByTagName("head")[0].appendChild(characterStyle);
  return "HI";
}
ExecuteJavascriptString();
