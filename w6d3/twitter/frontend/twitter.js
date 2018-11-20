const FollowToggle = require('./follow_toggle');
const UserSearch = require('./user-search');

$(() => {
  const $followButtons = $('.follow-toggle');

  $followButtons.each((index, button) => {
    const $button = new FollowToggle(button);
    $button.render();
  });
  const $searchInputs = $('.users-search');

  const $users = new UserSearch($searchInputs);
  $users.users.render();

}
);
