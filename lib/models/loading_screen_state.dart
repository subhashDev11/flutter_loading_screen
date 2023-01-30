import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_loading_screen/flutter_loading_screen.dart';

/// The custom state that is used by the Loading Screen widget to handle the
/// messages that are provided by the initializer methods.
///
/// Note: Although the class is not exported from the package as not required by
/// the implementers using the package, the protected meta tag is added to make
/// the code clearer.
@protected
class FlutterLoadingScreenState extends MessageState<FlutterLoadingScreen> {
  /// Initialise the state
  @override
  void initState() {
    super.initState();

    /// If the LoadingScreen widget has an initial message set, then the default
    /// message in the MessageState class needs to be updated
    if (widget.initialMessage != null) {
      initialMessage = widget.initialMessage!;
    }

    /// We require the initializers to run after the loading screen is rendered
    SchedulerBinding.instance.addPostFrameCallback((_) {
      runInitTasks();
    });
  }

  /// This method calls the initializers and once they complete redirects to
  /// the widget provided in navigateAfterInit
  @protected
  Future runInitTasks() async {
    /// Run each initializer method sequentially
    Future.forEach(widget.initializers, (init) => init(this)).whenComplete(() {
      // When all the initializers has been called and terminated their
      // execution. The screen is navigated to the next scaffolding widget
      if (widget.navigateToWidget is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(widget.navigateToWidget);
      } else if (widget.navigateToWidget is Widget) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => widget.navigateToWidget));
      } else {
        throw ArgumentError('widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  /// Render the LoadingScreen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /// Paint the area where the inner widgets are loaded with the
            /// background to keep consistency with the screen background
            Container(
              decoration: BoxDecoration(color: widget.backgroundColor),
            ),

            /// Render the background image
            Visibility(
              visible: widget.image != null,
              child: Container(
                child: widget.image,
              ),
            ),

            /// Render the Title widget, loader and messages below each other
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: kTextTabBarHeight - 10),
                      ),
                      widget.titleWidget ??
                          RichText(
                            text: TextSpan(
                              text: widget.title ?? 'Welcome In Our App',
                              style: widget.titleStyle ??
                                  TextStyle(
                                    color: Colors.transparent.withOpacity(0.7),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Loader Animation Widget
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.loaderColor ?? Theme.of(context).primaryColor,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(getMessage, style: widget.styleTextUnderTheLoader),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
