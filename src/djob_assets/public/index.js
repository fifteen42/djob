import djob from 'ic:canisters/djob';

djob.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
