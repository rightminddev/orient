'use strict';
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js');

firebase.initializeApp({
  apiKey: 'AIzaSyD5Gl_NkMPOC-Rj_bJhXq5EEahcn8p9cqU',
  appId: '1:399301548774:web:41aabb7c85b1d036f83927',
  messagingSenderId: '399301548774',
  projectId: 'rm-employees-ee2e7',
  authDomain: 'rm-employees-ee2e7.firebaseapp.com',
  storageBucket: 'rm-employees-ee2e7.appspot.com',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log('Received background message: ', message);
});
