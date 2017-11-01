using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assecontweb.Classes.Views
{
    public static class css
    {
        public static string style()
        {
            return "<style> " +
                ".span { padding: 2px; display: -webkit-box; border-bottom: 2px solid #428BCA;}" +

                ".radioBtnList { float: left; } " +

                ".radioBtnList input[type=radio]:empty { margin-left: -999px;} " +

                ".radioBtnList input[type=radio]:empty ~ label { " +
                    "position: relative; float: left; " +
                    "line-height: 1.6em; text-indent: 2.2em; " +
                    "cursor: pointer; -webkit-user-select: none; " +
                    "-moz-user-select: none; -ms-user-select: none; " +
                    "user-select: none; margin-right: 20px; padding-bottom: 4px; padding-left: 4px;} " +

                ".radioBtnList input[type=radio]:empty ~ label:before {position: absolute;display: block;top: 0; " +
                    "bottom: 0; left: 0; content: '';  border: 1px solid #ccc; width: 2em; border-radius: 2px;} " +

                ".radioBtnList input[type=radio]:hover:not(:checked) ~ label {color: #0083E0;  text-decoration: underline;} " +

                ".radioBtnList input[type=radio]:checked ~ label:before { " +
                    "_content:'\\2714';content:'\\58';  " +
                    "text-indent: .35em; " +
                    "font-size: 16pt; font-weight: bold; " +
                    "width: 1.26em;} " +

                ".radioBtnList input[type=radio]:checked ~ label {color: #0083E0; padding-bottom: 4px;} " +

                ".ViewsTextbox { " +
                "box-shadow: 1px 1px 3px rgba(194, 194, 194, 1); border: 1px solid #ccc; " +
                "width: 230px; color:#333333; padding:3px; margin-right:4px; margin-bottom:8px; " +
                "color: #0083E0; } " +

                ".ViewsValidator{  color: #FFFFFF; " +
                      "position: absolute; padding: 4px 10px 6px 10px; " +
                      "margin-top: 2px; " +
                      "margin-left: -2px; " +
                      "background: brown; " +
                      "border-radius: 50px; " +
                      "font: 10pt 'Segoe UI', 'Segoe UI Light';} " +

                ".linkButtonEnviar {color: #fff;  background-color: #0086E7;" +
                      "border-color: #357ebd; padding: 6px 12px; " +
                      "line-height: 1.5; text-align: center; " +
                      "white-space: nowrap;vertical-align: middle; " +
                      "cursor: pointer; border-radius: 2px; " +
                      "-webkit-user-select: none;text-decoration: none; " +
                      "display: -webkit-inline-box; } " +

                " </style> ";

        }

        public static string styleNumber()
        {
            return "<style>" +

                 ".Number input[type=radio]:empty { margin-left: -999px; } " +

                 ".Number input[type=radio]:empty ~ label {   position: relative;" +
                      "float: left;" +
                      "line-height: 2em;" +
                      "text-indent: 0.4em;" +
                      "cursor: pointer;" +
                      "-webkit-user-select: none;" +
                      "-moz-user-select: none;" +
                      "-ms-user-select: none;" +
                      "  margin-right: 2px;" +
                      "background: #F3F1F1;" +
                      "padding-right: 10px;" +
                      "padding-left: 6px; " +
                            "border: 1px solid transparent;} " +

                  ".Number input[type=radio]:empty ~ label:before {position: absolute;display: block;top: 0; " +
                    "bottom: 0; left: 0; content: '';   width: 1.7em;} " +

                 ".Number input[type=radio]:hover:not(:checked) ~ label { background: white;} " +

                 ".Number input[type=radio]:checked ~ label { background: white;  border: 1px solid;}" +

                 //".Font_Orange { color: orange !important;}" +

                 //".Font_Red { color: Red  !important; }" +

                 //".Font_Blue { color: #009EFF  !important; }" +

                 "</style>";
        }
    }
}
