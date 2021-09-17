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
const String kAnonymous = 'anonymous';
//this is for markers upvoted by user, stored in user collection
const String kUpvotedList = 'upvotedmarkers';
//this is for markers downvoted by user, stored in user collection
const String kDownvotedList = 'downvotedmarkers';
//this is for users who've upvoted the marker, stored in marker collection
const String kUpvotersList = 'upvotingUsers';
//this is for users who've downvoted the marker, stored in marker collection
const String kDownvotersList = 'downvotingUsers';
