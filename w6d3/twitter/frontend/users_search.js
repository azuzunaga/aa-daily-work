const APIUtil = require('./api_util.js');

class UserSearch {
  constructor(el) {
    this.$el = $(el);
    this.$input = this.$el.find('input[username]');
    this.$ul = this.$el.find('ul');
    this.$input.on('input', this.handleInput.bind(this));
    debugger;
  }

  query() {
    return this.$input.val();
  }

  handleInput(e) {
    // e.preventDefault();
    this.users = APIUtil.searchUsers(this.query());

    this.users.then(users => this.render(users));
  }

  render(users) {
    this.$ul.empty();
    users.forEach((user) => {
      const $li = $(`<li><a href=./users/${user.id}></a></li>`);
      $li.text(`${user.username}`);
      this.$ul.append($li);
    });

  }
}

module.exports = UserSearch;
