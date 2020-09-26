import 'git_config.dart';

class Config{
  static const String appName = "SpaceXopedia";
  static const String authUrl = "https://github.com/login/oauth/authorize?client_id=";
  static const String accessTken = "https://github.com/login/oauth/access_token?client_id=${GitConfig.CLIENT_ID}&client_secret=${GitConfig.CLIENT_SECRET}&code=";
  static const String apiBaseUrl = "https://api.github.com/";
  static const String user = "user";
  static const String repos = "user/repos";
  static String notificationsList({String since = "2010-03-29T18:46:19Z", int pageNo = 1}){
    return "notifications?all=true&participating=true&since=$since&per_page=10&page=$pageNo";
  }

  static String getEvent({userName,int pageNo = 1}) {
    return "users/$userName/events?per_page=20&page=$pageNo";
  }
  static String getReadme({String name, String owner}) {
    return "https://raw.githubusercontent.com/$owner/$name/master/README.md";
  }
  static String getGistDetail(String id){
    return "gists/$id";
  }
}
const readme = r'''## Fwitter - Flutter Based Twitter Clone ![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Ftwitter.com%2Fthealphamerc) [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_twitter_clone?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_twitter_clone) ![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/flutter_twitter_clone?style=social) 
![Dart CI](https://github.com/TheAlphamerc/flutter_twitter_clone/workflows/Dart%20CI/badge.svg) ![GitHub pull requests](https://img.shields.io/github/issues-pr/TheAlphamerc/flutter_twitter_clone) ![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/Thealphamerc/flutter_twitter_clone) ![GitHub last commit](https://img.shields.io/github/last-commit/Thealphamerc/flutter_twitter_clone)  ![GitHub issues](https://img.shields.io/github/issues-raw/Thealphamerc/flutter_twitter_clone) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/Thealphamerc/flutter_twitter_clone) 

A working Twitter clone written in Flutter using Firebase auth,realtime,firestore database and storage.


## Download App
<a href="https://play.google.com/store/apps/details?id=com.thealphamerc.flutter_twitter_clone"><img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" width="200"></img></a>



## Features
* App features is mentioned at project section [ Click here](https://github.com/TheAlphamerc/flutter_twitter_clone/projects/1)
* Messaging chat section status can be seen at [here](https://github.com/TheAlphamerc/flutter_twitter_clone/projects/2)

 :boom: Fwitter app now uses both firebase `realtime` and `firestore` database.:boom:
* In branch **firetore** Fwitter uses `Firestore` database for app. 
* In branch **Master** and **realtime_db** Fwitter uses `Firebase Realtime` database for app.


## Dependencies
<details>
     <summary> Click to expand </summary>
     
* [intl](https://pub.dev/packages/intl)
* [uuid](https://pub.dev/packages/uuid)
* [http](https://pub.dev/packages/http)
* [share](https://pub.dev/packages/share)
* [provider](https://pub.dev/packages/provider)
* [url_launcher](https://pub.dev/packages/url_launcher)
* [google_fonts](https://pub.dev/packages/google_fonts)
* [image_picker](https://pub.dev/packages/image_picker)
* [firebase_auth](https://pub.dev/packages/firebase_auth)
* [google_sign_in](https://pub.dev/packages/google_sign_in)
* [firebase_analytics](https://pub.dev/packages/firebase_analytics)
* [firebase_database](https://pub.dev/packages/firebase_database)
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [flutter_advanced_networkimage](https://pub.dev/packages/flutter_advanced_networkimage)
     
</details>

## Screenshots

Welcome Page               |  Login Page               | Signup Page               |  Forgot Password Page
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Auth/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Auth/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Auth/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Auth/screenshot_4.jpg?raw=true)|

Home Page Sidebaar         |  Home Page       |   Home Page               |  Home Page
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Home/screenshot_5.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Home/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Home/screenshot_7.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Home/screenshot_6.jpg?raw=true)|

Compose Tweet Page                  | Reply To Tweet       |   Reply to Tweet      |     Compose Retweet with comment
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/CreateTweet/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/CreateTweet/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/CreateTweet/screenshot_4.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/CreateTweet/screenshot_3.jpg?raw=true)|

Tweet Detail Page         |  Tweet Thread              |   Nested Tweet Thread     | Tweet options
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/TweetDetail/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/TweetDetail/screenshot_4.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/TweetDetail/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/TweetDetail/screenshot_2.jpg?raw=true)|

Notification Page         |  Notification Page         |   Notification Page       | Notification Setting Page
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Notification/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Notification/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Notification/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Notification/screenshot_4.jpg?raw=true)|

Profile Page                |  Profile Page            |   Profile  Page       | Profile  Page
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Profile/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Profile/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Profile/screenshot_4.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Profile/screenshot_7.jpg?raw=true)|

Select User Page                |  Chat Page            |    Chat Users List       | Conversation Info Page
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Chat/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Chat/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Chat/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Chat/screenshot_4.jpg?raw=true)|

Search Page                |  Search Setting Page            |  Tweet Options - 1     | Tweet Options - 2
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Search/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Search/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/TweetDetail/screenshot_5.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/TweetDetail/screenshot_6.jpg?raw=true)|


Setting Page                |  Account Setting Page    |  Privacy Setting Page    | Privacy Settings Page
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_4.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_3.jpg?raw=true)|

Content Prefrences Page      |  Display Setting Page    |  Data Settings Page    | Accessibility Settings
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_5.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_6.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_7.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_twitter_clone/blob/master/screenshots/Settings/screenshot_8.jpg?raw=true)|






## Getting started 
* Project setup instructions are given at [Wiki](https://github.com/TheAlphamerc/flutter_twitter_clone/wiki/Gettings-Started) section.

## Directory Structure
<details>
     <summary> Click to expand </summary>
  
```
|-- lib
|   |-- helper
|   |   |-- constant.dart
|   |   |-- customRoute.dart
|   |   |-- enum.dart
|   |   |-- routes.dart
|   |   |-- theme.dart
|   |   |-- utility.dart
|   |   '-- validator.dart
|   |-- main.dart
|   |-- model
|   |   |-- chatModel.dart
|   |   |-- feedModel.dart
|   |   |-- notificationModel.dart
|   |   '-- user.dart
|   |-- page
|   |   |-- Auth
|   |   |   |-- forgetPasswordPage.dart
|   |   |   |-- selectAuthMethod.dart
|   |   |   |-- signin.dart
|   |   |   |-- signup.dart
|   |   |   |-- verifyEmail.dart
|   |   |   '-- widget
|   |   |       '-- googleLoginButton.dart
|   |   |-- common
|   |   |   |-- sidebar.dart
|   |   |   |-- splash.dart
|   |   |   |-- usersListPage.dart
|   |   |   '-- widget
|   |   |       '-- userListWidget.dart
|   |   |-- feed
|   |   |   |-- composeTweet
|   |   |   |   |-- composeTweet.dart
|   |   |   |   |-- state
|   |   |   |   |   '-- composeTweetState.dart
|   |   |   |   '-- widget
|   |   |   |       |-- composeBottomIconWidget.dart
|   |   |   |       |-- composeTweetImage.dart
|   |   |   |       '-- widgetView.dart
|   |   |   |-- feedPage.dart
|   |   |   |-- feedPostDetail.dart
|   |   |   '-- imageViewPage.dart
|   |   |-- homePage.dart
|   |   |-- message
|   |   |   |-- chatListPage.dart
|   |   |   |-- chatScreenPage.dart
|   |   |   |-- conversationInformation
|   |   |   |   '-- conversationInformation.dart
|   |   |   '-- newMessagePage.dart
|   |   |-- notification
|   |   |   '-- notificationPage.dart
|   |   |-- profile
|   |   |   |-- EditProfilePage.dart
|   |   |   |-- follow
|   |   |   |   |-- followerListPage.dart
|   |   |   |   '-- followingListPage.dart
|   |   |   |-- profileImageView.dart
|   |   |   |-- profilePage.dart
|   |   |   '-- widgets
|   |   |       '-- tabPainter.dart
|   |   |-- search
|   |   |   '-- SearchPage.dart
|   |   '-- settings
|   |       |-- accountSettings
|   |       |   |-- about
|   |       |   |   '-- aboutTwitter.dart
|   |       |   |-- accessibility
|   |       |   |   '-- accessibility.dart
|   |       |   |-- accountSettingsPage.dart
|   |       |   |-- contentPrefrences
|   |       |   |   |-- contentPreference.dart
|   |       |   |   '-- trends
|   |       |   |       '-- trendsPage.dart
|   |       |   |-- dataUsage
|   |       |   |   '-- dataUsagePage.dart
|   |       |   |-- displaySettings
|   |       |   |   '-- displayAndSoundPage.dart
|   |       |   |-- notifications
|   |       |   |   '-- notificationPage.dart
|   |       |   |-- privacyAndSafety
|   |       |   |   |-- directMessage
|   |       |   |   |   '-- directMessage.dart
|   |       |   |   '-- privacyAndSafetyPage.dart
|   |       |   '-- proxy
|   |       |       '-- proxyPage.dart
|   |       |-- settingsAndPrivacyPage.dart
|   |       '-- widgets
|   |           |-- headerWidget.dart
|   |           |-- settingsAppbar.dart
|   |           '-- settingsRowWidget.dart
|   |-- state
|   |   |-- appState.dart
|   |   |-- authState.dart
|   |   |-- chats
|   |   |   '-- chatState.dart
|   |   |-- feedState.dart
|   |   |-- notificationState.dart
|   |   '-- searchState.dart
|   '-- widgets
|       |-- bottomMenuBar
|       |   |-- HalfPainter.dart
|       |   |-- bottomMenuBar.dart
|       |   '-- tabItem.dart
|       |-- customAppBar.dart
|       |-- customWidgets.dart
|       |-- newWidget
|       |   |-- customClipper.dart
|       |   |-- customLoader.dart
|       |   |-- customProgressbar.dart
|       |   |-- customUrlText.dart
|       |   |-- emptyList.dart
|       |   |-- rippleButton.dart
|       |   '-- title_text.dart
|       '-- tweet
|           |-- tweet.dart
|           '-- widgets
|               |-- parentTweet.dart
|               |-- retweetWidget.dart
|               |-- tweetBottomSheet.dart
|               |-- tweetIconsRow.dart
|               |-- tweetImage.dart
|               '-- unavailableTweet.dart
|-- pubspec.yaml
```

</details>
   

<img align="left" src = "https://profile-counter.glitch.me/flutter_twitter_clone/count.svg" alt ="Loading">
''';
const code = r'''
``` dartl
class RepositoryListScreen extends StatelessWidget {
  final List<RepositoriesNode> list;
  final bool isFromUserRepositoryListPage;
  final UserBloc userBloc;
  final PeopleBloc peopleBloc;
  final ScrollController controller;
  final String login;
  final int val;
  final double fa;
  final num das;
  final bool sdsd;

  static MaterialPageRoute getPageRoute(
      {ScrollController controller,
      List<RepositoriesNode> list,
      UserBloc userBloc,
      PeopleBloc peopleBloc,
      String login}) {
    return MaterialPageRoute(
      builder: (_) => RepositoryListScreen(
        list: list,
        controller: controller,
        userBloc: userBloc,
        peopleBloc: peopleBloc,
        login: login,
      ),
    );
  }

  /// `isFromUserRepositoryListPage` should be set to true if this screen is used as widget
  const RepositoryListScreen({
    Key key,
    this.list,
    this.isFromUserRepositoryListPage = false,
    this.controller,
    this.userBloc,
    this.peopleBloc,
    this.login,
  }) : super(key: key);

  Widget repoCard(context, RepositoriesNode repo) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAvatar(
            subtitle: repo.owner.login,
            imagePath: repo.owner.avatarUrl,
            titleStyle: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 16),
          Text(
            repo.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 4),
          Text(
            repo.description ?? "N/A",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 16),
          repo.languages.nodes.isEmpty
              ? SizedBox()
              : Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Icon(Icons.star,
                          size: 20, color: Colors.yellowAccent[700]),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${repo.stargazers.totalCount}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.blur_circular,
                      color: repo.languages.nodes.first.color,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${repo.languages.nodes.first.name}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
        ],
      ),
    ).ripple(() {
      Navigator.of(context).push(RepoDetailPage.getPageRoute(
        context,
        name: repo.name,
        owner: repo.owner.login,
      ));
    });
  }

  Widget _repoList(List<RepositoriesNode> list, {bool displayLoader = false}) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      controller: controller ?? ScrollController(),
      itemCount: list.length + 1,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
      itemBuilder: (BuildContext context, int index) {
        if ((index >= list.length && !isFromUserRepositoryListPage) &&
            (peopleBloc != null || userBloc != null)) {
          print("Fetching user's repositories");
          return displayLoader ? GCLoader() : SizedBox.shrink();
        } else if (index >= list.length && isFromUserRepositoryListPage) {
          print("Fetching more repositories");
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is LoadingNextSearchState) return GCLoader();

              return SizedBox.shrink();
            },
          );
        }
        final repo = list[index];
        return repoCard(context, repo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFromUserRepositoryListPage
          ? null
          : AppBar(title: GAppBarTitle(login: login, title: "Repositories"),),
      body: !(list != null && list.isNotEmpty)
          ? NoDataPage(
                title: "No repo Found",
                description: "$login haven't created any repo yet",
                icon: GIcons.github_1,
              )
          : !isFromUserRepositoryListPage
              ? peopleBloc != null
                  ? BlocBuilder<PeopleBloc, people.PeopleState>(
                      cubit: peopleBloc,
                      buildWhen: (old, newState) {
                        return (old != newState);
                      },
                      builder: (context, state) {
                        bool displayLoader = false;
                        if (state is people.LoadingNextRepositoriesState)
                          displayLoader = true;
                        if (state is people.LoadedUserState) {
                          return _repoList(state.user.repositories.nodes,
                              displayLoader: displayLoader);
                        } else {
                          return GLoader();
                        }
                      },
                    )
                  : BlocBuilder<UserBloc, UserState>(
                      cubit: userBloc,
                      buildWhen: (old, newState) {
                        return (old != newState);
                      },
                      builder: (context, state) {
                        bool displayLoader = false;
                        if (state is LoadingNextRepositoriesState)
                          displayLoader = true;
                        if (state is LoadedUserState) {
                          return _repoList(state.user.repositories.nodes,
                              displayLoader: displayLoader);
                        } else {
                          return GLoader();
                        }
                      },
                    )
              : _repoList(list),
    );
  }
}
```
### 3. How to use FilterList


#### Create a list of Strings
```dart
  List<String> countList = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Tweleve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen",
    "Twenty"
  ];
  List<String> selectedCountList = [];
```
#### Create a function and call `FilterListDialog.display()` on button clicked
```dart
  void _openFilterDialog() async {
    await FilterListDialog.display(
      context,
      allTextList: countList,
      height: 480,
      borderRadius: 20,
      headlineText: "Select Count",
      searchFieldHintText: "Search Here",
      selectedTextList: selectedCountList,
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedCountList = List.from(list);
          });
        }
        Navigator.pop(context);
      });
  }
```
#### Call `_openFilterDialog` function on `floatingActionButton` pressed to display filter dialog

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openFilterDialog,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        /// check for empty or null value selctedCountList
        body: selectedCountList == null || selectedCountList.length == 0
            ? Center(
                child: Text('No text selected'),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedCountList[index]),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: selectedCountList.length));
  }
```
#### To display filter widget use `FilterListWidget` and pass list of strings to it.

```dart
class FilterPage extends StatelessWidget {
  const FilterPage({Key key, this.allTextList}) : super(key: key);
  final List<String> allTextList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter list Page"),
      ),
      body: SafeArea(
        child: FilterListWidget(
          allTextList: allTextList,
          height: MediaQuery.of(context).size.height,
          hideheaderText: true,
          onApplyButtonClick: (list) {
            if(list != null){
              print("selected list length: ${list.length}");
            }
          },
        ),
      ),
    );
  }
}
```
## Screenshots


No selected text from list |  FilterList widget        |  Make selection           |  Selected text from list
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_1.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_2.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_3.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_4.jpg?raw=true)|

Hidden close Icon    |  Hidden text field     |  Hidden header text    |  Hidden full header
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_5.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_6.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_7.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_8.jpg?raw=true)|

Customised control button |Customised selected text |Customised unselected text  |Customised text field background color
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_9.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_10.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_12.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_11.jpg?raw=true)|


FilterListWidget |N/A |N/A |N/A
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_14.jpg?raw=true" width="200"></img>|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_101.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_121.jpg?raw=true)|![](https://github.com/TheAlphamerc/flutter_plugin_filter_list/blob/master/screenshots/screenshot_111.jpg?raw=true)|



### Parameters and Value

 `height` Type: **double**
* Set height of filter dialog.

`width` Type: **double**
* Set width of filter dialog.

`borderRadius` Type: **double**
* Set border radius of filter dialog.

`allTextList` Type: **List\<String>()**
* Populate filter dialog with text list.

`selectedTextList` Type: **List\<String>()**
* Marked selected text in filter dialog.

`headlineText` Type: **String**
* Set header text of filter dialog.

`searchFieldHintText` Type: **String**
* Set hint text in search field.

`hideSelectedTextCount` Type: **bool**
* Hide selected text count.

 `hideSearchField` Type: **bool**
* Hide search text field.

`hidecloseIcon` Type: **bool**
* Hide close Icon.

`hideheader` Type: **bool**
* Hide complete header section from filter dialog.

`closeIconColor` Type: **Color**
* set color of close Icon.

`headerTextColor` Type: **Color**
* Set color of header text.

`applyButonTextColor` Type: **Color**
* Set text color of apply button.

 `applyButonTextBackgroundColor` Type: **Color**
* Set background color of apply button.

`allResetButonColor` Type: **Color**
* Set text color of all and reset button.

`selectedTextColor` Type: **Color**
* Set color of selected text in filter dialog.

`selectedTextBackgroundColor` Type: **Color**
* Set background color of selected text field.

`unselectedTextbackGroundColor` Type: **Color**
* Set background color of unselected text field.

`unselectedTextColor` Type: **Color**
* Set text color of unselected text in filter dialog

`searchFieldBackgroundColor` Type: **Color**
* Set background color of Search field.

`backgroundColor` Type: **Color**
* Set background color of filter color.

`onApplyButtonClick` Type **Function(List<String>)**
 * Returns list of strings when apply button is clicked 

## Flutter plugins
Plugin Name        | Stars        
:-------------------------|-------------------------
|[Empty widget](https://github.com/TheAlphamerc/empty_widget) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/empty_widget?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%empty_widget)
|[Add Thumbnail](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail) |[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_add_thumbnail?style=social)](https://github.com/login?return_to=%2FTheAlphamerc%flutter_plugin_add_thumbnail)

''';