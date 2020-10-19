import 'package:flutter/material.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/helper/utility.dart';
import 'package:flutter_github_connect/ui/theme/custom_theme.dart';
import 'package:flutter_github_connect/ui/theme/theme.dart';
import 'package:flutter_github_connect/ui/widgets/cached_image.dart';
import 'package:flutter_github_connect/ui/widgets/markdown/syntax_highlight.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class MarkdownViewer extends StatelessWidget {
  const MarkdownViewer({Key key, this.markdownData}) : super(key: key);
  final String markdownData;
  _getMarkDownData(String markdownData) {
    RegExp exp = new RegExp(r'!\[.*\]\((.+)\)');
    RegExp expImg = new RegExp("<img.*?(?:>|\/>)");
    RegExp expSrc = new RegExp("src=[\'\"]?([^\'\"]*)[\'\"]?");
    RegExp anchor = new RegExp(r'<a[\s]+([^>]+)>((?:.(?!\<\/a\>))*.)<\/a>');

    String mdDataCode = markdownData;
    try {
      Iterable<Match> tags = exp.allMatches(markdownData);
            var anchorList = anchor.allMatches(markdownData);
      if(anchorList != null && anchorList.length > 0){
        for (Match m in anchorList) {
          String imageMatch = m.group(0);
          if (imageMatch != null && !imageMatch.contains(".svg")) {
            String match = imageMatch.replaceAll("\)", "?raw=true)");
            if (!match.contains(".svg") && match.contains("http")) {
              String src = match
                  .replaceAll(new RegExp(r'!\[.*\]\(.*'), "")
                  .replaceAll(")", "");
                  final Match imgtag = RegExp(r'<img[^>]* src=\"([^\"]*)\"[^>]*>').firstMatch(src);

                  if(imgtag != null){
                   final Match link = RegExp(r'<a[^>]* href=\"([^\"]*)\"[^>]*>').firstMatch(src);
                   src = link.group(0).split("\"")[1];
                    match = imgtag.group(0);
                  }
              //  String actionMatch = "$match$src";
              // match = actionMatch;
              // print(src);
              // print(match);
            } else {
              match = "";
            }
            mdDataCode = mdDataCode.replaceAll(m.group(0), match);
          }
        }
      }

      if (tags != null && tags.length > 0) {
        for (Match m in tags) {
          String imageMatch = m.group(0);
          if (imageMatch != null && !imageMatch.contains(".svg")) {
            String match = imageMatch.replaceAll("\)", "?raw=true)");
            if (!match.contains(".svg") && match.contains("http")) {
              String src = match
                  .replaceAll(new RegExp(r'!\[.*\]\(.*'), "")
                  .replaceAll(")", "");
              String actionMatch = "$match$src";
              match = actionMatch;
            } else {
              match = "";
            }
            mdDataCode = mdDataCode.replaceAll(m.group(0), match);
          }
        }
      }

      tags = expImg.allMatches(markdownData);
      if (tags != null && tags.length > 0) {
        for (Match m in tags) {
          String imageTag = m.group(0);
          String match = imageTag;
          if (imageTag != null) {
            Iterable<Match> srcTags = expSrc.allMatches(imageTag);
            for (Match srcMatch in srcTags) {
              String srcString = srcMatch.group(0);
              if (srcString != null && srcString.contains("http")) {
                String newSrc = srcString.substring(
                        srcString.indexOf("http"), srcString.length - 1) +
                    "?raw=true";

                // match = "[![]($newSrc)]($newSrc)";
                match = "![]($newSrc)";
              }
            }
          }
          mdDataCode = mdDataCode.replaceAll(imageTag, match);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return mdDataCode;
  }

  _getStyleSheet(BuildContext context) {
    MarkdownStyleSheet markdownStyleSheet =
        MarkdownStyleSheet.fromTheme(Theme.of(context));
    return markdownStyleSheet.copyWith(
      codeblockDecoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: Theme.of(context).colorScheme.surface,
        border: new Border.all(
          color: Theme.of(context).disabledColor,
          width: 0.3,
        ),
      ),
      blockquoteDecoration: new BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: Theme.of(context).colorScheme.surface,
        border: new Border.all(
          color: Theme.of(context).disabledColor,
          width: 0.3,
        ),
      ),
      blockquote: Theme.of(context).textTheme.subtitle2,
    );
  }

  Widget _getImageBuilder(Uri uri) {
    return uri != null && !uri.path.contains("svg")
        ? customNetworkImage(
            uri.toString(),
            fit: BoxFit.fill,
            progressIndicatorBuilder: SizedBox(),
          )
        : uri.path.contains("svg")
            ? SvgPicture.network(
                uri.toString(),
                semanticsLabel: 'Image',
                placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  height: 20,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Text("Loading image");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: new MarkdownBody(
          styleSheet: _getStyleSheet(context),
          syntaxHighlighter: new GHighlighter(isDarkMode : CustomTheme.instanceOf(context).isDarkMode),
          imageBuilder: (uri, text, val) => _getImageBuilder(uri),
          data: _getMarkDownData(markdownData),
          onTapLink: (String source) {
            // launch(source, statusBarBrightness: Theme.of(context).brightness,enableJavaScript: true);
            Utility.launchURL(context,source);
          },
        ),
      ),
    );
  }
}

class SubscriptSyntax extends md.InlineSyntax {
  static final _pattern = r'_([0-9]+)';

  SubscriptSyntax() : super(_pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('sub', match[1]));
    return true;
  }
}

class GHighlighter extends SyntaxHighlighter {
  final bool isDarkMode;

  GHighlighter({this.isDarkMode});
  @override
  TextSpan format(String source) {
    String showSource = source.replaceAll("&lt;", "<");
    showSource = showSource.replaceAll("&gt;", ">");
    return new DartSyntaxHighlighter(null,isDarkMode).format(showSource);
  }
}

// class TestMarkdownPage extends StatelessWidget {
//   const TestMarkdownPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(),
//       body: MarkdownViewer(markdownData: readme,),
//     );
//   }
// }