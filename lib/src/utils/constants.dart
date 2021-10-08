enum Screens {
  logInScreen,
  signUpScreen,
  forgotPasswordScreen,
}
enum VoteStatus {
  upvoted,
  notVoted,
  downvoted,
}

const double kDefaultPadding = 15;

//path for image assets
const String imageAssetpath = 'assets/images/';

//consts for google map camera positionszoom: 17,tilt: 60,
const double kZoom = 17;
const double kTilt = 60;

//constant distance for checking distance
const double kCheckDistance = 4000;

//constant name for anonymous user
const String kAnonymous = 'anonymous';

//this is for markers upvoted by user, stored in user collection
const String kUpvotedList = 'upvotedmarkers';
//this is for markers downvoted by user, stored in user collection
const String kDownvotedList = 'downvotedmarkers';
//this is for users who've upvoted the marker, stored in marker collection
const String kUpvotersList = 'upvotingUsers';
//this is for users who've downvoted the marker, stored in marker collection
const String kDownvotersList = 'downvotingUsers';
