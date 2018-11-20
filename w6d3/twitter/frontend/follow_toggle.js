const APIUtil = require('./api_util.js');

class FollowToggle {
  constructor(el) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id");
    this.followState = this.$el.data("initial-follow-state");

    this.$el.on('click', this.handleInput.bind(this));
    this.render();
  }

  render () {
    if (this.followState) {
      this.$el.text('Unfollow!');
    } else {
      this.$el.text('Follow');
    }
  }

  handleInput(e) {
    e.preventDefault();

    this.$el.prop('disabled', true);
    if (this.followState) {
      APIUtil.unfollowUser(this.userId).then(() => {
        this.$el.prop('disabled', false);
        this.followState = !this.followState;
        this.render();
      });
    } else {
      APIUtil.followUser(this.userId).then(() => {
        this.$el.prop('disabled', false);
        this.followState = !this.followState;
        this.render();
      });
    }

  }
}

module.exports = FollowToggle;
