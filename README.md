## flutter-GitConnect ![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2Fthealphamerc) [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter-GitConnect?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter-GitConnect) ![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter-GitConnect?style=social) 
![GitHub pull requests](https://img.shields.io/github/issues-pr/TheAlphamerc/flutter-GitConnect) ![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/Thealphamerc/flutter-GitConnect) ![GitHub last commit](https://img.shields.io/github/last-commit/Thealphamerc/flutter-GitConnect)  ![GitHub issues](https://img.shields.io/github/issues-raw/Thealphamerc/flutter-GitConnect) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/Thealphamerc/flutter-GitConnect) 

Github mobile app built in flutter framwork.


## Download App
Stable release build will be available soon..


## Dependencies
<details>
     <summary> Click to expand </summary>
     
* [intl](https://pub.dev/packages/intl)
* [dio](https://pub.dev/packages/dio)
* [share](https://pub.dev/packages/share)
* [get_it](https://pub.dev/packages/get_it)
* [graphql](https://pub.dev/packages/graphql)
* [equatable](https://pub.dev/packages/equatable)
* [flutter_bloc](https://pub.dev/packages/flutter_bloc)
* [url_launcher](https://pub.dev/packages/url_launcher)
* [google_fonts](https://pub.dev/packages/google_fonts)
* [build_context](https://pub.dev/packages/build_context)
* [webview_flutter](https://pub.dev/packages/webview_flutter)
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [cached_network_image](https://pub.dev/packages/cached_network_image)
     
</details>


## Features

* Login with Github account
* Activities          
* Contribution graph.
* Markdown and code highlighting support
* Notifications
* Repositories
* Issues and Pull Requests
* See your public, private and forked Repos
* Search users/orgs, repos, issues/prs & code.
* See repo stargazerrs and fork Repos
* PRs statuses
* Gists
* Themes mode   
* Following/Followers
* View Gists and their files
* View user profile, contribution graph, activities, repositories, pullrequest and issues
* Search Users, Repos, Issues,Pull Requests and Code

## Project structure
<details>
     <summary> Click to expand </summary>
     
```
|      
|-- lib
|   |-- app_delegate.dart
|   |-- bloc
|   |   |-- User
|   |   |   |-- User_bloc.dart
|   |   |   |-- User_event.dart
|   |   |   |-- User_model.dart
|   |   |   |-- User_state.dart
|   |   |   |-- index.dart
|   |   |   '-- model
|   |   |       |-- event_model.dart
|   |   |       '-- gist_model.dart
|   |   |-- auth
|   |   |   |-- auth_bloc.dart
|   |   |   |-- auth_event.dart
|   |   |   |-- auth_state.dart
|   |   |   '-- index.dart
|   |   |-- bloc
|   |   |   |-- repo_bloc.dart
|   |   |   |-- repo_event.dart
|   |   |   |-- repo_response_model.dart
|   |   |   '-- repo_state.dart
|   |   |-- gist
|   |   |   |-- gist_bloc.dart
|   |   |   |-- gist_event.dart
|   |   |   '-- gist_state.dart
|   |   |-- issues
|   |   |   |-- index.dart
|   |   |   |-- issues_bloc.dart
|   |   |   |-- issues_event.dart
|   |   |   |-- issues_model.dart
|   |   |   '-- issues_state.dart
|   |   |-- navigation
|   |   |   |-- index.dart
|   |   |   |-- navigation_bloc.dart
|   |   |   |-- navigation_event.dart
|   |   |   '-- navigation_state.dart
|   |   |-- notification
|   |   |   |-- index.dart
|   |   |   |-- notification_bloc.dart
|   |   |   |-- notification_event.dart
|   |   |   |-- notification_model.dart
|   |   |   '-- notification_state.dart
|   |   |-- people
|   |   |   |-- index.dart
|   |   |   |-- people_bloc.dart
|   |   |   |-- people_event.dart
|   |   |   |-- people_model.dart
|   |   |   '-- people_state.dart
|   |   |-- pullrequest
|   |   |   |-- index.dart
|   |   |   |-- pullrequest_bloc.dart
|   |   |   |-- pullrequest_event.dart
|   |   |   '-- pullrequest_state.dart
|   |   '-- search
|   |       |-- index.dart
|   |       |-- model
|   |       |   '-- search_userModel.dart
|   |       |-- repo_model.dart
|   |       |-- search_bloc.dart
|   |       |-- search_event.dart
|   |       '-- search_state.dart
|   |-- exceptions
|   |   '-- exceptions.dart
|   |-- helper
|   |   |-- GIcons.dart
|   |   |-- config.dart
|   |   |-- git_config.dart.template
|   |   |-- shared_prefrence_helper.dart
|   |   '-- utility.dart
|   |-- locator.dart
|   |-- main.dart
|   |-- model
|   |   |-- forks_model.dart
|   |   |-- page_info_model.dart
|   |   '-- pul_request.dart
|   |-- resources
|   |   |-- dio_client.dart
|   |   |-- gatway
|   |   |   |-- api_gatway.dart
|   |   |   '-- api_gatway_impl.dart
|   |   |-- grapgqlApi
|   |   |   |-- gist_api.dart
|   |   |   |-- graphql_query_api.dart
|   |   |   |-- issues_api.dart
|   |   |   |-- people_api.dart
|   |   |   |-- pull_request_api.dart
|   |   |   '-- repo_api.dart
|   |   |-- graphql_client.dart
|   |   |-- repository
|   |   |   |-- User_repository.dart
|   |   |   |-- auth_repository.dart
|   |   |   |-- gist_repository.dart
|   |   |   |-- issues_repository.dart
|   |   |   |-- notification_repository.dart
|   |   |   |-- people_repository.dart
|   |   |   |-- pullrequest_repository.dart
|   |   |   '-- repo_repository.dart
|   |   '-- service
|   |       |-- auth_service.dart
|   |       |-- impl
|   |       |   |-- auth_service_impl.dart
|   |       |   '-- session_service_impl.dart
|   |       '-- session_service.dart
|   '-- ui
|       |-- page
|       |   |-- app.dart
|       |   |-- auth
|       |   |   |-- auth_page.dart
|       |   |   |-- repo
|       |   |   |   '-- repo_list_screen.dart
|       |   |   '-- web_view.dart
|       |   |-- common
|       |   |   |-- dashboard_page.dart
|       |   |   |-- no_data_page.dart
|       |   |   '-- under_development.dart
|       |   | (8 more...)
|       |   |-- splash.dart
|       |   |-- user
|       |   |   |-- User_page.dart
|       |   |   |-- User_screen.dart
|       |   |   |-- gist
|       |   |   |   |-- gist_detail.dart
|       |   |   |   |   |-- gist_detail_page.dart
|       |   |   |   |   |-- gist_detail_scree.dart
|       |   |   |   |   '-- gist_file_content.dart
|       |   |   |   |-- gist_list_page.dart
|       |   |   |   '-- gist_list_screen.dart
|       |   |   '-- widget
|       |   |       '-- git_contribution_graph.dart
|       |   '-- welcome_page.dart
|       |-- theme
|       |   |-- app_theme_provider.dart
|       |   |-- color
|       |   |   '-- dark_color.dart
|       |   |-- colors.dart
|       |   |-- custom_theme.dart
|       |   |-- export_theme.dart
|       |   |-- extentions.dart
|       |   |-- images.dart
|       |   |-- texttheme
|       |   |   '-- text_theme.dart
|       |   '-- theme.dart
|       '-- widgets
|           |-- bottom_navigation_bar.dart
|           |-- cached_image.dart
|           |-- flat_button.dart
|           | (5 more...)
|           |-- g_user_tile.dart
|           |-- markdown
|           |   |-- markdown_viewer.dart
|           |   '-- syntax_highlight.dart
|           '-- user_image.dart
|-- pubspec.yaml

```    
</details>
     
## Contributing

If you wish to contribute a change to any of the existing feature or add new in this repo,
Send a [pull request](https://github.com/TheAlphamerc/flutter-GitConnect/pulls). I welcome and encourage all pull requests. It usually will take me within 24 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/)) ([Insta](https://www.instagram.com/_sonu_sharma__)) ([Dev.to](https://dev.to/thealphamerc))
  ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social) 

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>
> * [PayPal](https://paypal.me/TheAlphamerc/)

## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/flutter-GitConnect/count.svg" alt ="Loading">
