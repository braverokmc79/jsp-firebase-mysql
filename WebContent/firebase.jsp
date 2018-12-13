<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Learn how to use the Firebase platform on the Web">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Friendly Chat</title>
  <!-- Disable tap highlight on IE -->
  <meta name="msapplication-tap-highlight" content="no">

  <!-- Web Application Manifest -->
  <link rel="manifest" href="/scripts/manifest.json">

  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="application-name" content="Friendly Chat">
  <meta name="theme-color" content="#303F9F">

  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
  <meta name="apple-mobile-web-app-title" content="Friendly Chat">
  <meta name="apple-mobile-web-app-status-bar-style" content="#303F9F">

  <!-- Tile icon for Win8 -->
  <meta name="msapplication-TileColor" content="#3372DF">
  <meta name="msapplication-navbutton-color" content="#303F9F">

  <!-- Material Design Lite -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
  <link rel="stylesheet" href="https://code.getmdl.io/1.1.3/material.orange-indigo.min.css">
  <script defer src="https://code.getmdl.io/1.1.3/material.min.js"></script>

  <!-- App Styling -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
  <link rel="stylesheet" href="styles/main.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
</head>
<body>
<div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-header">

  <!-- Header section containing logo -->
  <header class="mdl-layout__header mdl-color-text--white mdl-color--light-blue-700">
    <div class="mdl-cell mdl-cell--12-col mdl-cell--12-col-tablet mdl-grid">
      <div class="mdl-layout__header-row mdl-cell mdl-cell--12-col mdl-cell--12-col-tablet mdl-cell--12-col-desktop">
        <h3><i class="material-icons">chat_bubble_outline</i> Friendly Chat</h3>
      </div>
      <div id="user-container">
        <div hidden id="user-pic"></div>
        <div hidden id="user-name"></div>
        <button hidden id="sign-out" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-color-text--white">
          로그아웃
        </button>
        <button hidden id="sign-in" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-color-text--white">
          <i class="material-icons">account_circle</i>Google 로그인
        </button>
      </div>
    </div>
  </header>

  <main class="mdl-layout__content mdl-color--grey-100">
    <div id="messages-card-container" class="mdl-cell mdl-cell--12-col mdl-grid">

      <!-- Messages container -->
      <div id="messages-card" class="mdl-card mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-cell--6-col-tablet mdl-cell--6-col-desktop">
        <div class="mdl-card__supporting-text mdl-color-text--grey-600">
          <div id="messages">
            <span id="message-filler"></span>
          </div>
          <form id="message-form" action="#">
            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
              <input class="mdl-textfield__input" type="text" id="message">
              <label class="mdl-textfield__label" for="message">Message...</label>
            </div>
            <button id="submit" disabled type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
              전송
            </button>
          </form>
          <form id="image-form" action="#">
            <input id="mediaCapture" type="file" accept="image/*" capture="camera">
            <button id="submitImage" title="Add an image" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-color--amber-400 mdl-color-text--white">
              <i class="material-icons">image</i>
            </button>
          </form>
        </div>
      </div>

      <div id="must-signin-snackbar" class="mdl-js-snackbar mdl-snackbar">
        <div class="mdl-snackbar__text"></div>
        <button class="mdl-snackbar__action" type="button"></button>
      </div>

    </div>
  </main>
</div>


<!-- Firebase App is always required and must be first -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-app.js"></script>

<!-- Add additional services that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-messaging.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-functions.js"></script>

<!-- Comment out (or don't include) services that you don't want to use -->
<!-- <script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-storage.js"></script> -->


<script src="https://www.gstatic.com/firebasejs/5.7.0/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyCpyxgb1w-qRUDDNBs7Id123NmaGomQlGQ",
    authDomain: "juhofcm.firebaseapp.com",
    databaseURL: "https://juhofcm.firebaseio.com",
    projectId: "juhofcm",
    storageBucket: "juhofcm.appspot.com",
    messagingSenderId: "462864433045"
  };
  firebase.initializeApp(config);
  
  
  firebase.auth().onAuthStateChanged(function(user) {
	  if (user) {
	    // User is signed in.
	    var isAnonymous = user.isAnonymous;
	    var uid = user.uid;
	    
	    console.dir("로그인 : "+user);
	  } else {
	    // User is signed out.
	    // ...
		  console.dir("로그 아웃" +user);
	  }
	  // ...
	});
  
  firebase.auth().signOut().then(function() {
	  // Sign-out successful.
	  console.dir("Sign-out successful  : " +user);
	}).catch(function(error) {
	  // An error happened.
	});
  
  
 
</script>


<script src="scripts/main.js"></script>


<script>
$(document).ready(function(){
	$("#submit").on("click", function(){
		var userName=$("#user-name").html();
		if(userName!=""){
			alert("메시지");	
		}
		
	})	
});


</script>


</body>
</html>
