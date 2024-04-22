# Food Finder

## Student Information
Name: Dhruv Bansal

CSE netid: dhvbnl

email: dhvbnl@uw.edu

## Design Vision
Tell us about what your design vision was.
 - Functionally
    My vision for the functionality of my app was to provide the user with a ton of information about each place
    as well as give them ways to move forward with their choice. I wanted to let them find a choice and then take
    the next step. This meant allowing them to call, go to their website, or simply navigate using a navigation app.
 - Aesthetically
    I wanted to create a cohesive theme that emobodied Seattle as the app is just for this area. This meant using a 
    default green as the base of my app and themeing it from there. I also tried to given mutliple options at once so
    that it doesn't feel limiting but it's also not too much. With my map, I wanted to create a dynamic view that could
    feel personal especially with my choice to include current location. 
 - How are you nudging people toward patios on sunny days?
    I'm nudging people towards patios on sunny days by changing the colors of certain elements. On the main list view,
    this comprises of creating a darker color for the places without patios so that implicitly people are attracted to
    the lighter tiles. On the map, I grayed out the places without a patio. They are still accessible, but they seem
    'worse' therefore nudging them to those with patios. 

Where in your repo can we find the sketches that you made? 
assets folder

If your final design changed from your initial sketches please explain what changed and why.
My design mostly stayed the same throughout. Halfway through it, I realized I wanted more data than the standard JSON
that was shared. This resulted in me adding review data as well. For the map view, I freestyled most of it. I did know
for sure I wanted some marker over the locations, but I wasn't sure what I had access to in flutter. Eventually I realzied
it made the most sense to create a little pop up window which is what you can see right now. 

## Resources Used
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all online resources (other than information learned in lecture or section and android documentation) such as Stack Overflow, other blogs, students in this class, or TAs and instructors who helped you during Office Hours. If you did not use any such resources, please state so explicitly.

Answer here:

Packages and functions: 
https://github.com/shawnchan2014/haversine-dart
https://pub.dev/packages/geolocator
https://pub.dev/packages/google_fonts
https://pub.dev/packages/flutter_platform_widgets
https://pub.dev/packages/platform_maps_flutter
https://pub.dev/packages/flutter_map_location_marker
https://pub.dev/packages/url_launcher
https://pub.dev/packages/auto_size_text
https://pub.dev/packages/flutter_launcher_icons
https://github.com/lpongetti/flutter_map_marker_cluster?tab=readme-ov-file

Articles and Blogs:
https://stackoverflow.com/questions/28419255/how-do-you-round-a-double-in-dart-to-a-given-degree-of-precision-after-the-decim
https://stackoverflow.com/questions/52489458/how-to-change-status-bar-color-in-flutter
https://stackoverflow.com/questions/70922830/flutter-how-can-i-add-dynamic-number-of-columns-depending-on-device-width-or-or
https://www.edureka.co/community/234752/how-to-dynamically-resize-text-in-flutter#:~:text=You%20can%20use%20the%20FittedBox,properties%20of%20the%20Text%20widget.
https://raphaeldelio.medium.com/getting-started-with-flutter-map-9cf4113f22e9
https://stackoverflow.com/questions/73709040/manage-the-position-of-showmenu-in-flutter
https://stackoverflow.com/questions/70193457/flutter-gesturedector-on-tap-doesnt-work-with-popupmenubutton
https://stackoverflow.com/questions/65822604/fittedbox-with-maximum-two-lines-in-flutter
https://stackoverflow.com/questions/51587003/how-to-center-only-one-element-in-a-row-of-2-elements-in-flutter
https://stackoverflow.com/questions/43928702/how-to-change-the-application-launcher-icon-on-flutter

Online Tools:
https://gmapsextractor.com/
https://jsonformatter.org
https://perchance.org/ai-icon-generator
https://www.appicon.co/#app-icon


Data Source:
https://www.google.com/maps

Various:
Adit and Lauren helped in 4/19 section, with follow up help from Ben on EdStem in order to remove errors from PositionProvider
Initially used Shared JSON file as well as AI(chat gpt) to reformat

## Reflection Prompts

### New Learnings
What new tools, techniques, or other skills did you learn while doing this assignment?

How do you think you might use what you learned in the future?

Answer here:
I used a ton of new tools and tecniques in this project. The main tool I learned about was how to integreate geolocator into
the project. I had to understand how to set up an async function in order to allow the app to run while the location data was still coming in. Another skill I improved on a lot was my general understanding of the flutter framework and how to combine my work with
everything else surrounding my own code. I dove into the code behind the specific plaform codes in order to create slighly different
Uis depending on whether the app was being run on android or iOS. I also learned about how packages work in flutter so that I could
use that to abtract some of the code away.  

## Challenges
What was hard about doing this assignment?
What did you learn from working through those challenges?
How could the assignment be improved for future years?

Answer here:
One of the hardest parts of this assignment was desinging for robustness. With the amount of data that we were dealing with, it was
important to add certain 'catches'. This included adding a default view if location was not found. I also wanted to make this app
as compatible as possible which required adding conditions for certain other devices. This included exmpanding the UI if the width
is more than the height. It also requires making sure the UI doesn't go over certain elements in devices like the bar at the top of
iPhones, or navigation elements at the bottom of most phones. I learned a lot of about the differences in devices that are important to
account for as well as for extranous data. 

I believe this assignment could be improved in future years by providing some more links to read more about some of the tools we are 
using. This could make it easier to go deeper into those and implement some of the other features that they provide.


### Mistakes
What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

Answer here:
One mistake that I made while completing this assignment was when creating the PositionProvider. I did not fully understand how to
catch the errors that the _determinePosition function may throw leading the app to freeze. In the future, I want to try to read more
of the documentation behind functions from other packages so that I am prepared for any error that may come. I'd rather be able to
understand the error and what causes it as opposed to just finding some solution on stackOverflow. 

### Optional Challenges
Tell us about what you did, learned, and struggled with while tackling some of the optional challenges.